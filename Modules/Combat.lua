local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Modules = ReplicatedStorage:WaitForChild('Modules')
local Weapons = Modules:WaitForChild('Weapon Modules')

local Player = game:GetService('Players').LocalPlayer

local CurrentWeaponData = nil

for _, WeaponObj in pairs(Weapons:GetChildren()) do
	local Weapon = require(WeaponObj)
	if Weapon and Weapon.Stats then
		Weapon.Stats.VerticleRecoil = math.rad(0.01)
		Weapon.Stats.HorizontalRecoil = math.rad(0.01)
		Weapon.Stats.RecoilShake = 0.01
		Weapon.Stats.MaxPen = 10

		if Weapon.Stats.Type == 'Flamethrower' then
			Weapon.Stats.Range = 250
			Weapon.Animations.Reload = {
				Number = 1,
				CurrentTime = 0,
				PullBack = {100, 100},
				Sequence = {
					{
						Time = 0.1,
						Sound = {
							Played = false,
							Sound = 'rbxassetid://1425270902',
							PlaybackSpeed = 1.2
						},
						AddAmmo = {},
					}
				}
			}
		elseif WeaponObj.Name == 'M60' then
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
		elseif WeaponObj.Name == 'Katana' then
            local SwingAnim = Weapon.Animations.Swing
            for _, Animation in pairs(SwingAnim.Sequence) do
                if Animation.Time then
                    Animation.Time = Animation.Time * 0.5
                end
            end
            local EquipAnim = Weapon.Animations.Equip
            for _, Animation in pairs(EquipAnim.Sequence) do
                if Animation.Time then
                    Animation.Time = Animation.Time * 0.5
                end
            end
		end
	end
	if Weapon and Weapon.Animations then
		local ReloadAnim = Weapon.Animations.Reload
		if ReloadAnim then
			for _, Anim in pairs(ReloadAnim.Sequence) do
				if Anim.Time >= 0.18 then
					Anim.Time = Anim.Time * 0.4
				else
					Anim.Time = .001
				end
			end
		end
	end
end

local GameStuff = ReplicatedStorage:WaitForChild('Game Stuff')
local StageName = GameStuff:WaitForChild('StageName')

local CharacterConnection = function(Character)
    repeat wait() until StageName.Value == 'Game'
	local Humanoid = Character:WaitForChild('Humanoid')
	local Client = Player:WaitForChild('PlayerScripts'):FindFirstChild('Client')
	local FortInfo = require(Modules:WaitForChild('FortificationsInfo'))
	local SpawnAndDie = require(Client:WaitForChild('Spawn/Die'))

	local env = getsenv(Client)
	local OCE = env.OnClientEvent
	env = debug.getupvalues(OCE)

	local Forts = env[3]
	local Ammo = env[4]

	local List = Forts['List']

	spawn(function()
		while wait() do
			for Name, Data in pairs(FortInfo) do
				local NotFound = true
				for i,v in pairs(List) do
					if v.Name == Name then
						NotFound = false 
						break
					end
				end

				if NotFound then
					table.insert(List, {
						Name = Name,
						Count = Data.Count
					})
				end
			end

			for _, Data in pairs(Ammo) do
				if Data and Data.Name and Weapons:findFirstChild(Data.Name) and Data.Pool then
					local GunData = require(Weapons:findFirstChild(Data.Name))
					if GunData and GunData.Stats and GunData.Stats.Pool then
						Data.Pool = GunData.Stats.Pool
					end
				end
			end
		end
	end)
end

Player.CharacterAdded:Connect(CharacterConnection)
if Player.Character then
	CharacterConnection(Player.Character)
end

local mt = getrawmetatable(game)

local old
old = hookfunction(mt.__namecall, function(...)
	if checkcaller() then return old(...) end

	local Args = {...}
	local Self = select(1, ...)
	local NamecallMethod = getnamecallmethod()


	if NamecallMethod == 'FireServer' and Args[2] and Args[2] == 'aa' then
		if Args[3] and Args[3]['AIs'] and type(Args[3]['AIs']) == 'table' then 
			if CurrentWeaponData and CurrentWeaponData.Stats then
				local GunData = CurrentWeaponData.Stats
				local DoRedirect = 1

				if GunData.Type == 'Flamethrower' then 
					DoRedirect = math.random(1, 2)
				end

				if DoRedirect == 1 then
					for _, AI in pairs(Args[3]['AIs']) do
						AI['Special'] = 'Headshot'
						AI['Damage'] = GunData.Damage * 2.5 * 1
						--AI['Edit'] = truez
					end
					return old(unpack(Args))
				end
			end
		end
	end

	return old(...)
end)

local Mouse = Player:GetMouse()
local PlaceEvent = game:GetService("ReplicatedStorage").RE
local Place = function(Item, CFrame) -- Barbed Wire, Clap Bomb
	PlaceEvent:FireServer(
		"PlaceFortification",
		{
			["PlaceCF"] = CFrame,
			["FortName"] = Item
		}
	)
end

Mouse.KeyDown:connect(function(Key)
	Key = Key:upper()

	local Character = Player.Character
	if not Character or not Character:findFirstChild('HumanoidRootPart') then 
		return
	end

	local HRP = Character:findFirstChild('HumanoidRootPart')
	local CF = HRP.CFrame * CFrame.new(0, -2.4, 0)

	if Key == 'C' then
		Place('Barbed Wire', CF)
	elseif Key == 'V' then
		Place('Clap Bomb', CF)
	end
end)


spawn(function()
    while wait() do
        if Player and Player.Character then
            if Player.Character:FindFirstChildOfClass('Model') then
                local Name = Player.Character:FindFirstChildOfClass('Model').Name
                if Weapons:FindFirstChild(Name) then
                    CurrentWeaponData = require(Weapons:FindFirstChild(Name))
                end
            end
        end
    end
end)

return true