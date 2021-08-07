local RunService = game:GetService('RunService')

----------------------------------------------

_G.Settings = {

    -- Combat
    FortKeybinds = {
        [Enum.KeyCode.C] = 'Barbed Wire',
        [Enum.KeyCode.V] = 'Clap Bomb'
    },
    FortPlaceOffset = -2.4,
    Recoil = 0.01,
    Penetration = 10, -- how many zombies a bullet can shoot through

    -- Auto farming
    AFKFarmKey = Enum.KeyCode.RightAlt, -- key that needs to be pressed to start farming
    SafeHeight = 12, -- how high up from secure objectives
	LookForHeal = 70, -- at how much health should it look for bandages/medkit
	ObjectiveKillZombieRange = 60,
	TargettingKillZombieRange = 30,
	GetBodyArmor = true,
	GamesBeforeRejoin = 3,
	HeadChance = 3, -- will always head shot bursters anyways

    -- Zombie shooting while auto farming
    MaxZombiesPerEvent = 3,
    MaxZombiesPerShot = 10,
}

----------------------------------------------

_G.Import = function(Source)
	local Repo = 'https://raw.githubusercontent.com/RainyLofi/ThoseWhoRemain/main/new/'
	if RunService:IsStudio() then
		return require(script:WaitForChild(Source))
	else
		return loadstring(game:HttpGet(Repo .. 'Modules/' .. Source .. '.lua', true))()
	end
end

_G.Import('init.client')