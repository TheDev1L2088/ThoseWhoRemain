local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local World = Workspace:WaitForChild('World')
local Objectives = World:WaitForChild('Objectives')

local Services = ReplicatedStorage:WaitForChild('ServiceRemotes')
local ObjectiveService = Services:WaitForChild('ObjectiveService')

local Ignore = Workspace:WaitForChild('Ignore')
local Items = Ignore:WaitForChild('Items')

local Healable = {'Medkit', 'Bandages'}
local GetHealable = function(Character, Data)
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

		Data.Functions.Pickup()
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

				local Part = Instance.new('Part', Workspace)
				Part.Size = Vector3.new(10, 2, 10)
				Part.Anchored = true

				while not Completed and Data.Functions.IsAlive(Character, Humanoid) and Target and Target.Parent do
					local CF = Target.CFrame * CFrame.new(0, Data.Settings.SafeHeight, 0)
					Part.CFrame = CF * CFrame.new(0, -3.4, 0)
					Data.Teleport(Character, CF)

					if Humanoid.Health <= 50 then
						GetHealable(Character, Data)
					end

					wait()
				end

				wait()

				if Part then Part:Destroy() end
				if Con then Con:Disconnect() end
				if PrimaryPart and PrimaryPart.Anchored and Data.Functions.IsAlive(Character, Humanoid) then
					PrimaryPart.Anchored = false
					Data.Teleport(Character, OriginCF)
				end

				return true
			end, function()
				return true
			end,
		},
		['Fuel Truck'] = {
			function (Object, Data)

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

				local Part = Instance.new('Part', Workspace)
				Part.Size = Vector3.new(10, 2, 10)
				Part.Anchored = true

				while not Completed and Data.Functions.IsAlive(Character, Humanoid) and Target and Target.Parent do
					local CF = Target.CFrame * CFrame.new(0, Data.Settings.SafeHeight, 0)
					Part.CFrame = CF * CFrame.new(0, -3.4, 0)
					Data.Teleport(Character, CF)

					if Humanoid.Health <= 50 then
						GetHealable(Character, Data)
					end

					wait()
				end

				wait()

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

return Objs