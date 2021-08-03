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
            local r, e = pcall(function()
                for _, Connection in pairs(getconnections(Humanoid[Con])) do
                    warn('Got connection for', Con)
                    Connection:Disable()
                end
            end)
            if e then warn(e) end
        end
    end

	Character.PrimaryPart.CFrame = CF
	Character:SetPrimaryPartCFrame(CF)
end