local Workspace = game:GetService('Workspace')
local RunService = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Modules = ReplicatedStorage:WaitForChild('Modules')
local Weapons = Modules:WaitForChild('Weapon Modules')

local Player = game:GetService('Players').LocalPlayer
local PlayerScripts = Player:WaitForChild('PlayerScripts')
local Client = PlayerScripts:WaitForChild('Client')

local RF = ReplicatedStorage:WaitForChild('RF')
local RE = ReplicatedStorage:WaitForChild('RE')

local senv = getsenv(Client)
local Fire2 = debug.getupvalues(senv.Fire2)
local Entities = Workspace:WaitForChild('Entities')
local Infected = Entities:WaitForChild('Infected')

local GetLastEquipped = function()
	local Data = Fire2[3]
	local Objs = Data['Objs']
	local WeaponModel = nil
	local WeaponStats = nil
	if Objs and Objs['WeaponModel'] then
		WeaponModel = Objs['WeaponModel']
		WeaponModel:Clone().Parent = game.Lighting

		local Module = Weapons:FindFirstChild(WeaponModel.Name)
		if Module then WeaponStats = require(Module).Stats end
	end
	return Data.LastEquipped, WeaponModel, WeaponStats
end

local ShootZombie = function(AI, Range)
    
    if not Range then Range = 20 end
	local WeaponList = Fire2[5]
	local LastEquipped, WeaponModel, WeaponStats = GetLastEquipped()
	local Weapon = WeaponList[1]
	if not Weapon or not WeaponModel or not WeaponStats then warn('Weapon not found', LastEquipped, WeaponModel, WeaponStats) return false end

	RE:FireServer(
        "GlobalReplicate",
        {
            ["Type"] = "Fire",
            ["RecoilScale"] = 1,
            ["RandomX"] = 0,
            ["Mag"] = Weapon.Mag,
            ["PosCF"] = CFrame.new(-57.0553169, 45.1759377, 51.003006, 0.533760428, 0.129877284, -0.835602522, 0.00888907537, 0.987218976, 0.159121037, 0.845589042, -0.0923602507, 0.525783837),
            ["Direction"] = Vector3.new(0.83560252189636, -0.15912103652954, -0.52578383684158)
        }
    )

	local AILists = {
		{
			{
				["AI"] = AI,
				["Velocity"] = Vector3.new(125.34039306641, -23.868158340454, -78.867584228516),
				["Special"] = "Headshot",
				["Damage"] = WeaponStats.Damage * 2.5 * 1
			},
		}
	}

	local MaxPerList = 5
	local ListKey = 1
	for _, Enemy in pairs(Infected:GetChildren()) do
        if Enemy and Enemy.PrimaryPart then
            local Distance = (AI.PrimaryPart.Position - Enemy.PrimaryPart.Position).Magnitude
            if Distance <= Range then
				local List = AILists[ListKey]
				if #List >= MaxPerList then
					ListKey = ListKey + 1
					AILists[ListKey] = {}
					List = AILists[ListKey]
				end
                table.insert(List, {
                    ["AI"] = Enemy,
                    ["Velocity"] = Vector3.new(125.34039306641, -23.868158340454, -78.867584228516),
                    ["Special"] = "Headshot",
                    ["Damage"] = WeaponStats.Damage * 2.5 * 1
                })
            end
        end
    end

	for _, AIList in pairs(AILists) do
		RE:FireServer(
			"aa",
			{
				["AIs"] = AIList
			}
		)
	end

	wait(60 / WeaponStats.RPM)

	return true
end

local Mouse = Player:GetMouse()

Mouse.KeyDown:connect(function(Key)
    Key = Key:upper()
    if Key == 'U' then
        warn('here')
        if Mouse.Target and Mouse.Target:IsDescendantOf(Infected) and Mouse.Target.Parent:FindFirstChildOfClass('Humanoid') then
            warn('here 2')
            ShootZombie(Mouse.Target.Parent)
        end
    end
end)