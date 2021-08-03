local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local World = Workspace:WaitForChild('World')
local Objectives = World:WaitForChild('Objectives')

local Services = ReplicatedStorage:WaitForChild('ServiceRemotes')
local ObjectiveService = Services:WaitForChild('ObjectiveService')

local Ignore = Workspace:WaitForChild('Ignore')
local Items = Ignore:WaitForChild('Items')

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
				local Part = Instance.new('Part', Workspace)
				Part.Size = Vector3.new(10, 2, 10)
				Part.Anchored = true
				Part.Transparency = 0.8

				while not Completed and Data.Functions.IsAlive(Character, Humanoid) and Target and Target.Parent do
					local CF = CFrame.new(Target.Position) * CFrame.new(0, Data.Settings.SafeHeight, 0)
					Part.CFrame = CF * CFrame.new(0, -3.4, 0)
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
					PrimaryPart.Anchored = false
					Data.Teleport(Character, OriginCF)
				end

				return true
			end, function(Obj)
				return (Obj and Obj.Parent ~= nil)
			end,
		},
		['Fuel Truck'] = {
			function (Object, Data)
				
			end, function()
				return false
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
				local Part = Instance.new('Part', Workspace)
				Part.Size = Vector3.new(10, 2, 10)
				Part.Anchored = true
				Part.Transparency = 0.8

				while not Completed and Data.Functions.IsAlive(Character, Humanoid) and Target and Target.Parent do
					local CF = CFrame.new(Target.Position) * CFrame.new(0, Data.Settings.SafeHeight, 0)
					Part.CFrame = CF * CFrame.new(0, -3.4, 0)
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
					PrimaryPart.Anchored = false
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