local Settings = {
	SafeHeight = 13, -- how high up from secure objectives

}

----------------------------------------------
--// Variables

local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')
local Player = game:GetService('Players').LocalPlayer

local World = Workspace:WaitForChild('World')
local ObjectiveFolder = World:WaitForChild('Objectives')

local GameStuff = ReplicatedStorage:WaitForChild('Game Stuff')
local StageName = GameStuff:WaitForChild('StageName')

local Entities = Workspace:WaitForChild('Entities')
local EntityObjectives = Entities:WaitForChild('Objectives')
local Infected = Entities:WaitForChild('Infected')

----------------------------------------------
--// Import function

local Import = function(Source)
	local Repo = 'https://raw.githubusercontent.com/RainyLofi/ThoseWhoRemain/main/'
	if RunService:IsStudio() then
		return require(script:WaitForChild(Source))
	else
		return loadstring(game:HttpGet(Repo .. 'Modules/' .. Source .. '.lua', true))()
	end
end

----------------------------------------------
--// Import modules

local Objectives = Import('Objectives')
local Teleport = Import('SafeTeleport')
local Functions = Import('Functions')


----------------------------------------------
--// Main

local Character = function()
	if Player and Player.Character then return Player.Character end
end

local Humanoid = function()
	local Char = Character()
	if Char then
		return Char:FindFirstChildOfClass('Humanoid')
	end
end

local GameValues = {}

for _, V in pairs(GameStuff:GetChildren()) do
	if V:IsA('NumberValue') or V:IsA('StringValue') or V:IsA('BoolValue') then
		GameValues[V.Name] = V.Value
		V.Changed:Connect(function()
			GameValues[V.Name] = V.Value
		end)
	end
end

local DataTable = {
	GameValues = GameValues,
	Objectives = ObjectiveFolder,

	Player = Player,
	Character = Character,
	Humanoid = Humanoid,

	Teleport = Teleport,
	Functions = Functions,

	Settings = Settings,
}

local Status = 'Nothing'

local FightStatuses = {'Objective', 'Nothing'}
spawn(function()
	while wait() do
		if table.find(FightStatuses, Status) and Player.Character and Player.Character.PrimaryPart and StageName.Value == 'Game' then
			for _, Enemy in pairs(Infected:GetChildren()) do
				if Enemy and Enemy.PrimaryPart then
					local Distance = (Enemy.PrimaryPart.Position - Player.Character.PrimaryPart.Position).Magnitude
					if Distance <= 15 then
						Functions.ShootZombie(Enemy)
					end
				end
				if not table.find(FightStatuses, Status) or not Player.Character or not Player.Character.PrimaryPart or StageName.Value ~= 'Game' then
					break
				end
			end
		end
	end
end)

while wait() do
	if StageName.Value == 'Game' then
		for _, Objective in pairs(ObjectiveFolder:GetChildren()) do
			local CompleteObjective = Objectives.List[Objective.Name]
			if CompleteObjective and CompleteObjective[2](Objective, DataTable) then
				Status = 'Objective'
				CompleteObjective[1](Objective, DataTable)
			end
			if StageName.Value ~= 'Game' then break end
		end
		if StageName.Value == 'Game' then
			for _, Objective in pairs(EntityObjectives:GetChildren()) do
				local CompleteObjective = Objectives.List[Objective.Name]
				if CompleteObjective and CompleteObjective[2](Objective, DataTable) then
					Status = 'Objective'
					CompleteObjective[1](Objective, DataTable)
				end
				if StageName.Value ~= 'Game' then break end
			end
		end
	end

	if StageName.Value == 'Game' then
		Status = 'TargettingZombies'
		Functions.TargetZombies(GameValues, Teleport, Objectives.GetHealable)
		Status = 'Nothing'
	end
end