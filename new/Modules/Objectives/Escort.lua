wait()

----------------------------------------------
--// Variables

local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')
local Player = Players.LocalPlayer

repeat wait() until _G.YWR and _G.YWR['FullyImported']

local YWR = _G.YWR
local Character = YWR.Character
local Functions = YWR.Imports.Functions
local ObjectiveService = YWR.ObjectiveService
local GameValues = YWR.GameValues

----------------------------------------------
--// Main

local Objective = {}

Objective.Check = function(Object)
    return (Object and Object.Parent ~= nil)
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

    local Healing = false
	RunService:BindToRenderStep('Escort', 3, function()
		local CF = CFrame.new(Target.Position) * CFrame.new(0, _G.Settings.SafeHeight, 0)
		Part.CFrame = CF * CFrame.new(0, -3.5, 0)
		if not Healing then
			Functions.Teleport(Character(), CF)
		end
	end)

	while not Completed and Functions.IsAlive() and Target and Target.Parent and GameValues.StageName == 'Game' do
		wait()
		if Humanoid.Health <= _G.Settings.LookForHeal then
			Healing = true
			Functions.GetHealable(Character())
			Healing = false
		end
	end

	RunService:UnbindFromRenderStep('Escort')
	wait()

	Functions.NoClip(false)
	if Part then Part:Destroy() end
	if Con then Con:Disconnect() end

	return true
end

----------------------------------------------

return Objective