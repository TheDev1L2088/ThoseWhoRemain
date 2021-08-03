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

return {
	ObjectiveService = ObjectiveService,
	List = {
		['Radio'] = {
			function(Object, Data)
				local Player, Character, Humanoid = Data.Player, Data.Character(), Data.Humanoid()
				if not Data.Functions.IsAlive(Character, Humanoid) then warn('no') return false end

				local Target = Object.PrimaryPart
				local PrimaryPart = Character.PrimaryPart

				local Completed = nil
				local Con = nil

				local OriginCF = PrimaryPart.CFrame

				Con = ObjectiveService.ObjectiveCompleted.OnClientEvent:connect(function()
					Completed = true
					Con:Disconnect()
				end)

				while not Completed and Data.Functions.IsAlive(Character, Humanoid) and Target and Target.Parent do
					PrimaryPart.Anchored = true
					Data.Teleport(Character, Target.CFrame * CFrame.new(0, Data.Settings.SafeHeight, 0))

					if Humanoid.Health <= 50 then
						GetHealable(Character, Data)
					end

					wait()
				end

				wait()

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