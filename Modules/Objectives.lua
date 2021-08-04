local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local World = Workspace:WaitForChild('World')
local Objectives = World:WaitForChild('Objectives')

local Services = ReplicatedStorage:WaitForChild('ServiceRemotes')
local ObjectiveService = Services:WaitForChild('ObjectiveService')

local Ignore = Workspace:WaitForChild('Ignore')
local Items = Ignore:WaitForChild('Items')

local CreateFloatingPart = function()
	local Part = Instance.new('Part', Ignore)
	Part.Size = Vector3.new(12, 1, 12)
	Part.Anchored = true
	Part.Transparency = 0.7
	Part.CanCollide = true
	Part.CollisionGroupId = 4
	return Part
end

local Healable = {'Medkit', 'Bandages'}
local GetHealable = function(Character, Data, Player, Functions)
	local HealItem = nil
	for _, Item in pairs(Items:GetChildren()) do
		if table.find(Healable, Item.Name) and Item.PrimaryPart then
			HealItem = Item
			break
		end
	end

	if HealItem then
		local CF = HealItem.PrimaryPart.CFrame * CFrame.new(0, 5, 0)
		Data.Teleport(Character, CF)

		wait()

		Data.Functions.Pickup(Functions.GetModule(Player, 'Interact'))
	end
end

local Objs = {
	ObjectiveService = ObjectiveService,
	List = {
		['Tundra'] = {
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
									if Item.Name == SearchingFor then
										FoundItem = Item
										break
									end
								end
								if FoundItem then
									local PickedUp = false
									local PickedUpCon = nil
									PickedUpCon = ObjectiveService.UpdateCarryingItem.OnClientEvent:connect(function()
										PickedUp = true
										PickedUpCon:Disconnect()
									end)

									repeat wait(.2) -- Pickup the object
										Data.Teleport(Character, FoundItem.PrimaryPart.CFrame * CFrame.new(0, 3.5, 0))
										Data.Functions.PickupObjectiveItem()
										
										if Humanoid.Health <= 50 then
											GetHealable(Character, Data, Player, Data.Functions)
										end
									until PickedUp or not Data.Functions.IsAlive(Character, Humanoid) or SpotLight.Enabled == true or Data.GameValues.StageName ~= 'Game'
									
									if PickedUp then -- Place the object in the bus
										Data.Teleport(Character, Part.CFrame)
										wait(.2)
										Data.Functions.PlaceItem()
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
						if Item:findFirstChild('Glow') and Item.PrimaryPart then

							local PickedUp = false
							local PickedUpCon = nil
							PickedUpCon = ObjectiveService.UpdateCarryingItem.OnClientEvent:connect(function()
								PickedUp = true
								PickedUpCon:Disconnect()
							end)

							repeat wait(.2) -- Pickup the object
								Data.Teleport(Character, Item.PrimaryPart.CFrame * CFrame.new(0, 3.5, 0))
								Data.Functions.PickupObjectiveItem()
								
								if Humanoid.Health <= 50 then
									GetHealable(Character, Data, Player, Data.Functions)
								end
							until PickedUp or not Data.Functions.IsAlive(Character, Humanoid) or not Target or not Target.Parent or Data.GameValues.StageName ~= 'Game'
							
							if PickedUp then -- Place the object in the bus
								Data.Teleport(Character, Target.CFrame)
								wait(.2)
								Data.Functions.PlaceItem()
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

				local OriginCF = PrimaryPart.CFrame

				Con = ObjectiveService.ObjectiveCompleted.OnClientEvent:connect(function()
					Completed = true
					Con:Disconnect()
				end)

				Data.Functions.NoClip(true)
				local Part = CreateFloatingPart()

				while not Completed and Data.Functions.IsAlive(Character, Humanoid) and Target and Target.Parent and Data.GameValues.StageName == 'Game' do
					local CF = CFrame.new(Target.Position) * CFrame.new(0, Data.Settings.SafeHeight, 0)
					Part.CFrame = CF * CFrame.new(0, -3.5, 0)
					Data.Teleport(Character, CF)

					if Humanoid.Health <= 50 then
						GetHealable(Character, Data, Player, Data.Functions)
					end

					wait()
				end

				wait()

				Data.Functions.NoClip(false)
				if Part then Part:Destroy() end
				if Con then Con:Disconnect() end
				if PrimaryPart and PrimaryPart.Anchored and Data.Functions.IsAlive(Character, Humanoid) then
					Data.Teleport(Character, OriginCF)
				end

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

				local OriginCF = PrimaryPart.CFrame

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

					if Humanoid.Health <= 50 then
						GetHealable(Character, Data, Player, Data.Functions)
					end

					wait()
				end

				wait()

				Data.Functions.NoClip(false)
				if Part then Part:Destroy() end
				if Con then Con:Disconnect() end
				if PrimaryPart and PrimaryPart.Anchored and Data.Functions.IsAlive(Character, Humanoid) then
					Data.Teleport(Character, OriginCF)
				end

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

				local OriginCF = PrimaryPart.CFrame

				Con = ObjectiveService.ObjectiveCompleted.OnClientEvent:connect(function()
					Completed = true
					Con:Disconnect()
				end)

				Data.Functions.NoClip(true)
				local Part = CreateFloatingPart()

				while not Completed and Data.Functions.IsAlive(Character, Humanoid) and Target and Target.Parent and Data.GameValues.StageName == 'Game' do
					local CF = CFrame.new(Target.Position) * CFrame.new(0, Data.Settings.SafeHeight, 0)
					Part.CFrame = CF * CFrame.new(0, -3.5, 0)
					Data.Teleport(Character, CF)

					if Humanoid.Health <= 50 then
						GetHealable(Character, Data, Player, Data.Functions)
					end

					wait()
				end

				wait()

				Data.Functions.NoClip(false)
				if Part then Part:Destroy() end
				if Con then Con:Disconnect() end
				if PrimaryPart and PrimaryPart.Anchored and Data.Functions.IsAlive(Character, Humanoid) then
					Data.Teleport(Character, OriginCF)
				end

				return true
			end, function(Object, Data)
				return Object.PrimaryPart ~= nil
			end
		},
	}
}

Objs.List['Ammo'] = Objs.List['Radio']
Objs.List['Medical'] = Objs.List['Radio']

return Objs