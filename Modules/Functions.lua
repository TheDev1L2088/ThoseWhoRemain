local Workspace = game:GetService('Workspace')
local RunService = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Modules = ReplicatedStorage:WaitForChild('Modules')
local Weapons = Modules:WaitForChild('Weapon Modules')

local Services = ReplicatedStorage:WaitForChild('ServiceRemotes')
local InteractionService = Services:WaitForChild('InteractionService')
local ObjectiveService = Services:WaitForChild('ObjectiveService')

local RF = ReplicatedStorage:WaitForChild('RF')
local RE = ReplicatedStorage:WaitForChild('RE')

local Player = game:GetService('Players').LocalPlayer
local PlayerScripts = Player:WaitForChild('PlayerScripts')
local Client = PlayerScripts:WaitForChild('Client')

local senv = getsenv(Client)
local Fire2 = debug.getupvalues(senv.Fire2)

local Entities = Workspace:WaitForChild('Entities')
local Infected = Entities:WaitForChild('Infected')

local Ignore = Workspace:WaitForChild('Ignore')

local Functions = {}

Functions.CreateFloatingPart = function()
	local Part = Instance.new('Part', Ignore)
	Part.Size = Vector3.new(12, 1, 12)
	Part.Anchored = true
	Part.Transparency = 0.7
	Part.CanCollide = true
	Part.CollisionGroupId = 4
	return Part
end

Functions.Pickup = function(Interact)
	InteractionService.TryInteract:FireServer()
	local Data = Interact.ReturnTarget()
	if Data and Data.CanInteract then
		RF:InvokeServer(
			'CheckInteract',
			{
				['Target'] = Data
			}
		)
	end
end

Functions.PlaceItem = function()
	InteractionService.TryInteract:FireServer()
end

Functions.PickupObjectiveItem = function()
	InteractionService.TryInteract:FireServer()
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
	return require(Client:WaitForChild(Module))
end

Functions.ShootTank = function(Object)
	ObjectiveService.HitDamageable:FireServer(
		Object:FindFirstChild('Body'):FindFirstChild('Trailer'):FindFirstChild('Tank')
	)
end

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

Functions.ShootZombie = function(AI)
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

	wait(60 / WeaponStats.RPM)

	return true
end

Functions.TargetZombies = function(GameValues, SafeTeleport, GetHealable)
	local Part = Functions.CreateFloatingPart()
	Functions.NoClip(true)

	local Character = Player.Character
	local Humanoid = Player.Character:FindFirstChildOfClass('Humanoid')

	while GameValues.StageName == 'Game' and Functions.IsAlive(Character, Humanoid) do
		for _, Zombie in pairs(Infected:GetChildren()) do
			if Zombie and Zombie.PrimaryPart and Zombie:FindFirstChildOfClass('Humanoid') and Zombie:FindFirstChildOfClass('Humanoid').Health >= 0 then

				local Dead = false
				local DiedCon = nil

				DiedCon = Zombie:FindFirstChildOfClass('Humanoid').Died:Connect(function()
					Dead = true
					DiedCon:Disconnect()
				end)

				local Healing = false
				RunService:BindToRenderStep('ShootZombie', 2, function()
					if Zombie and Zombie.Parent and Zombie.PrimaryPart then
						Part.CFrame = Zombie.PrimaryPart.CFrame * CFrame.new(0, 6, 0)
						if not Healing then
							
							SafeTeleport(Player.Character, Part.CFrame * CFrame.new(math.random(-3, 3), 3.5, math.random(-3, 3)) * CFrame.Angles(math.rad(0), math.rad(math.random(0, 360)), math.rad(0)))
						end
					end
				end)

				while Zombie and Zombie.Parent and not Dead and Functions.IsAlive(Character, Humanoid) and GameValues.StageName == 'Game' do
					Functions.ShootZombie(Zombie)
					if Humanoid.Health <= 50 then
						Healing = true
						GetHealable(Character, SafeTeleport, Functions)
						Healing = false
					end
				end

				if DiedCon then DiedCon:Disconnect() end
			end
			if GameValues.StageName ~= 'Game' or not Functions.IsAlive(Character, Humanoid) then break end
		end
		wait()
	end
	if Part then Part:Destroy() end
	Functions.NoClip(false)
end

Functions.IsAlive = function(Character, Humanoid)
	if Character and Humanoid then
		return (Character and Character.Parent and Humanoid and Humanoid.Health > 0 and Humanoid.WalkSpeed > 0)
	end
	return nil
end

return Functions