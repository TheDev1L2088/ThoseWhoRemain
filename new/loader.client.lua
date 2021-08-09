local RunService = game:GetService('RunService')

----------------------------------------------

_G.Settings = {

    -- Combat
    FortKeybinds = {
        ['Barbed Wire'] = Enum.KeyCode.C,
        ['Clap Bomb'] = Enum.KeyCode.V
    },
    FortPlaceOffset = -2.5,
    Recoil = 0.01,
    Penetration = 10, -- how many zombies a bullet can shoot through

    -- Auto farming
    AFKFarmKey = Enum.KeyCode.RightAlt, -- key that needs to be pressed to start farming
    SafeHeight = 12, -- how high up from secure objectives
	LookForHeal = 70, -- at how much health should it look for bandages/medkit
	ObjectiveKillZombieRange = 60,
	TargettingKillZombieRange = 60,
	GetBodyArmor = true,
	GamesBeforeRejoin = 3,
	HeadChance = 3, -- will always head shot bursters anyways

    -- Zombie shooting while auto farming
    MaxZombiesPerEvent = 3,
    MaxZombiesPerShot = 10,
}

----------------------------------------------

_G.Import = function(Source, JSON)
	local Repo = 'https://raw.githubusercontent.com/RainyLofi/ThoseWhoRemain/main/new/'
    if JSON then
        return RunService:IsStudio() and game:GetService('HttpService'):JSONDecode(script:WaitForChild(Source)) or game:GetService('HttpService'):JSONDecode(game:HttpGet(Repo .. Source .. '.lua', true))
    elseif RunService:IsStudio() then
		return require(script:WaitForChild(Source))
	else
		return loadstring(game:HttpGet(Repo .. Source .. '.lua', true))()
	end
end

_G.Import('init.client')