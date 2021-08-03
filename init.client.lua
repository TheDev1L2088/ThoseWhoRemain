local Settings = {
	SafeHeight = 10, -- how high up from secure objectives

}

----------------------------------------------
--// Variables

local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RunService = game:GetService('RunService')
local Player = game:GetService('Players').LocalPlayer

local World = Workspace:WaitForChild('World')
local ObjectiveFolder = World:WaitForChild('Objectives')

local GameStuff = ReplicatedStorage:WaitForChild('Game Stuff')
local StageName = GameStuff:WaitForChild('StageName')


----------------------------------------------
--// Import function

local Import = function(Source)
	local Repo = 'https://raw.githubusercontent.com/RainyLofi/ThoseWhoRemain/'
	if RunService:IsStudio() then
		return require(script:WaitForChild(Source))
	else
		return loadstring(game:HttpGet(Repo .. 'Modules/' .. Source .. '.lua', true))()
	end
end

----------------------------------------------
--// Import modules

local Objectives = Import('Objectives')
local Teleport = Import('SafeTeleport')


----------------------------------------------
--// Main

local Thread = nil
local StageNameCon = nil
StageName.Changed:Connect(function()
	if StageName.Value ~= 'Game' and Thread and coroutine.status(Thread) ~= 'suspended' then
		if coroutine.status(Thread) ~= 'suspended' then
			coroutine.yield(Thread)
		end
	end
end)

while wait() do
	if StageName.Value == 'Game' then
		for _, Objective in pairs(ObjectiveFolder:GetChildren()) do
			local CompleteObjective = Objectives.List[Objective.Name]
			if CompleteObjective then

				Thread = coroutine.create(function(...)
					if StageNameCon then StageNameCon:Disconnect() end
					StageNameCon = StageName.Changed:Connect(function()
						if StageName.Value ~= 'Game' then
							StageNameCon:Disconnect()
							Thread = nil
							coroutine.yield()
						end
					end)

					if not CompleteObjective(...) then
						StageNameCon:Disconnect()
						Thread = nil
					end
				end)

				coroutine.resume(Thread, Objective, {
					
				})
				repeat wait() until not Thread
			end
			if StageName.Value ~= 'Game' then break end
		end
	end
end