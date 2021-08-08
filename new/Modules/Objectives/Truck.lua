wait()

----------------------------------------------
--// Variables

local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')
local Player = Players.LocalPlayer

local YWR = _G.YWR
local Character = YWR.Character
warn('Here1')
local Functions = YWR.Imports.Functions
warn('Here2')
local ObjectiveService = YWR.ObjectiveService
local GameValues = YWR.GameValues

----------------------------------------------
--// Main

local Objective = {}

Objective.Check = function(Object)
    local Body = Object:FindFirstChild('Body')
    if not Body then return false end
    local Trailer = Body:FindFirstChild('Trailer')
    if not Trailer then return false end
    return Trailer:FindFirstChild('Exploded Tank') == nil
end

Objective.Run = function(Object)
    local Target = Object.PrimaryPart
    local Completed, Con

	Con = ObjectiveService.ObjectiveCompleted.OnClientEvent:connect(function()
	    Completed = true
		Con:Disconnect()
	end)

    Functions.NoClip(true)
	local Part = Functions.CreateFloatingPart()

    local Body = Object:FindFirstChild('Body')
    if not Body then return false end
    local Trailer = Body:FindFirstChild('Trailer')
    if not Trailer then return false end

    while not Completed and Functions.IsAlive() and Target and Target.Parent and GameValues.StageName == 'Game' and not Trailer:FindFirstChild('Exploded Tank') do
        local CF = CFrame.new(Target.Position) * CFrame.new(0, _G.Settings.SafeHeight, 0)
        Part.CFrame = CF * CFrame.new(0, -3.5, 0)
        Functions.Teleport(Character, CF)

        for i = 1, 3 do
            Functions.ShootTank(Object)
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