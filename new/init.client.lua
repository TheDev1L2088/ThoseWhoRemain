repeat wait() until
game:GetService('Players') and
game:GetService('Players').LocalPlayer and
game:GetService('Players').LocalPlayer:FindFirstChild('PlayerGui') and
game.PlaceId

----------------------------------------------
--// Startup

wait(1)

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
_G.YWR.Items = _G.YWR.Ignore:WaitForChild('Items')
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
_G.YWR.State = 'Waiting'

_G.YWR.Character = function() if Player and Player.Character then return Player.Character end end

local YWR = _G.YWR -- shortcut

YWR.GameStuff:WaitForChild('StageName')

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

----------------------------------------------
--// Imports

local Imports = {}
Imports['Functions'] = _G.Import('Modules/Functions')
Imports['ObjectiveManager'] = _G.Import('Modules/ObjectiveManager')
Imports['StopReporting'] = _G.Import('Modules/StopReporting')
Imports['CombatManager'] = _G.Import('Modules/CombatManager')

YWR.Imports = Imports
YWR.FullyImported = true
local GetObjective = Imports['ObjectiveManager']
local Functions = Imports['Functions']

----------------------------------------------
--// Main

local KillZombies = function()
    local Part = Functions.CreateFloatingPart()
    Functions.NoClip(true)

    while GameValues.StageName == 'Game' and Functions.IsAlive() do
        local Character = YWR.Character()
        local Humanoid = Character:FindFirstChildOfClass('Humanoid')

        for _, Zombie in pairs(YWR.Infected:GetChildren()) do
			if Zombie and Zombie.PrimaryPart and Zombie:FindFirstChildOfClass('Humanoid') and Zombie:FindFirstChildOfClass('Humanoid').Health > 0 then
                local Dead, DiedCon = false, nil
				DiedCon = Zombie:FindFirstChildOfClass('Humanoid').Died:Connect(function()
					Dead = true
					DiedCon:Disconnect()
				end)

                local Busy = false
                RunService:BindToRenderStep('ShootZombie', 2, function()
					if Zombie and Zombie.Parent and Zombie.PrimaryPart and Character and Character.Parent and Character.PrimaryPart then
						Part.CFrame = Zombie.PrimaryPart.CFrame * CFrame.new(0, 8, 0)
						if not Busy then
							Functions.Teleport(Character, Part.CFrame * CFrame.new(math.random(-3, 3), 3.8, math.random(-3, 3)))
						end
					end
				end)

                while Zombie and Zombie.Parent and not Dead and Functions.IsAlive(Character, Humanoid) and GameValues.StageName == 'Game' do
					Functions.ShootZombie(Zombie, _G.Settings.TargettingKillZombieRange)
					if Humanoid.Health <= _G.Settings.LookForHeal then
						Busy = true
						Functions.GetHealable(Character)
						Busy = false
                    elseif _G.Settings.GetBodyArmor then
                        local Armor = Functions.CheckArmor()
                        if Armor == nil or Armor <= 0 then
                            Busy = true
                            Functions.GetArmor(Character)
                            Busy = false
                        end
					end
                    wait()
				end

                RunService:UnbindFromRenderStep('ShootZombie')

				if DiedCon then DiedCon:Disconnect() end
            end
            if GameValues.StageName ~= 'Game' or not Functions.IsAlive() then break end
        end
        wait()
    end

    if Part then Part:Destroy() end
    Functions.NoClip(false)

    return true
end

local AFKKillZombies = function()
    while wait() do
        if YWR.State == 'Objective' and GameValues.StageName == 'Game' and Functions.IsAlive() then
            for _, Enemy in pairs(YWR.Infected:GetChildren()) do
                if Enemy and Enemy.PrimaryPart then
					local Distance = (Enemy.PrimaryPart.Position - Player.Character.PrimaryPart.Position).Magnitude
					if Distance <= _G.Settings.ObjectiveKillZombieRange then
						Functions.ShootZombie(Enemy, _G.Settings.ObjectiveKillZombieRange)
					end
				end
				if YWR.State ~= 'Objective' or not Player.Character or not Player.Character.PrimaryPart or GameValues.StageName ~= 'Game' then
					break
				end
            end
        end
    end
end

local StartCon = nil
local AFKFarm = function()
    spawn(AFKKillZombies)
    --spawn(Functions.DoAngles)
    while wait() do
        if GameValues.StageName == 'Game' and Functions.IsAlive() then
            local Data = GetObjective()
            warn(Data)
            if not Data then -- Kill zombie afk farm
                YWR.State = 'AFK'
                KillZombies()
            else -- do objective afk farm
                local Objective, Object = Data[1], Data[2]
                YWR.State = 'Objective'
                Objective.Run(Object)
            end
        else
            YWR.State = 'Waiting'
        end
    end
end

StartCon = UIS.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Keyboard then
        local Key = Input.KeyCode
        if Key == _G.Settings.AFKFarmKey then
            warn('Started AFK Farming!')
            spawn(AFKFarm)
            StartCon:Disconnect()
        end
    end
end)

warn('Fully loaded YouWontRemain!')