local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')

local World = Workspace:WaitForChild('World')
local Objectives = World:WaitForChild('Objectives')

local Services = ReplicatedStorage:WaitForChild('ServiceRemotes')
local ObjectiveService = Services:WaitForChild('ObjectiveService')

local Ignore = Workspace:WaitForChild('Ignore')
local Items = Ignore:WaitForChild('Items')

local Player = game:GetService('Players').LocalPlayer

local CreateFloatingPart = function()
	local Part = Instance.new('Part', Ignore)
	Part.Size = Vector3.new(12, 1, 12)
	Part.Anchored = true
	Part.Transparency = 0.7
	Part.CanCollide = true
	Part.CollisionGroupId = 4
	return Part
end

local CarryingItem = nil
ObjectiveService.UpdateCarryingItem.OnClientEvent:Connect(function(Item, Item2)
	CarryingItem = Item2 or Item
end)
ObjectiveService.RemoveCarryingItem.OnClientEvent:Connect(function()
	CarryingItem = nil
end)
Player.CharacterAdded:Connect(function()
	CarryingItem = nil
end)

local Healable = {'Medkit', 'Bandages'}
local GetHealable = function(Character, Teleport, Functions)
	local HealItem = nil
	for _, Item in pairs(Items:GetChildren()) do
		if table.find(Healable, Item.Name) and Item.PrimaryPart then
			HealItem = Item
			break
		end
	end

	if HealItem then
		local CF = HealItem.PrimaryPart.CFrame * CFrame.new(0, 5, 0)
		Teleport(Character, CF)

		wait()

		Functions.Pickup(Functions.GetModule('Interact'))
	end
end

local GetArmor = function(Character, Teleport, Functions)
	local ArmorItem = nil
	for _, Item in pairs(Items:GetChildren()) do
		if Item.Name == 'Body Armor' and Item.PrimaryPart then
			ArmorItem = Item
			break
		end
	end

	if ArmorItem then
		local CF = ArmorItem.PrimaryPart.CFrame * CFrame.new(0, 5, 0)
		Teleport(Character, CF)

		wait()

		Functions.Pickup(Functions.GetModule('Interact'))
	end
end

local Objs = {
	ObjectiveService = ObjectiveService,
	GetHealable = GetHealable,
	GetArmor = GetArmor,
	List = {
		['Tundra'] = {
			function(Object, Data)
				local Player, Character, Humanoid = Data.Player, Data.Character(), Data.Humanoid()
				if not Data.Functions.IsAlive(Character, Humanoid) then return false end

				local Completed = nil
				local Con = nil

				local HeadLights = Object:FindFirstChild('HeadLights')
				if not HeadLights then return false end
				local SpotLight = HeadLights:FindFirstChild('SpotLight')
				if not SpotLight then return false end

				Con = ObjectiveService.ObjectiveCompleted.OnClientEvent:connect(function()
					Completed = true
					Con:Disconnect()
				end)

				Data.Functions.NoClip(true)

				local DisplayTextToItem = function(Display)
					if Display == 'TIRE REQUIRED' then
						return Object.Name .. ' Wheel'
					elseif string.find(Display, 'FUEL') then
						return 'Jerry Can'
					elseif string.find(Display, 'SPARK') then
						return 'Spark Plug'
					end
					return nil
				end

				local PlaceItem = function(Part)
					Data.Teleport(Character, Part.CFrame)
					wait(.2)

					spawn(Data.Functions.PlaceItem)
					local Tries = 0
					repeat wait(.1)
						Tries = Tries + 1
					until CarryingItem == nil or Tries >= 5
					if Tries >= 5 then return false else return true end
				end

				local PickupItem = function(Item)
					local Tries = 0

					local PickedUp = false
					spawn(function()
						ObjectiveService.UpdateCarryingItem.OnClientEvent:Wait()
						PickedUp = true
					end)

					repeat wait(.2)
						Data.Teleport(Character, Item.PrimaryPart.CFrame * CFrame.new(0, 3.5, 0))
						Data.Functions.PickupObjectiveItem()

						if Humanoid.Health <= Data.Settings.LookForHeal then
							GetHealable(Character, Data.Teleport, Data.Functions)
						end
						Tries = Tries + 1
					until CarryingItem ~= nil or Tries >= 5 or PickedUp or not Item.Parent or not Item.PrimaryPart
					if Tries >= 5 then return false else return true end
				end

				while not Completed and Data.Functions.IsAlive(Character, Humanoid) and SpotLight.Enabled == false and Data.GameValues.StageName == 'Game' do
					if CarryingItem then
						local TargetPart = nil
						for _, P in pairs(Object.Parent:GetChildren()) do
							if P.Name == 'Part' and P:FindFirstChild('DisplayText') then
								local Display = P:FindFirstChild('DisplayText').Value
								local PartGoal = DisplayTextToItem(Display)

								if PartGoal == CarryingItem then
									TargetPart = P
									break
								end
							end
						end

						if TargetPart then PlaceItem(TargetPart) wait() else warn('No part found for picked up (1)', CarryingItem) end
					else
						local Goals = {}
						for _, Part in pairs(Object.Parent:GetChildren()) do
							if Part.Name == 'Part' and Part:FindFirstChild('DisplayText') then
								table.insert(Goals, DisplayTextToItem(Part:FindFirstChild('DisplayText').Value))
							end
						end

						if #Goals <= 0 then break end

						local RandomGoal = Goals[math.random(1, #Goals)]
						if RandomGoal then
							local ItemName = RandomGoal

							local Found = nil
							for _, Item in pairs(Object.Parent:GetChildren()) do
								if Item.Name == ItemName and Item.PrimaryPart and not Item:FindFirstChild('Debounce') then
									Found = Item
									break
								end
							end

							if Found then
								PickupItem(Found)
								wait(.2)

								if CarryingItem then
									local TargetPart = nil
									for _, P in pairs(Object.Parent:GetChildren()) do
										if P.Name == 'Part' and P:FindFirstChild('DisplayText') then
											local Display = P:FindFirstChild('DisplayText').Value
											local PartGoal = DisplayTextToItem(Display)

											if PartGoal == CarryingItem then
												TargetPart = P
												break
											end
										end
									end

									if TargetPart then PlaceItem(TargetPart) wait() else warn('No part found for picked up (2)', CarryingItem) end
								end
							end
						end
					end
					wait()
				end

				wait()

				Data.Functions.NoClip(false)
				if Con then Con:Disconnect() end

				return true
			end, function(Object, Data)
				local HeadLights = Object:FindFirstChild('HeadLights')
				if not HeadLights then return false end
				local SpotLight = HeadLights:FindFirstChild('SpotLight')
				if not SpotLight then return false end
				return SpotLight.Enabled == false
			end
		},
		['Tundrax'] = {
			function(Object, Data)
				local Player, Character, Humanoid = Data.Player, Data.Character(), Data.Humanoid()
				if not Data.Functions.IsAlive(Character, Humanoid) then return false end

				local PrimaryPart = Character.PrimaryPart

				local Completed = nil
				local Con = nil

				local OriginCF = PrimaryPart.CFrame

				local HeadLights = Object:FindFirstChild('HeadLights')
				if not HeadLights then return false end
				local SpotLight = HeadLights:FindFirstChild('SpotLight')
				if not SpotLight then return false end

				Con = ObjectiveService.ObjectiveCompleted.OnClientEvent:connect(function()
					Completed = true
					Con:Disconnect()
				end)

				Data.Functions.NoClip(true)

				while not Completed and Data.Functions.IsAlive(Character, Humanoid) and SpotLight.Enabled == false and Data.GameValues.StageName == 'Game' do
					for _, Part in pairs(Object.Parent:GetChildren()) do
						if Part.Name == 'Part' and Part:FindFirstChild('DisplayText') then
							local Display = Part:FindFirstChild('DisplayText').Value
							local SearchingFor = nil
							if Display == 'TIRE REQUIRED' then
								SearchingFor = Object.Name .. ' Wheel'
							elseif string.find(Display, 'FUEL') then
								SearchingFor = 'Jerry Can'
							elseif string.find(Display, 'SPARK') then
								SearchingFor = 'Spark Plug'
							end

							if SearchingFor then
								local FoundItem = nil
								for _, Item in pairs(Object.Parent:GetChildren()) do
									if Item.Name == SearchingFor and Item.PrimaryPart and not Item:FindFirstChild('Debounce') then
										FoundItem = Item
										break
									end
								end
								if FoundItem then
									local PickedUp = false
									local PickedUpCon = nil
									local ItemPickedUp = nil
									PickedUpCon = ObjectiveService.UpdateCarryingItem.OnClientEvent:connect(function(...)
										ItemPickedUp = select(..., 1)
										PickedUp = true
										PickedUpCon:Disconnect()
									end)

									local Attempts = 0
									repeat wait(.2) -- Pickup the object
										Data.Teleport(Character, FoundItem.PrimaryPart.CFrame * CFrame.new(0, 3.5, 0))
										Data.Functions.PickupObjectiveItem()

										if Humanoid.Health <= Data.Settings.LookForHeal then
											GetHealable(Character, Data.Teleport, Data.Functions)
										end

										Attempts += 1
									until PickedUp or Attempts >= 5 or not Data.Functions.IsAlive(Character, Humanoid) or SpotLight.Enabled == true or Data.GameValues.StageName ~= 'Game'

									if PickedUp and ItemPickedUp ~= SearchingFor then
										Part = nil
										for _, P in pairs(Object.Parent:GetChildren()) do
											if P.Name == 'Part' and P:FindFirstChild('DisplayText') then
												local Display = P:FindFirstChild('DisplayText').Value
												local PartGoal = nil
												if Display == 'TIRE REQUIRED' then
													PartGoal = Object.Name .. ' Wheel'
												elseif string.find(Display, 'FUEL') then
													PartGoal = 'Jerry Can'
												elseif string.find(Display, 'SPARK') then
													PartGoal = 'Spark Plug'
												end

												if PartGoal == ItemPickedUp then
													Part = P
													break
												end
											end
										end
									end

									if Part and PickedUp then -- Place the object in the bus
										Data.Teleport(Character, Part.CFrame)
										wait(.2)
										Data.Functions.PlaceItem()
									elseif Part then
										local M = Instance.new('Model', FoundItem)
										M.Name = 'Debounce'
										game:GetService('Debris'):AddItem(M, 5)
									end
									wait()
								end
							end
						end
					end
					wait()
				end

				wait()

				Data.Functions.NoClip(false)
				if Con then Con:Disconnect() end
				if PrimaryPart and PrimaryPart.Anchored and Data.Functions.IsAlive(Character, Humanoid) then
					Data.Teleport(Character, OriginCF)
				end

				return true
			end, function(Object, Data)
				local HeadLights = Object:FindFirstChild('HeadLights')
				if not HeadLights then return false end
				local SpotLight = HeadLights:FindFirstChild('SpotLight')
				if not SpotLight then return false end
				return SpotLight.Enabled == false
			end,
		},
		['Bus'] = {
			function(Object, Data)
				local Player, Character, Humanoid = Data.Player, Data.Character(), Data.Humanoid()
				if not Data.Functions.IsAlive(Character, Humanoid) then return false end

				local Target = Object.Parent:FindFirstChild('Part')
				local PrimaryPart = Character.PrimaryPart

				local Completed = nil
				local Con = nil

				local OriginCF = PrimaryPart.CFrame

				Con = ObjectiveService.ObjectiveCompleted.OnClientEvent:connect(function()
					Completed = true
					Con:Disconnect()
				end)

				Data.Functions.NoClip(true)

				while not Completed and Data.Functions.IsAlive(Character, Humanoid) and Target and Target.Parent and Data.GameValues.StageName == 'Game' do
					for _, Item in pairs(Object.Parent:GetChildren()) do
						if Item:FindFirstChild('Glow') and Item.PrimaryPart and not Item:FindFirstChild('Debounce') then

							local PickedUp = false
							local PickedUpCon = nil
							PickedUpCon = ObjectiveService.UpdateCarryingItem.OnClientEvent:connect(function()
								PickedUp = true
								PickedUpCon:Disconnect()
							end)

							local Attempts = 0
							repeat wait(.2) -- Pickup the object
								Data.Teleport(Character, Item.PrimaryPart.CFrame * CFrame.new(0, 3.5, 0))
								Data.Functions.PickupObjectiveItem()

								if Humanoid.Health <= Data.Settings.LookForHeal then
									GetHealable(Character, Data.Teleport, Data.Functions)
								end
								Attempts += 1
							until PickedUp or not Item.Parent or Attempts >= 5 or not Item.PrimaryPart or not Data.Functions.IsAlive(Character, Humanoid) or not Target or not Target.Parent or Data.GameValues.StageName ~= 'Game'

							if PickedUp then -- Place the object in the bus
								Data.Teleport(Character, Target.CFrame)
								wait(.2)
								Data.Functions.PlaceItem()
							else
								local M = Instance.new('Model', Item)
								M.Name = 'Debounce'
								game:GetService('Debris'):AddItem(M, 5)
							end
						end

						if not Data.Functions.IsAlive(Character, Humanoid) or not Target or not Target.Parent or Data.GameValues.StageName ~= 'Game' then break end
					end
					wait()
				end

				wait()

				Data.Functions.NoClip(false)
				if Con then Con:Disconnect() end
				if PrimaryPart and PrimaryPart.Anchored and Data.Functions.IsAlive(Character, Humanoid) then
					Data.Teleport(Character, OriginCF)
				end

				return true
			end, function(Object, Data)
				return Object.Parent:FindFirstChild('Part') ~= nil
			end,
		},
		['EscortChar'] = {
			function(Object, Data)
				local Player, Character, Humanoid = Data.Player, Data.Character(), Data.Humanoid()
				if not Data.Functions.IsAlive(Character, Humanoid) then return false end

				local Target = Object.PrimaryPart
				local PrimaryPart = Character.PrimaryPart

				local Completed = nil
				local Con = nil

				Con = ObjectiveService.ObjectiveCompleted.OnClientEvent:connect(function()
					Completed = true
					Con:Disconnect()
				end)

				Data.Functions.NoClip(true)
				local Part = CreateFloatingPart()

				local Healing = false
				RunService:BindToRenderStep('Escort', 3, function()
					local CF = CFrame.new(Target.Position) * CFrame.new(0, Data.Settings.SafeHeight, 0)
					Part.CFrame = CF * CFrame.new(0, -3.5, 0)
					if not Healing then
						Data.Teleport(Character, CF)
					end
				end)

				while not Completed and Data.Functions.IsAlive(Character, Humanoid) and Target and Target.Parent and Data.GameValues.StageName == 'Game' do
					wait()
					if Humanoid.Health <= Data.Settings.LookForHeal then
						Healing = true
						GetHealable(Character, Data.Teleport, Data.Functions)
						Healing = false
					end
				end

				RunService:UnbindFromRenderStep('Escort')

				wait()

				Data.Functions.NoClip(false)
				if Part then Part:Destroy() end
				if Con then Con:Disconnect() end

				return true
			end, function(Obj)
				return (Obj and Obj.Parent ~= nil)
			end,
		},
		['Fuel Truck'] = {
			function (Object, Data)
				local Player, Character, Humanoid = Data.Player, Data.Character(), Data.Humanoid()
				if not Data.Functions.IsAlive(Character, Humanoid) then return false end

				local Target = Object.PrimaryPart
				local PrimaryPart = Character.PrimaryPart

				local Completed = nil
				local Con = nil

				Con = ObjectiveService.ObjectiveCompleted.OnClientEvent:connect(function()
					Completed = true
					Con:Disconnect()
				end)

				Data.Functions.NoClip(true)
				local Part = CreateFloatingPart()

				local Body = Object:FindFirstChild('Body')
				if not Body then return false end
				local Trailer = Body:FindFirstChild('Trailer')
				if not Trailer then return false end

				while not Completed and Data.Functions.IsAlive(Character, Humanoid) and Target and Target.Parent and Data.GameValues.StageName == 'Game' and not Trailer:FindFirstChild('Exploded Tank') do
					local CF = CFrame.new(Target.Position) * CFrame.new(0, Data.Settings.SafeHeight, 0)
					Part.CFrame = CF * CFrame.new(0, -3.5, 0)
					Data.Teleport(Character, CF)

					for i = 1, 3 do
						Data.Functions.ShootTank(Object)
					end

					if Humanoid.Health <= Data.Settings.LookForHeal then
						GetHealable(Character, Data.Teleport, Data.Functions)
					end

					wait()
				end

				wait()

				Data.Functions.NoClip(false)
				if Part then Part:Destroy() end
				if Con then Con:Disconnect() end

				return true
			end, function(Object)
				local Body = Object:FindFirstChild('Body')
				if not Body then return false end
				local Trailer = Body:FindFirstChild('Trailer')
				if not Trailer then return false end
				return Trailer:FindFirstChild('Exploded Tank') == nil
			end,
		},
		['Radio'] = {
			function(Object, Data)
				local Player, Character, Humanoid = Data.Player, Data.Character(), Data.Humanoid()
				if not Data.Functions.IsAlive(Character, Humanoid) then return false end

				local Target = Object.PrimaryPart
				local PrimaryPart = Character.PrimaryPart

				local Completed = nil
				local Con = nil

				Con = ObjectiveService.ObjectiveCompleted.OnClientEvent:connect(function()
					Completed = true
					Con:Disconnect()
				end)

				Data.Functions.NoClip(true)
				local Part = CreateFloatingPart()
				local Offset = 0
				local Healing = false
				RunService:BindToRenderStep('Escort', 3, function()
					local CF = CFrame.new(Target.Position) * CFrame.new(Offset, Data.Settings.SafeHeight, Offset)
					Part.CFrame = CF * CFrame.new(0, -3.5, 0)
					if not Healing then
						Data.Teleport(Character, CF)
					end
				end)

				while not Completed and Data.Functions.IsAlive(Character, Humanoid) and Target and Target.Parent and Data.GameValues.StageName == 'Game' do
					wait()
					if Humanoid.Health <= Data.Settings.LookForHeal then
						Healing = true
						GetHealable(Character, Data.Teleport, Data.Functions)
						Healing = false
						Offset = math.random(1, 5)
					end
				end

				RunService:UnbindFromRenderStep('Escort')

				wait()

				Data.Functions.NoClip(false)
				if Part then Part:Destroy() end
				if Con then Con:Disconnect() end

				return true
			end, function(Object, Data)
				return Object.PrimaryPart ~= nil
			end
		},
	}
}

Objs.List['Ammo'] = Objs.List['Radio']
Objs.List['Medical'] = Objs.List['Radio']
Objs.List['Silverado'] = Objs.List['Tundra']

return Objs