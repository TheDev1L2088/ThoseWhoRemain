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

    local Busy = false
    RunService:BindToRenderStep('Sit', 3, function()
        local CF = CFrame.new(Target.Position) * CFrame.new(0, _G.Settings.SafeHeight, 0)
        Part.CFrame = CF * CFrame.new(0, -3.5, 0)
        if not Busy then
            Functions.Teleport(Character(), CF)
        end
    end)

    while not Completed and Functions.IsAlive() and Target and Target.Parent and GameValues.StageName == 'Game' do
        wait()
        if Humanoid.Health <= _G.Settings.LookForHeal then
            Busy = true
            Functions.GetHealable(Character())
            Busy = false
        elseif _G.Settings.GetBodyArmor then
			local Armor = Functions.CheckArmor()
			if Armor == nil or Armor <= 0 then
				Busy = true
				Functions.GetArmor(Character())
				Busy = false
			end
        end
    end

    RunService:UnbindFromRenderStep('Sit')
	wait()

	Functions.NoClip(false)
	if Part then Part:Destroy() end
	if Con then Con:Disconnect() end

	return true
end

----------------------------------------------

return Objective