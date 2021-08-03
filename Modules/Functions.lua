local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Services = ReplicatedStorage:WaitForChild('ServiceRemotes')
local InteractionService = Services:WaitForChild('InteractionService')

local RF = ReplicatedStorage:WaitForChild('RF')

local Functions = {}

Functions.Pickup = function(Item, Interact)
	InteractionService.TryInteract:FireServer()
	local Data = Interact.ReturnTarget()
	warn(Data)
	if Data.CanInteract then
		warn('Can Interact')
		RF:InvokeServer(
			'CheckInteract',
			{
				['Target'] = Data
			}
		)
	end
end

Functions.GetModule = function(Player, Module)
	local PlayerScripts = Player:WaitForChild('PlayerScripts')
	local Client = PlayerScripts:WaitForChild('Client')
	return require(Client:WaitForChild(Module))
end

Functions.ShootTank = function()
	
end

Functions.IsAlive = function(Character, Humanoid)
	if Character and Humanoid then
		return (Character and Character.Parent and Humanoid and Humanoid.Health > 0 and Humanoid.WalkSpeed > 0)
	end
	return nil
end

return Functions