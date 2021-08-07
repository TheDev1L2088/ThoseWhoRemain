wait()

----------------------------------------------
--// Variables

local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')

----------------------------------------------
--// Main

if not RunService:IsStudio() then
	local mt = getrawmetatable(game)

	local old
	old = hookfunction(mt.__namecall, function(...)
		if checkcaller() then return old(...) end

		local Args = {...}
		local NamecallMethod = getnamecallmethod()


		if NamecallMethod == 'FireServer' then
			if Args[2] and Args[2] == 'RejoinK' then return wait(9e9) end
			if Args[2] and Args[2] == 'CheatKick' then return wait(9e9) end
			if Args[2] and Args[2] == 'GlobalReplicate' and Args[3] and type(Args[3]) == 'table' then
				--[[if Args[3]['Type'] and Args[3]['Type'] == 'Fire' then
					spawn(function() -- rainbow bullets
						RE:FireServer(
							"EditData",
							{
								{
									["Option"] = "TracerNum",
									["Type"] = "EditOptions",
									["Value"] = math.random(2, 14)
								}
							}
						)
					end)
				end]]--
			end
		elseif NamecallMethod:lower() == 'kick' then
			return wait(9e9)
		end

		return old(...)
	end)
end

----------------------------------------------

warn('StopReporting loaded.')
return true