local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Workspace = game:GetService('Workspace')
local Modules = ReplicatedStorage:WaitForChild('Modules')
local Weapons = Modules:WaitForChild('Weapon Modules')

local RF = ReplicatedStorage:WaitForChild('RF')
local RE = ReplicatedStorage:WaitForChild('RE')

local Player = game:GetService('Players').LocalPlayer
local PlayerScripts = Player:WaitForChild('PlayerScripts')
local Client = PlayerScripts:WaitForChild('Client')

local senv = getsenv(Client)
local Fire2 = debug.getupvalues(senv.Fire2)

local Entities = Workspace:WaitForChild('Entities')
local Infected = Entities:WaitForChild('Infected')

warn('---------------')

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

local ShootZombie = function(AI)
	local WeaponList = Fire2[5]
	local LastEquipped, WeaponModel, WeaponStats = GetLastEquipped()
	local Weapon = WeaponList[1]
	if not Weapon or not WeaponModel or not WeaponStats then warn('Weapon not found', LastEquipped, WeaponModel, WeaponStats) return false end

	--[[Weapon.Mag = Weapon.Mag - 1

    local PosCF = WeaponModel.Pos.CFrame
    local A = PosCF:pointToObjectSpace(WeaponModel.AimPart.CFrame.p)
    --PosCF = PosCF * CFrame.new(A.x, A.y, 0)

    local Replicate = {
        Type = 'Fire',
        RandomX = Random.new():NextInteger(-1, 1),
        Mag = Weapon.Mag,
        PosCF = PosCF,
        ShotgunTable = nil,
        Direction = PosCF.lookVector,
        RecoilScale = 1,
    }

    RE:FireServer('GlobalReplicate', Replicate)

    local Damage = {
        AIs = {
			AI = AI,
            Velocity = PosCF.lookVector.unit.unit * 150,
            Special = 'Headshot',
            Damage = WeaponStats.Damage * 2.5 * 1,
		}
    }

    RE:FireServer('aa', Damage)]]--

    RE:FireServer(
        "GlobalReplicate",
        {
            ["Type"] = "Fire",
            ["RecoilScale"] = 1,
            ["RandomX"] = 0,
            ["Mag"] = Weapon.Pool,
            ["PosCF"] = CFrame.new(-57.0553169, 45.1759377, 51.003006, 0.533760428, 0.129877284, -0.835602522, 0.00888907537, 0.987218976, 0.159121037, 0.845589042, -0.0923602507, 0.525783837),
            ["Direction"] = Vector3.new(0.83560252189636, -0.15912103652954, -0.52578383684158)
        }
    )

    local AIs = {
        {
            ["AI"] = AI,
            ["Velocity"] = Vector3.new(125.34039306641, -23.868158340454, -78.867584228516),
            ["Special"] = "Headshot",
            ["Damage"] = WeaponStats.Damage * 2.5 * 1
        },
    }

    for _, Enemy in pairs(Infected:GetChildren()) do
        if Enemy and Enemy.PrimaryPart then
            local Distance = (AI.PrimaryPart.Position - Enemy.PrimaryPart.Position).Magnitude
            if Distance <= 20 then
                table.insert(AIs, {
                    ["AI"] = Enemy,
                    ["Velocity"] = Vector3.new(125.34039306641, -23.868158340454, -78.867584228516),
                    ["Special"] = "Headshot",
                    ["Damage"] = WeaponStats.Damage * 2.5 * 1
                })
            end
        end
    end

    RE:FireServer(
        "aa",
        {
            ["AIs"] = AIs
        }
    )

	return true
end

local Mouse = Player:GetMouse()

Mouse.KeyDown:Connect(function(k)
	k = k:upper()
	if k == 'U' then
		if Mouse.Target and Mouse.Target:IsDescendantOf(Infected) then
			if Mouse.Target.Parent:FindFirstChildOfClass('Humanoid') then
				local AI = Mouse.Target.Parent
				ShootZombie(AI)
			end
		end
	end
end)