wait()

----------------------------------------------
--// Variables

local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UIS = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')
local Player = Players.LocalPlayer

local YWR = _G.YWR

local FortInfo = require(YWR.Modules:WaitForChild('FortificationsInfo'))

----------------------------------------------
--// Weapon stat editor

for _, WeaponObj in pairs(YWR.Weapons:GetChildren()) do 
    if WeaponObj:IsA('ModuleScript') then
        local Weapon = require(WeaponObj)
        if Weapon and Weapon.Stats then
            Weapon.Stats.VerticleRecoil = math.rad(_G.Settings.Recoil)
            Weapon.Stats.HorizontalRecoil = math.rad(_G.Settings.Recoil)
            Weapon.Stats.RecoilShake = _G.Settings.Recoil
            Weapon.Stats.MaxPen = _G.Settings.Penetration

            if Weapon.Stats.Type == 'Flamethrower' then
                Weapon.Stats.Range = 250
            end

            if Weapon.Animations and Weapon.Animations.Reload then -- instant reload
                Weapon.Animations.Reload = {
                    Number = 1,
                    CurrentTime = 0,
                    Sequence = {
                        {
                            Time = 0.1,
                            AddAmmo = {},
                        }
                    }
                }
            end
        end
    end
end

----------------------------------------------
--// Infinite Ammo & Building Supplies

spawn(function()
    while wait() do
        if YWR.Imports.Functions.IsAlive() then
            local OCE = YWR.ClientEnv.OnClientEvent
            local UV = debug.getupvalues(OCE)

            local Forts, Ammo = UV[3]['List'], UV[4]

            for Name, Fortification in pairs(FortInfo) do -- unlimited fortifications
                local Found = false
                for _, Fort in pairs(Forts) do
                    if Fort.Name == Name then
                        Found = true
                    end
                end
                if not Found then
                    table.insert(Forts, {
						Name = Name,
						Count = Fortification.Count
					})
                end
            end

            for _, WeaponData in pairs(Ammo) do -- unlimited ammo
                if WeaponData.Name and YWR.Weapons:FindFirstChild(WeaponData.Name) and WeaponData.Pool then
                    local GunData = require(YWR.Weapons:FindFirstChild(WeaponData.Name))
                    if GunData and GunData.Stats and GunData.Stats.Pool then
						WeaponData.Pool = GunData.Stats.Pool
					end
                end
            end

        end
    end
end)

----------------------------------------------
--// Always headshot & silent aim

local DoSilentAim = function(WeaponStats, AI)
    local Targets = {}
    for _, Enemy in pairs(YWR.Infected:GetChildren()) do
        if Enemy and Enemy.PrimaryPart and AI and AI.Parent and AI.PrimaryPart and Enemy ~= AI then
            local Distance = (AI.PrimaryPart.Position - Enemy.PrimaryPart.Position).Magnitude
            if Distance <= _G.Settings.SilentAimDistance then
                table.insert(Targets, Enemy)
            end
        end
    end

    local AILists = {{}}
    local MaxPerList = _G.Settings.MaxZombiesPerEvent
    local ListKey = 1
    local ZombieCount = 1
    for _, Target in pairs(Targets) do
        if ZombieCount < _G.Settings.MaxZombiesPerShot then
            local List = AILists[ListKey]
            if #List >= MaxPerList then
                ListKey += 1
                AILists[ListKey] = {}
                List = AILists[ListKey]
            end
            table.insert(List, {
                ["AI"] = Target,
                ["Velocity"] = Vector3.new(125.34039306641, -23.868158340454, -78.867584228516),
                ["Special"] = 'Headshot',
                ["Damage"] = WeaponStats.Damage * 2.5 * 1
            })
            ZombieCount = ZombieCount + 1
        end
    end

    -- Deal damage
    for _, AIList in pairs(AILists) do
        if #AIList > 0 then
            YWR.RE:FireServer(
                "aa",
                {
                    ["AIs"] = AIList
                }
            )
        end
	end

end

local mt = getrawmetatable(game)

local old
old = hookfunction(mt.__namecall, function(...)
	if checkcaller() then return old(...) end
    local Args = {...}
	local NamecallMethod = getnamecallmethod()

	if NamecallMethod == 'FireServer' and Args[2] and Args[2] == 'aa' then
		if Args[3] and Args[3]['AIs'] and type(Args[3]['AIs']) == 'table' then
            local WeaponModel, WeaponStats = YWR.Imports.Functions.GetWeaponModel()
			if WeaponStats and WeaponModel then
				local DoRedirect = 1

				if WeaponStats.Type == 'Flamethrower' then
					DoRedirect = math.random(1, 2)
				end

				if DoRedirect == 1 then
					for _, AI in pairs(Args[3]['AIs']) do
						AI['Special'] = 'Headshot'
						AI['Damage'] = WeaponStats.Damage * 2.5 * 1
					end
                    if _G.Settings.SilentAim then
                        local r, e = pcall(function()
                            DoSilentAim(WeaponStats, Args[3]['AIs'][1].AI)
                        end)
                        if e then warn(e) end
                    end
					return old(unpack(Args))
				end
			end
		end
	end

	return old(...)
end)

----------------------------------------------
--// Place fortification keybinds

UIS.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Keyboard then
        local Key = Input.KeyCode
        local Fort = _G.Settings.FortKeybinds[Key]

        if Fort and YWR.Imports.Functions.IsAlive() then
            local HRP = Player.Character.PrimaryPart
            local CF = HRP.CFrame * CFrame.new(0, _G.Settings.FortPlaceOffset, 0)
            YWR.Imports.Functions.PlaceFort(Fort, CF)
        end
    end
end)

----------------------------------------------

warn('CombatManager loaded.')
return true