repeat wait() until
game:GetService('Players') and
game:GetService('Players').LocalPlayer and
game:GetService('Players').LocalPlayer:FindFirstChild('PlayerGui') and
game.PlaceId

----------------------------------------------
--// Startup

local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UIS = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')

local Player = game:GetService('Players').LocalPlayer
local PlayerScripts = Player:WaitForChild('PlayerScripts')

if game.PlaceId ~= 488667523 then warn('Not Those Who Remain') return end
if not getsenv then getsenv = function() warn('no getsenv?') return {} end end

----------------------------------------------
--// Variables

_G.YWR = {} -- shared
_G.YWR.World = Workspace:WaitForChild('World')
_G.YWR.ObjectiveFolder = _G.YWR.World:WaitForChild('Objectives')
_G.YWR.GameStuff = ReplicatedStorage:WaitForChild('Game Stuff')
_G.YWR.Ignore = Workspace:WaitForChild('Ignore')
_G.YWR.Entities = Workspace:WaitForChild('Entities')
_G.YWR.EntityObjectives = _G.YWR.Entities:WaitForChild('Objectives')
_G.YWR.Infected = _G.YWR.Entities:WaitForChild('Infected')
_G.YWR.RE = ReplicatedStorage:WaitForChild('RE')
_G.YWR.RF = ReplicatedStorage:WaitForChild('RF')
_G.YWR.Services = ReplicatedStorage:WaitForChild('ServiceRemotes')
_G.YWR.InteractionService = _G.YWR.Services:WaitForChild('InteractionService')
_G.YWR.ObjectiveService = _G.YWR.Services:WaitForChild('ObjectiveService')
_G.YWR.Client = PlayerScripts:WaitForChild('Client')
_G.YWR.ClientEnv = getsenv(_G.YWR.Client)
_G.YWR.Fire2 = debug.getupvalues(_G.YWR.ClientEnv.Fire2)
_G.YWR.Modules = ReplicatedStorage:WaitForChild('Modules')
_G.YWR.Weapons = _G.YWR.Modules:WaitForChild('Weapon Modules')

_G.YWR.Character = function() if Player and Player.Character then return Player.Character end end

local YWR = _G.YWR -- shortcut

local GameValues = {}
for _, V in pairs(YWR.GameStuff:GetChildren()) do
	if V:IsA('NumberValue') or V:IsA('StringValue') or V:IsA('BoolValue') then
		GameValues[V.Name] = V.Value
		V.Changed:Connect(function()
			GameValues[V.Name] = V.Value
		end)
	end
end
YWR.GameValues = GameValues
local GameStage = YWR.GameValues.StageName

----------------------------------------------
--// Imports

local Imports = {}
Imports['Functions'] = _G.Import('Modules/Functions')
Imports['ObjectiveManager'] = _G.Import('Modules/ObjectiveManager')
Imports['StopReporting'] = _G.Import('Modules/StopReporting')
Imports['CombatManager'] = _G.Import('Modules/CombatManager')

YWR.Imports = Imports

----------------------------------------------
--// Main

local AFKFarm = function()
    while wait() do
        
    end
end

local StartCon = nil
StartCon = UIS.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Keyboard then
        local Key = Input.KeyCode
        if Key == _G.Settings.AFKFarmKey then
            StartCon:Disconnect()
            AFKFarm()
        end
    end
end)

warn('Fully loaded YouWontRemain!')