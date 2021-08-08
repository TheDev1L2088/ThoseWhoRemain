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
                local Reload = Weapon.Animations.Reload
                for i, Anim in pairs(Reload.Sequence) do
                    if i > 1 then table.remove(Reload.Sequence, i) end
                end

                Reload.Sequence[1].AddAmmo = {}
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
--// Always headshot

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
    if Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode then
        local Key = Input.KeyCode
        local Fort = nil

        for Name, Bind in pairs(_G.Settings.FortKeybinds) do
            if Bind == Key then
                Fort = Name
                break
            end
        end

        if Fort and YWR.Imports.Functions.IsAlive() then
            local HRP = Player.Character:FindFirstChild('HumanoidRootPart')
            local CF = HRP.CFrame * CFrame.new(0, _G.Settings.FortPlaceOffset, 0)
            YWR.Imports.Functions.PlaceFort(Fort, CF)
        end
    end
end)

----------------------------------------------

warn('CombatManager loaded.')
return true