--[[VARIABLE DEFINITION ANOMALY DETECTED, DECOMPILATION OUTPUT POTENTIALLY INCORRECT]]--
-- Decompiled with the Synapse X Luau decompiler.

local l__GuiService__1 = game:GetService("GuiService");
local l__RF__2 = game.ReplicatedStorage.RF;
local v3 = require(game.ReplicatedStorage.Nevermore);
local l__SurfaceGuis__4 = workspace:WaitForChild("Lobby").BulletinBoard.SurfaceGuis;
local v5 = {};
local v6 = { 1163048, 4900333 };
function CanClick(p1)
	local v7, v8, v9 = pairs({ p1["XBOX Message"], p1["Login Rewards"], p1.Revive, p1.Gift });
	while true do
		local v10, v11 = v7(v8, v9);
		if v10 then

		else
			break;
		end;
		v9 = v10;
		if v11.Visible then
			return false;
		end;	
	end;
	return true;
end;
local l__SoundService__1 = game:GetService("SoundService");
function LoginRewardsClose(p2)
	l__SoundService__1.Menu.MenuClick:Play();
	p2["Login Rewards"].Visible = false;
end;
local l__RE__2 = game.ReplicatedStorage.RE;
function AcceptRevive(p3)
	l__RE__2:FireServer("AcceptRev", nil);
	p3.Revive.Visible = false;
end;
function DenyRevive(p4)
	l__SoundService__1.Menu.Cancel:Play();
	l__RE__2:FireServer("DenyRevive", nil);
	p4.Revive.Visible = false;
end;
local u3 = "Primary";
function SkinClick(p5, p6, p7)
	local v12, v13, v14 = pairs(p5.Weapons);
	while true do
		local v15, v16 = v12(v13, v14);
		if v15 then

		else
			break;
		end;
		v14 = v15;
		local l__Stats__17 = require(game.ReplicatedStorage.Modules["Weapon Modules"][v15]).Stats;
		if v16.Equipped then
			if l__Stats__17.Slot == u3 then
				if v16.Skin then
					if v16.Skin[2] ~= p7 then
						if not p6 then
							if not p7 then
								l__RE__2:FireServer("EditData", { {
										Type = "UnchooseSkin", 
										WeaponName = v15
									} });
								return;
							else
								l__RE__2:FireServer("EditData", { {
										Type = "ChooseNewSkin", 
										WeaponName = v15, 
										Tier = p6, 
										SkinName = p7
									} });
								return;
							end;
						else
							l__RE__2:FireServer("EditData", { {
									Type = "ChooseNewSkin", 
									WeaponName = v15, 
									Tier = p6, 
									SkinName = p7
								} });
							return;
						end;
					else
						l__RE__2:FireServer("EditData", { {
								Type = "UnchooseSkin", 
								WeaponName = v15
							} });
						return;
					end;
				elseif not p6 then
					if not p7 then
						l__RE__2:FireServer("EditData", { {
								Type = "UnchooseSkin", 
								WeaponName = v15
							} });
						return;
					else
						l__RE__2:FireServer("EditData", { {
								Type = "ChooseNewSkin", 
								WeaponName = v15, 
								Tier = p6, 
								SkinName = p7
							} });
						return;
					end;
				else
					l__RE__2:FireServer("EditData", { {
							Type = "ChooseNewSkin", 
							WeaponName = v15, 
							Tier = p6, 
							SkinName = p7
						} });
					return;
				end;
			end;
		end;	
	end;
end;
local u4 = nil;
local u5 = nil;
function AcceptPurchase(p8)
	if u4 then
		l__RE__2:FireServer("EditData", { {
				Type = "BuyWeapon", 
				Name = u4
			} });
	end;
	if u5 then
		l__RE__2:FireServer("EditData", { {
				Type = "BuyCase", 
				Tier = u5
			} });
	end;
	p8.Menu.Confirm.Visible = false;
end;
local u6 = nil;
local u7 = {};
function CancelPurchase(p9, p10, p11)
	l__SoundService__1.Menu.Cancel:Play();
	p9.Menu.Confirm.Visible = false;
	if u6 == "Loadout" then
		u7.UpdateLoadout(p9, p10, p11);
	end;
end;
function AcceptPrepurchase(p12, p13, p14)
	if u4 then
		local v18 = require(game.ReplicatedStorage.Modules["Weapon Modules"][u4]);
		if not v18.Stats.PerkLocked then
			if p14.Stats.Level < v18.Stats.Level then
				if CalculatePrepurchase(v18.Stats.Price, v18.Stats.Level, p14.Stats.Level) <= p14.Stats.Credits then
					l__RE__2:FireServer("EditData", { {
							Type = "PrepurchaseWeapon", 
							Name = u4
						} });
				else
					l__SoundService__1.Menu.Cancel:Play();
					u7.AddNotification({
						Parent = p12.NotificationsHolder, 
						Text = "Insufficient credits", 
						Position = UDim2.new(0.5, 0, 0, 216), 
						BackgroundTransparency = 1, 
						Size = UDim2.new(0, 0, 0, 12), 
						TextStrokeColor3 = Color3.new(), 
						TextStrokeTransparency = 0.5, 
						TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
						TextStrokeTransparency = 0.6, 
						TextTransparency = 0.2, 
						Font = "Highway", 
						TextSize = 16, 
						TextXAlignment = "Center"
					}, "Top");
					u7.UpdateLoadout(p12, p13, p14);
				end;
			else
				l__SoundService__1.Menu.Cancel:Play();
				u7.AddNotification({
					Parent = p12.NotificationsHolder, 
					Text = "Insufficient credits", 
					Position = UDim2.new(0.5, 0, 0, 216), 
					BackgroundTransparency = 1, 
					Size = UDim2.new(0, 0, 0, 12), 
					TextStrokeColor3 = Color3.new(), 
					TextStrokeTransparency = 0.5, 
					TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
					TextStrokeTransparency = 0.6, 
					TextTransparency = 0.2, 
					Font = "Highway", 
					TextSize = 16, 
					TextXAlignment = "Center"
				}, "Top");
				u7.UpdateLoadout(p12, p13, p14);
			end;
		end;
		p12.Menu.Preview.Visible = false;
		p12.Menu.Preview.Prepurchase.Visible = false;
	end;
end;
function DenyPrepurchase(p15, p16, p17)
	l__SoundService__1.Menu.Cancel:Play();
	u7.UpdateLoadout(p15, p16, p17);
end;
local u8 = require(game.ReplicatedStorage.Modules["String Manipulation"]);
function PromptSkinSell(p18, p19)
	p18.Menu.Sell.Question.Text = "Would you like to sell this skin for $" .. u8.addComas(tostring(p19)) .. "?";
	p18.Menu.Sell.Visible = true;
end;
local u9 = nil;
function SellSkin(p20)
	if u9 then
		l__RE__2:FireServer("EditData", { {
				Type = "SellSkin", 
				Name = u9
			} });
		p20.Menu.Sell.Visible = false;
	end;
end;
function CancelSell(p21, p22, p23)
	l__SoundService__1.Menu.Cancel:Play();
	p21.Menu.Sell.Visible = false;
	if u6 == "Loadout" then
		u7.UpdateLoadout(p21, p22, p23);
	end;
end;
local u10 = require(game.ReplicatedStorage.Modules.Perks);
function PerkHover(p24, p25, p26)
	p24.Menu.ButtonFrames.Perks.Info.Visible = true;
	p24.Menu.ButtonFrames.Perks.Info.PerkName.Text = "";
	p24.Menu.ButtonFrames.Perks.Info.PerkName.Text = string.upper(p26.Name);
	p24.Menu.ButtonFrames.Perks.Info.Icon.Image = u10[p26.Category][p26.Name].Icon;
	p24.Menu.ButtonFrames.Perks.Info.Desc.Text = u10[p26.Category][p26.Name].Desc;
	if p25.Perks[p26.Category][p26.Name] then
		p24.Menu.ButtonFrames.Perks.Info.Status.Text = "EQUIPPED";
	elseif p26.Level <= p25.Stats.Level then
		p24.Menu.ButtonFrames.Perks.Info.Status.Text = "ACQUIRED";
	else
		p24.Menu.ButtonFrames.Perks.Info.Status.Text = "LOCKED";
	end;
	if p26.Equipped then
		local v19 = "rbxassetid://2634766577";
	else
		v19 = "rbxassetid://2600757682";
	end;
	p26.PerkF.BaseDefault.Image = v19;
end;
local v20 = {};
local u11 = {};
local u12 = require(script.Parent.Lobby);
function v20.Loadout(p27, p28, p29)
	if p28.Name ~= u3 then
		if u11.Loadout then
			u11.Loadout.Main.SubNum = 1;
			local l__SkinsLabel__21 = p27.Menu.ButtonFrames.Loadout.Main.SkinsLabel;
			l__SkinsLabel__21.TextTransparency = 0.6;
			l__SkinsLabel__21.BackgroundTransparency = 1;
			l__SkinsLabel__21.BorderSizePixel = 1;
		end;
		u12.SetRightDown(false);
		l__SoundService__1.Menu.Tabs:Play();
		for v22, v23 in pairs(p27.Menu.ButtonFrames.Loadout.Main:GetChildren()) do
			if v23:IsA("TextButton") then
				v23.TextTransparency = 0.6;
				v23.BackgroundTransparency = 1;
				v23.BorderSizePixel = 0;
			end;
		end;
		p28.TextTransparency = 0;
		p28.BackgroundTransparency = 0.75;
		p28.BorderSizePixel = 2;
		p28.BorderColor3 = Color3.new(1, 1, 1);
		u3 = p28.Name;
		u7.UpdateLoadout(p27, p29.Camera, p29.Data);
	end;
end;
function v20.Options(p30, p31, p32)
	if not p30.Menu.ButtonFrames.Options[p31.Name .. "Frame"].Visible then
		l__SoundService__1.Menu.Tabs:Play();
		for v24, v25 in pairs(p30.Menu.ButtonFrames.Options:GetChildren()) do
			if v25:IsA("TextButton") then
				v25.TextTransparency = 0.6;
				v25.BackgroundTransparency = 1;
				v25.BorderSizePixel = 0;
			end;
		end;
		p31.TextTransparency = 0;
		p31.BackgroundTransparency = 0.6;
		p31.BorderSizePixel = 2;
		p31.BorderColor3 = Color3.new(1, 1, 1);
		for v26, v27 in pairs(p30.Menu.ButtonFrames.Options:GetChildren()) do
			if v27:IsA("ScrollingFrame") then
				v27.Visible = false;
				if v27.Name == p31.Name .. "Frame" then
					v27.Visible = true;
				end;
			end;
		end;
	end;
end;
local u13 = nil;
local u14 = false;
function v20.Shop(p33, p34, p35)
	if not p33.Menu.ButtonFrames.Shop[p34.Name .. "Frame"].Visible then
		if u13 and not u14 then
			u14 = true;
			SkinSlide(p33, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0));
			p33.Menu.ButtonFrames.Shop.SkinsFrame.Skip.Visible = false;
		end;
		l__SoundService__1.Menu.Tabs:Play();
		for v28, v29 in pairs(p33.Menu.ButtonFrames.Shop:GetChildren()) do
			if v29:IsA("TextButton") then
				v29.TextTransparency = 0.6;
				v29.BackgroundTransparency = 1;
				v29.BorderSizePixel = 0;
			end;
		end;
		p34.TextTransparency = 0;
		p34.BackgroundTransparency = 0.6;
		p34.BorderSizePixel = 2;
		p34.BorderColor3 = Color3.new(1, 1, 1);
		for v30, v31 in pairs(p33.Menu.ButtonFrames.Shop:GetChildren()) do
			if v31:IsA("Frame") then
				v31.Visible = false;
				if v31.Name == p34.Name .. "Frame" then
					v31.Visible = true;
				end;
			end;
		end;
	end;
end;
function UpdateStats(p36, p37, p38)
	local v32, v33, v34 = pairs(p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo:GetChildren());
	while true do
		local v35, v36 = v32(v33, v34);
		if v35 then

		else
			break;
		end;
		v34 = v35;
		v36.Visible = false;	
	end;
	if p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo:FindFirstChild(p38.Stats.WeaponType) then
		p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Visible = true;
		if p38.Stats.WeaponType == "Gun" then
			local v37 = 0;
			local v38, v39, v40 = pairs(game.ReplicatedStorage.Modules["Weapon Modules"]:GetChildren());
			while true do
				local v41, v42 = v38(v39, v40);
				if v41 then

				else
					break;
				end;
				v40 = v41;
				local v43 = require(v42);
				if v43.Stats.MaxPen then
					if v37 < v43.Stats.MaxPen then
						v37 = v43.Stats.MaxPen;
					end;
				end;			
			end;
			local l__MaxPen__44 = p37.Stats.MaxPen;
			local l__MaxPen__45 = p38.Stats.MaxPen;
			if l__MaxPen__44 < l__MaxPen__45 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].BulletPunch.Bar.Compare.BackgroundColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].BulletPunch.Bar.Compare:TweenSize(UDim2.new(math.min(1, l__MaxPen__45 / v37), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].BulletPunch.Bar.Top:TweenSize(UDim2.new(math.min(1, l__MaxPen__44 / v37), 0, 1, 0), "Out", "Sine", 0.25, true);
			elseif l__MaxPen__45 < l__MaxPen__44 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].BulletPunch.Bar.Compare.BackgroundColor3 = Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].BulletPunch.Bar.Compare:TweenSize(UDim2.new(math.min(1, l__MaxPen__44 / v37), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].BulletPunch.Bar.Top:TweenSize(UDim2.new(math.min(1, l__MaxPen__45 / v37), 0, 1, 0), "Out", "Sine", 0.25, true);
			else
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].BulletPunch.Bar.Compare:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].BulletPunch.Bar.Top:TweenSize(UDim2.new(math.min(1, l__MaxPen__45 / v37), 0, 1, 0), "Out", "Sine", 0.25, true);
			end;
			local v46 = 0;
			local v47, v48, v49 = pairs(game.ReplicatedStorage.Modules["Weapon Modules"]:GetChildren());
			while true do
				local v50, v51 = v47(v48, v49);
				if v50 then

				else
					break;
				end;
				v49 = v50;
				local v52 = require(v51);
				if v52.Stats.RPM then
					if v46 < v52.Stats.RPM then
						v46 = v52.Stats.RPM;
					end;
				end;			
			end;
			local l__RPM__53 = p37.Stats.RPM;
			local l__RPM__54 = p38.Stats.RPM;
			if l__RPM__53 < l__RPM__54 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].RPM.Bar.Compare.BackgroundColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].RPM.Bar.Compare:TweenSize(UDim2.new(math.min(1, l__RPM__54 / v46), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].RPM.Bar.Top:TweenSize(UDim2.new(math.min(1, l__RPM__53 / v46), 0, 1, 0), "Out", "Sine", 0.25, true);
			elseif l__RPM__54 < l__RPM__53 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].RPM.Bar.Compare.BackgroundColor3 = Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].RPM.Bar.Compare:TweenSize(UDim2.new(math.min(1, l__RPM__53 / v46), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].RPM.Bar.Top:TweenSize(UDim2.new(math.min(1, l__RPM__54 / v46), 0, 1, 0), "Out", "Sine", 0.25, true);
			else
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].RPM.Bar.Compare:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].RPM.Bar.Top:TweenSize(UDim2.new(math.min(1, l__RPM__54 / v46), 0, 1, 0), "Out", "Sine", 0.25, true);
			end;
			local v55 = 0;
			local v56, v57, v58 = pairs(game.ReplicatedStorage.Modules["Weapon Modules"]:GetChildren());
			while true do
				local v59, v60 = v56(v57, v58);
				if v59 then

				else
					break;
				end;
				local v61 = require(v60);
				local v62 = 0;
				if v61.Stats.VerticleRecoil then
					if v61.Stats.HorizontalRecoil then
						v62 = v62 + v61.Stats.VerticleRecoil + v61.Stats.HorizontalRecoil;
					end;
				end;
				if v55 < v62 then
					v55 = v62;
				end;			
			end;
			local v63 = p37.Stats.VerticleRecoil + p37.Stats.HorizontalRecoil;
			local v64 = p38.Stats.VerticleRecoil + p38.Stats.HorizontalRecoil;
			if v63 < v64 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Recoil.Bar.Compare.BackgroundColor3 = Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Recoil.Bar.Compare:TweenSize(UDim2.new(math.min(1, v64 / v55), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Recoil.Bar.Top:TweenSize(UDim2.new(math.min(1, v63 / v55), 0, 1, 0), "Out", "Sine", 0.25, true);
			elseif v64 < v63 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Recoil.Bar.Compare.BackgroundColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Recoil.Bar.Compare:TweenSize(UDim2.new(math.min(1, v63 / v55), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Recoil.Bar.Top:TweenSize(UDim2.new(math.min(1, v64 / v55), 0, 1, 0), "Out", "Sine", 0.25, true);
			else
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Recoil.Bar.Compare:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Recoil.Bar.Top:TweenSize(UDim2.new(math.min(1, v64 / v55), 0, 1, 0), "Out", "Sine", 0.25, true);
			end;
			local v65 = math.huge;
			local v66, v67, v68 = pairs(game.ReplicatedStorage.Modules["Weapon Modules"]:GetChildren());
			while true do
				local v69, v70 = v66(v67, v68);
				if v69 then

				else
					break;
				end;
				v68 = v69;
				local v71 = require(v70);
				if v71.Stats.FOV then
					if v71.Stats.FOV < v65 then
						v65 = v71.Stats.FOV;
					end;
				end;			
			end;
			local l__FOV__72 = p37.Stats.FOV;
			local l__FOV__73 = p38.Stats.FOV;
			if l__FOV__73 < l__FOV__72 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Magnification.Bar.Compare.BackgroundColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Magnification.Bar.Compare:TweenSize(UDim2.new(1 / (l__FOV__73 / v65), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Magnification.Bar.Top:TweenSize(UDim2.new(1 / (l__FOV__72 / v65), 0, 1, 0), "Out", "Sine", 0.25, true);
			elseif l__FOV__72 < l__FOV__73 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Magnification.Bar.Compare.BackgroundColor3 = Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Magnification.Bar.Compare:TweenSize(UDim2.new(1 / (l__FOV__72 / v65), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Magnification.Bar.Top:TweenSize(UDim2.new(1 / (l__FOV__73 / v65), 0, 1, 0), "Out", "Sine", 0.25, true);
			else
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Magnification.Bar.Compare:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Magnification.Bar.Top:TweenSize(UDim2.new(1 / (l__FOV__73 / v65), 0, 1, 0), "Out", "Sine", 0.25, true);
			end;
			local v74 = 0;
			local v75, v76, v77 = pairs(game.ReplicatedStorage.Modules["Weapon Modules"]:GetChildren());
			while true do
				local v78, v79 = v75(v76, v77);
				if v78 then

				else
					break;
				end;
				v77 = v78;
				local v80 = require(v79);
				if v80.Stats.Mag then
					if v74 < v80.Stats.Mag then
						v74 = v80.Stats.Mag;
					end;
				end;			
			end;
			local l__Mag__81 = p37.Stats.Mag;
			local l__Mag__82 = p38.Stats.Mag;
			if l__Mag__81 < l__Mag__82 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Capacity.Bar.Compare.BackgroundColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Capacity.Bar.Compare:TweenSize(UDim2.new(math.min(1, l__Mag__82 / v74), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Capacity.Bar.Top:TweenSize(UDim2.new(math.min(1, l__Mag__81 / v74), 0, 1, 0), "Out", "Sine", 0.25, true);
			elseif l__Mag__82 < l__Mag__81 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Capacity.Bar.Compare.BackgroundColor3 = Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Capacity.Bar.Compare:TweenSize(UDim2.new(math.min(1, l__Mag__81 / v74), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Capacity.Bar.Top:TweenSize(UDim2.new(math.min(1, l__Mag__82 / v74), 0, 1, 0), "Out", "Sine", 0.25, true);
			else
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Capacity.Bar.Compare:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Capacity.Bar.Top:TweenSize(UDim2.new(math.min(1, l__Mag__82 / 100), 0, 1, 0), "Out", "Sine", 0.25, true);
			end;
			local v83 = 0;
			local function v84(p39)
				local l__Sequence__85 = p39.Animations.Reload.Sequence;
				local v86 = 0;
				local v87, v88, v89 = pairs(l__Sequence__85);
				while true do
					local v90, v91 = v87(v88, v89);
					if v90 then

					else
						break;
					end;
					v89 = v90;
					if p39.Animations.Reload.StayBack then
						if not (v90 < p39.Animations.Reload.StayBack[1]) then
							if not (p39.Animations.Reload.StayBack[2] < v90) then
								if not p39.Animations.Reload.StayBack then
									v86 = v86 + v91.Time;
								end;
							else
								v86 = v86 + v91.Time;
							end;
						else
							v86 = v86 + v91.Time;
						end;
					elseif not p39.Animations.Reload.StayBack then
						v86 = v86 + v91.Time;
					end;				
				end;
				if p39.Animations.Reload.Repeat then
					local v92 = {};
					local v93 = p39.Stats.Mag - 1;
					local v94 = 1 - 1;
					while true do
						local v95 = p39.Animations.Reload.Repeat[2];
						local v96 = p39.Animations.Reload.Repeat[1] - 1;
						while true do
							v86 = v86 + l__Sequence__85[v96].Time;
							if 0 <= 1 then
								if v96 < v95 then

								else
									break;
								end;
							elseif v95 < v96 then

							else
								break;
							end;
							v96 = v96 + 1;						
						end;
						if 0 <= 1 then
							if v94 < v93 then

							else
								break;
							end;
						elseif v93 < v94 then

						else
							break;
						end;
						v94 = v94 + 1;					
					end;
				end;
				return v86;
			end;
			local v97, v98, v99 = pairs(game.ReplicatedStorage.Modules["Weapon Modules"]:GetChildren());
			while true do
				local v100, v101 = v97(v98, v99);
				if v100 then

				else
					break;
				end;
				v99 = v100;
				local v102 = require(v101);
				if v102.Animations.Reload then
					local v103 = v84(v102);
					if v83 < v103 then
						v83 = v103;
					end;
				end;			
			end;
			local v104 = v84(p38);
			local v105 = v84(p37);
			if v105 < v104 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Reload.Bar.Compare.BackgroundColor3 = Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Reload.Bar.Compare:TweenSize(UDim2.new(math.min(1, v104 / v83), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Reload.Bar.Top:TweenSize(UDim2.new(math.min(1, v105 / v83), 0, 1, 0), "Out", "Sine", 0.25, true);
			elseif v104 < v105 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Reload.Bar.Compare.BackgroundColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Reload.Bar.Compare:TweenSize(UDim2.new(math.min(1, v105 / v83), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Reload.Bar.Top:TweenSize(UDim2.new(math.min(1, v104 / v83), 0, 1, 0), "Out", "Sine", 0.25, true);
			else
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Reload.Bar.Compare:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Reload.Bar.Top:TweenSize(UDim2.new(math.min(1, v104 / v83), 0, 1, 0), "Out", "Sine", 0.25, true);
			end;
		end;
		if p38.Stats.WeaponType == "Melee" then
			local function v106(p40)
				local v107 = 0;
				local v108, v109, v110 = pairs(p40.Animations.Swing.Sequence);
				while true do
					local v111, v112 = v108(v109, v110);
					if v111 then

					else
						break;
					end;
					v110 = v111;
					v107 = v107 + v112.Time;				
				end;
				return v107;
			end;
			local v113 = math.huge;
			local v114, v115, v116 = pairs(game.ReplicatedStorage.Modules["Weapon Modules"]:GetChildren());
			while true do
				local v117, v118 = v114(v115, v116);
				if v117 then

				else
					break;
				end;
				v116 = v117;
				local v119 = require(v118);
				if v119.Animations.Swing then
					local v120 = v106(v119);
					if v120 < v113 then
						v113 = v120;
					end;
				end;			
			end;
			local v121 = v106(p37);
			local v122 = v106(p38);
			if v122 < v121 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Speed.Bar.Compare.BackgroundColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Speed.Bar.Compare:TweenSize(UDim2.new(1 / (v122 / v113), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Speed.Bar.Top:TweenSize(UDim2.new(1 / (v121 / v113), 0, 1, 0), "Out", "Sine", 0.25, true);
			elseif v121 < v122 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Speed.Bar.Compare.BackgroundColor3 = Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Speed.Bar.Compare:TweenSize(UDim2.new(1 / (v121 / v113), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Speed.Bar.Top:TweenSize(UDim2.new(1 / (v122 / v113), 0, 1, 0), "Out", "Sine", 0.25, true);
			else
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Speed.Bar.Compare:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Speed.Bar.Top:TweenSize(UDim2.new(1 / (v122 / v113), 0, 1, 0), "Out", "Sine", 0.25, true);
			end;
			local v123 = 0;
			local v124, v125, v126 = pairs(game.ReplicatedStorage.Modules["Weapon Modules"]:GetChildren());
			while true do
				local v127, v128 = v124(v125, v126);
				if v127 then

				else
					break;
				end;
				v126 = v127;
				local v129 = require(v128);
				if v129.Stats.Dimensions then
					if v123 < v129.Stats.Dimensions.y then
						v123 = v129.Stats.Dimensions.y;
					end;
				end;			
			end;
			local l__y__130 = p37.Stats.Dimensions.y;
			local l__y__131 = p38.Stats.Dimensions.y;
			if l__y__130 < l__y__131 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Range.Bar.Compare.BackgroundColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Range.Bar.Compare:TweenSize(UDim2.new(math.min(1, l__y__131 / v123), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Range.Bar.Top:TweenSize(UDim2.new(math.min(1, l__y__130 / v123), 0, 1, 0), "Out", "Sine", 0.25, true);
			elseif l__y__131 < l__y__130 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Range.Bar.Compare.BackgroundColor3 = Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Range.Bar.Compare:TweenSize(UDim2.new(math.min(1, l__y__130 / v123), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Range.Bar.Top:TweenSize(UDim2.new(math.min(1, l__y__131 / v123), 0, 1, 0), "Out", "Sine", 0.25, true);
			else
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Range.Bar.Compare:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Range.Bar.Top:TweenSize(UDim2.new(math.min(1, l__y__131 / v123), 0, 1, 0), "Out", "Sine", 0.25, true);
			end;
			local v132 = 0;
			local v133, v134, v135 = pairs(game.ReplicatedStorage.Modules["Weapon Modules"]:GetChildren());
			while true do
				local v136, v137 = v133(v134, v135);
				if v136 then

				else
					break;
				end;
				v135 = v136;
				local v138 = require(v137);
				if v138.Stats.Stun then
					if v132 < v138.Stats.Stun then
						v132 = v138.Stats.Stun;
					end;
				end;			
			end;
			local l__Stun__139 = p37.Stats.Stun;
			local l__Stun__140 = p38.Stats.Stun;
			if l__Stun__139 < l__Stun__140 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Stun.Bar.Compare.BackgroundColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Stun.Bar.Compare:TweenSize(UDim2.new(math.min(1, l__Stun__140 / v132), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Stun.Bar.Top:TweenSize(UDim2.new(math.min(1, l__Stun__139 / v132), 0, 1, 0), "Out", "Sine", 0.25, true);
			elseif l__Stun__140 < l__Stun__139 then
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Stun.Bar.Compare.BackgroundColor3 = Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Stun.Bar.Compare:TweenSize(UDim2.new(math.min(1, l__Stun__139 / v132), 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Stun.Bar.Top:TweenSize(UDim2.new(math.min(1, l__Stun__140 / v132), 0, 1, 0), "Out", "Sine", 0.25, true);
			else
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Stun.Bar.Compare:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.25, true);
				p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Stun.Bar.Top:TweenSize(UDim2.new(math.min(1, l__Stun__140 / v132), 0, 1, 0), "Out", "Sine", 0.25, true);
			end;
		end;
		if p37.Stats.Type == "Shotgun" then
			local v141 = 8;
		else
			v141 = 1;
		end;
		local v142 = p37.Stats.Damage * v141;
		if p38.Stats.Type == "Shotgun" then
			local v143 = 8;
		else
			v143 = 1;
		end;
		local v144 = p38.Stats.Damage * v143;
		if v142 < v144 then
			p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Damage.Bar.Compare.ZIndex = 1;
			p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Damage.Bar.Top.ZIndex = 2;
			p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Damage.Bar.Compare.BackgroundColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315);
			p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Damage.Bar.Compare:TweenSize(UDim2.new(math.min(1, v144 / 100), 0, 1, 0), "Out", "Sine", 0.25, true);
			p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Damage.Bar.Top:TweenSize(UDim2.new(math.min(1, v142 / 100), 0, 1, 0), "Out", "Sine", 0.25, true);
			return;
		end;
		if v144 < v142 then
			p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Damage.Bar.Compare.ZIndex = 1;
			p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Damage.Bar.Top.ZIndex = 2;
			p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Damage.Bar.Compare.BackgroundColor3 = Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863);
			p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Damage.Bar.Compare:TweenSize(UDim2.new(math.min(1, v142 / 100), 0, 1, 0), "Out", "Sine", 0.25, true);
			p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Damage.Bar.Top:TweenSize(UDim2.new(math.min(1, v144 / 100), 0, 1, 0), "Out", "Sine", 0.25, true);
			return;
		else
			p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Damage.Bar.Compare:TweenSize(UDim2.new(0, 0, 1, 0), "Out", "Sine", 0.25, true);
			p36.Menu.ButtonFrames.Loadout.Main.WeaponInfo[p38.Stats.WeaponType].Damage.Bar.Top:TweenSize(UDim2.new(math.min(1, v144 / 100), 0, 1, 0), "Out", "Sine", 0.25, true);
		end;
	end;
end;
function CalculatePrepurchase(p41, p42, p43)
	return math.floor((1 - p43 / p42) * (p41 * 6) + p41 + 0.5);
end;
function AdjustScroll(p44, p45, p46)
	p45.BackgroundTransparency = 0.8;
	p45.BorderColor3 = Color3.new(1, 1, 1);
	p45.BorderSizePixel = 2;
	local l__AbsolutePosition__145 = p46.AbsolutePosition;
	local l__AbsoluteSize__146 = p46.AbsoluteSize;
	if l__AbsolutePosition__145.y + l__AbsoluteSize__146.y < p45.AbsolutePosition.y + p45.AbsoluteSize.y then
		p46.CanvasPosition = Vector2.new(0, p46.CanvasPosition.Y + (p45.AbsolutePosition.y + p45.AbsoluteSize.y - (l__AbsolutePosition__145.y + l__AbsoluteSize__146.y)) + l__AbsoluteSize__146.y + -p45.AbsoluteSize.y + -2);
		return;
	end;
	if p45.AbsolutePosition.y < l__AbsolutePosition__145.y then
		local v147 = p45.AbsolutePosition.y - l__AbsolutePosition__145.y;
		p46.CanvasPosition = Vector2.new(0, p46.CanvasPosition.Y - l__AbsoluteSize__146.y);
		p46.CanvasPosition = Vector2.new(0, p46.CanvasPosition.Y + (p45.AbsolutePosition.y + p45.AbsoluteSize.y - (l__AbsolutePosition__145.y + l__AbsoluteSize__146.y)) + 2);
	end;
end;
local u15 = nil;
local u16 = {};
function WeaponClick(p47, p48, p49, p50)
	p47.Menu.Preview.Visible = false;
	p47.Menu.Preview.Prepurchase.Visible = false;
	p47.Menu.Confirm.Visible = false;
	p47.Menu.Sell.Visible = false;
	p47.Menu.ButtonFrames.Loadout.Main.SkinsLabel.Visible = false;
	p47.Menu.ButtonFrames.Loadout.Main.Skins.Visible = false;
	local v148 = require(game.ReplicatedStorage.Modules["Weapon Modules"][p50]);
	UpdateStats(p47, u15, v148);
	if not v148.Stats.PerkLocked then
		if not p49.Weapons[p50] then
			if v148.Stats.Price <= p49.Stats.Credits then
				if v148.Stats.Level <= p49.Stats.Level then
					u12.UpdateLoadoutModels({
						[p50] = {
							Equipped = true, 
							Skin = nil
						}
					});
					p47.Menu.Confirm.Question.Text = "Would you like to buy the " .. p50 .. " for " .. u8.addComas(tostring(v148.Stats.Price)) .. "?";
					p47.Menu.Confirm.Visible = true;
					u4 = p50;
					if u16.PurchaseChoice then
						u16.PurchaseChoice.Bind();
					end;
				elseif p49.Weapons[p50] then
					if not p49.Weapons[p50].Equipped then
						if p50 ~= u4 then
							u12.UpdateLoadoutModels({
								[p50] = {
									Equipped = true, 
									Skin = nil
								}
							});
							u4 = p50;
							if not v148.Stats.PerkLocked then
								u7.AddNotification({
									Parent = p47.NotificationsHolder, 
									Text = "Press again to equip", 
									Position = UDim2.new(0.5, 0, 0, 216), 
									BackgroundTransparency = 1, 
									Size = UDim2.new(0, 0, 0, 12), 
									TextStrokeColor3 = Color3.new(), 
									TextStrokeTransparency = 0.5, 
									TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
									TextStrokeTransparency = 0.6, 
									TextTransparency = 0.2, 
									Font = "Highway", 
									TextSize = 16, 
									TextXAlignment = "Center"
								}, "Top");
							end;
						elseif p50 == u4 then
							local l__PerkLocked__149 = v148.Stats.PerkLocked;
							if l__PerkLocked__149 then
								if p49.Perks[l__PerkLocked__149[1]][l__PerkLocked__149[2]] then
									l__RE__2:FireServer("EditData", { {
											Type = "SelectWeapon", 
											Name = p50
										} });
								else
									l__SoundService__1.Menu.Cancel:Play();
									u7.AddNotification({
										Parent = p47.NotificationsHolder, 
										Text = l__PerkLocked__149[2] .. " perk must be equipped", 
										Position = UDim2.new(0.5, 0, 0, 216), 
										BackgroundTransparency = 1, 
										Size = UDim2.new(0, 0, 0, 12), 
										TextStrokeColor3 = Color3.new(), 
										TextStrokeTransparency = 0.5, 
										TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
										TextStrokeTransparency = 0.6, 
										TextTransparency = 0.2, 
										Font = "Highway", 
										TextSize = 16, 
										TextXAlignment = "Center"
									}, "Top");
								end;
							else
								l__RE__2:FireServer("EditData", { {
										Type = "SelectWeapon", 
										Name = p50
									} });
							end;
						end;
					elseif p49.Weapons[p50] then
						if p49.Weapons[p50].Equipped then
							u12.UpdateLoadoutModels(p49.Weapons);
							if v148.Stats.Slot ~= "Melee" then
								p47.Menu.ButtonFrames.Loadout.Main.SkinsLabel.Visible = true;
								p47.Menu.ButtonFrames.Loadout.Main.Skins.Visible = true;
							end;
							u4 = nil;
						elseif not p49.Weapons[p50] then
							local v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
							while true do
								local v153, v154 = v150(v151, v152);
								if v153 then

								else
									break;
								end;
								v152 = v153;
								if v154.Name == "Requirement" then
									v154:Destroy();
								end;							
							end;
							p47.Menu.Preview.Prepurchase.Visible = false;
							u12.UpdateLoadoutModels({
								[p50] = {
									Equipped = true, 
									Skin = nil
								}
							});
							p47.Menu.Preview.Visible = true;
							u4 = p50;
							local v155 = 0;
							if not v148.Stats.PerkLocked then
								if p49.Stats.Level < v148.Stats.Level then
									local v156 = game.ReplicatedStorage.GUI.Requirement:clone();
									v156.Text = "INSUFFICIENT LEVEL";
									v156.Parent = p47.Menu.Preview;
									v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
									v155 = v155 + 20;
									p47.Menu.Preview.Prepurchase.Visible = true;
									p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
									if u16.PrepurchaseChoice then
										u16.PrepurchaseChoice.Bind();
									end;
								end;
								if p49.Stats.Credits < v148.Stats.Price then
									local v157 = game.ReplicatedStorage.GUI.Requirement:clone();
									v157.Text = "INSUFFICIENT CREDITS";
									v157.Parent = p47.Menu.Preview;
									v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
									v155 = v155 + 20;
								end;
								p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
							else
								local v158 = game.ReplicatedStorage.GUI.Requirement:clone();
								v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
								v158.Parent = p47.Menu.Preview;
								v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
							end;
						end;
					elseif not p49.Weapons[p50] then
						v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
						while true do
							v153, v154 = v150(v151, v152);
							if v153 then

							else
								break;
							end;
							v152 = v153;
							if v154.Name == "Requirement" then
								v154:Destroy();
							end;						
						end;
						p47.Menu.Preview.Prepurchase.Visible = false;
						u12.UpdateLoadoutModels({
							[p50] = {
								Equipped = true, 
								Skin = nil
							}
						});
						p47.Menu.Preview.Visible = true;
						u4 = p50;
						v155 = 0;
						if not v148.Stats.PerkLocked then
							if p49.Stats.Level < v148.Stats.Level then
								v156 = game.ReplicatedStorage.GUI.Requirement:clone();
								v156.Text = "INSUFFICIENT LEVEL";
								v156.Parent = p47.Menu.Preview;
								v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
								v155 = v155 + 20;
								p47.Menu.Preview.Prepurchase.Visible = true;
								p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
								if u16.PrepurchaseChoice then
									u16.PrepurchaseChoice.Bind();
								end;
							end;
							if p49.Stats.Credits < v148.Stats.Price then
								v157 = game.ReplicatedStorage.GUI.Requirement:clone();
								v157.Text = "INSUFFICIENT CREDITS";
								v157.Parent = p47.Menu.Preview;
								v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
								v155 = v155 + 20;
							end;
							p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
						else
							v158 = game.ReplicatedStorage.GUI.Requirement:clone();
							v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
							v158.Parent = p47.Menu.Preview;
							v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
						end;
					end;
				elseif p49.Weapons[p50] then
					if p49.Weapons[p50].Equipped then
						u12.UpdateLoadoutModels(p49.Weapons);
						if v148.Stats.Slot ~= "Melee" then
							p47.Menu.ButtonFrames.Loadout.Main.SkinsLabel.Visible = true;
							p47.Menu.ButtonFrames.Loadout.Main.Skins.Visible = true;
						end;
						u4 = nil;
					elseif not p49.Weapons[p50] then
						v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
						while true do
							v153, v154 = v150(v151, v152);
							if v153 then

							else
								break;
							end;
							v152 = v153;
							if v154.Name == "Requirement" then
								v154:Destroy();
							end;						
						end;
						p47.Menu.Preview.Prepurchase.Visible = false;
						u12.UpdateLoadoutModels({
							[p50] = {
								Equipped = true, 
								Skin = nil
							}
						});
						p47.Menu.Preview.Visible = true;
						u4 = p50;
						v155 = 0;
						if not v148.Stats.PerkLocked then
							if p49.Stats.Level < v148.Stats.Level then
								v156 = game.ReplicatedStorage.GUI.Requirement:clone();
								v156.Text = "INSUFFICIENT LEVEL";
								v156.Parent = p47.Menu.Preview;
								v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
								v155 = v155 + 20;
								p47.Menu.Preview.Prepurchase.Visible = true;
								p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
								if u16.PrepurchaseChoice then
									u16.PrepurchaseChoice.Bind();
								end;
							end;
							if p49.Stats.Credits < v148.Stats.Price then
								v157 = game.ReplicatedStorage.GUI.Requirement:clone();
								v157.Text = "INSUFFICIENT CREDITS";
								v157.Parent = p47.Menu.Preview;
								v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
								v155 = v155 + 20;
							end;
							p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
						else
							v158 = game.ReplicatedStorage.GUI.Requirement:clone();
							v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
							v158.Parent = p47.Menu.Preview;
							v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
						end;
					end;
				elseif not p49.Weapons[p50] then
					v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
					while true do
						v153, v154 = v150(v151, v152);
						if v153 then

						else
							break;
						end;
						v152 = v153;
						if v154.Name == "Requirement" then
							v154:Destroy();
						end;					
					end;
					p47.Menu.Preview.Prepurchase.Visible = false;
					u12.UpdateLoadoutModels({
						[p50] = {
							Equipped = true, 
							Skin = nil
						}
					});
					p47.Menu.Preview.Visible = true;
					u4 = p50;
					v155 = 0;
					if not v148.Stats.PerkLocked then
						if p49.Stats.Level < v148.Stats.Level then
							v156 = game.ReplicatedStorage.GUI.Requirement:clone();
							v156.Text = "INSUFFICIENT LEVEL";
							v156.Parent = p47.Menu.Preview;
							v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
							v155 = v155 + 20;
							p47.Menu.Preview.Prepurchase.Visible = true;
							p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
							if u16.PrepurchaseChoice then
								u16.PrepurchaseChoice.Bind();
							end;
						end;
						if p49.Stats.Credits < v148.Stats.Price then
							v157 = game.ReplicatedStorage.GUI.Requirement:clone();
							v157.Text = "INSUFFICIENT CREDITS";
							v157.Parent = p47.Menu.Preview;
							v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
							v155 = v155 + 20;
						end;
						p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
					else
						v158 = game.ReplicatedStorage.GUI.Requirement:clone();
						v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
						v158.Parent = p47.Menu.Preview;
						v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
					end;
				end;
			elseif p49.Weapons[p50] then
				if not p49.Weapons[p50].Equipped then
					if p50 ~= u4 then
						u12.UpdateLoadoutModels({
							[p50] = {
								Equipped = true, 
								Skin = nil
							}
						});
						u4 = p50;
						if not v148.Stats.PerkLocked then
							u7.AddNotification({
								Parent = p47.NotificationsHolder, 
								Text = "Press again to equip", 
								Position = UDim2.new(0.5, 0, 0, 216), 
								BackgroundTransparency = 1, 
								Size = UDim2.new(0, 0, 0, 12), 
								TextStrokeColor3 = Color3.new(), 
								TextStrokeTransparency = 0.5, 
								TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
								TextStrokeTransparency = 0.6, 
								TextTransparency = 0.2, 
								Font = "Highway", 
								TextSize = 16, 
								TextXAlignment = "Center"
							}, "Top");
						end;
					elseif p50 == u4 then
						l__PerkLocked__149 = v148.Stats.PerkLocked;
						if l__PerkLocked__149 then
							if p49.Perks[l__PerkLocked__149[1]][l__PerkLocked__149[2]] then
								l__RE__2:FireServer("EditData", { {
										Type = "SelectWeapon", 
										Name = p50
									} });
							else
								l__SoundService__1.Menu.Cancel:Play();
								u7.AddNotification({
									Parent = p47.NotificationsHolder, 
									Text = l__PerkLocked__149[2] .. " perk must be equipped", 
									Position = UDim2.new(0.5, 0, 0, 216), 
									BackgroundTransparency = 1, 
									Size = UDim2.new(0, 0, 0, 12), 
									TextStrokeColor3 = Color3.new(), 
									TextStrokeTransparency = 0.5, 
									TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
									TextStrokeTransparency = 0.6, 
									TextTransparency = 0.2, 
									Font = "Highway", 
									TextSize = 16, 
									TextXAlignment = "Center"
								}, "Top");
							end;
						else
							l__RE__2:FireServer("EditData", { {
									Type = "SelectWeapon", 
									Name = p50
								} });
						end;
					end;
				elseif p49.Weapons[p50] then
					if p49.Weapons[p50].Equipped then
						u12.UpdateLoadoutModels(p49.Weapons);
						if v148.Stats.Slot ~= "Melee" then
							p47.Menu.ButtonFrames.Loadout.Main.SkinsLabel.Visible = true;
							p47.Menu.ButtonFrames.Loadout.Main.Skins.Visible = true;
						end;
						u4 = nil;
					elseif not p49.Weapons[p50] then
						v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
						while true do
							v153, v154 = v150(v151, v152);
							if v153 then

							else
								break;
							end;
							v152 = v153;
							if v154.Name == "Requirement" then
								v154:Destroy();
							end;						
						end;
						p47.Menu.Preview.Prepurchase.Visible = false;
						u12.UpdateLoadoutModels({
							[p50] = {
								Equipped = true, 
								Skin = nil
							}
						});
						p47.Menu.Preview.Visible = true;
						u4 = p50;
						v155 = 0;
						if not v148.Stats.PerkLocked then
							if p49.Stats.Level < v148.Stats.Level then
								v156 = game.ReplicatedStorage.GUI.Requirement:clone();
								v156.Text = "INSUFFICIENT LEVEL";
								v156.Parent = p47.Menu.Preview;
								v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
								v155 = v155 + 20;
								p47.Menu.Preview.Prepurchase.Visible = true;
								p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
								if u16.PrepurchaseChoice then
									u16.PrepurchaseChoice.Bind();
								end;
							end;
							if p49.Stats.Credits < v148.Stats.Price then
								v157 = game.ReplicatedStorage.GUI.Requirement:clone();
								v157.Text = "INSUFFICIENT CREDITS";
								v157.Parent = p47.Menu.Preview;
								v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
								v155 = v155 + 20;
							end;
							p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
						else
							v158 = game.ReplicatedStorage.GUI.Requirement:clone();
							v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
							v158.Parent = p47.Menu.Preview;
							v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
						end;
					end;
				elseif not p49.Weapons[p50] then
					v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
					while true do
						v153, v154 = v150(v151, v152);
						if v153 then

						else
							break;
						end;
						v152 = v153;
						if v154.Name == "Requirement" then
							v154:Destroy();
						end;					
					end;
					p47.Menu.Preview.Prepurchase.Visible = false;
					u12.UpdateLoadoutModels({
						[p50] = {
							Equipped = true, 
							Skin = nil
						}
					});
					p47.Menu.Preview.Visible = true;
					u4 = p50;
					v155 = 0;
					if not v148.Stats.PerkLocked then
						if p49.Stats.Level < v148.Stats.Level then
							v156 = game.ReplicatedStorage.GUI.Requirement:clone();
							v156.Text = "INSUFFICIENT LEVEL";
							v156.Parent = p47.Menu.Preview;
							v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
							v155 = v155 + 20;
							p47.Menu.Preview.Prepurchase.Visible = true;
							p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
							if u16.PrepurchaseChoice then
								u16.PrepurchaseChoice.Bind();
							end;
						end;
						if p49.Stats.Credits < v148.Stats.Price then
							v157 = game.ReplicatedStorage.GUI.Requirement:clone();
							v157.Text = "INSUFFICIENT CREDITS";
							v157.Parent = p47.Menu.Preview;
							v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
							v155 = v155 + 20;
						end;
						p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
					else
						v158 = game.ReplicatedStorage.GUI.Requirement:clone();
						v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
						v158.Parent = p47.Menu.Preview;
						v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
					end;
				end;
			elseif p49.Weapons[p50] then
				if p49.Weapons[p50].Equipped then
					u12.UpdateLoadoutModels(p49.Weapons);
					if v148.Stats.Slot ~= "Melee" then
						p47.Menu.ButtonFrames.Loadout.Main.SkinsLabel.Visible = true;
						p47.Menu.ButtonFrames.Loadout.Main.Skins.Visible = true;
					end;
					u4 = nil;
				elseif not p49.Weapons[p50] then
					v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
					while true do
						v153, v154 = v150(v151, v152);
						if v153 then

						else
							break;
						end;
						v152 = v153;
						if v154.Name == "Requirement" then
							v154:Destroy();
						end;					
					end;
					p47.Menu.Preview.Prepurchase.Visible = false;
					u12.UpdateLoadoutModels({
						[p50] = {
							Equipped = true, 
							Skin = nil
						}
					});
					p47.Menu.Preview.Visible = true;
					u4 = p50;
					v155 = 0;
					if not v148.Stats.PerkLocked then
						if p49.Stats.Level < v148.Stats.Level then
							v156 = game.ReplicatedStorage.GUI.Requirement:clone();
							v156.Text = "INSUFFICIENT LEVEL";
							v156.Parent = p47.Menu.Preview;
							v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
							v155 = v155 + 20;
							p47.Menu.Preview.Prepurchase.Visible = true;
							p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
							if u16.PrepurchaseChoice then
								u16.PrepurchaseChoice.Bind();
							end;
						end;
						if p49.Stats.Credits < v148.Stats.Price then
							v157 = game.ReplicatedStorage.GUI.Requirement:clone();
							v157.Text = "INSUFFICIENT CREDITS";
							v157.Parent = p47.Menu.Preview;
							v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
							v155 = v155 + 20;
						end;
						p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
					else
						v158 = game.ReplicatedStorage.GUI.Requirement:clone();
						v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
						v158.Parent = p47.Menu.Preview;
						v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
					end;
				end;
			elseif not p49.Weapons[p50] then
				v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
				while true do
					v153, v154 = v150(v151, v152);
					if v153 then

					else
						break;
					end;
					v152 = v153;
					if v154.Name == "Requirement" then
						v154:Destroy();
					end;				
				end;
				p47.Menu.Preview.Prepurchase.Visible = false;
				u12.UpdateLoadoutModels({
					[p50] = {
						Equipped = true, 
						Skin = nil
					}
				});
				p47.Menu.Preview.Visible = true;
				u4 = p50;
				v155 = 0;
				if not v148.Stats.PerkLocked then
					if p49.Stats.Level < v148.Stats.Level then
						v156 = game.ReplicatedStorage.GUI.Requirement:clone();
						v156.Text = "INSUFFICIENT LEVEL";
						v156.Parent = p47.Menu.Preview;
						v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
						v155 = v155 + 20;
						p47.Menu.Preview.Prepurchase.Visible = true;
						p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
						if u16.PrepurchaseChoice then
							u16.PrepurchaseChoice.Bind();
						end;
					end;
					if p49.Stats.Credits < v148.Stats.Price then
						v157 = game.ReplicatedStorage.GUI.Requirement:clone();
						v157.Text = "INSUFFICIENT CREDITS";
						v157.Parent = p47.Menu.Preview;
						v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
						v155 = v155 + 20;
					end;
					p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
				else
					v158 = game.ReplicatedStorage.GUI.Requirement:clone();
					v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
					v158.Parent = p47.Menu.Preview;
					v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
				end;
			end;
		elseif p49.Weapons[p50] then
			if not p49.Weapons[p50].Equipped then
				if p50 ~= u4 then
					u12.UpdateLoadoutModels({
						[p50] = {
							Equipped = true, 
							Skin = nil
						}
					});
					u4 = p50;
					if not v148.Stats.PerkLocked then
						u7.AddNotification({
							Parent = p47.NotificationsHolder, 
							Text = "Press again to equip", 
							Position = UDim2.new(0.5, 0, 0, 216), 
							BackgroundTransparency = 1, 
							Size = UDim2.new(0, 0, 0, 12), 
							TextStrokeColor3 = Color3.new(), 
							TextStrokeTransparency = 0.5, 
							TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
							TextStrokeTransparency = 0.6, 
							TextTransparency = 0.2, 
							Font = "Highway", 
							TextSize = 16, 
							TextXAlignment = "Center"
						}, "Top");
					end;
				elseif p50 == u4 then
					l__PerkLocked__149 = v148.Stats.PerkLocked;
					if l__PerkLocked__149 then
						if p49.Perks[l__PerkLocked__149[1]][l__PerkLocked__149[2]] then
							l__RE__2:FireServer("EditData", { {
									Type = "SelectWeapon", 
									Name = p50
								} });
						else
							l__SoundService__1.Menu.Cancel:Play();
							u7.AddNotification({
								Parent = p47.NotificationsHolder, 
								Text = l__PerkLocked__149[2] .. " perk must be equipped", 
								Position = UDim2.new(0.5, 0, 0, 216), 
								BackgroundTransparency = 1, 
								Size = UDim2.new(0, 0, 0, 12), 
								TextStrokeColor3 = Color3.new(), 
								TextStrokeTransparency = 0.5, 
								TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
								TextStrokeTransparency = 0.6, 
								TextTransparency = 0.2, 
								Font = "Highway", 
								TextSize = 16, 
								TextXAlignment = "Center"
							}, "Top");
						end;
					else
						l__RE__2:FireServer("EditData", { {
								Type = "SelectWeapon", 
								Name = p50
							} });
					end;
				end;
			elseif p49.Weapons[p50] then
				if p49.Weapons[p50].Equipped then
					u12.UpdateLoadoutModels(p49.Weapons);
					if v148.Stats.Slot ~= "Melee" then
						p47.Menu.ButtonFrames.Loadout.Main.SkinsLabel.Visible = true;
						p47.Menu.ButtonFrames.Loadout.Main.Skins.Visible = true;
					end;
					u4 = nil;
				elseif not p49.Weapons[p50] then
					v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
					while true do
						v153, v154 = v150(v151, v152);
						if v153 then

						else
							break;
						end;
						v152 = v153;
						if v154.Name == "Requirement" then
							v154:Destroy();
						end;					
					end;
					p47.Menu.Preview.Prepurchase.Visible = false;
					u12.UpdateLoadoutModels({
						[p50] = {
							Equipped = true, 
							Skin = nil
						}
					});
					p47.Menu.Preview.Visible = true;
					u4 = p50;
					v155 = 0;
					if not v148.Stats.PerkLocked then
						if p49.Stats.Level < v148.Stats.Level then
							v156 = game.ReplicatedStorage.GUI.Requirement:clone();
							v156.Text = "INSUFFICIENT LEVEL";
							v156.Parent = p47.Menu.Preview;
							v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
							v155 = v155 + 20;
							p47.Menu.Preview.Prepurchase.Visible = true;
							p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
							if u16.PrepurchaseChoice then
								u16.PrepurchaseChoice.Bind();
							end;
						end;
						if p49.Stats.Credits < v148.Stats.Price then
							v157 = game.ReplicatedStorage.GUI.Requirement:clone();
							v157.Text = "INSUFFICIENT CREDITS";
							v157.Parent = p47.Menu.Preview;
							v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
							v155 = v155 + 20;
						end;
						p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
					else
						v158 = game.ReplicatedStorage.GUI.Requirement:clone();
						v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
						v158.Parent = p47.Menu.Preview;
						v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
					end;
				end;
			elseif not p49.Weapons[p50] then
				v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
				while true do
					v153, v154 = v150(v151, v152);
					if v153 then

					else
						break;
					end;
					v152 = v153;
					if v154.Name == "Requirement" then
						v154:Destroy();
					end;				
				end;
				p47.Menu.Preview.Prepurchase.Visible = false;
				u12.UpdateLoadoutModels({
					[p50] = {
						Equipped = true, 
						Skin = nil
					}
				});
				p47.Menu.Preview.Visible = true;
				u4 = p50;
				v155 = 0;
				if not v148.Stats.PerkLocked then
					if p49.Stats.Level < v148.Stats.Level then
						v156 = game.ReplicatedStorage.GUI.Requirement:clone();
						v156.Text = "INSUFFICIENT LEVEL";
						v156.Parent = p47.Menu.Preview;
						v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
						v155 = v155 + 20;
						p47.Menu.Preview.Prepurchase.Visible = true;
						p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
						if u16.PrepurchaseChoice then
							u16.PrepurchaseChoice.Bind();
						end;
					end;
					if p49.Stats.Credits < v148.Stats.Price then
						v157 = game.ReplicatedStorage.GUI.Requirement:clone();
						v157.Text = "INSUFFICIENT CREDITS";
						v157.Parent = p47.Menu.Preview;
						v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
						v155 = v155 + 20;
					end;
					p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
				else
					v158 = game.ReplicatedStorage.GUI.Requirement:clone();
					v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
					v158.Parent = p47.Menu.Preview;
					v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
				end;
			end;
		elseif p49.Weapons[p50] then
			if p49.Weapons[p50].Equipped then
				u12.UpdateLoadoutModels(p49.Weapons);
				if v148.Stats.Slot ~= "Melee" then
					p47.Menu.ButtonFrames.Loadout.Main.SkinsLabel.Visible = true;
					p47.Menu.ButtonFrames.Loadout.Main.Skins.Visible = true;
				end;
				u4 = nil;
			elseif not p49.Weapons[p50] then
				v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
				while true do
					v153, v154 = v150(v151, v152);
					if v153 then

					else
						break;
					end;
					v152 = v153;
					if v154.Name == "Requirement" then
						v154:Destroy();
					end;				
				end;
				p47.Menu.Preview.Prepurchase.Visible = false;
				u12.UpdateLoadoutModels({
					[p50] = {
						Equipped = true, 
						Skin = nil
					}
				});
				p47.Menu.Preview.Visible = true;
				u4 = p50;
				v155 = 0;
				if not v148.Stats.PerkLocked then
					if p49.Stats.Level < v148.Stats.Level then
						v156 = game.ReplicatedStorage.GUI.Requirement:clone();
						v156.Text = "INSUFFICIENT LEVEL";
						v156.Parent = p47.Menu.Preview;
						v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
						v155 = v155 + 20;
						p47.Menu.Preview.Prepurchase.Visible = true;
						p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
						if u16.PrepurchaseChoice then
							u16.PrepurchaseChoice.Bind();
						end;
					end;
					if p49.Stats.Credits < v148.Stats.Price then
						v157 = game.ReplicatedStorage.GUI.Requirement:clone();
						v157.Text = "INSUFFICIENT CREDITS";
						v157.Parent = p47.Menu.Preview;
						v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
						v155 = v155 + 20;
					end;
					p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
				else
					v158 = game.ReplicatedStorage.GUI.Requirement:clone();
					v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
					v158.Parent = p47.Menu.Preview;
					v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
				end;
			end;
		elseif not p49.Weapons[p50] then
			v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
			while true do
				v153, v154 = v150(v151, v152);
				if v153 then

				else
					break;
				end;
				v152 = v153;
				if v154.Name == "Requirement" then
					v154:Destroy();
				end;			
			end;
			p47.Menu.Preview.Prepurchase.Visible = false;
			u12.UpdateLoadoutModels({
				[p50] = {
					Equipped = true, 
					Skin = nil
				}
			});
			p47.Menu.Preview.Visible = true;
			u4 = p50;
			v155 = 0;
			if not v148.Stats.PerkLocked then
				if p49.Stats.Level < v148.Stats.Level then
					v156 = game.ReplicatedStorage.GUI.Requirement:clone();
					v156.Text = "INSUFFICIENT LEVEL";
					v156.Parent = p47.Menu.Preview;
					v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
					v155 = v155 + 20;
					p47.Menu.Preview.Prepurchase.Visible = true;
					p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
					if u16.PrepurchaseChoice then
						u16.PrepurchaseChoice.Bind();
					end;
				end;
				if p49.Stats.Credits < v148.Stats.Price then
					v157 = game.ReplicatedStorage.GUI.Requirement:clone();
					v157.Text = "INSUFFICIENT CREDITS";
					v157.Parent = p47.Menu.Preview;
					v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
					v155 = v155 + 20;
				end;
				p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
			else
				v158 = game.ReplicatedStorage.GUI.Requirement:clone();
				v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
				v158.Parent = p47.Menu.Preview;
				v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
			end;
		end;
	elseif p49.Weapons[p50] then
		if not p49.Weapons[p50].Equipped then
			if p50 ~= u4 then
				u12.UpdateLoadoutModels({
					[p50] = {
						Equipped = true, 
						Skin = nil
					}
				});
				u4 = p50;
				if not v148.Stats.PerkLocked then
					u7.AddNotification({
						Parent = p47.NotificationsHolder, 
						Text = "Press again to equip", 
						Position = UDim2.new(0.5, 0, 0, 216), 
						BackgroundTransparency = 1, 
						Size = UDim2.new(0, 0, 0, 12), 
						TextStrokeColor3 = Color3.new(), 
						TextStrokeTransparency = 0.5, 
						TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
						TextStrokeTransparency = 0.6, 
						TextTransparency = 0.2, 
						Font = "Highway", 
						TextSize = 16, 
						TextXAlignment = "Center"
					}, "Top");
				end;
			elseif p50 == u4 then
				l__PerkLocked__149 = v148.Stats.PerkLocked;
				if l__PerkLocked__149 then
					if p49.Perks[l__PerkLocked__149[1]][l__PerkLocked__149[2]] then
						l__RE__2:FireServer("EditData", { {
								Type = "SelectWeapon", 
								Name = p50
							} });
					else
						l__SoundService__1.Menu.Cancel:Play();
						u7.AddNotification({
							Parent = p47.NotificationsHolder, 
							Text = l__PerkLocked__149[2] .. " perk must be equipped", 
							Position = UDim2.new(0.5, 0, 0, 216), 
							BackgroundTransparency = 1, 
							Size = UDim2.new(0, 0, 0, 12), 
							TextStrokeColor3 = Color3.new(), 
							TextStrokeTransparency = 0.5, 
							TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
							TextStrokeTransparency = 0.6, 
							TextTransparency = 0.2, 
							Font = "Highway", 
							TextSize = 16, 
							TextXAlignment = "Center"
						}, "Top");
					end;
				else
					l__RE__2:FireServer("EditData", { {
							Type = "SelectWeapon", 
							Name = p50
						} });
				end;
			end;
		elseif p49.Weapons[p50] then
			if p49.Weapons[p50].Equipped then
				u12.UpdateLoadoutModels(p49.Weapons);
				if v148.Stats.Slot ~= "Melee" then
					p47.Menu.ButtonFrames.Loadout.Main.SkinsLabel.Visible = true;
					p47.Menu.ButtonFrames.Loadout.Main.Skins.Visible = true;
				end;
				u4 = nil;
			elseif not p49.Weapons[p50] then
				v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
				while true do
					v153, v154 = v150(v151, v152);
					if v153 then

					else
						break;
					end;
					v152 = v153;
					if v154.Name == "Requirement" then
						v154:Destroy();
					end;				
				end;
				p47.Menu.Preview.Prepurchase.Visible = false;
				u12.UpdateLoadoutModels({
					[p50] = {
						Equipped = true, 
						Skin = nil
					}
				});
				p47.Menu.Preview.Visible = true;
				u4 = p50;
				v155 = 0;
				if not v148.Stats.PerkLocked then
					if p49.Stats.Level < v148.Stats.Level then
						v156 = game.ReplicatedStorage.GUI.Requirement:clone();
						v156.Text = "INSUFFICIENT LEVEL";
						v156.Parent = p47.Menu.Preview;
						v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
						v155 = v155 + 20;
						p47.Menu.Preview.Prepurchase.Visible = true;
						p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
						if u16.PrepurchaseChoice then
							u16.PrepurchaseChoice.Bind();
						end;
					end;
					if p49.Stats.Credits < v148.Stats.Price then
						v157 = game.ReplicatedStorage.GUI.Requirement:clone();
						v157.Text = "INSUFFICIENT CREDITS";
						v157.Parent = p47.Menu.Preview;
						v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
						v155 = v155 + 20;
					end;
					p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
				else
					v158 = game.ReplicatedStorage.GUI.Requirement:clone();
					v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
					v158.Parent = p47.Menu.Preview;
					v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
				end;
			end;
		elseif not p49.Weapons[p50] then
			v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
			while true do
				v153, v154 = v150(v151, v152);
				if v153 then

				else
					break;
				end;
				v152 = v153;
				if v154.Name == "Requirement" then
					v154:Destroy();
				end;			
			end;
			p47.Menu.Preview.Prepurchase.Visible = false;
			u12.UpdateLoadoutModels({
				[p50] = {
					Equipped = true, 
					Skin = nil
				}
			});
			p47.Menu.Preview.Visible = true;
			u4 = p50;
			v155 = 0;
			if not v148.Stats.PerkLocked then
				if p49.Stats.Level < v148.Stats.Level then
					v156 = game.ReplicatedStorage.GUI.Requirement:clone();
					v156.Text = "INSUFFICIENT LEVEL";
					v156.Parent = p47.Menu.Preview;
					v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
					v155 = v155 + 20;
					p47.Menu.Preview.Prepurchase.Visible = true;
					p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
					if u16.PrepurchaseChoice then
						u16.PrepurchaseChoice.Bind();
					end;
				end;
				if p49.Stats.Credits < v148.Stats.Price then
					v157 = game.ReplicatedStorage.GUI.Requirement:clone();
					v157.Text = "INSUFFICIENT CREDITS";
					v157.Parent = p47.Menu.Preview;
					v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
					v155 = v155 + 20;
				end;
				p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
			else
				v158 = game.ReplicatedStorage.GUI.Requirement:clone();
				v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
				v158.Parent = p47.Menu.Preview;
				v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
			end;
		end;
	elseif p49.Weapons[p50] then
		if p49.Weapons[p50].Equipped then
			u12.UpdateLoadoutModels(p49.Weapons);
			if v148.Stats.Slot ~= "Melee" then
				p47.Menu.ButtonFrames.Loadout.Main.SkinsLabel.Visible = true;
				p47.Menu.ButtonFrames.Loadout.Main.Skins.Visible = true;
			end;
			u4 = nil;
		elseif not p49.Weapons[p50] then
			v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
			while true do
				v153, v154 = v150(v151, v152);
				if v153 then

				else
					break;
				end;
				v152 = v153;
				if v154.Name == "Requirement" then
					v154:Destroy();
				end;			
			end;
			p47.Menu.Preview.Prepurchase.Visible = false;
			u12.UpdateLoadoutModels({
				[p50] = {
					Equipped = true, 
					Skin = nil
				}
			});
			p47.Menu.Preview.Visible = true;
			u4 = p50;
			v155 = 0;
			if not v148.Stats.PerkLocked then
				if p49.Stats.Level < v148.Stats.Level then
					v156 = game.ReplicatedStorage.GUI.Requirement:clone();
					v156.Text = "INSUFFICIENT LEVEL";
					v156.Parent = p47.Menu.Preview;
					v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
					v155 = v155 + 20;
					p47.Menu.Preview.Prepurchase.Visible = true;
					p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
					if u16.PrepurchaseChoice then
						u16.PrepurchaseChoice.Bind();
					end;
				end;
				if p49.Stats.Credits < v148.Stats.Price then
					v157 = game.ReplicatedStorage.GUI.Requirement:clone();
					v157.Text = "INSUFFICIENT CREDITS";
					v157.Parent = p47.Menu.Preview;
					v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
					v155 = v155 + 20;
				end;
				p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
			else
				v158 = game.ReplicatedStorage.GUI.Requirement:clone();
				v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
				v158.Parent = p47.Menu.Preview;
				v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
			end;
		end;
	elseif not p49.Weapons[p50] then
		v150, v151, v152 = pairs(p47.Menu.Preview:GetChildren());
		while true do
			v153, v154 = v150(v151, v152);
			if v153 then

			else
				break;
			end;
			v152 = v153;
			if v154.Name == "Requirement" then
				v154:Destroy();
			end;		
		end;
		p47.Menu.Preview.Prepurchase.Visible = false;
		u12.UpdateLoadoutModels({
			[p50] = {
				Equipped = true, 
				Skin = nil
			}
		});
		p47.Menu.Preview.Visible = true;
		u4 = p50;
		v155 = 0;
		if not v148.Stats.PerkLocked then
			if p49.Stats.Level < v148.Stats.Level then
				v156 = game.ReplicatedStorage.GUI.Requirement:clone();
				v156.Text = "INSUFFICIENT LEVEL";
				v156.Parent = p47.Menu.Preview;
				v156.Position = v156.Position + UDim2.new(0, 0, 0, v155);
				v155 = v155 + 20;
				p47.Menu.Preview.Prepurchase.Visible = true;
				p47.Menu.Preview.Prepurchase.Text = "Purchase weapon early for $" .. u8.addComas(tostring(CalculatePrepurchase(v148.Stats.Price, v148.Stats.Level, p49.Stats.Level))) .. "?";
				if u16.PrepurchaseChoice then
					u16.PrepurchaseChoice.Bind();
				end;
			end;
			if p49.Stats.Credits < v148.Stats.Price then
				v157 = game.ReplicatedStorage.GUI.Requirement:clone();
				v157.Text = "INSUFFICIENT CREDITS";
				v157.Parent = p47.Menu.Preview;
				v157.Position = v157.Position + UDim2.new(0, 0, 0, v155);
				v155 = v155 + 20;
			end;
			p47.Menu.Preview.Prepurchase.Position = UDim2.new(0, 0, 1, v155 + 10);
		else
			v158 = game.ReplicatedStorage.GUI.Requirement:clone();
			v158.Text = string.upper(v148.Stats.PerkLocked[2]) .. " PERK REQUIRED";
			v158.Parent = p47.Menu.Preview;
			v158.Position = v158.Position + UDim2.new(0, 0, 0, v155);
		end;
	end;
	local v159, v160, v161 = pairs(p47.Menu.ButtonFrames.Loadout.Main.Weapons:GetChildren());
	while true do
		local v162, v163 = v159(v160, v161);
		if v162 then

		else
			break;
		end;
		if u11.Loadout then
			v163.BackgroundTransparency = 1;
			v163.BorderSizePixel = 0;
		end;
		if p49.Weapons[v163.Name] then
			if p49.Weapons[v163.Name].Equipped then
				local v164 = 0;
			else
				v164 = 0.5;
			end;
		else
			v164 = 0.5;
		end;
		v163.WeaponName.TextTransparency = v164;
		local l__Stats__165 = require(game.ReplicatedStorage.Modules["Weapon Modules"][v163.Name]).Stats;
		if u4 ~= v163.Name then
			if l__Stats__165.PerkLocked then
				if not p49.Weapons[v163.Name] then
					v163.Status.Text = "PERK LOCKED";
					v163.Status.TextColor3 = Color3.new(1, 1, 0.9058823529411765);
				else
					if not p49.Weapons[v163.Name] then
						local v166 = "$" .. u8.addComas(tostring(l__Stats__165.Price));
						if not v166 then
							if p49.Weapons[v163.Name].Equipped then
								v166 = "EQUIPPED";
							else
								v166 = "OWNED";
							end;
						end;
					elseif p49.Weapons[v163.Name].Equipped then
						v166 = "EQUIPPED";
					else
						v166 = "OWNED";
					end;
					v163.Status.Text = v166;
					v163.Status.TextColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315);
				end;
			else
				if not p49.Weapons[v163.Name] then
					v166 = "$" .. u8.addComas(tostring(l__Stats__165.Price));
					if not v166 then
						if p49.Weapons[v163.Name].Equipped then
							v166 = "EQUIPPED";
						else
							v166 = "OWNED";
						end;
					end;
				elseif p49.Weapons[v163.Name].Equipped then
					v166 = "EQUIPPED";
				else
					v166 = "OWNED";
				end;
				v163.Status.Text = v166;
				v163.Status.TextColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315);
			end;
		elseif u4 then
			v163.Status.Text = "VIEWING";
			v163.Status.TextColor3 = Color3.new(1, 1, 0.9058823529411765);
		end;	
	end;
	if u11.Loadout then
		AdjustScroll(p47, p47.Menu.ButtonFrames.Loadout.Main.Weapons[p50], p47.Menu.ButtonFrames.Loadout.Main.Weapons);
	end;
end;
local u17 = require(game.ReplicatedStorage.Modules.Skins);
function GetAvailableSkins(p51, p52)
	local v167 = {};
	local v168, v169, v170 = pairs(u17.Skins[p52]);
	while true do
		local v171, v172 = v168(v169, v170);
		if v171 then

		else
			break;
		end;
		v170 = v171;
		if p51.Skins[p52][v171] == nil then
			if not v172.Gift then
				table.insert(v167, v171);
			end;
		end;	
	end;
	return #v167;
end;
local l__ContextActionService__18 = game:GetService("ContextActionService");
function PerkClick(p53, p54, p55, p56)
	if u10[p55][p56].Level <= p54.Stats.Level then
		if not p54.Perks[p55][p56] then
			l__RE__2:FireServer("EditData", { {
					Type = "EquipPerk", 
					Category = p55, 
					Perk = p56
				} });
		else
			l__RE__2:FireServer("EditData", { {
					Type = "UnequipPerk", 
					Category = p55, 
					Perk = p56
				} });
		end;
		l__ContextActionService__18:UnbindAction("PerkF");
		return;
	end;
	l__SoundService__1.Menu.Cancel:Play();
	u7.AddNotification({
		Parent = p53.NotificationsHolder, 
		Text = "Insufficient level", 
		Position = UDim2.new(0.5, 0, 0, 216), 
		BackgroundTransparency = 1, 
		Size = UDim2.new(0, 0, 0, 12), 
		TextStrokeColor3 = Color3.new(), 
		TextStrokeTransparency = 0.5, 
		TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
		TextStrokeTransparency = 0.6, 
		TextTransparency = 0.2, 
		Font = "Highway", 
		TextSize = 16, 
		TextXAlignment = "Center"
	}, "Top");
end;
local l__MarketplaceService__19 = game:GetService("MarketplaceService");
local l__LocalPlayer__20 = game.Players.LocalPlayer;
local u21 = {};
local u22 = tick();
function u7.UpdatePerks(p57, p58)
	delay(0, function()
		if l__MarketplaceService__19:UserOwnsGamePassAsync(l__LocalPlayer__20.UserId, 5571407) then
			local v173 = 4;
		else
			v173 = 3;
		end;
		if u6 ~= "Perks" then
			return;
		end;
		u21 = {};
		local l__Perk__174 = game.ReplicatedStorage.GUI.Perk;
		local v175, v176, v177 = pairs(u10);
		while true do
			local v178, v179 = v175(v176, v177);
			if not v178 then
				break;
			end;
			for v180, v181 in pairs(p57.Menu.ButtonFrames.Perks:GetChildren()) do
				if v181.Name == v178 then
					for v182, v183 in pairs(v181:GetChildren()) do
						if v183:IsA("Frame") then
							v183:Destroy();
						end;
					end;
				end;
			end;
			if not u21[v178] then
				u21[v178] = {};
			end;
			for v184, v185 in pairs(v179) do
				table.insert(u21[v178], {
					Category = v178, 
					Name = v184, 
					Icon = v185.Icon, 
					Level = v185.Level
				});
			end;
			table.sort(u21[v178], function(p59, p60)
				return p59.Level < p60.Level;
			end);		
		end;
		local v186 = {};
		local v187, v188, v189 = pairs(u21);
		while true do
			local v190, v191 = v187(v188, v189);
			if not v190 then
				break;
			end;
			local v192 = 0;
			local v193 = #u21[v190];
			local v194 = 1 - 1;
			while true do
				local v195 = l__Perk__174:clone();
				v195.Icon.Image = u21[v190][v194].Icon;
				v195.Position = UDim2.new(0, v192, 0, 0);
				v195.Parent = p57.Menu.ButtonFrames.Perks[v190];
				v195.Name = u21[v190][v194].Name;
				u21[v190][v194].PerkF = v195;
				u21[v190][v194].Over = false;
				u21[v190][v194].Equipped = false;
				if p58.Stats.Level < u21[v190][v194].Level then
					v195.Icon.ImageTransparency = 0.65;
					v195.BaseDefault.ImageTransparency = 0.65;
				end;
				if p58.Perks[v190][u21[v190][v194].Name] then
					v195.BaseDefault.Image = "rbxassetid://2634711088";
					u21[v190][v194].Equipped = true;
					v173 = v173 - 1;
				else
					v195.BaseDefault.Image = "rbxassetid://2600757280";
				end;
				table.insert(v186, u21[v190][v194]);
				local u23 = v194;
				v195.BaseDefault.MouseButton1Down:connect(function()
					if not CanClick(p57) then
						return;
					end;
					if tick() - u22 > 0.1 then
						u22 = tick();
						PerkClick(p57, p58, v190, u21[v190][u23].Name);
					end;
				end);
				v192 = v192 + 90;
				if 0 <= 1 then
					if not (u23 < v193) then
						break;
					end;
				elseif not (v193 < u23) then
					break;
				end;
				u23 = u23 + 1;			
			end;		
		end;
		if u11.Perks then
			table.sort(v186, function(p61, p62)
				return p61.PerkF.AbsolutePosition.y < p62.PerkF.AbsolutePosition.y;
			end);
			local v196 = 1;
			local v197 = v186[1].PerkF.AbsolutePosition.y;
			local v198 = {};
			while #v186 > 0 do
				local v199 = 0 + 1;
				if v186[v199].PerkF.AbsolutePosition.y ~= v197 then
					v197 = v186[v199].PerkF.AbsolutePosition.y;
					v196 = v196 + 1;
				end;
				if not v198[v196] then
					v198[v196] = {};
				end;
				table.insert(v198[v196], v186[0]);			
			end;
			for v200, v201 in pairs(v198) do
				table.sort(v201, function(p63, p64)
					return p63.PerkF.AbsolutePosition.x < p64.PerkF.AbsolutePosition.x;
				end);
			end;
			u11.Perks.SubContainers[1].Rows = v198;
			local v202 = u11.Perks.SubContainers[1];
			PerkHover(p57, p58, v202.Rows[v202.RowNum][v202.ItemNum]);
		end;
		p57.Menu.ButtonFrames.Perks.PerksLeft.Text = "SLOTS LEFT: " .. v173;
	end);
end;
local u24 = l__GuiService__1:IsTenFootInterface();
local u25 = require(game.ReplicatedStorage.Modules.Shop);
function u7.UpdateLoadout(p65, p66, p67)
	if u6 ~= "Loadout" then
		return;
	end;
	if u24 then

	end;
	for v203, v204 in pairs(p65.Menu.ButtonFrames.Loadout.Main.Weapons:GetChildren()) do
		v204:Destroy();
	end;
	local v205 = nil;
	local v206 = {};
	for v207, v208 in pairs(game.ReplicatedStorage.Modules["Weapon Modules"]:GetChildren()) do
		local v209 = require(v208);
		if v209.Stats.Slot == u3 then
			table.insert(v206, {
				Name = v208.Name, 
				Module = v209, 
				Price = v209.Stats.Price, 
				Level = v209.Stats.Level
			});
		end;
	end;
	for v210, v211 in pairs(v206) do
		table.sort(v206, function(p68, p69)
			if p68.Level ~= p69.Level then
				return p68.Level < p69.Level;
			end;
			if not p68.Price or not p69.Price then
				return;
			end;
			return p68.Price < p69.Price;
		end);
	end;
	local v212 = 2;
	if u11.Loadout then
		u11.Loadout.Main.SubContainers[1].ButtonsOrder = v206;
	end;
	local v213, v214, v215 = pairs(v206);
	while true do
		local v216, v217 = v213(v214, v215);
		if not v216 then
			break;
		end;
		local v218 = game.ReplicatedStorage.GUI.WeaponB:clone();
		if v217.Module.Stats.Mag and not v217.Module.Animations.BasicEquip then
			v218.WeaponName.TextColor3 = Color3.new(0.6666666666666666, 0, 0);
			v218.WeaponName.TextStrokeTransparency = 1;
		end;
		v218.Name = v217.Name;
		v218.WeaponName.Text = string.upper(v217.Name);
		v218.Level.Text = v217.Level;
		v218.Parent = p65.Menu.ButtonFrames.Loadout.Main.Weapons;
		v218.Position = UDim2.new(0, 2, 0, v212);
		if p67.Weapons[v217.Name] and p67.Weapons[v217.Name].Equipped then
			u15 = v217.Module;
			v205 = v217.Name;
			if u11.Loadout then
				u11.Loadout.Main.SubContainers[1].ButtonNum = v216;
			end;
		end;
		v218.Button.MouseButton1Down:connect(function()
			if not CanClick(p65) then
				return;
			end;
			u12.SetRightDown(false);
			WeaponClick(p65, p66, p67, v217.Name);
		end);
		v212 = v212 + 26 + 2 + 2 + 1;	
	end;
	if v212 > 210 then
		p65.Menu.ButtonFrames.Loadout.Main.Weapons.CanvasSize = UDim2.new(0, 0, 0, 210 + (v212 - 210) - 3);
	elseif v212 <= 210 then
		p65.Menu.ButtonFrames.Loadout.Main.Weapons.CanvasSize = UDim2.new(0, 0, 0, 211);
	end;
	if v205 then
		WeaponClick(p65, p66, p67, v205);
		if u11.Loadout and u11.Loadout.Main.SubNum == 1 then

		end;
	end;
	for v219, v220 in pairs(p65.Menu.ButtonFrames.Loadout.Main.Skins:GetChildren()) do
		v220:Destroy();
	end;
	local v221 = 33;
	local v222 = true;
	local v223 = 1;
	local v224 = {};
	local v225 = { "Low", "Mid", "High", "Neon" };
	for v226 = 1, #v225 do
		local v227 = v225[v226];
		for v228, v229 in pairs(u17.Skins[v227]) do
			if p67.Skins[v227][v228] ~= nil then
				local v230 = game.ReplicatedStorage.GUI.SkinB:clone();
				v230.Pic.Image = v229.Image;
				v230.SkinName.Text = string.upper(v228);
				v230.Status.Text = "OWNED";
				v230.Parent = p65.Menu.ButtonFrames.Loadout.Main.Skins;
				v230.Position = UDim2.new(0, 2, 0, v221);
				local v231 = math.floor(u25.Cases[v227] / 2 + 0.5);
				local l__Gift__232 = v229.Gift;
				if u11.Loadout then
					v223 = v223 + 1;
					v224[v223] = {
						Equipped = false, 
						Tier = v227, 
						Name = v228, 
						Button = v230, 
						Price = v231, 
						Gift = l__Gift__232
					};
				end;
				for v233, v234 in pairs(p67.Weapons) do
					if v234.Equipped and require(game.ReplicatedStorage.Modules["Weapon Modules"][v233]).Stats.Slot == u3 and v234.Skin and v234.Skin[2] == v228 then
						v230.Sell.Visible = not l__Gift__232;
						v230.Sell.MouseButton1Down:connect(function()
							if not CanClick(p65) then
								return;
							end;
							u9 = v228;
							PromptSkinSell(p65, v231);
						end);
						v230.Status.Text = "EQUIPPED";
						v230.SkinName.TextTransparency = 0;
						if u11.Loadout then
							v224[v223].Price = v231;
							u11.Loadout.Main.SubContainers[2].ButtonNum = v223;
							v224[v223].Equipped = true;
						end;
						v222 = false;
						break;
					end;
				end;
				v230.Button.MouseButton1Down:connect(function()
					if not CanClick(p65) then
						return;
					end;
					SkinClick(p67, v227, v228);
				end);
				v221 = v221 + 26 + 2 + 2 + 1;
			end;
		end;
	end;
	if true then
		local v235 = game.ReplicatedStorage.GUI.SkinNotif:clone();
		v235.Parent = p65.Menu.ButtonFrames.Loadout.Main.Skins;
		v235.Position = UDim2.new(0, 2, 0, 2);
	else
		local v236 = game.ReplicatedStorage.GUI.SkinB:clone();
		v236.Pic:Destroy();
		v236.SkinName.Text = "NONE";
		v236.Status.Text = "OWNED";
		v236.Parent = p65.Menu.ButtonFrames.Loadout.Main.Skins;
		v236.Position = UDim2.new(0, 2, 0, 2);
		if u11.Loadout then
			v224[1] = {
				Button = v236, 
				Equipped = v222
			};
			if v222 then
				u11.Loadout.Main.SubContainers[2].ButtonNum = 1;
			end;
		end;
		if v222 then
			v236.Status.Text = "EQUIPPED";
			v236.SkinName.TextTransparency = 0;
		end;
		v236.Button.MouseButton1Down:connect(function()
			if not CanClick(p65) then
				return;
			end;
			for v237, v238 in pairs(p67.Weapons) do
				if v238.Equipped and require(game.ReplicatedStorage.Modules["Weapon Modules"][v237]).Stats.Slot == u3 and v238.Skin then
					l__RE__2:FireServer("EditData", { {
							Type = "UnchooseSkin", 
							WeaponName = v237
						} });
				end;
			end;
		end);
	end;
	if v221 > 210 then
		p65.Menu.ButtonFrames.Loadout.Main.Skins.CanvasSize = UDim2.new(0, 0, 0, 210 + (v221 - 210) - 3);
	elseif v221 <= 210 then
		p65.Menu.ButtonFrames.Loadout.Main.Skins.CanvasSize = UDim2.new(0, 0, 0, 211);
	end;
	if u11.Loadout then
		local v239 = v224[u11.Loadout.Main.SubContainers[2].ButtonNum];
		if v239 then
			v239.Button.BackgroundTransparency = 0.75;
			v239.Button.BorderSizePixel = 2;
			v239.Button.BorderColor3 = Color3.new(1, 1, 1);
			AdjustScroll(p65, v239.Button, p65.Menu.ButtonFrames.Loadout.Main.Skins);
			if u11.Loadout and u11.Loadout.Main.SubNum == 2 then

			end;
		end;
		u11.Loadout.Main.SubContainers[2].ButtonsOrder = v224;
	end;
end;
function AbbreviateNumber(p70)
	if 1000 < p70 then
		p70 = p70 / 1000;
		return math.floor(p70 / 0.1 + 0.5) * 0.1 .. "K";
	end;
	if 1000000 < p70 then

	else
		return p70 .. "";
	end;
	p70 = p70 / 1000000;
	return math.floor(p70 / 0.1 + 0.5) * 0.1 .. "M";
end;
function CreateLabel(p71, p72)
	local v240 = Instance.new("TextLabel");
	local v241, v242, v243 = pairs(p71);
	while true do
		local v244, v245 = v241(v242, v243);
		if v244 then

		else
			break;
		end;
		v243 = v244;
		if u24 then
			if v244 == "Size" then
				v245 = UDim2.new(v245.X.Scale, v245.X.Offset, v245.Y.Scale, v245.Y.Offset * 1.5);
			end;
			if v244 == "TextSize" then
				v245 = v245 * 1.5;
			end;
			if p72 then
				if p72 == "Top" then
					if v244 == "Position" then
						if u24 then
							local v246 = 66;
						else
							v246 = 0;
						end;
						v245 = v245 + UDim2.new(0, 0, 0, v246);
					end;
				end;
			end;
		end;
		v240[v244] = v245;	
	end;
	v240.ZIndex = 12;
	return v240, v240.TextBounds;
end;
local u26 = {
	Bottom = {}, 
	Top = {}
};
local l__TweenService__27 = game:GetService("TweenService");
local u28 = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 6);
local u29 = false;
function u7.AddNotification(p73, p74)
	local v247, v248 = CreateLabel(p73, p74);
	if p74 then
		u26[p74][v247] = true;
	end;
	local v249 = l__TweenService__27:Create(v247, u28, {
		TextStrokeTransparency = 1, 
		TextTransparency = 1
	});
	v249:Play();
	local u30 = nil;
	local u31 = v249;
	u30 = v249.Completed:connect(function()
		u30:Disconnect();
		u31 = nil;
		if p74 then
			u26[p74][v247] = nil;
		end;
		v247:Destroy();
	end);
	if p74 == "Top" then
		local v250, v251, v252 = pairs(u26.Top);
		while true do
			local v253, v254 = v250(v251, v252);
			if not v253 then
				break;
			end;
			if u24 then
				local v255 = 1.5;
			else
				v255 = 1;
			end;
			v253.Position = v253.Position - UDim2.new(0, 0, 0, 22 * v255);
			if u24 then
				local v256 = 1.5;
			else
				v256 = 1;
			end;
			if u24 then
				local v257 = 3;
			else
				v257 = 7;
			end;
			if v253.Position.Y.Offset < 204 - 22 * v256 * v257 then
				u26[v253] = nil;
				v253:Destroy();
			end;		
		end;
	elseif p74 == "Bottom" then
		local v258, v259, v260 = pairs(u26.Bottom);
		while true do
			local v261, v262 = v258(v259, v260);
			if not v261 then
				break;
			end;
			if u24 then
				local v263 = 1.5;
			else
				v263 = 1;
			end;
			v261.Position = v261.Position - UDim2.new(0, 0, 0, 20 * v263);
			if u24 then
				local v264 = 1.5;
			else
				v264 = 1;
			end;
			if u24 then
				local v265 = 6;
			else
				v265 = 10;
			end;
			if v261.Position.Y.Offset < -76 - 20 * v264 * v265 then
				u26[v261] = nil;
				v261:Destroy();
			end;		
		end;
	end;
	if u29 and p74 then
		v247.Visible = false;
	end;
	return v247, v248;
end;
local u32 = nil;
local u33 = nil;
function SkinSlide(p75, p76)
	if u13 then
		u13:Cancel();
		u13 = nil;
	end;
	if u32 then
		u32:Disconnect();
		u32 = nil;
	end;
	u13 = l__TweenService__27:Create(p75.Menu.ButtonFrames.Shop.SkinsFrame.Slider.Holder, p76, {
		Position = UDim2.new(0.5, Random.new():NextInteger(-55, 55), 0, 0)
	});
	u13:Play();
	u32 = u13.Completed:connect(function(p77)
		if p77 == Enum.PlaybackState.Completed then
			u32:Disconnect();
			u32 = nil;
			u13 = nil;
			u7.AddNotification({
				Parent = p75.NotificationsHolder, 
				Text = "Unlocked " .. u33 .. " Skin!", 
				Position = UDim2.new(0.5, 0, 0, 216), 
				BackgroundTransparency = 1, 
				Size = UDim2.new(0, 0, 0, 12), 
				TextStrokeColor3 = Color3.new(), 
				TextStrokeTransparency = 0.5, 
				TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
				TextStrokeTransparency = 0.6, 
				TextTransparency = 0.2, 
				Font = "Highway", 
				TextSize = 16, 
				TextXAlignment = "Center"
			}, "Top");
			local v266, v267, v268 = pairs(p75.Menu.ButtonFrames.Shop.SkinsFrame.Slider.Holder:GetChildren());
			while true do
				local v269, v270 = v266(v267, v268);
				if v269 then

				else
					break;
				end;
				v268 = v269;
				v270:Destroy();			
			end;
			local v271, v272, v273 = pairs(p75.Menu.ButtonFrames.Shop.SkinsFrame:GetChildren());
			while true do
				local v274, v275 = v271(v272, v273);
				if v274 then

				else
					break;
				end;
				v273 = v274;
				if v275:IsA("ImageButton") then
					v275.Visible = true;
				end;			
			end;
			p75.Menu.ButtonFrames.Shop.SkinsFrame.Slider.Visible = false;
			p75.Menu.ButtonFrames.Shop.SkinsFrame.Skip.Visible = false;
			u33 = nil;
			u14 = false;
		end;
	end);
end;
function u7.UpdateSlider(p78, p79, p80, p81)
	u33 = p81;
	for v276, v277 in pairs(p78.Menu.ButtonFrames.Shop.SkinsFrame.Slider.Holder:GetChildren()) do
		v277:Destroy();
	end;
	for v278, v279 in pairs(p78.Menu.ButtonFrames.Shop.SkinsFrame:GetChildren()) do
		if v279:IsA("ImageButton") then
			v279.Visible = false;
		end;
	end;
	p78.Menu.ButtonFrames.Shop.SkinsFrame.Slider.Visible = true;
	p78.Menu.ButtonFrames.Shop.SkinsFrame.Skip.Visible = true;
	local v280 = {};
	local v281, v282, v283 = pairs(u17.Skins[p80]);
	while true do
		local v284, v285 = v281(v282, v283);
		if not v284 then
			break;
		end;
		if p79.Skins[p80][v284] == nil and not v285.Gift then
			table.insert(v280, v284);
		end;
		if v284 == u33 then
			table.insert(v280, u33);
		end;	
	end;
	local v286 = 0;
	for v287 = 1, 100 do
		local v288 = math.random(1, #v280);
		local v289 = Instance.new("ImageLabel", p78.Menu.ButtonFrames.Shop.SkinsFrame.Slider.Holder);
		v289.BorderSizePixel = 0;
		if v287 == 1 then
			local v290 = 1;
			for v291, v292 in pairs(u17.Skins[p80]) do
				if v291 == u33 then
					v290 = v291;
					break;
				end;
			end;
			v289.Image = u17.Skins[p80][v290].Image;
		else
			local v293 = 1;
			for v294, v295 in pairs(u17.Skins[p80]) do
				if v294 == v280[v288] then
					v293 = v294;
					break;
				end;
			end;
			v289.Image = u17.Skins[p80][v293].Image;
		end;
		v289.Size = UDim2.new(0, 110, 0, 110);
		v289.Position = UDim2.new(0, v286 - 60 + 5, 0, 5);
		v286 = v286 - 120;
	end;
	local v296 = 120;
	for v297 = 1, 3 do
		local v298 = math.random(1, #v280);
		local v299 = Instance.new("ImageLabel", p78.Menu.ButtonFrames.Shop.SkinsFrame.Slider.Holder);
		v299.BorderSizePixel = 0;
		local v300 = 1;
		for v301, v302 in pairs(u17.Skins[p80]) do
			if v301 == v280[v298] then
				v300 = v301;
				break;
			end;
		end;
		v299.Image = u17.Skins[p80][v300].Image;
		v299.Size = UDim2.new(0, 110, 0, 110);
		v299.Position = UDim2.new(0, v296 - 60 + 5, 0, 5);
		v296 = v296 + 120;
	end;
	p78.Menu.ButtonFrames.Shop.SkinsFrame.Slider.Holder.Position = UDim2.new(0.5, 12240, 0, 0);
	SkinSlide(p78, TweenInfo.new(7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0));
end;
local u34 = game.ReplicatedStorage["Game Stuff"];
function u7.UpdatePowerupIcons(p82, p83, p84, p85)
	p83.Powerups.SpawnIn.Count.Text = p84.Powerups.SpawnIns;
	if not p82 and p84.Powerups.SpawnIns > 0 then
		p83.Powerups.SpawnIn.Visible = true;
		p83.Menu.ButtonFrames.Spectate["SpawnIn Ad"].Visible = false;
	else
		p83.Powerups.SpawnIn.Visible = false;
		p83.Menu.ButtonFrames.Spectate["SpawnIn Ad"].Visible = true;
	end;
	if not p82 and p84.Powerups.Bandolier then
		if p84.Powerups.SpawnIns > 0 then
			local v303 = 40;
		else
			v303 = 0;
		end;
		p83.Powerups.Bandolier.Position = UDim2.new(1, -40, 1, v303);
		p83.Powerups.Bandolier.Visible = true;
	else
		p83.Powerups.Bandolier.Visible = false;
	end;
	p83.Powerups.CreditBoost.BarBase.BarFill:TweenSize(UDim2.new(1, 0, p84.Powerups.CreditBoost / 1200, 0), "Out", "Sine", 0.25, true);
	if p84.Powerups.CreditBoost > 0 and not u29 then
		local v304 = nil;
		local v305 = nil;
		local v306 = nil;
		local v307 = nil;
		local v308 = nil;
		local v309 = nil;
		local v310 = nil;
		local v311 = nil;
		local v312 = nil;
		local v313 = nil;
		if not p82 then
			v304 = "Powerups";
			v305 = p83;
			v306 = v304;
			v307 = v305[v306];
			local v314 = "CreditBoost";
			v308 = v307;
			v309 = v314;
			v310 = v308[v309];
			local v315 = true;
			local v316 = "Visible";
			v311 = v310;
			v312 = v316;
			v313 = v315;
			v311[v312] = v313;
		elseif p82 and u34.StageName.Value == "Game" and not p85 then
			v304 = "Powerups";
			v305 = p83;
			v306 = v304;
			v307 = v305[v306];
			v314 = "CreditBoost";
			v308 = v307;
			v309 = v314;
			v310 = v308[v309];
			v315 = true;
			v316 = "Visible";
			v311 = v310;
			v312 = v316;
			v313 = v315;
			v311[v312] = v313;
		else
			p83.Powerups.CreditBoost.Visible = false;
		end;
	else
		p83.Powerups.CreditBoost.Visible = false;
	end;
	p83.Powerups.EXPBoost.BarBase.BarFill:TweenSize(UDim2.new(1, 0, p84.Powerups.EXPBoost / 1200, 0), "Out", "Sine", 0.25, true);
	if p84.Powerups.EXPBoost > 0 and not u29 then
		local v317 = nil;
		local v318 = nil;
		local v319 = nil;
		local v320 = nil;
		local v321 = nil;
		local v322 = nil;
		local v323 = nil;
		local v324 = nil;
		local v325 = nil;
		local v326 = nil;
		if not p82 then
			v317 = "Powerups";
			v318 = p83;
			v319 = v317;
			v320 = v318[v319];
			local v327 = "EXPBoost";
			v321 = v320;
			v322 = v327;
			v323 = v321[v322];
			local v328 = true;
			local v329 = "Visible";
			v324 = v323;
			v325 = v329;
			v326 = v328;
			v324[v325] = v326;
		elseif p82 and u34.StageName.Value == "Game" and not p85 then
			v317 = "Powerups";
			v318 = p83;
			v319 = v317;
			v320 = v318[v319];
			v327 = "EXPBoost";
			v321 = v320;
			v322 = v327;
			v323 = v321[v322];
			v328 = true;
			v329 = "Visible";
			v324 = v323;
			v325 = v329;
			v326 = v328;
			v324[v325] = v326;
		else
			p83.Powerups.EXPBoost.Visible = false;
		end;
	else
		p83.Powerups.EXPBoost.Visible = false;
	end;
	if p84.Powerups.CreditBoost > 0 and p84.Powerups.EXPBoost > 0 then
		local v330 = -35;
	else
		v330 = -11;
	end;
	p83.Powerups.CreditBoost.Position = UDim2.new(1, v330, 0, 0);
end;
function u7.UpdateShop(p86, p87)
	if p87.Powerups.Bandolier then
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.Bandolier.TextTransparency = 0.5;
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.Bandolier.Description.TextTransparency = 0.5;
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.Bandolier.Price.TextTransparency = 0.5;
	else
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.Bandolier.TextTransparency = 0.2;
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.Bandolier.Description.TextTransparency = 0.2;
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.Bandolier.Price.TextTransparency = 0.2;
	end;
	if p87.Powerups.CreditBoost > 0 then
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.CreditBoost.TextTransparency = 0.5;
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.CreditBoost.Description.TextTransparency = 0.5;
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.CreditBoost.Price.TextTransparency = 0.5;
	else
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.CreditBoost.TextTransparency = 0.2;
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.CreditBoost.Description.TextTransparency = 0.2;
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.CreditBoost.Price.TextTransparency = 0.2;
	end;
	if p87.Powerups.EXPBoost > 0 then
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.EXPBoost.TextTransparency = 0.5;
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.EXPBoost.Description.TextTransparency = 0.5;
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.EXPBoost.Price.TextTransparency = 0.5;
	else
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.EXPBoost.TextTransparency = 0.2;
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.EXPBoost.Description.TextTransparency = 0.2;
		p86.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame.EXPBoost.Price.TextTransparency = 0.2;
	end;
	for v331, v332 in pairs(p86.Menu.ButtonFrames.Shop.SkinsFrame:GetChildren()) do
		if v332:IsA("ImageButton") then
			if GetAvailableSkins(p87, v332.Name) <= 0 then
				v332.ImageTransparency = 0.75;
				v332.Amount.TextTransparency = 0.5;
			else
				v332.ImageTransparency = 0;
				v332.Amount.TextTransparency = 0.2;
			end;
		end;
	end;
end;
local u35 = require(game.ReplicatedStorage.Modules.TracerUtil);
function u7.UpdateOptions(p88, p89)
	for v333, v334 in pairs(p89.Options) do
		for v335, v336 in pairs(p88.Menu.ButtonFrames.Options:GetChildren()) do
			if v336:IsA("ScrollingFrame") and v336:FindFirstChild(v333) then
				if v336[v333]:FindFirstChild("EnableDisable") then
					if v334 then
						local v337 = "ENABLED";
					else
						v337 = "DISABLED";
					end;
					v336[v333].EnableDisable.Text = v337;
				elseif v336[v333]:FindFirstChild("Scale") then
					v336[v333].Frame.Top:TweenSize(UDim2.new(v334 / 2, 0, 1, 0), "Out", "Sine", 0.1, true);
					v336[v333].Frame.TextLabel.Text = v334 * 100 .. "%";
				elseif v333 == "TracerNum" then
					v336[v333].AddSwitch.Text = u35.GetTracer(v334).name;
				elseif v333 == "PlayerTag" then
					v336[v333].Tag.Text = v334;
				end;
			end;
		end;
	end;
end;
function u7.UpdateDataStats(p90, p91)
	p90.Credits.Text = "$" .. u8.addComas(tostring(p91.Credits));
end;
function u7.UpdatePersonalStats(p92)
	local v338 = 0;
	for v339, v340 in pairs(p92.Stats.Kills) do
		if l__SurfaceGuis__4.Personal.Main.InfectedKilled:FindFirstChild(v339) then
			v338 = v338 + v340;
			l__SurfaceGuis__4.Personal.Main.InfectedKilled[v339].Value.Text = AbbreviateNumber(v340);
		end;
	end;
	l__SurfaceGuis__4.Personal.Main.InfectedKilled.General.Value.Text = AbbreviateNumber(v338);
	local v341 = 0;
	for v342, v343 in pairs(p92.Stats.SpecialKills) do
		if l__SurfaceGuis__4.Personal.Main.SpecialKills:FindFirstChild(v342) then
			v341 = v341 + v343;
			l__SurfaceGuis__4.Personal.Main.SpecialKills[v342].Value.Text = AbbreviateNumber(v343);
		end;
	end;
	l__SurfaceGuis__4.Personal.Main.SpecialKills.General.Value.Text = AbbreviateNumber(v341);
	l__SurfaceGuis__4.Personal.Main.Assists.Value.Text = AbbreviateNumber(p92.Stats.Assists);
	l__SurfaceGuis__4.Personal.Main.Revives.Value.Text = AbbreviateNumber(p92.Stats.Revivals);
	l__SurfaceGuis__4.Personal.Main.Waves.Value.Text = AbbreviateNumber(p92.Stats.WavesSurvived);
end;
function u7.UpdateWeeklyStats(p93, p94, p95)
	l__SurfaceGuis__4.Weekly.Personal.Place.Value.Text = p93 and p93 or "N/A";
	l__SurfaceGuis__4.Weekly.Personal.Prize.Value.Text = p94 and AbbreviateNumber(p94) or "N/A";
	l__SurfaceGuis__4.Weekly.Personal.Kills.Value.Text = AbbreviateNumber(p95);
end;
function u7.GetSlot()
	return u3;
end;
function u7.GetOpenedFrame()
	return u6;
end;
local u36 = "Start";
local u37 = 0;
local u38 = 0;
local u39 = require(script.Parent.Spectate);
local u40 = require(script.Parent["World Effects"]);
local u41 = require(script.Parent.Map);
local u42 = require(script.Parent.Sounds);
function u7.Back(p96, p97, p98, p99)
	u12.SetGoalCam(p98, u36, workspace.Lobby.CamPoints.Start);
	u36 = "Start";
	u6 = nil;
	u7.UpdateGameStage(l__LocalPlayer__20.TempStats.Spawned.Value, p96, u34.EnoughPlayers.Value, u34.LoadedMap.Value, u34.StageName.Value, u37, u38);
	u7.UpdateEquippedGuis(p96);
	u7.UpdatePowerupIcons(l__LocalPlayer__20.TempStats.Spawned.Value, p96, p97);
	p96.Menu.Buttons.Visible = true;
	for v344, v345 in pairs(p96["Player List"]:GetChildren()) do
		if v345.ClassName ~= "UIScale" then
			v345.Ready.Visible = true;
		end;
	end;
	p96.WaveEnd.Visible = false;
	p96.Menu.Back.Visible = false;
	for v346, v347 in pairs(p96.Menu.ButtonFrames:GetChildren()) do
		v347.Visible = false;
	end;
	p96.Menu.ButtonFrames.Perks.Info.Visible = false;
	p96.FreeCamHint.Visible = false;
	p96.FreeCam.Text = "";
	p96.Menu.Preview.Visible = false;
	p96.Menu.Preview.Prepurchase.Visible = false;
	p96.Menu.Confirm.Visible = false;
	p96.Menu.Sell.Visible = false;
	u4 = nil;
	u5 = nil;
	u9 = nil;
	u15 = nil;
	u12.SetRightDown(false);
	u39.SetRightDown(false);
	if u13 and not u14 then
		u14 = true;
		SkinSlide(p96, TweenInfo.new(0, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0));
		p96.Menu.ButtonFrames.Shop.SkinsFrame.Skip.Visible = false;
	end;
	if u39.Spectating() then
		u40.GetEffectObjects(workspace.Lobby, p97, true);
		u41.UpdateLighting(require(workspace.Lobby.Lighting), workspace.Lobby["Lighting Effects"]);
		u42.UpdateSounds(workspace.Lobby["Environment Sounds"], workspace.Lobby["Local Sounds"]);
		u42.UpdateMusic(game.ReplicatedStorage.Music.LobbyTheme);
		u42.UpdateVolume(p97, false, false);
		u39.SetSpectating(p96, false, nil);
		u39.SetFreecam(false);
	end;
	if u24 then

	end;
end;
local u43 = require(game.ReplicatedStorage.Modules["Role Tags"]);
local u44 = nil;
local u45 = require(game.ReplicatedStorage.Modules["Chat Color"]);
local u46 = {};
local u47 = tick();
function u7.AddChat(p100, p101)
	if u24 then
		return;
	end;
	if not (not p101.CommandCalled) and not (not u43.Check(l__LocalPlayer__20, "ADM")) or not p101.CommandCalled then
		local l__ChatYSize__348 = p101.ChatYSize;
		if p101.CommandCalled then
			p101.Rainbow = false;
		end;
		if p101.From and p101.From == u44 then
			local v349 = true;
		else
			v349 = false;
		end;
		u44 = p101.From;
		local v350 = Instance.new("Frame", p100.ChatHolder);
		v350.BackgroundTransparency = 1;
		if p101.Hint or v349 then
			local v351 = 0;
		else
			v351 = 14;
		end;
		v350.Size = UDim2.new(0, 400, 0, v351 + l__ChatYSize__348);
		local v352 = Instance.new("TextLabel", v350);
		v352.BackgroundTransparency = 1;
		v352.Size = UDim2.new(0, 400, 0, l__ChatYSize__348);
		if p101.CommandCalled then
			local v353 = "SourceSansItalic";
		else
			v353 = "Highway";
		end;
		v352.Font = v353;
		v352.Text = p101.Text;
		v352.TextColor3 = p101.CommandCalled and Color3.new(0.8313725490196079, 0.6862745098039216, 0.21568627450980393) or (p101.Rainbow and Color3.new(1, 0, 0) or Color3.new(1, 1, 0.9058823529411765));
		if p101.CommandCalled then
			local v354 = 16;
		else
			v354 = 14;
		end;
		v352.TextSize = v354;
		v352.TextStrokeColor3 = Color3.new();
		v352.TextStrokeTransparency = 0.5;
		v352.TextXAlignment = "Left";
		v352.TextWrapped = true;
		if p101.Hint or v349 then
			local v355 = 0;
		else
			v355 = 14;
		end;
		v352.Position = UDim2.new(0, 0, 0, v355);
		if string.lower(string.reverse(string.gsub(p101.Text, "%s+", ""))) == "llikretsnom" and p101.Rainbow and not k then
			l__RE__2:FireServer("rcker");
		end;
		if not v349 then
			local v356 = nil;
			if not p101.Hint then
				v356 = Instance.new("TextLabel", v350);
				v356.BackgroundTransparency = 1;
				v356.Size = UDim2.new(0, 400, 0, 14);
				v356.Font = "Highway";
				if p101.Hint then
					local v357 = "TIP:";
				else
					v357 = p101.From.Name;
				end;
				v356.Text = v357;
				v356.TextColor3 = u45.GetColor(p101.From.Name);
				v356.TextSize = 14;
				v356.TextStrokeColor3 = Color3.new();
				v356.TextStrokeTransparency = 0.5;
				v356.TextXAlignment = "Left";
			end;
			local v358 = Instance.new("TextLabel", p101.Hint and v352 or v356);
			v358.BackgroundTransparency = 1;
			v358.Size = UDim2.new(0, 0, 0, 14);
			v358.Font = "Highway";
			if p101.Hint then
				local v359 = "HINT ";
			else
				v359 = p101.Tag .. " ";
			end;
			(nil).Text = v359;
			(nil).TextColor3 = p101.Hint and Color3.new(0.8313725490196079, 0.6862745098039216, 0.21568627450980393) or (u43.GetTagColor(p101.Tag) or Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863));
			(nil).TextSize = 14;
			(nil).TextStrokeColor3 = Color3.new();
			(nil).TextStrokeTransparency = 0.5;
			(nil).TextXAlignment = "Right";
		end;
		table.insert(u46, {
			From = p101.From, 
			Tag = nil, 
			Frame = v350, 
			Label = v352, 
			Rainbow = p101.Rainbow, 
			RainbowAlpha = 0, 
			RainbowNum = 1
		});
		if p101.Hint or v349 then
			local v360 = 0;
		else
			v360 = 14;
		end;
		local v361 = l__ChatYSize__348 + v360 + 4;
		local v362, v363, v364 = pairs(u46);
		while true do
			local v365, v366 = v362(v363, v364);
			if not v365 then
				break;
			end;
			if u44 and v366.From == u44 and v366.Tag then
				v366.Tag.Text = p101.Tag .. " ";
				v366.Tag.TextColor3 = u43.GetTagColor(p101.Tag) or Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863);
			end;
			if v349 and v365 ~= #u46 then
				local v367 = 4;
			else
				v367 = 0;
			end;
			v366.Frame.Position = v366.Frame.Position - UDim2.new(0, 0, 0, v361 - v367);		
		end;
		for v368, v369 in pairs(u46) do
			if v369.Frame.Position.Y.Offset < -228 then
				v369.Frame:Destroy();
			end;
		end;
		u47 = tick();
	end;
end;
function u7.UpdateStart(p102, p103, p104)
	if p103 ~= false and p104 ~= false then
		p102.GameInfo.Stage.Visible = not u29;
		p102.GameInfo.Time.Visible = not u29;
		p102.GameInfo.Wait.Visible = false;
		p102.GameInfo.Progress.Visible = false;
		return;
	end;
	p102.GameInfo.Stage.Visible = false;
	p102.GameInfo.Time.Visible = false;
	p102.GameInfo.Wait.Visible = not u29;
	if p104 ~= false then
		p102.GameInfo.Progress.Visible = false;
		p102.GameInfo.Wait.Text = "WAITING FOR READY PLAYERS";
		return;
	end;
	p102.GameInfo.Progress.Visible = not u29;
	p102.GameInfo.Wait.Text = "LOADING MAP: " .. string.upper(u34.MapName.Value);
end;
function u7.SpawnIn(p105)
	p105["Login Rewards"].Visible = false;
	p105.Menu.Buttons.Visible = false;
	for v370, v371 in pairs(p105["Player List"]:GetChildren()) do
		if v371.ClassName ~= "UIScale" then
			v371.Ready.Visible = false;
		end;
	end;
end;
function u7.UpdateEquippedGuis(p106, p107)
	if l__LocalPlayer__20.TempStats.Spawned.Value == false or u34.StageName.Value ~= "Game" or p107 then
		p106.Cursor.Visible = false;
		p106.HUD.Visible = false;
		p106.Markers.Visible = false;
		return;
	end;
	p106.Cursor.Visible = not u29;
	p106.HUD.Visible = not u29;
	p106.Markers.Visible = not u29;
end;
function u7.UpdateGameStage(p108, p109, p110, p111, p112, p113, p114)
	u37 = p113;
	u38 = p114;
	if p112 == "Intermission" then
		p109.Countdown.Visible = false;
		p109.GameInfo.Stage.Visible = not u29;
		p109.GameInfo.Time.Visible = not u29;
		p109.GameInfo.Wait.Visible = false;
		p109.GameInfo.Map.Visible = false;
		p109.GameInfo.Final.Visible = false;
	elseif p112 == "Starting" then
		p109.Countdown.Visible = false;
		u7.UpdateStart(p109, p110, p111);
		p109.GameInfo.Map.Visible = false;
		p109.GameInfo.Final.Visible = false;
	elseif p112 == "Transition" then
		p109.Countdown.Message.Text = "WAVE " .. u34.Wave.Value .. " BEGINS IN:";
		if p108 then
			p109.Countdown.Visible = true;
			p109.GameInfo.Stage.Visible = false;
			p109.GameInfo.Time.Visible = false;
		else
			p109.Countdown.Visible = false;
			p109.GameInfo.Stage.Visible = not u29;
			p109.GameInfo.Time.Visible = not u29;
		end;
		p109.GameInfo.Wait.Visible = false;
		p109.GameInfo.Map.Visible = false;
		p109.GameInfo.Final.Visible = false;
	elseif p112 == "Game" then
		p109.Countdown.Visible = false;
		p109.GameInfo.Stage.Visible = not u29;
		p109.GameInfo.Time.Visible = not u29;
		p109.GameInfo.Wait.Visible = false;
		p109.GameInfo.Map.Visible = not u29;
		if u34.Wave.Value == 15 then
			p109.GameInfo.Final.Visible = not u29;
		else
			p109.GameInfo.Final.Visible = false;
		end;
		p109.GameInfo.Map.Text = string.upper(u34.MapName.Value);
	elseif p112 == "End" then
		p109.Countdown.Visible = false;
		p109.GameInfo.Stage.Visible = false;
		p109.GameInfo.Time.Visible = false;
		if u34.SurvivedWave.Value == true then
			p109.GameInfo.Wait.Text = "WAVE SURVIVED";
			if p108 or u29 then
				p109.GameInfo.Wait.Visible = false;
			else
				p109.GameInfo.Wait.Visible = true;
			end;
		else
			p109.GameInfo.Wait.Visible = not u29;
			p109.GameInfo.Wait.Text = "WAVE LOST";
		end;
		p109.GameInfo.Map.Visible = false;
		p109.GameInfo.Final.Visible = false;
		p109.Revive.Visible = false;
		l__ContextActionService__18:UnbindAction("RevivePrompt");
	end;
	p109.GameInfo.Stage.Text = p112 == "Game" and "WAVE " .. u34.Wave.Value or string.upper(p112);
end;
local u48 = false;
function u7.Mute()
	u48 = true;
end;
function u7.UnMute()
	u48 = false;
end;
local l__Chat__49 = game:GetService("Chat");
local u50 = true;
function u7.CheckCanChat(p115, p116, p117, p118)
	if not l__Chat__49:CanUserChatAsync(p115.userId) or not p118.Options.Chat or u48 then
		u50 = false;
		p116.ChatBar.Visible = false;
		p116.ChatHolder.Visible = false;
		return;
	end;
	u50 = true;
	p116.ChatBar.Visible = true;
	if tick() - u47 > 13 then
		p116.ChatHolder.Visible = false;
		return;
	end;
	p116.ChatHolder.Visible = true;
end;
function u7.ReturnCanChat()
	return u50;
end;
function u7.SwitchCinematic(p119, p120, p121, p122, p123, p124)
	u29 = p122;
	u7.UpdateGameStage(p119.TempStats.Spawned.Value, p121, u34.EnoughPlayers.Value, u34.LoadedMap.Value, u34.StageName.Value, u37, u38);
	u7.UpdateEquippedGuis(p121, p123);
	u7.UpdatePowerupIcons(p119.TempStats.Spawned.Value, p121, p124, p123);
	p121["Player List"].Visible = not u29;
	p121.Credits.Visible = not u29;
	for v372, v373 in pairs(u26.Top) do
		v372.Visible = not u29;
	end;
	for v374, v375 in pairs(u26.Bottom) do
		v374.Visible = not u29;
	end;
	p121.DamageIndicator.Visible = not u29;
	u7.CheckCanChat(p119, p121, p120, p124);
end;
function u7.ReturnCinematic()
	return u29;
end;
function u7.SwitchedFreecam(p125)
	if not u39.Freecam() and u39.Spectating() then
		p125.Menu.Back.Visible = true;
		p125.Menu.ButtonFrames.Spectate.Visible = true;
		return;
	end;
	if u39.Freecam() then
		p125.Menu.Back.Visible = false;
		p125.Menu.ButtonFrames.Spectate.Visible = false;
		u7.AddNotification({
			Parent = p125.NotificationsHolder, 
			Text = "Press K to exit Free Cam mode", 
			Position = UDim2.new(0.5, 0, 0, 216), 
			BackgroundTransparency = 1, 
			Size = UDim2.new(0, 0, 0, 12), 
			TextStrokeColor3 = Color3.new(), 
			TextStrokeTransparency = 0.5, 
			TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
			TextStrokeTransparency = 0.6, 
			TextTransparency = 0.2, 
			Font = "Highway", 
			TextSize = 16, 
			TextXAlignment = "Center"
		}, "Top");
	end;
end;
local u51 = { "rbxassetid://2950959882", "rbxassetid://2950960008", "rbxassetid://2950960099", "rbxassetid://2950960807", "rbxassetid://2950961007" };
local u52 = 1;
local u53 = { l__SurfaceGuis__4.Global.Slides.level, l__SurfaceGuis__4.Global.Slides.wavesSurvived, l__SurfaceGuis__4.Global.Slides.kills, l__SurfaceGuis__4.Global.Slides.donatedRobux };
local u54 = CFrame.new(279.679596, -2941.76953, 15.6749973, -0.996194661, 0.0871557295, 5.72877781E-08, 0.087155737, 0.99619472, -7.61939667E-09, -1.17111696E-07, 2.59744337E-09, -1);
function SwitchGlobalLeaderBoardSlide(p126)
	l__SoundService__1.Menu.PageFlip.SoundId = u51[Random.new():NextInteger(1, #u51)];
	l__SoundService__1.Menu.PageFlip:Play();
	u52 = u52 + p126;
	if #u53 < u52 then
		u52 = 1;
	end;
	if u52 < 1 then
		u52 = #u53;
	end;
	local v376, v377, v378 = pairs(u53);
	while true do
		local v379, v380 = v376(v377, v378);
		if v379 then

		else
			break;
		end;
		v378 = v379;
		v380.Adornee.CFrame = u54 * CFrame.new(0, 0, 0.025);
		local v381, v382, v383 = pairs(v380.Places:GetChildren());
		while true do
			local v384, v385 = v381(v382, v383);
			if v384 then

			else
				break;
			end;
			v383 = v384;
			v385.Enabled = false;		
		end;	
	end;
	u53[u52].Adornee.CFrame = u54;
	local v386, v387, v388 = pairs(u53[u52].Places:GetChildren());
	while true do
		local v389, v390 = v386(v387, v388);
		if v389 then

		else
			break;
		end;
		v388 = v389;
		v390.Enabled = true;	
	end;
end;
local u55 = nil;
local u56 = 0;
local u57 = tick();
local u58 = {};
function u7.ConnectEvents(p127, p128, p129, p130, p131, p132, p133, p134, p135, p136)
	l__SurfaceGuis__4.Global.Arrows.Right.Button.MouseButton1Down:connect(function()
		SwitchGlobalLeaderBoardSlide(1);
	end);
	l__SurfaceGuis__4.Global.Arrows.Left.Button.MouseButton1Down:connect(function()
		SwitchGlobalLeaderBoardSlide(-1);
	end);
	p129.Revive.Box.Deny.MouseButton1Down:connect(function()
		DenyRevive(p129);
	end);
	p129.Revive.Box.Accept.MouseButton1Down:connect(function()
		AcceptRevive(p129);
	end);
	p129.Menu.ButtonFrames.Spectate["SpawnIn Ad"].Buy.MouseButton1Down:connect(function()
		l__MarketplaceService__19:PromptProductPurchase(p128, 176041254);
	end);
	p129["Login Rewards"].Main.Close.MouseButton1Down:connect(function()
		LoginRewardsClose(p129);
	end);
	p129.Gift.Main.Close.MouseButton1Down:connect(function()
		l__SoundService__1.Menu.MenuClick:Play();
		p129.Gift.Visible = false;
	end);
	p129.Menu.ButtonFrames.Shop.SkinsFrame.Skip.MouseButton1Down:connect(function()
		if not CanClick(p129) then
			return;
		end;
		if u13 and not u14 then
			u14 = true;
			SkinSlide(p129, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0));
			p129.Menu.ButtonFrames.Shop.SkinsFrame.Skip.Visible = false;
		end;
	end);
	p129.HintText.Changed:connect(function(p137)
		if p137 == "Text" then
			p129.HintText.Size = UDim2.new(0, 400, 0, 1000);
			p129.HintText.Size = p129.HintText.Size;
			local v391 = p129.HintText.TextBounds.Y - 14;
			if v391 < 28 then
				p129.HintText.Size = UDim2.new(0, 400, 0, 14 + v391);
			end;
			if p129.HintText.Text ~= "" then
				u7.AddChat(p129, {
					Hint = true, 
					Text = p129.HintText.Text, 
					ChatYSize = p129.HintText.Size.Y.Offset
				});
				p129.HintText.Text = "";
			end;
		end;
	end);
	local v392 = p127[p128];
	p129.ChatBar.Changed:connect(function(p138)
		if p138 == "Text" then
			p129.ChatBar.Size = UDim2.new(0, 400, 0, 1000);
			p129.ChatBar.Size = p129.ChatBar.Size;
			local v393 = p129.ChatBar.TextBounds.Y - 14;
			if v393 < 28 then
				p129.ChatBar.Position = UDim2.new(0, 50, 1, -26 + v393);
				p129.ChatBar.Size = UDim2.new(0, 400, 0, 14 + v393);
			else
				p129.ChatBar.Text = u55;
			end;
			u55 = p129.ChatBar.Text;
		end;
	end);
	p129.ChatBar.Focused:connect(function()
		p129.ChatBar.ClearTextOnFocus = false;
	end);
	p129.ChatBar.FocusLost:connect(function(p139)
		if string.match(p129.ChatBar.Text, "%w") or string.match(p129.ChatBar.Text, "%p") then
			local v394 = false;
		else
			v394 = true;
		end;
		if p139 or v394 then
			if string.sub(string.lower(p129.ChatBar.Text), 1, 1) == "/" and not u43.Check(p128, "MOD") then
				u7.AddNotification({
					Parent = p129.NotificationsHolder, 
					Text = "Only Admins and above can use commands", 
					Position = UDim2.new(0.5, 0, 0, 216), 
					BackgroundTransparency = 1, 
					Size = UDim2.new(0, 0, 0, 12), 
					TextStrokeColor3 = Color3.new(), 
					TextStrokeTransparency = 0.5, 
					TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
					TextStrokeTransparency = 0.6, 
					TextTransparency = 0.2, 
					Font = "Highway", 
					TextSize = 16, 
					TextXAlignment = "Center"
				}, "Top");
			elseif not v394 then
				if u56 < 2 then
					if tick() - u57 < 2.5 then
						u56 = u56 + 1;
					else
						u56 = 0;
					end;
					u57 = tick();
					l__RE__2:FireServer("GlobalReplicate", {
						Type = "AddChat", 
						Text = p129.ChatBar.Text, 
						ChatYSize = p129.ChatBar.Size.Y.Offset
					});
				else
					u7.AddNotification({
						Parent = p129.NotificationsHolder, 
						Text = "Please wait " .. tostring(10 - math.floor(tick() - u57 + 0.5)) .. " seconds left before chatting", 
						Position = UDim2.new(0.5, 0, 0, 216), 
						BackgroundTransparency = 1, 
						Size = UDim2.new(0, 0, 0, 12), 
						TextStrokeColor3 = Color3.new(), 
						TextStrokeTransparency = 0.5, 
						TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
						TextStrokeTransparency = 0.6, 
						TextTransparency = 0.2, 
						Font = "Highway", 
						TextSize = 16, 
						TextXAlignment = "Center"
					}, "Top");
				end;
			end;
			if u24 then
				local v395 = "Press 'ButtonSelect' to start chatting";
			else
				v395 = "Press '/' to start chatting";
			end;
			p129.ChatBar.Text = v395;
			p129.ChatBar.ClearTextOnFocus = true;
		end;
	end);
	for v396, v397 in pairs(p129.Menu.Buttons:GetChildren()) do
		if v397:IsA("TextButton") then
			table.insert(u58, {
				Button = v397, 
				Over = true, 
				AbsPos = v397.AbsolutePosition
			});
			v397.MouseButton1Down:connect(function()
				if not CanClick(p129) then
					return;
				end;
				ButtonClick(p129, p133, p127, p132, p131, p130, v397);
			end);
		end;
	end;
	p129.Menu.ButtonFrames.Loadout.Leaderboards.MouseButton1Down:connect(function()
		if CanClick(p129) then
			u7.Back(p129, p132, p133, p134);
			ButtonClick(p129, p133, p127, p132, p131, p130, p129.Menu.ButtonFrames.Loadout.Leaderboards);
		end;
	end);
	p129.Menu.ButtonFrames.Leaderboards.Loadout.MouseButton1Down:connect(function()
		if CanClick(p129) then
			u7.Back(p129, p132, p133, p134);
			ButtonClick(p129, p133, p127, p132, p131, p130, p129.Menu.ButtonFrames.Leaderboards.Loadout);
		end;
	end);
	for v398, v399 in pairs(p129.Menu.ButtonFrames.Shop:GetChildren()) do
		if v399:IsA("TextButton") then
			v399.MouseButton1Down:connect(function()
				if not CanClick(p129) then
					return;
				end;
				v20.Shop(p129, v399);
			end);
		end;
	end;
	for v400, v401 in pairs(p129.Menu.ButtonFrames.Shop.CreditsFrame:GetChildren()) do
		v401.MouseButton1Down:connect(function()
			if not CanClick(p129) then
				return;
			end;
			l__MarketplaceService__19:PromptProductPurchase(p128, v401.DevID.Value);
		end);
	end;
	for v402, v403 in pairs(p129.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame:GetChildren()) do
		if v403:IsA("TextButton") then
			v403.MouseButton1Down:connect(function()
				if not CanClick(p129) then
					return;
				end;
				if v403.Name == "CreditBoost" and p132.Powerups.CreditBoost > 0 or v403.Name == "EXPBoost" and p132.Powerups.EXPBoost > 0 then
					u7.AddNotification({
						Parent = p129.NotificationsHolder, 
						Text = "You already have an ongoing boost for this", 
						Position = UDim2.new(0.5, 0, 0, 216), 
						BackgroundTransparency = 1, 
						Size = UDim2.new(0, 0, 0, 12), 
						TextStrokeColor3 = Color3.new(), 
						TextStrokeTransparency = 0.5, 
						TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
						TextStrokeTransparency = 0.6, 
						TextTransparency = 0.2, 
						Font = "Highway", 
						TextSize = 16, 
						TextXAlignment = "Center"
					}, "Top");
					return;
				end;
				if v403.Name ~= "Bandolier" or not p132.Powerups.Bandolier then
					l__MarketplaceService__19:PromptProductPurchase(p128, v403.DevID.Value);
					return;
				end;
				u7.AddNotification({
					Parent = p129.NotificationsHolder, 
					Text = "You already have a bandolier powerup for the next wave", 
					Position = UDim2.new(0.5, 0, 0, 216), 
					BackgroundTransparency = 1, 
					Size = UDim2.new(0, 0, 0, 12), 
					TextStrokeColor3 = Color3.new(), 
					TextStrokeTransparency = 0.5, 
					TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
					TextStrokeTransparency = 0.6, 
					TextTransparency = 0.2, 
					Font = "Highway", 
					TextSize = 16, 
					TextXAlignment = "Center"
				}, "Top");
			end);
		end;
	end;
	for v404, v405 in pairs(p129.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Passes.ScrollingFrame:GetChildren()) do
		if v405:IsA("TextButton") then
			v405.MouseButton1Down:connect(function()
				l__MarketplaceService__19:PromptGamePassPurchase(p128, v405.ProductID.Value);
			end);
		end;
	end;
	for v406, v407 in pairs(p129.Menu.ButtonFrames.Shop.SkinsFrame:GetChildren()) do
		if v407:IsA("ImageButton") then
			v407.MouseButton1Down:connect(function()
				if not CanClick(p129) then
					return;
				end;
				if u25.Cases[v407.Name] <= p132.Stats.Credits and GetAvailableSkins(p132, v407.Name) > 0 then
					p129.Menu.Confirm.Question.Text = "Would you like to buy a " .. v407.Name .. " Tier Skin Case for " .. u8.addComas(tostring(u25.Cases[v407.Name])) .. "?";
					p129.Menu.Confirm.Visible = true;
					u5 = v407.Name;
					return;
				end;
				l__SoundService__1.Menu.Cancel:Play();
				local v408 = {
					Parent = p129.NotificationsHolder
				};
				if p132.Stats.Credits < u25.Cases[v407.Name] then
					local v409 = "Insufficient amount of credits";
				else
					v409 = "You've already unlocked all the skins for this tier";
				end;
				v408.Text = v409;
				v408.Position = UDim2.new(0.5, 0, 0, 216);
				v408.BackgroundTransparency = 1;
				v408.Size = UDim2.new(0, 0, 0, 12);
				v408.TextStrokeColor3 = Color3.new();
				v408.TextStrokeTransparency = 0.5;
				v408.TextColor3 = Color3.new(1, 1, 0.9058823529411765);
				v408.TextStrokeTransparency = 0.6;
				v408.TextTransparency = 0.2;
				v408.Font = "Highway";
				v408.TextSize = 16;
				v408.TextXAlignment = "Center";
				u7.AddNotification(v408, "Top");
			end);
		end;
	end;
	for v410, v411 in pairs(p129.Menu.ButtonFrames.Loadout.Main:GetChildren()) do
		if v411:IsA("TextButton") then
			v411.MouseButton1Down:connect(function()
				if not CanClick(p129) then
					return;
				end;
				v20.Loadout(p129, v411, {
					Camera = p131, 
					Data = p132
				});
			end);
		end;
	end;
	for v412, v413 in pairs(p129.Menu.ButtonFrames.Options:GetChildren()) do
		if v413:IsA("TextButton") then
			v413.MouseButton1Down:connect(function()
				if not CanClick(p129) then
					return;
				end;
				v20.Options(p129, v413);
			end);
		end;
	end;
	for v414, v415 in pairs(p129.Menu.ButtonFrames.Options:GetChildren()) do
		if v415:IsA("ScrollingFrame") then
			local v416, v417, v418 = pairs(v415:GetChildren());
			while true do
				local v419, v420 = v416(v417, v418);
				if not v419 then
					break;
				end;
				if v420:FindFirstChild("EnableDisable") then
					v420.EnableDisable.MouseButton1Down:connect(function()
						if not CanClick(p129) then
							return;
						end;
						l__SoundService__1.Menu.Tabs:Play();
						l__RE__2:FireServer("EditData", { {
								Type = "EditOptions", 
								Option = v420.Name, 
								Value = not p132.Options[v420.Name]
							} });
					end);
				end;
				if v420:FindFirstChild("AddSwitch") then
					v420.AddSwitch.MouseButton1Down:connect(function()
						if CanClick(p129) then
							l__SoundService__1.Menu.Tabs:Play();
							l__RE__2:FireServer("EditData", { {
									Type = "EditOptions", 
									Option = v420.Name, 
									Value = p132.Options[v420.Name] + 1
								} });
						end;
					end);
				end;			
			end;
		end;
	end;
	p129.Menu.ButtonFrames.Options.PlayerFrame.PlayerTag.Tag.FocusLost:connect(function()
		l__RE__2:FireServer("EditData", { {
				Type = "EditOptions", 
				Option = "PlayerTag", 
				Value = p129.Menu.ButtonFrames.Options.PlayerFrame.PlayerTag.Tag.Text
			} });
	end);
	p129.Menu.Confirm.Purchase.MouseButton1Down:connect(function()
		if not CanClick(p129) then
			return;
		end;
		AcceptPurchase(p129);
	end);
	p129.Menu.Confirm.Cancel.MouseButton1Down:connect(function()
		if not CanClick(p129) then
			return;
		end;
		CancelPurchase(p129, p131, p132);
	end);
	p129.Menu.Sell.Sell.MouseButton1Down:connect(function()
		if not CanClick(p129) then
			return;
		end;
		SellSkin(p129);
	end);
	p129.Menu.Sell.Cancel.MouseButton1Down:connect(function()
		if not CanClick(p129) then
			return;
		end;
		CancelSell(p129, p131, p132);
	end);
	p129.Menu.Preview.Prepurchase.Purchase.MouseButton1Down:connect(function()
		if not CanClick(p129) then
			return;
		end;
		AcceptPrepurchase(p129, p131, p132);
	end);
	p129.Menu.Preview.Prepurchase.Cancel.MouseButton1Down:connect(function()
		if not CanClick(p129) then
			return;
		end;
		DenyPrepurchase(p129, p131, p132);
	end);
	p129.Menu.Back.MouseButton1Down:connect(function()
		if not CanClick(p129) then
			return;
		end;
		l__SoundService__1.Menu.MenuClick:Play();
		u7.Back(p129, p132, p133, p134);
	end);
	p129.Powerups.SpawnIn.MouseButton1Down:connect(function()
		if not CanClick(p129) then
			return;
		end;
		if u34.StageName.Value == "Game" then
			if not (u34.StageMaxTime.Value - u34.StageTime.Value > 60) then
				u7.AddNotification({
					Parent = p129.NotificationsHolder, 
					Text = "Too little time left", 
					Position = UDim2.new(0.5, 0, 0, 216), 
					BackgroundTransparency = 1, 
					Size = UDim2.new(0, 0, 0, 12), 
					TextStrokeColor3 = Color3.new(), 
					TextStrokeTransparency = 0.5, 
					TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
					TextStrokeTransparency = 0.6, 
					TextTransparency = 0.2, 
					Font = "Highway", 
					TextSize = 16, 
					TextXAlignment = "Center"
				}, "Top");
				return;
			end;
			if p128.Character and (p128.Character:FindFirstChild("Humanoid") and p128.Character.Humanoid.Health > 0 and p128.TempStats.Spawned.Value == false and p132.Powerups.SpawnIns > 0) then
				l__RE__2:FireServer("SpawnBack", nil);
				return;
			end;
		else
			u7.AddNotification({
				Parent = p129.NotificationsHolder, 
				Text = "There is no ongoing wave", 
				Position = UDim2.new(0.5, 0, 0, 216), 
				BackgroundTransparency = 1, 
				Size = UDim2.new(0, 0, 0, 12), 
				TextStrokeColor3 = Color3.new(), 
				TextStrokeTransparency = 0.5, 
				TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
				TextStrokeTransparency = 0.6, 
				TextTransparency = 0.2, 
				Font = "Highway", 
				TextSize = 16, 
				TextXAlignment = "Center"
			}, "Top");
		end;
	end);
	p129.Menu.ButtonFrames.Spectate.Next.MouseButton1Down:connect(function()
		if not CanClick(p129) then
			return;
		end;
		u39.AddNum(p129, 1, u39.GetSpectatablePlayers(p128, p127));
	end);
	p129.Menu.ButtonFrames.Spectate.Back.MouseButton1Down:connect(function()
		if not CanClick(p129) then
			return;
		end;
		u39.AddNum(p129, -1, u39.GetSpectatablePlayers(p128, p127));
	end);
end;
function u7.WeeklyWin(p140, p141, p142, p143)
	local v421, v422 = u7.AddNotification({
		Parent = p140.NotificationsHolder, 
		Text = "RANK #" .. p142 .. " FOR WEEK " .. p141 .. " REWARD", 
		Position = UDim2.new(0.5, 0, 0, 216), 
		BackgroundTransparency = 1, 
		Size = UDim2.new(0, 0, 0, 12), 
		TextStrokeColor3 = Color3.new(), 
		TextStrokeTransparency = 0.5, 
		TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
		TextStrokeTransparency = 0.6, 
		TextTransparency = 0.2, 
		Font = "Highway", 
		TextSize = 22, 
		TextXAlignment = "Center"
	}, "Top");
	local v423, v424 = u7.AddNotification({
		Parent = p140.NotificationsHolder, 
		Text = "+$" .. u8.addComas(p143), 
		Position = UDim2.new(0.5, 0, 0, 216), 
		BackgroundTransparency = 1, 
		Size = UDim2.new(0, 0, 0, 12), 
		TextStrokeColor3 = Color3.new(), 
		TextStrokeTransparency = 0.5, 
		TextColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315), 
		TextStrokeTransparency = 0.6, 
		TextTransparency = 0.2, 
		Font = "Highway", 
		TextSize = 20, 
		TextXAlignment = "Center"
	}, "Top");
end;
local u59 = {};
function u7.HandleRewards(p144, p145)
	local v425, v426, v427 = pairs(p145);
	while true do
		local v428, v429 = v425(v426, v427);
		if not v428 then
			break;
		end;
		if v428 == "WeeklyWin" then
			u7.WeeklyWin(p144, v429.Week, v429.Place, v429.Prize);
		end;
		if v428 == "Daily Login" then
			delay(0, function()
				local l__InGroup__430 = v429.InGroup;
				local l__Day__431 = v429.Day;
				p144["Login Rewards"].Visible = true;
				if u59.LoginRewardsClose then
					u59.LoginRewardsClose.Bind();
				end;
				for v432 = 1, 7 do
					if l__InGroup__430 then
						local v433 = 1.5;
					else
						v433 = 1;
					end;
					p144["Login Rewards"].Main[tostring(v432)].Award.Text = "+$" .. u8.addComas(tostring((math.floor(v432 * 250 * 4 * v433 + 0.5))));
				end;
				for v434 = 1, l__Day__431 do
					p144["Login Rewards"].Main[tostring(v434)].Checkmark.Visible = true;
				end;
				if l__InGroup__430 then
					p144["Login Rewards"].Main.Extra.Visible = false;
				else
					p144["Login Rewards"].Main.Extra.Visible = true;
				end;
				local v435, v436 = u7.AddNotification({
					Parent = p144.NotificationsHolder, 
					Text = "RECEIVED LOGIN REWARD!", 
					Position = UDim2.new(0.5, 0, 0, 216), 
					BackgroundTransparency = 1, 
					Size = UDim2.new(0, 0, 0, 12), 
					TextStrokeColor3 = Color3.new(0.19215686274509805, 0.19215686274509805, 0.19215686274509805), 
					TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
					TextStrokeTransparency = 0.6, 
					TextTransparency = 0.2, 
					Font = "Highway", 
					TextSize = 22, 
					TextXAlignment = "Center"
				}, "Top");
				if l__InGroup__430 then
					local v437 = 1.5;
				else
					v437 = 1;
				end;
				local v438, v439 = u7.AddNotification({
					Parent = p144.NotificationsHolder, 
					Text = "+$" .. u8.addComas(tostring((math.floor(l__Day__431 * 250 * 4 * v437 + 0.5)))), 
					Position = UDim2.new(0.5, 0, 0, 216), 
					BackgroundTransparency = 1, 
					Size = UDim2.new(0, 0, 0, 12), 
					TextStrokeColor3 = Color3.new(), 
					TextStrokeTransparency = 0.5, 
					TextColor3 = Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315), 
					TextStrokeTransparency = 0.6, 
					TextTransparency = 0.2, 
					Font = "Highway", 
					TextSize = 22, 
					TextXAlignment = "Center"
				}, "Top");
			end);
		end;
		if v428 == "Christmas 2020" then
			p144.Gift.Main.Background.Dear.Text = "Dear " .. l__LocalPlayer__20.Name .. ",";
			p144.Gift.Visible = true;
		end;	
	end;
end;
function u7.UpdateSpectateButton(p146, p147)
	p146.Menu.Buttons.Spectate.TextTransparency = p147;
end;
function u7.UpdatePlayerList(p148, p149, p150)
	if p148 then
		for v440, v441 in pairs(p148["Player List"]:GetChildren()) do
			if v441.ClassName ~= "UIScale" then
				v441:Destroy();
			end;
		end;
		local v442 = 0;
		for v443, v444 in pairs(game.Players:GetChildren()) do
			if p149[v444.Name] and v444.UserId ~= 1163048 then
				local v445 = game.ReplicatedStorage.GUI.PlayerTag:clone();
				v445.Parent = p148["Player List"];
				v445.PlayerName.TextColor3 = u45.GetColor(v444.Name);
				v445.PlayerName.Text = v444.Name;
				if v444.TempStats.Ready.Value == true then
					local v446 = "READY";
				else
					v446 = "NOT READY";
				end;
				v445.Ready.Text = v446;
				v445.Ready.TextColor3 = v444.TempStats.Ready.Value == true and Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315) or Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863);
				v445.Level.Text = p149[v444.Name].Level;
				v445.Position = UDim2.new(0, 0, v442, 0);
				v445.Gamepad.Visible = v444.TempStats.Gamepad.Value;
				v442 = v442 + 0.125;
			end;
		end;
		for v447, v448 in pairs(p148["Player List"]:GetChildren()) do
			if v448.ClassName ~= "UIScale" then
				if p150 then
					v448.Ready.Visible = false;
				else
					v448.Ready.Visible = true;
				end;
			end;
		end;
	end;
end;
local u60 = nil;
local u61 = nil;
function u7.AppearDrinkEffect(p151)
	if u60 then
		u60:Destroy();
		u60 = nil;
	end;
	if not u61 then
		u61 = l__TweenService__27:Create(p151.Speed, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
			ImageTransparency = 0.5
		});
		u61:Play();
		local u62 = nil;
		u62 = u61.Completed:connect(function()
			u62:Disconnect();
			u61 = nil;
		end);
	end;
end;
function u7.FadeDrinkEffect(p152)
	if u61 then
		u61:Destroy();
		u61 = nil;
	end;
	if not u60 then
		u60 = l__TweenService__27:Create(p152.Speed, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
			ImageTransparency = 1
		});
		u60:Play();
		local u63 = nil;
		u63 = u60.Completed:connect(function()
			u63:Disconnect();
			u60 = nil;
		end);
	end;
end;
local u64 = nil;
local u65 = nil;
function u7.FadeCursor(p153)
	if u64 then
		u64:Destroy();
		u64 = nil;
	end;
	if not u65 then
		u65 = l__TweenService__27:Create(p153.Cursor, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
			ImageTransparency = 1
		});
		u65:Play();
		local u66 = nil;
		u66 = u65.Completed:connect(function()
			u66:Disconnect();
			u65 = nil;
		end);
	end;
end;
function u7.AppearCursor(p154)
	if u65 then
		u65:Destroy();
		u65 = nil;
	end;
	if not u64 then
		u64 = l__TweenService__27:Create(p154.Cursor, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
			ImageTransparency = 0
		});
		u64:Play();
		local u67 = nil;
		u67 = u64.Completed:connect(function()
			u67:Disconnect();
			u64 = nil;
		end);
	end;
end;
local u68 = nil;
local u69 = nil;
function u7.DamageFlash(p155, p156)
	if u68 then
		u68:Destroy();
		u68 = nil;
	end;
	if not u69 then
		u69 = l__TweenService__27:Create(p155.DamageFlash, TweenInfo.new(0.1 * p156, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
			ImageTransparency = 0.25 * (1 / p156)
		});
		u69:Play();
		local u70 = nil;
		u70 = u69.Completed:connect(function()
			u70:Disconnect();
			u69 = nil;
			if not u68 then
				u68 = l__TweenService__27:Create(p155.DamageFlash, TweenInfo.new(1.5 * p156, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0.15 * p156), {
					ImageTransparency = 1
				});
				u68:Play();
				local u71 = nil;
				u71 = u68.Completed:connect(function()
					u71:Disconnect();
					u68 = nil;
				end);
			end;
		end);
	end;
end;
local u72 = nil;
local u73 = nil;
local u74 = nil;
function u7.UpdateDamage(p157, p158)
	u72 = p158;
	if u73 then
		u73:Destroy();
		u73 = nil;
	end;
	if not u74 then
		u74 = l__TweenService__27:Create(p157.DamageIndicator.Image, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0), {
			ImageTransparency = 0
		});
		u74:Play();
		local u75 = nil;
		u75 = u74.Completed:connect(function()
			u75:Disconnect();
			u74 = nil;
		end);
	end;
	delay(2, function()
		if not u74 and not u73 then
			u73 = l__TweenService__27:Create(p157.DamageIndicator.Image, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0), {
				ImageTransparency = 1
			});
			u73:Play();
			local u76 = nil;
			u76 = u73.Completed:connect(function()
				u76:Disconnect();
				u73 = nil;
			end);
		end;
	end);
end;
local u77 = tick();
function ButtonClick(p159, p160, p161, p162, p163, p164, p165)
	if p165.Name == "Spectate" then
		if p165.Name == "Spectate" then
			if 0 < #u39.GetSpectatablePlayers(l__LocalPlayer__20, p161) then
				l__SoundService__1.Menu.MenuClick:Play();
				if p165.Name == "Spectate" then
					u39.SetSpectating(p159, true, u39.GetSpectatablePlayers(l__LocalPlayer__20, p161));
					u40.GetEffectObjects(workspace.Map, p162, true);
					u40.GetEffectObjects(workspace.Ignore, p162, false);
					u41.UpdateLighting(require(game.ReplicatedStorage.Maps[u34.MapName.Value].Lighting), game.ReplicatedStorage.Maps[u34.MapName.Value]["Lighting Effects"]);
					u42.UpdateSounds(game.ReplicatedStorage.Maps[u34.MapName.Value]["Environment Sounds"], game.ReplicatedStorage.Maps[u34.MapName.Value]["Local Sounds"]);
					u42.UpdateMusic();
					u42.UpdateVolume(p162, true, false);
					delay(0, function()
						if l__MarketplaceService__19:UserOwnsGamePassAsync(l__LocalPlayer__20.UserId, 5144766) then
							u7.AddNotification({
								Parent = p159.NotificationsHolder, 
								Text = "Press K to enter Free Cam mode", 
								Position = UDim2.new(0.5, 0, 0, 216), 
								BackgroundTransparency = 1, 
								Size = UDim2.new(0, 0, 0, 12), 
								TextStrokeColor3 = Color3.new(), 
								TextStrokeTransparency = 0.5, 
								TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
								TextStrokeTransparency = 0.6, 
								TextTransparency = 0.2, 
								Font = "Highway", 
								TextSize = 16, 
								TextXAlignment = "Center"
							}, "Top");
						end;
					end);
				end;
				if workspace.Lobby.CamPoints:FindFirstChild(p165.Name) then
					u12.SetGoalCam(p160, u36, workspace.Lobby.CamPoints[p165.Name]);
					u36 = p165.Name;
				end;
				if p159.Menu.ButtonFrames:FindFirstChild(p165.Name) then
					u6 = p165.Name;
					p159.Menu.ButtonFrames[p165.Name].Visible = true;
					p159.Menu.Back.Visible = true;
					p159.Menu.Buttons.Visible = false;
				end;
			else
				u7.AddNotification({
					Parent = p159.NotificationsHolder, 
					Text = "There is no ongoing wave", 
					Position = UDim2.new(0.5, 0, 0, 216), 
					BackgroundTransparency = 1, 
					Size = UDim2.new(0, 0, 0, 12), 
					TextStrokeColor3 = Color3.new(), 
					TextStrokeTransparency = 0.5, 
					TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
					TextStrokeTransparency = 0.6, 
					TextTransparency = 0.2, 
					Font = "Highway", 
					TextSize = 16, 
					TextXAlignment = "Center"
				}, "Top");
			end;
		else
			u7.AddNotification({
				Parent = p159.NotificationsHolder, 
				Text = "There is no ongoing wave", 
				Position = UDim2.new(0.5, 0, 0, 216), 
				BackgroundTransparency = 1, 
				Size = UDim2.new(0, 0, 0, 12), 
				TextStrokeColor3 = Color3.new(), 
				TextStrokeTransparency = 0.5, 
				TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
				TextStrokeTransparency = 0.6, 
				TextTransparency = 0.2, 
				Font = "Highway", 
				TextSize = 16, 
				TextXAlignment = "Center"
			}, "Top");
		end;
	else
		l__SoundService__1.Menu.MenuClick:Play();
		if p165.Name == "Spectate" then
			u39.SetSpectating(p159, true, u39.GetSpectatablePlayers(l__LocalPlayer__20, p161));
			u40.GetEffectObjects(workspace.Map, p162, true);
			u40.GetEffectObjects(workspace.Ignore, p162, false);
			u41.UpdateLighting(require(game.ReplicatedStorage.Maps[u34.MapName.Value].Lighting), game.ReplicatedStorage.Maps[u34.MapName.Value]["Lighting Effects"]);
			u42.UpdateSounds(game.ReplicatedStorage.Maps[u34.MapName.Value]["Environment Sounds"], game.ReplicatedStorage.Maps[u34.MapName.Value]["Local Sounds"]);
			u42.UpdateMusic();
			u42.UpdateVolume(p162, true, false);
			delay(0, function()
				if l__MarketplaceService__19:UserOwnsGamePassAsync(l__LocalPlayer__20.UserId, 5144766) then
					u7.AddNotification({
						Parent = p159.NotificationsHolder, 
						Text = "Press K to enter Free Cam mode", 
						Position = UDim2.new(0.5, 0, 0, 216), 
						BackgroundTransparency = 1, 
						Size = UDim2.new(0, 0, 0, 12), 
						TextStrokeColor3 = Color3.new(), 
						TextStrokeTransparency = 0.5, 
						TextColor3 = Color3.new(1, 1, 0.9058823529411765), 
						TextStrokeTransparency = 0.6, 
						TextTransparency = 0.2, 
						Font = "Highway", 
						TextSize = 16, 
						TextXAlignment = "Center"
					}, "Top");
				end;
			end);
		end;
		if workspace.Lobby.CamPoints:FindFirstChild(p165.Name) then
			u12.SetGoalCam(p160, u36, workspace.Lobby.CamPoints[p165.Name]);
			u36 = p165.Name;
		end;
		if p159.Menu.ButtonFrames:FindFirstChild(p165.Name) then
			u6 = p165.Name;
			p159.Menu.ButtonFrames[p165.Name].Visible = true;
			p159.Menu.Back.Visible = true;
			p159.Menu.Buttons.Visible = false;
		end;
	end;
	if p165.Name == "Perks" then
		u7.UpdatePerks(p159, p162);
	end;
	if p165.Name == "Loadout" then
		u7.UpdateLoadout(p159, p163, p162);
	end;
	if p165.Name == "Shop" then
		u7.UpdateShop(p159, p162);
	end;
	if p165.Name == "Options" then
		u7.UpdateOptions(p159, p162);
	end;
	if p165.Name == "Start" then
		if 0.5 < tick() - u77 then
			u77 = tick();
			l__RE__2:FireServer("ChangeValue", {
				Obj = p164.Ready, 
				Value = not p164.Ready.Value
			});
		end;
	end;
end;
function ButtonSelect(p166)
	p166:TweenPosition(UDim2.new(0, 100, p166.Position.Y.Scale, p166.Position.Y.Offset), "Out", "Quad", 0.1, true);
	l__SoundService__1.Menu.MenuFocus:Play();
end;
function ButtonDeselect(p167)
	p167:TweenPosition(UDim2.new(0, 50, p167.Position.Y.Scale, p167.Position.Y.Offset), "Out", "Quad", 0.1, true);
end;
local u78 = nil;
local u79 = nil;
local u80 = {};
local u81 = tick();
function u7.CheckMouse(p168, p169, p170, p171, p172)
	if p168.Menu.ButtonFrames.Perks.Visible then
		local v449 = false;
		for v450, v451 in pairs(u21) do
			for v452, v453 in pairs(v451) do
				local l__AbsolutePosition__454 = v453.PerkF.AbsolutePosition;
				if CanClick(p168) and p171.X < l__AbsolutePosition__454.x + v453.PerkF.AbsoluteSize.X and l__AbsolutePosition__454.x < p171.X and p171.Y < l__AbsolutePosition__454.y + v453.PerkF.AbsoluteSize.Y and l__AbsolutePosition__454.y < p171.Y then
					if v453.Name ~= u78 then
						PerkHover(p168, p169, v453);
						l__SoundService__1.Menu.Hover:Play();
						u78 = v453.Name;
					end;
					v449 = true;
				else
					if v453.Equipped then
						local v455 = "rbxassetid://2634711088";
					else
						v455 = "rbxassetid://2600757280";
					end;
					v453.PerkF.BaseDefault.Image = v455;
				end;
			end;
		end;
		if not v449 then
			u78 = nil;
			p168.Menu.ButtonFrames.Perks.Info.Visible = false;
		end;
	end;
	for v456, v457 in pairs(p168.Menu.ButtonFrames.Loadout.Main.Skins:GetChildren()) do
		if v457:IsA("Frame") then
			local l__AbsolutePosition__458 = v457.AbsolutePosition;
			local v459 = false;
			if p171.X < l__AbsolutePosition__458.x + v457.AbsoluteSize.X and l__AbsolutePosition__458.x < p171.X and p171.Y < l__AbsolutePosition__458.y + v457.AbsoluteSize.Y and l__AbsolutePosition__458.y < p171.Y then
				v459 = true;
			end;
			if v459 and CanClick(p168) then
				v457.BackgroundTransparency = 0.8;
				v457.BorderColor3 = Color3.new(1, 1, 1);
				v457.BorderSizePixel = 2;
			else
				v457.BackgroundTransparency = 1;
				v457.BorderSizePixel = 0;
			end;
		end;
	end;
	local v460, v461, v462 = pairs(p168.Menu.ButtonFrames.Loadout.Main.Weapons:GetChildren());
	while true do
		local v463, v464 = v460(v461, v462);
		if not v463 then
			break;
		end;
		local l__AbsolutePosition__465 = v464.AbsolutePosition;
		local v466 = false;
		if p171.X < l__AbsolutePosition__465.x + v464.AbsoluteSize.X and l__AbsolutePosition__465.x < p171.X and p171.Y < l__AbsolutePosition__465.y + v464.AbsoluteSize.Y and l__AbsolutePosition__465.y < p171.Y then
			v466 = true;
		end;
		if v466 and CanClick(p168) then
			v464.BackgroundTransparency = 0.8;
			v464.BorderColor3 = Color3.new(1, 1, 1);
			v464.BorderSizePixel = 2;
		else
			v464.BackgroundTransparency = 1;
			v464.BorderSizePixel = 0;
		end;	
	end;
	for v467, v468 in pairs(p168.Menu.ButtonFrames.Shop.SkinsFrame.Slider.Holder:GetChildren()) do
		local l__AbsolutePosition__469 = v468.AbsolutePosition;
		if p168.Menu.ButtonFrames.Shop.SkinsFrame.Slider.Center.AbsolutePosition.X < l__AbsolutePosition__469.x + v468.AbsoluteSize.X and l__AbsolutePosition__469.x < p168.Menu.ButtonFrames.Shop.SkinsFrame.Slider.Center.AbsolutePosition.X and v468 ~= u79 then
			u79 = v468;
			local v470 = Instance.new("Sound", p168);
			v470.SoundId = "rbxassetid://156286438";
			v470:Play();
			game.Debris:AddItem(v470, 1);
		end;
	end;
	if p168.Menu.ButtonFrames.Options.Visible then
		for v471, v472 in pairs(p168.Menu.ButtonFrames.Options:GetChildren()) do
			if v472:IsA("ScrollingFrame") then
				for v473, v474 in pairs(v472:GetChildren()) do
					if v474:FindFirstChild("Scale") then
						local l__AbsolutePosition__475 = v474.Frame.AbsolutePosition;
						if v472.Visible and p171.X < l__AbsolutePosition__475.x + v474.Frame.AbsoluteSize.X and l__AbsolutePosition__475.x < p171.X then
							if p171.Y < l__AbsolutePosition__475.y + v474.Frame.AbsoluteSize.Y and l__AbsolutePosition__475.y < p171.Y then
								if not p170 and CanClick(p168) then
									u80[v474.Name] = true;
								end;
							else
								u80[v474.Name] = nil;
							end;
						else
							u80[v474.Name] = nil;
						end;
					end;
				end;
			end;
		end;
	else
		u80 = {};
	end;
	for v476, v477 in pairs(p168.Menu.ButtonFrames.Shop.CreditsFrame:GetChildren()) do
		if v477:IsA("ImageButton") and v477.Visible then
			local l__AbsolutePosition__478 = v477.AbsolutePosition;
			local v479 = false;
			if p171.X < l__AbsolutePosition__478.x + v477.AbsoluteSize.X and l__AbsolutePosition__478.x < p171.X and p171.Y < l__AbsolutePosition__478.y + v477.AbsoluteSize.Y and l__AbsolutePosition__478.y < p171.Y then
				v479 = true;
			end;
			if v479 and CanClick(p168) then
				v477.BackgroundTransparency = 0.8;
				v477.BorderColor3 = Color3.new(1, 1, 1);
				v477.BorderSizePixel = 2;
			else
				v477.BackgroundTransparency = 1;
				v477.BorderSizePixel = 0;
			end;
		end;
	end;
	for v480, v481 in pairs(p168.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Passes.ScrollingFrame:GetChildren()) do
		if v481:IsA("TextButton") and v481.Visible then
			local l__AbsolutePosition__482 = v481.AbsolutePosition;
			local v483 = false;
			if p171.X < l__AbsolutePosition__482.x + v481.AbsoluteSize.X and l__AbsolutePosition__482.x < p171.X and p171.Y < l__AbsolutePosition__482.y + v481.AbsoluteSize.Y and l__AbsolutePosition__482.y < p171.Y then
				v483 = true;
			end;
			if v483 and CanClick(p168) then
				v481.BackgroundTransparency = 0.8;
				v481.BorderColor3 = Color3.new(1, 1, 1);
				v481.BorderSizePixel = 2;
			else
				v481.BackgroundTransparency = 1;
				v481.BorderSizePixel = 0;
			end;
		end;
	end;
	for v484, v485 in pairs(p168.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Powerups.ScrollingFrame:GetChildren()) do
		if v485:IsA("TextButton") and v485.Visible then
			local l__AbsolutePosition__486 = v485.AbsolutePosition;
			local v487 = false;
			if p171.X < l__AbsolutePosition__486.x + v485.AbsoluteSize.X and l__AbsolutePosition__486.x < p171.X and p171.Y < l__AbsolutePosition__486.y + v485.AbsoluteSize.Y and l__AbsolutePosition__486.y < p171.Y then
				v487 = true;
			end;
			if v487 and CanClick(p168) then
				v485.BackgroundTransparency = 0.8;
				v485.BorderColor3 = Color3.new(1, 1, 1);
				v485.BorderSizePixel = 2;
			else
				v485.BackgroundTransparency = 1;
				v485.BorderSizePixel = 0;
			end;
		end;
	end;
	for v488, v489 in pairs(p168.Menu.ButtonFrames.Shop.SkinsFrame:GetChildren()) do
		if v489:IsA("ImageButton") and v489.Visible then
			local l__AbsolutePosition__490 = v489.AbsolutePosition;
			local v491 = false;
			if p171.X < l__AbsolutePosition__490.x + v489.AbsoluteSize.X and l__AbsolutePosition__490.x < p171.X and p171.Y < l__AbsolutePosition__490.y + v489.AbsoluteSize.Y and l__AbsolutePosition__490.y < p171.Y then
				v491 = true;
			end;
			if v491 and CanClick(p168) then
				v489.BackgroundTransparency = 0.8;
				v489.BorderColor3 = Color3.new(1, 1, 1);
				v489.BorderSizePixel = 2;
			else
				v489.BackgroundTransparency = 1;
				v489.BorderSizePixel = 0;
			end;
		end;
	end;
	local v492, v493, v494 = pairs(u58);
	while true do
		local v495, v496 = v492(v493, v494);
		if not v495 then
			break;
		end;
		if p168.Menu.Buttons.Visible then
			if p171.X < v496.Button.AbsolutePosition.x + v496.Button.AbsoluteSize.X - v496.Button.Position.X.Offset and v496.Button.AbsolutePosition.x - v496.Button.Position.X.Offset < p171.X then
				if p171.Y < v496.Button.AbsolutePosition.y + v496.Button.AbsoluteSize.Y and v496.Button.AbsolutePosition.y < p171.Y then
					if not v496.Over and CanClick(p168) then
						v496.Over = true;
						ButtonSelect(v496.Button);
					end;
				else
					v496.Over = false;
				end;
			else
				v496.Over = false;
			end;
		else
			v496.Over = false;
		end;
		if not v496.Over and v496.Over ~= v496.Over then
			ButtonDeselect(v496.Button);
		end;
		if v496.Button.Name == "Start" then
			if p172 then
				v496.Button.Text = "UNREADY";
			else
				v496.Button.Text = "READY";
			end;
		end;	
	end;
	if p168.Powerups.SpawnIn.Visible and p171.X < p168.Powerups.SpawnIn.AbsolutePosition.x + p168.Powerups.SpawnIn.AbsoluteSize.X and p168.Powerups.SpawnIn.AbsolutePosition.x < p171.X then
		if p171.Y < p168.Powerups.SpawnIn.AbsolutePosition.y + p168.Powerups.SpawnIn.AbsoluteSize.Y and p168.Powerups.SpawnIn.AbsolutePosition.y < p171.Y then
			p168.Powerups.SpawnIn.Hint.Visible = true;
		else
			p168.Powerups.SpawnIn.Hint.Visible = false;
		end;
	else
		p168.Powerups.SpawnIn.Hint.Visible = false;
	end;
	for v497, v498 in pairs(p168.Menu.ButtonFrames.Options:GetChildren()) do
		if v498:IsA("ScrollingFrame") then
			for v499, v500 in pairs(v498:GetChildren()) do
				if v500:FindFirstChild("Scale") and p170 and u80[v500.Name] then
					local v501 = math.clamp(math.floor((p171.X - v500.Frame.AbsolutePosition.X) / v500.Frame.AbsoluteSize.X * 2 / 0.05 + 0.5) * 0.05, 0, 2);
					if v501 ~= p169.Options[v500.Name] and tick() - u81 > 0.05 then
						u81 = tick();
						l__RE__2:FireServer("EditData", { {
								Type = "EditOptions", 
								Option = v500.Name, 
								Value = v501
							} });
					end;
				end;
			end;
		end;
	end;
end;
function u7.PromptRevive(p173)
	p173.Revive.Visible = true;
	if u59.RevivePrompt then
		u59.RevivePrompt.Bind();
	end;
end;
function u7.PromptLogin(p174)
	p174["Login Rewards"].Visible = true;
	if u59.LoginRewardsClose then
		u59.LoginRewardsClose.Bind();
	end;
end;
function u7.UpdateSurviveGui(p175, p176, p177, p178, p179, p180)
	if p177 then
		p175.WaveEnd.Frame.PlayersAlive.Visible = false;
		p175.WaveEnd.Frame.WaveBonuses.Visible = true;
		p175.WaveEnd.Frame.WaveNumber.Visible = false;
		p175.WaveEnd.Frame.WaveBonuses.Text = "NO BONUS";
		p175.WaveEnd.Frame.MapCompletion.Visible = false;
	else
		p175.WaveEnd.Frame.PlayersAlive.Visible = true;
		p175.WaveEnd.Frame.WaveBonuses.Visible = true;
		p175.WaveEnd.Frame.WaveNumber.Visible = true;
		p175.WaveEnd.Frame.PlayersAlive.Money.Text = "+$" .. u8.addComas(tostring(math.floor(500 * p176 * 0.2 + 0.5)));
		p175.WaveEnd.Frame.PlayersAlive.Experience.Text = "+" .. u8.addComas(tostring(math.floor(100 * p176 * 0.2 + 0.5)));
		p175.WaveEnd.Frame.PlayersAlive.Text = "REMAINING PLAYERS: " .. p176;
		p175.WaveEnd.Frame.WaveBonuses.Text = "WAVE BONUSES";
		p175.WaveEnd.Frame.WaveNumber.Money.Text = "+$" .. u8.addComas(tostring(math.floor(p179 * 50 * 0.2 + 0.3)));
		p175.WaveEnd.Frame.WaveNumber.Experience.Text = "+" .. u8.addComas(tostring(math.floor(p178 * p179 * 15 * 0.2 + 0.5)));
		p175.WaveEnd.Frame.WaveNumber.Text = "WAVE: " .. p179;
		if p180 then
			p175.WaveEnd.Frame.MapCompletion.Text = "MAP COMPLETION";
			p175.WaveEnd.Frame.MapCompletion.Experience.Text = "+" .. u8.addComas(tostring(math.floor(p178 * 1500 * 0.2 + 0.5)));
			p175.WaveEnd.Frame.MapCompletion.Money.Text = "+$3,500";
			p175.WaveEnd.Frame.MapCompletion.Visible = true;
		else
			p175.WaveEnd.Frame.MapCompletion.Visible = false;
		end;
	end;
	p175.WaveEnd.Visible = true;
end;
local u82 = require(game.ReplicatedStorage.Modules.FortificationsInfo);
local u83 = require(game.ReplicatedStorage.Modules.EXP);
function u7.UpdateHUD(p181, p182, p183, p184, p185)
	for v502, v503 in pairs({
		Frag = 4, 
		Molotov = 5, 
		["Nerve Gas"] = 6
	}) do
		if p181.Equipped == v503 then
			p183.HUD.Throwables[v502].ImageTransparency = 0.2;
		elseif p184[v503] then
			p183.HUD.Throwables[v502].ImageTransparency = 0.6;
		else
			p183.HUD.Throwables[v502].ImageTransparency = 1;
		end;
	end;
	if p181.Equipped then
		local l__Stats__504 = p181.WeaponModule.Stats;
		if l__Stats__504.WeaponType ~= "Throwable" and p181.WeaponModule.Stats.Slot ~= "Defibrillator" then
			p183.HUD.WeaponIcon.Image = l__Stats__504.Icon;
			if p184[p181.Equipped].Mag < 10 then
				local v505 = "0";
			else
				v505 = "";
			end;
			p183.HUD.Mag.Text = v505 .. p184[p181.Equipped].Mag;
			if p184[p181.Equipped].Pool < 10 then
				local v506 = "00";
			elseif p184[p181.Equipped].Pool < 100 then
				v506 = "0";
			else
				v506 = "";
			end;
			p183.HUD.Pool.Text = v506 .. p184[p181.Equipped].Pool;
		end;
	elseif p181.GunnerInfo.Mounted then
		p183.HUD.WeaponIcon.Image = u82["50 Cal"].Icon;
		if p181.GunnerInfo.Mag < 10 then
			local v507 = "0";
		else
			v507 = "";
		end;
		p183.HUD.Mag.Text = v507 .. p181.GunnerInfo.Mag;
		p183.HUD.Pool.Text = "000";
	end;
	local l__Value__508 = p185.MaxArmor.Value;
	for v509 = 1, 92 do
		p183.HUD.BodyArmorIncremements[v509].ImageColor3 = l__Value__508 > 100 and Color3.new(0.9215686274509803, 0.5215686274509804, 0.2549019607843137) or Color3.new(0.38823529411764707, 0.5294117647058824, 0.6431372549019608);
		p183.HUD.BodyArmorIncremements[v509].Visible = true;
	end;
	for v510 = 1, 4 do
		local v511 = l__Value__508 - p185.Armor.Value;
		local v512 = l__Value__508 - l__Value__508 / 4 * v510;
		local v513 = false;
		if v512 <= v511 and v511 <= v512 + l__Value__508 / 4 then
			for v514 = v510 * 23 + 1, 92 do
				p183.HUD.BodyArmorIncremements[v514].Visible = false;
			end;
			for v515 = 1, math.floor(23 * (1 - (p185.Armor.Value - (v510 - 1) * (l__Value__508 / 4)) / (l__Value__508 / 4)) + 0.5) do
				p183.HUD.BodyArmorIncremements[v510 * 23 - v515 + 1].Visible = false;
			end;
			v513 = true;
		end;
		if v513 then
			break;
		end;
	end;
	for v516 = 1, 125 do
		p183.HUD.HealthIncremements[v516].Visible = true;
		p183.HUD.HealthIncremements[v516].ImageColor3 = Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863):lerp(Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315), p185.Humanoid.Health / 100);
	end;
	for v517 = 1, 5 do
		local v518 = 100 - p185.Humanoid.Health;
		local v519 = 100 - 20 * v517;
		local v520 = false;
		if v519 <= v518 and v518 <= v519 + 20 then
			for v521 = v517 * 25 + 1, 125 do
				p183.HUD.HealthIncremements[v521].Visible = false;
			end;
			for v522 = 1, math.floor(25 * (1 - (p185.Humanoid.Health - (v517 - 1) * 20) / 20) + 0.5) do
				p183.HUD.HealthIncremements[v517 * 25 - v522 + 1].Visible = false;
			end;
			v520 = true;
		end;
		if v520 then
			break;
		end;
	end;
	for v523 = 1, 208 do
		p183.HUD.ExpIncremements[v523].Visible = false;
	end;
	for v524 = 1, math.floor(208 * (p182.Stats.EXP / u83.CalculateEXP(p182.Stats.Level + 1)) + 0.5) do
		p183.HUD.ExpIncremements[v524].Visible = true;
	end;
	if p182.Stats.Level < 10 then
		local v525 = "00";
	elseif p182.Stats.Level < 100 then
		v525 = "0";
	else
		v525 = "";
	end;
	p183.HUD.Current.Text = v525 .. p182.Stats.Level;
	if p182.Stats.Level + 1 < 10 then
		local v526 = "00";
	elseif p182.Stats.Level + 1 < 100 then
		v526 = "0";
	else
		v526 = "";
	end;
	p183.HUD.Next.Text = v526 .. p182.Stats.Level + 1;
end;
function u7.UpdateSpectateInfo(p186, p187)
	p186.Menu.ButtonFrames.Spectate.PlayerName.Text = p187.Name;
end;
function u7.UpdateRainbow()
	for v527, v528 in pairs(u46) do
		if v528.Rainbow then
			if v528.RainbowNum == 1 then
				v528.Label.TextColor3 = Color3.new(v528.Label.TextColor3.r, v528.Label.TextColor3.g + 0.06666666666666667, v528.Label.TextColor3.b);
			end;
			if v528.RainbowNum == 2 then
				v528.Label.TextColor3 = Color3.new(v528.Label.TextColor3.r - 0.06666666666666667, v528.Label.TextColor3.g, v528.Label.TextColor3.b);
			end;
			if v528.RainbowNum == 3 then
				v528.Label.TextColor3 = Color3.new(v528.Label.TextColor3.r, v528.Label.TextColor3.g, v528.Label.TextColor3.b + 0.06666666666666667);
			end;
			if v528.RainbowNum == 4 then
				v528.Label.TextColor3 = Color3.new(v528.Label.TextColor3.r, v528.Label.TextColor3.g - 0.06666666666666667, v528.Label.TextColor3.b);
			end;
			if v528.RainbowNum == 5 then
				v528.Label.TextColor3 = Color3.new(v528.Label.TextColor3.r + 0.06666666666666667, v528.Label.TextColor3.g, v528.Label.TextColor3.b);
			end;
			if v528.RainbowNum == 6 then
				v528.Label.TextColor3 = Color3.new(v528.Label.TextColor3.r, v528.Label.TextColor3.g, v528.Label.TextColor3.b - 0.06666666666666667);
			end;
			v528.RainbowAlpha = v528.RainbowAlpha + 1;
			if v528.RainbowAlpha > 15 then
				v528.RainbowAlpha = 0;
				v528.RainbowNum = v528.RainbowNum + 1;
				if v528.RainbowNum > 6 then
					v528.RainbowNum = 1;
				end;
			end;
		end;
	end;
end;
function u7.UpdatePlayerTags(p188, p189, p190)
	for v529, v530 in pairs(p190) do
		if v530.PlayerThirdTag then
			if not u29 and v529 and v529.TempStats.Spawned.Value == true and v529.Character and v529.Character:FindFirstChild("Head") and v529.Character:FindFirstChild("HumanoidRootPart") and (v529.Character:FindFirstChild("Armor") and (p189.CoordinateFrame.p - v529.Character.HumanoidRootPart.Position).magnitude < 50) then
				local v531, v532 = p189:WorldToScreenPoint((v529.Character.Head.CFrame * CFrame.new(0, 2.5, 0)).p);
				if v532 then
					v530.PlayerThirdTag.Visible = true;
					v530.PlayerThirdTag.Position = UDim2.new(0, v531.x, 0, v531.y);
					if p188 then
						local v533 = 1.5;
					else
						v533 = 1;
					end;
					v530.PlayerThirdTag.UIScale.Scale = v533;
					local l__Value__534 = v529.Character.MaxArmor.Value;
					v530.PlayerThirdTag.Armor.BackgroundColor3 = l__Value__534 > 100 and Color3.new(0.9215686274509803, 0.5215686274509804, 0.2549019607843137) or Color3.new(0.38823529411764707, 0.5294117647058824, 0.6431372549019608);
					if v529.Character.Armor.Value > 0 then
						v530.PlayerThirdTag.Armor.Visible = true;
					else
						v530.PlayerThirdTag.Armor.Visible = false;
					end;
					v530.PlayerThirdTag.Armor.Size = UDim2.new(math.min(1, v529.Character.Armor.Value / l__Value__534), 0, 0, 2);
					v530.PlayerThirdTag.Health.Size = UDim2.new(math.min(1, v529.Character.Humanoid.Health / 100), 0, 0, 2);
					v530.PlayerThirdTag.Health.BackgroundColor3 = Color3.new(0.6196078431372549, 0.1450980392156863, 0.1450980392156863):lerp(Color3.new(0.3686274509803922, 0.5450980392156862, 0.37254901960784315), v529.Character.Humanoid.Health / 100);
				else
					v530.PlayerThirdTag.Visible = false;
				end;
			else
				v530.PlayerThirdTag.Visible = false;
			end;
		end;
	end;
end;
function u7.UpdateFortifications(p191, p192)
	for v535, v536 in pairs(p191.Fortifications:GetChildren()) do
		if not v536:IsA("UIScale") then
			v536:Destroy();
		end;
	end;
	if not (not u29) or u34.StageName.Value ~= "Game" or not p192 then
		p191.Fortifications.Visible = false;
		return;
	end;
	if p192.List[p192.FortNum] then
		local v537 = nil;
		local v538 = game.ReplicatedStorage.GUI.FortLabel:clone();
		v538.Text = string.upper(p192.List[p192.FortNum].Name) .. " (" .. p192.List[p192.FortNum].Count .. ")";
		v538.Parent = p191.Fortifications;
		v538.Position = UDim2.new(0, 0, 0, 0);
		v537 = 0 + 20;
		for v539 = p192.FortNum + 1, #p192.List do
			local v540 = game.ReplicatedStorage.GUI.FortLabel:clone();
			v540.Text = string.upper(p192.List[v539].Name) .. " (" .. p192.List[v539].Count .. ")";
			v540.Parent = p191.Fortifications;
			v540.Position = UDim2.new(0, 0, 0, v537);
			v540.TextTransparency = 0.8;
			v537 = v537 + 20;
		end;
		for v541 = 1, p192.FortNum - 1 do
			local v542 = game.ReplicatedStorage.GUI.FortLabel:clone();
			v542.Text = string.upper(p192.List[v541].Name) .. " (" .. p192.List[v541].Count .. ")";
			v542.Parent = p191.Fortifications;
			v542.Position = UDim2.new(0, 0, 0, local v543);
			v542.TextTransparency = 0.8;
		end;
	end;
	p191.Fortifications.Visible = true;
end;
function u7.UpdateTime(p193, p194)
	local v544 = math.clamp(u34.StageMaxTime.Value - u34.StageTime.Value + 1, 1, u34.StageMaxTime.Value);
	p193.GameInfo.Time.Text = string.format("%2d:%02d", math.floor(v544 / 60) % 60, (math.floor(v544 % 60)));
	if u34.StageName.Value == "Transition" then
		p193.Countdown.Countdown.Text = math.floor(v544 % 60);
	end;
	p193.GameInfo.Progress.Text = math.floor(u34.Progress.Value * 100) .. "%";
end;
function u7.UpdatePObjectives(p195, p196)

end;
function u7.UpdateFreecam(p197, p198)
	if not u39.Freecam() then
		p197.FreeCam.Text = "";
		return;
	end;
	if p198[Enum.KeyCode.LeftControl] then
		p197.FreeCam.Text = "FOV: " .. u39.GetFOV();
		return;
	end;
	if p198[Enum.KeyCode.LeftAlt] then
		p197.FreeCam.Text = "Speed: " .. u39.GetSpeed();
		return;
	end;
	if not p198[Enum.KeyCode.RightAlt] then
		p197.FreeCam.Text = "";
		return;
	end;
	p197.FreeCam.Text = "Constant Rotate Speed: " .. u39.GetRotateSpeed() .. " deg/sec";
end;
local u84 = {};
function u7.AdjustConsoleUI(p199)
	u48 = true;
	p199.ChatBar.Visible = false;
	p199.ChatBar.Selectable = false;
	p199.ChatHolder.Visible = false;
	p199.HUD.UIScale.Scale = 1.5;
	p199["Player List"].Position = UDim2.new(1, -55, 0, 20);
	p199["Player List"].UIScale.Scale = 1.5;
	p199.GameInfo.Position = UDim2.new(0.5, 0, 0, 20);
	p199.GameInfo.UIScale.Scale = 1.5;
	p199.Credits.UIScale.Scale = 1.5;
	p199.Countdown.UIScale.Scale = 1.5;
	p199.Countdown.Vignette.UIScale.Scale = 0.6666666666666666;
	p199.WaveEnd.UIScale.Scale = 1.5;
	p199.WaveEnd.Vignette.UIScale.Scale = 0.6666666666666666;
	p199.Cursor.UIScale.Scale = 1.5;
	p199.Fortifications.Position = UDim2.new(0.5, -20, 0.5, 0);
	p199.Fortifications.UIScale.Scale = 1.5;
	p199.BuildProgress.Position = p199.BuildProgress.Position + UDim2.new(0, 0, 0, 16);
	p199.BuildProgress.UIScale.Scale = 1.5;
	p199.ChatHolder.UIScale.Scale = 1.5;
	p199.ChatBar.UIScale.Scale = 1.5;
	p199.ChatBar.Text = "Press 'ButtonSelect' to start chatting";
	p199.CarryingItem.Position = UDim2.new(1, -38, 1, -375);
	p199.CarryingItem.UIScale.Scale = 1.5;
	for v545, v546 in pairs(p199.Menu.Buttons:GetChildren()) do
		if v546:IsA("TextButton") then
			table.insert(u84, {
				Button = v546, 
				Out = false, 
				AbsPos = v546.AbsolutePosition
			});
		end;
	end;
	table.sort(u84, function(p200, p201)
		return p200.AbsPos.y < p201.AbsPos.y;
	end);
	p199["XBOX Message"].Visible = true;
	l__ContextActionService__18:BindActionAtPriority("XBOXClose", function(p202, p203, p204)
		if p203 ~= Enum.UserInputState.Begin then
			return;
		end;
		if p204.KeyCode ~= Enum.KeyCode.ButtonA then
			return Enum.ContextActionResult.Sink;
		end;
		l__SoundService__1.Menu.MenuClick:Play();
		p199["XBOX Message"].Visible = false;
		l__ContextActionService__18:UnbindAction("XBOXClose");
	end, false, Enum.ContextActionPriority.High.Value + 4, Enum.KeyCode.ButtonA, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonR1, Enum.KeyCode.ButtonL1, Enum.KeyCode.DPadDown, Enum.KeyCode.DPadUp);
	p199.Menu.ButtonFrames.Options.Graphics:Destroy();
	p199.Menu.ButtonFrames.Options.Audio:Destroy();
	p199.Menu.ButtonFrames.Options.GraphicsFrame:Destroy();
	p199.Menu.ButtonFrames.Options.AudioFrame:Destroy();
	p199.Menu.ButtonFrames.Options.PlayerFrame.Headbob.Position = p199.Menu.ButtonFrames.Options.PlayerFrame.Sensitivity.Position;
	p199.Menu.ButtonFrames.Options.PlayerFrame.TracerNum.Position = p199.Menu.ButtonFrames.Options.PlayerFrame.AimScale.Position;
	for v547, v548 in pairs(p199.Menu.ButtonFrames.Options.PlayerFrame:GetChildren()) do
		if v548.Name ~= "TracerNum" and v548.Name ~= "Headbob" then
			v548:Destroy();
		end;
	end;
	p199.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Passes.ScrollingFrame.ExtraPerk.Position = p199.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Passes.ScrollingFrame.CustomTag.Position;
	p199.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Passes.ScrollingFrame.ColoredTracers.Position = p199.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Passes.ScrollingFrame.RainbowText.Position;
	for v549, v550 in pairs(p199.Menu.ButtonFrames.Shop["Powerups/PassesFrame"].Passes.ScrollingFrame:GetChildren()) do
		if v550.Name ~= "ExtraPerk" and v550.Name ~= "ColoredTracers" then
			v550:Destroy();
		end;
	end;
end;
local u85 = tick();
local u86 = 1;
function u7.ConsoleUpdate(p205, p206, p207, p208, p209)
	local v551 = 0;
	for v552, v553 in pairs(l__ContextActionService__18:GetAllBoundActionInfo()) do
		if u16[v552] then
			v551 = v551 + 1;
		end;
	end;
	p205.Debug.Text = v551;
	p205.Debug.BackgroundColor3 = v551 > 0 and Color3.new(0, 1, 0) or Color3.new(1, 0, 0);
	if not l__GuiService__1.MenuIsOpen and CanClick(p205) then
		local v554 = math.abs(p207.y) > 0.85;
		local v555 = math.abs(p207.x) > 0.85;
		if (v554 or v555) and tick() - u85 > 0.15 then
			u85 = tick();
			if v554 and not u6 then
				if p207.y > 0 then
					local v556 = -1;
				else
					v556 = 1;
				end;
				u86 = u86 + v556;
				if u86 < 1 then
					u86 = #u84;
				end;
				if #u84 < u86 then
					u86 = 1;
				end;
			elseif u6 and u11[u6] and u11[u6].SubContainers then
				local v557 = u11[u6].SubContainers[u11[u6].SubNum];
				if v554 and v557.ButtonNum then
					if p207.y > 0 then
						local v558 = -1;
					else
						v558 = 1;
					end;
					v557.ButtonNum = v557.ButtonNum + v558;
					if v557.ButtonNum < 1 then
						v557.ButtonNum = #v557.ButtonsOrder;
					end;
					if #v557.ButtonsOrder < v557.ButtonNum then
						v557.ButtonNum = 1;
					end;
					if u6 == "Loadout" then
						if u11[u6].SubNum == 1 then
							u12.SetRightDown(false);
							WeaponClick(p205, p208, p209, v557.ButtonsOrder[v557.ButtonNum].Name);
						end;
						if u11[u6].SubNum == 2 and #v557.ButtonsOrder > 0 then
							for v559, v560 in pairs(v557.ButtonsOrder) do
								v560.Button.BackgroundTransparency = 1;
								v560.Button.BorderSizePixel = 0;
							end;
							v557.ButtonsOrder[v557.ButtonNum].Button.BackgroundTransparency = 0.8;
							v557.ButtonsOrder[v557.ButtonNum].Button.BorderColor3 = Color3.new(1, 1, 1);
							v557.ButtonsOrder[v557.ButtonNum].Button.BorderSizePixel = 2;
							AdjustScroll(p205, v557.ButtonsOrder[v557.ButtonNum].Button, p205.Menu.ButtonFrames.Loadout.Main.Skins);
						end;
					end;
				elseif v557.Rows and (v554 or v555) then
					if v555 then
						if p207.x > 0 then
							local v561 = 1;
						else
							v561 = -1;
						end;
						v557.ItemNum = v557.ItemNum + v561;
						if v557.ItemNum < 1 then
							v557.ItemNum = #v557.Rows[v557.RowNum];
						end;
						if #v557.Rows[v557.RowNum] < v557.ItemNum then
							v557.ItemNum = 1;
						end;
					end;
					if v554 then
						if p207.y > 0 then
							local v562 = -1;
						else
							v562 = 1;
						end;
						v557.RowNum = v557.RowNum + v562;
						if v557.RowNum < 1 then
							v557.RowNum = #v557.Rows;
						end;
						if #v557.Rows < v557.RowNum then
							v557.RowNum = 1;
						end;
					end;
					for v563, v564 in pairs(v557.Rows) do
						for v565, v566 in pairs(v564) do
							if v566.Equipped then
								local v567 = "rbxassetid://2634711088";
							else
								v567 = "rbxassetid://2600757280";
							end;
							v566.PerkF.BaseDefault.Image = v567;
						end;
					end;
					PerkHover(p205, p209, v557.Rows[v557.RowNum][v557.ItemNum]);
					l__SoundService__1.Menu.Hover:Play();
				end;
			end;
		end;
		local v568, v569, v570 = pairs(u84);
		while true do
			local v571, v572 = v568(v569, v570);
			if not v571 then
				break;
			end;
			if v571 == u86 then
				if not v572.Out then
					v572.Out = true;
					ButtonSelect(u84[v571].Button);
				end;
			elseif v572.Out then
				v572.Out = false;
				ButtonDeselect(u84[v571].Button);
			end;
			if v572.Button.Name == "Start" then
				if p206 then
					v572.Button.Text = "UNREADY";
				else
					v572.Button.Text = "READY";
				end;
			end;		
		end;
	end;
end;
local u87 = 0;
local u88 = 0;
local u89 = tick();
local u90 = 0;
local u91 = 0;
local u92 = {};
local u93 = require(game.ReplicatedStorage.Modules.DeepCopy);
local u94 = require(game.ReplicatedStorage.Modules.Hints);
local u95 = nil;
function u7.Update(p210, p211, p212, p213, p214, p215, p216, p217, p218)
	local v573, v574 = p212:WorldToScreenPoint(workspace.Lobby.LoadoutPoints.View.CFrame.p);
	if v574 then
		p213.Menu.Preview.Position = UDim2.new(0, v573.x - p213.Menu.Preview.Size.X.Offset / 2, 0, v573.y - p213.Menu.Preview.Size.Y.Offset / 2);
	end;
	u87 = u87 + p217;
	u88 = u88 + 1;
	if tick() - u89 > 0.5 then
		u89 = tick();
		u87 = 0;
		u88 = 0;
		if math.clamp(1 / (u87 / u88), 0, 60) < 27.5 and tick() - u90 > 45 and p218.Options.Hints then
			u90 = tick();
			u7.AddChat(p213, {
				Hint = true, 
				Text = "You can reduce lag by disabling graphics settings under the Options menu in the lobby", 
				ChatYSize = 28
			});
		end;
	end;
	if tick() - u91 > 90 and p218.Options.Hints then
		u91 = tick();
		if #u92 <= 0 then
			local v575 = u93.Copy(u94.PC);
			while #v575 > 0 do
				local v576 = Random.new():NextInteger(1, #v575);
				table.insert(u92, v575[v576]);
				table.remove(v575, v576);			
			end;
			u95 = u92[#u92];
		end;
		p213.HintText.Text = u92[1];
		table.remove(u92, 1);
	end;
	local v577 = p212.ViewportSize.y / 1080;
	if p216 then
		local v578 = 1.5;
	else
		v578 = 1.25;
	end;
	p213.Menu.ButtonFrames.Perks.UIScale.Scale = v577 * v578;
	if p216 then
		local v579 = 1.5;
	else
		v579 = 1.25;
	end;
	p213.Menu.ButtonFrames.Loadout.Main.UIScale.Scale = v577 * v579;
	if p216 then
		local v580 = 1.5;
	else
		v580 = 1.25;
	end;
	p213.Menu.ButtonFrames.Shop.UIScale.Scale = v577 * v580;
	if p216 then
		local v581 = 1.5;
	else
		v581 = 1.25;
	end;
	p213.Menu.ButtonFrames.Options.UIScale.Scale = v577 * v581;
	p213.Menu.Buttons.UIScale.Scale = v577 * 1.25;
	if p216 then
		local v582 = 1.5;
	else
		v582 = 1.25;
	end;
	p213["Login Rewards"].Main.UIScale.Scale = v577 * v582;
	p213.Revive.Box.UIScale.Scale = v577;
	if p216 then
		local v583 = 1.5;
	else
		v583 = 1.25;
	end;
	p213.Gift.Main.UIScale.Scale = v577 * v583;
	p213.Menu.Confirm.UIScale.Scale = v577 * 1.25;
	p213.Menu.Sell.UIScale.Scale = v577 * 1.25;
	p213.Menu.ButtonFrames.Loadout.Leaderboards.UIScale.Scale = v577;
	p213.Menu.ButtonFrames.Leaderboards.Loadout.UIScale.Scale = v577;
	p213.Menu.Back.UIScale.Scale = v577;
	if u56 >= 2 and tick() - u57 > 10 then
		u56 = 0;
	end;
	if p216 then
		local v584 = 0;
	else
		v584 = -16;
	end;
	p213.Cursor.Position = UDim2.new(0.5, 0, 0.5, v584);
	if p211.Objs.WeaponModel then
		if p211.Objs.WeaponModel:FindFirstChild("ReticleGlass") then
			local v585 = p212.CoordinateFrame:toObjectSpace(p211.Objs.WeaponModel.ReticleGlass.CFrame);
			local l__Size__586 = p211.Objs.WeaponModel.ReticleGlass.Size;
			p211.Objs.WeaponModel.ReticleGlass.Reticle.ImageLabel.Position = UDim2.new(0.5 - v585.x / l__Size__586.x, 0, 0.5 + v585.y / l__Size__586.y, 0);
		end;
	else
		p213.Reticle.Visible = false;
	end;
	if p210:FindFirstChild("HumanoidRootPart") and u72 and u72.Parent then
		local v587 = p210.HumanoidRootPart.CFrame:toObjectSpace(CFrame.new(u72.Position));
		p213.DamageIndicator.Rotation = math.deg(math.atan2(v587.x, -v587.z));
	end;
	if not u29 and p211.SequenceWhole.Build then
		local v588 = nil;
		local v589 = nil;
		p213.BuildProgress.Visible = true;
		v588 = 0;
		for v590 = 1, #p211.SequenceWhole.Build.Sequence.Sequence - 1 do
			v588 = v588 + p211.SequenceWhole.Build.Sequence.Sequence[v590].Time;
		end;
		v589 = p211.SequenceWhole.Build.Sequence.CurrentTime;
		for v591 = 1, p211.SequenceWhole.Build.Sequence.Number - 2 do
			v589 = v589 + p211.SequenceWhole.Build.Sequence.Sequence[v591].Time;
		end;
		local v592 = local v593 / local v594;
		if v592 < 1 then
			p213.BuildProgress.BarBase.BarFill.Size = UDim2.new(1, 0, v592, 0);
		else
			p213.BuildProgress.Visible = false;
		end;
	else
		p213.BuildProgress.Visible = false;
	end;
	if not u29 and p211.SequenceWhole.Revive then
		local v595 = nil;
		local v596 = nil;
		p213.ReviveProgress.Visible = true;
		v595 = 0;
		for v597 = 1, #p211.SequenceWhole.Revive.Sequence.Sequence - 1 do
			v595 = v595 + p211.SequenceWhole.Revive.Sequence.Sequence[v597].Time;
		end;
		v596 = p211.SequenceWhole.Revive.Sequence.CurrentTime;
		for v598 = 1, p211.SequenceWhole.Revive.Sequence.Number - 2 do
			v596 = v596 + p211.SequenceWhole.Revive.Sequence.Sequence[v598].Time;
		end;
		local v599 = local v600 / local v601;
		if v599 < 1 then
			p213.ReviveProgress.Fill.Size = UDim2.new(v599, 0, 1, 0);
		else
			p213.ReviveProgress.Visible = false;
		end;
	else
		p213.ReviveProgress.Visible = false;
	end;
	u7.UpdateTime(p213, p217);
	if p213.ChatBar:IsFocused() then
		u47 = tick();
	end;
	if tick() - u47 > 13 and not (not p213.ChatHolder.Visible) or tick() - u47 <= 13 and not p213.ChatHolder.Visible then
		u7.CheckCanChat(l__LocalPlayer__20, p213, p216, p218);
	end;
end;
return u7;
