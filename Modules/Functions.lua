local Workspace = game:GetService('Workspace')
local RunService = game:GetService('RunService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Services = ReplicatedStorage:WaitForChild('ServiceRemotes')
local InteractionService = Services:WaitForChild('InteractionService')
local ObjectiveService = Services:WaitForChild('ObjectiveService')

local RF = ReplicatedStorage:WaitForChild('RF')

local Player = game:GetService('Players').LocalPlayer

local Functions = {}

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

Functions.GetModule = function(Player, Module)
	local PlayerScripts = Player:WaitForChild('PlayerScripts')
	local Client = PlayerScripts:WaitForChild('Client')
	return require(Client:WaitForChild(Module))
end

Functions.ShootTank = function(Object)
	ObjectiveService.HitDamageable:FireServer(
		Object:FindFirstChild('Body'):FindFirstChild('Trailer'):FindFirstChild('Tank')
	)
end

Functions.IsAlive = function(Character, Humanoid)
	if Character and Humanoid then
		return (Character and Character.Parent and Humanoid and Humanoid.Health > 0 and Humanoid.WalkSpeed > 0)
	end
	return nil
end

return Functions