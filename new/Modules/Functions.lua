wait()

----------------------------------------------
--// Variables

local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')
local Player = Players.LocalPlayer

local YWR = _G.YWR

----------------------------------------------
--// Functions

local Functions = {}

Functions.CreateFloatingPart = function()
	local Part = Instance.new('Part', YWR.Ignore)
	Part.Size = Vector3.new(12, 1, 12)
	Part.Anchored = true
	Part.Transparency = 0.7
	Part.CanCollide = true
	Part.CollisionGroupId = 4
	return Part
end

Functions.PlaceFort = function(Fort, CFrame)
    YWR.RE:FireServer(
		"PlaceFortification",
		{
			["PlaceCF"] = CFrame,
			["FortName"] = Fort
		}
	)
end

Functions.GetArmor = function()
	if Player and Player.Character then
		local Armor = Player.Character:WaitForChild('Armor')
		return Armor.Value
	else
		return nil
	end
end

Functions.Pickup = function(Interact)
	YWR.InteractionService.TryInteract:FireServer()
	local Data = Interact.ReturnTarget()
	if Data and Data.CanInteract then
		YWR.RF:InvokeServer(
			'CheckInteract',
			{
				['Target'] = Data
			}
		)
	end
end

Functions.PlaceItem = function()
	YWR.InteractionService.TryInteract:FireServer()
end

Functions.PickupObjectiveItem = function()
	YWR.InteractionService.TryInteract:FireServer()
end

local Noclipped = false
Functions.NoClip = function(state)
	Noclipped = state
end

RunService.Stepped:Connect(function()
	if Player and Player.Character and Player.Character:FindFirstChildOfClass('Humanoid') then
		local Character, Humanoid = Player.Character, Player.Character:FindFirstChildOfClass('Humanoid')
		if Functions.IsAlive(Character, Humanoid) and Noclipped then
			for _, child in pairs(Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true then
					child.CanCollide = false
				end
			end
		end
	end
end)

Functions.GetModule = function(Module)
	return require(YWR.Client:WaitForChild(Module))
end

Functions.ShootTank = function(Object)
	YWR.ObjectiveService.HitDamageable:FireServer(
		Object:FindFirstChild('Body'):FindFirstChild('Trailer'):FindFirstChild('Tank')
	)
end

Functions.HeadshotChance = function(WeaponStats, AI)
	local r, HeadChance = 1, _G.Settings.HeadChance
	if HeadChance ~= 1 then
		r = math.random(1, HeadChance)
	end

	if AI.Name == 'Burster' or AI.Name == 'Bloater' or AI.Name == 'Riot' then r = 1 end
	if r == 1 then
		return WeaponStats.Damage * 2.5 * 1, 'Headshot'
	else
		return WeaponStats.Damage, nil
	end
end

Functions.GetWeaponModel = function()
    local Data = YWR.Fire2[3]
    local Objs = Data['Objs']
    local WeaponModel, WeaponStats = nil, nil

    if Objs and Objs['WeaponModel'] then
        WeaponModel = Objs['WeaponModel']
        local Module = _G.YWR.Weapons:FindFirstChild(WeaponModel.Name)
        if Module then WeaponStats = require(Module).Stats end
    end
    return WeaponModel, WeaponStats
end

Functions.ShootZombie = function(AI, Range)
    local WeaponList = YWR.Fire2[5]
	local Weapon = WeaponList[1]

    local WeaponModel, WeaponStats = Functions.GetWeaponModel()
    if not WeaponModel then warn('No weapon model!') return end
    if not WeaponStats then warn('No weapon stats!') return end

    -- Enable damage functions
    YWR.RE:FireServer(
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

    -- Get all nearby zombies
    local Damage, Special = Functions.HeadshotChance(WeaponStats, AI)
	local AILists = {
		{
			{
				["AI"] = AI,
				["Velocity"] = Vector3.new(125.34039306641, -23.868158340454, -78.867584228516),
				["Special"] = Special,
				["Damage"] = Damage,
			},
		}
	}

    local MaxPerList = _G.Settings.MaxZombiesPerEvent
	local ListKey = 1
    local ZombieCount = 1
	for _, Enemy in pairs(YWR.Infected:GetChildren()) do
        if Enemy and Enemy.PrimaryPart and AI and AI.Parent and AI.PrimaryPart then
            local Distance = (AI.PrimaryPart.Position - Enemy.PrimaryPart.Position).Magnitude
            if Distance <= Range and ZombieCount < _G.Settings.MaxZombiesPerShot then
				local List = AILists[ListKey]
				if #List >= MaxPerList then
					ListKey += 1
					AILists[ListKey] = {}
					List = AILists[ListKey]
				end
				local AIDamage, AISpecial = Functions.HeadshotChance(WeaponStats, Enemy)
                table.insert(List, {
                    ["AI"] = Enemy,
                    ["Velocity"] = Vector3.new(125.34039306641, -23.868158340454, -78.867584228516),
                    ["Special"] = AISpecial,
                    ["Damage"] = AIDamage
                })
                ZombieCount = ZombieCount + 1
            end
        end
    end

    -- Deal damage
    for _, AIList in pairs(AILists) do
		YWR.RE:FireServer(
			"aa",
			{
				["AIs"] = AIList
			}
		)
	end


	wait(60 / (WeaponStats.RPM * 1.5)) -- make sure not to flag any speed checks

	return true
end

Functions.IsAlive = function()
    local Character = YWR.Character()
    if Character and Character:FindFirstChildOfClass('Humanoid') then
        local Humanoid = Character:FindFirstChildOfClass('Humanoid')
        return (Humanoid.Health > 0 and Character:FindFirstChild('HumanoidRootPart') and Character.PrimaryPart and Character.Parent) and Humanoid.Health or false
    end
    return nil
end

----------------------------------------------

warn('Functions loaded.')
return Functions