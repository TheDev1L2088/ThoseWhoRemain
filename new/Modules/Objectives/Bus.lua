wait()

----------------------------------------------
--// Variables

local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')
local Player = Players.LocalPlayer

local YWR, Character, Functions, ObjectiveService, GameValues

----------------------------------------------
--// Main

local Objective = {}

Objective.Check = function(Object)
    return Object.PrimaryPart ~= nil
end

Objective.Load = function()
    YWR = _G.YWR
    Character = YWR.Character
    Functions = YWR.Imports.Functions
    ObjectiveService = YWR.ObjectiveService
    GameValues = YWR.GameValues
	return true
end

Objective.Run = function(Object)
    local Humanoid = Character():FindFirstChildOfClass('Humanoid')
    local Target = Object.PrimaryPart
    local Completed, Con

	Con = ObjectiveService.ObjectiveCompleted.OnClientEvent:connect(function()
	    Completed = true
		Con:Disconnect()
	end)

    Functions.NoClip(true)
    local Part = Functions.CreateFloatingPart()

    while not Completed and Functions.IsAlive() and Target and Target.Parent and GameValues.StageName == 'Game' do
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
                    Functions.Teleport(Character(), Item.PrimaryPart.CFrame * CFrame.new(0, 3.5, 0))
                    Functions.PickupObjectiveItem()

                    if Humanoid.Health <= _G.Settings.LookForHeal then
                        Functions.GetHealable(Character())
                    end
                    Attempts += 1
                until PickedUp or not Item.Parent or Attempts >= 5 or not Item.PrimaryPart or not Functions.IsAlive() or not Target or not Target.Parent or GameValues.StageName ~= 'Game'

                if PickedUp then -- Place the object in the bus
                    Functions.Teleport(Character(), Target.CFrame)
                    wait(.2)
                    Functions.PlaceItem()
                else
                    local M = Instance.new('Model', Item)
                    M.Name = 'Debounce'
                    game:GetService('Debris'):AddItem(M, 5)
                end
            end
            if not Functions.IsAlive() or not Target or not Target.Parent or GameValues.StageName ~= 'Game' then break end
        end
        wait()
    end

	wait()

	Functions.NoClip(false)
	if Part then Part:Destroy() end
	if Con then Con:Disconnect() end

	return true
end

----------------------------------------------

return Objective