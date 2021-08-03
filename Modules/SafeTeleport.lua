local HumanoidConnections = {'Changed', 'StateChanged'}

return function(Character, CF)
	for _, Child in pairs(Character:GetChildren()) do
		if Child:IsA('BasePart') then
			pcall(function()
				for _, Connection in pairs(getconnections(Child.Changed)) do
					Connection:Disable()
				end
			end)
		end
	end

    local Humanoid = Character:FindFirstChildOfClass('Humanoid')
    if Humanoid then
        for _, Con in pairs(HumanoidConnections) do
            pcall(function()
                for _, Connection in pairs(getconnections(Humanoid[Con])) do
                    Connection:Disable()
                end
            end)
        end
    end

	Character.PrimaryPart.CFrame = CF
	Character:SetPrimaryPartCFrame(CF)
end