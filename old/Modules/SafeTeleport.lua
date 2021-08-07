local Parts = {}

return function(Character, CF)
	for _, Child in pairs(Character:GetChildren()) do
		if Child:IsA('BasePart') and not table.find(Parts, Child) then
			for _, Connection in pairs(getconnections(Child.Changed)) do
				Connection:Disable()
			end
			table.insert(Parts, Child)
		end
	end

	if Character.PrimaryPart then
		Character.PrimaryPart.CFrame = CF
		Character:SetPrimaryPartCFrame(CF)
	end
end