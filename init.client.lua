
wait(10) if game.PlaceId ~= 488667523 then warn('Not Those Who Remain') return end

local Settings = {
	SafeHeight = 12.5, -- how high up from secure objectives
	LookForHeal = 75, -- at how much health should it look for bandages/medkit
	ObjectiveKillZombieRange = 60,
	TargettingKillZombieRange = 30,
	GetBodyArmor = true,
	GamesBeforeRejoin = 3,
	HeadChance = 3,
}

----------------------------------------------
--// Variables

local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')

local Player = Players.LocalPlayer

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

spawn(function()
	Import('Combat') -- runs all combat-related stuff
end)

----------------------------------------------
--// Anti AFK

local VirtualUser = game:GetService('VirtualUser')

if not RunService:IsStudio() then
	for index, value in next, getconnections(Player.Idled) do
		value:Disable()
	end

	Player.Idled:Connect(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
		VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(1)
		VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	end)
end

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

----------------------------------------------
--// Stop client from reporting to anti cheat

local Rejoin = function()
	game:GetService('TeleportService'):Teleport(game.PlaceId, game.JobId)
end

if not RunService:IsStudio() then
	local mt = getrawmetatable(game)

	local old
	old = hookfunction(mt.__namecall, function(...)
		if checkcaller() then return old(...) end

		local Args = {...}
		local Self = select(1, ...)
		local NamecallMethod = getnamecallmethod()


		if NamecallMethod == 'FireServer' then
			if Args[2] and Args[2] == 'RejoinK' then spawn(Rejoin) return wait(9e9) end
			if Args[2] and Args[2] == 'CheatKick' then spawn(Rejoin) return wait(9e9) end
		end

		return old(...)
	end)
end

if #Players:GetPlayers() > 1 then warn('Other players!') return end
----------------------------------------------

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
					if Distance <= Settings.ObjectiveKillZombieRange then
						Functions.ShootZombie(Enemy, Settings.ObjectiveKillZombieRange, Settings.HeadChance)
					end
				end
				if not table.find(FightStatuses, Status) or not Player.Character or not Player.Character.PrimaryPart or StageName.Value ~= 'Game' then
					break
				end
			end
		end
	end
end)

local Games = 0
GameStuff.Wave.Changed:Connect(function()
	if GameStuff.Wave.Value == 1 then
		Games = Games + 1

		if Games > Settings.GamesBeforeRejoin then
			Rejoin()
		end
	end
end)

while wait() do
	if StageName.Value == 'Game' then
		if Settings.GetBodyArmor then
			local Armor = Functions.GetArmor()
			if Armor ~= nil and Armor <= 0 then
				Objectives.GetArmor(Player.Character, Teleport, Functions)
				wait()
			end
		end
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
		Functions.TargetZombies(GameValues, Teleport, Objectives.GetHealable, Settings)
		Status = 'Nothing'
	end
end