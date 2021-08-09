local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UIS = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')

local Player = game:GetService('Players').LocalPlayer
local PlayerScripts = Player:WaitForChild('PlayerScripts')

if game.PlaceId ~= 488667523 then warn('Not Those Who Remain') return end
if not getsenv then getsenv = function() warn('no getsenv?') return {} end end

----------------------------------------------

local Recording = false
local Storage = {}

local FormatStorage = function()
    setclipboard(game:GetService('HttpService'):JSONEncode(Storage))
end

UIS.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Keyboard then
        local Key = Input.KeyCode
        if Key == Enum.KeyCode.Z then
            Recording = true
            warn('Recording')
        end
    end
end)
UIS.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.Keyboard then
        local Key = Input.KeyCode
        if Key == Enum.KeyCode.Z then
            Recording = false
            warn('Stopped recording')
            FormatStorage()
        end
    end
end)

----------------------------------------------

local mt = getrawmetatable(game)

local old
old = hookfunction(mt.__namecall, function(...)
	if checkcaller() then return old(...) end
    local Args = {...}
	local NamecallMethod = getnamecallmethod()

	if NamecallMethod == 'FireServer' and Recording and Args[2] and Args[2] == 'GlobalReplicate' and Args[3] and Args[3]['Angle'] then
		local Data = Args[3]
        table.insert(Storage, Data)
	end

	return old(...)
end)

