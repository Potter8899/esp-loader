-- ===============================
-- ESP FULL UI FINAL (CENTER TOP TRACER)
-- ===============================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Cam = workspace.CurrentCamera
local LP = Players.LocalPlayer

for _,v in ipairs(LP.PlayerGui:GetChildren()) do
	if v.Name == "SilentAimUI" then v:Destroy() end
end

-- ===== STATE =====
local espEnabled = true
local nameEnabled = true
local hpEnabled = true
local tracerEnabled = true

local espScale = 100
local nameScale = 100

local draggingMain, draggingMini = false,false
local slidingEsp, slidingName = false,false
local dragStart, startPos

local ESP_CACHE = {}

-- ===== GUI =====
local gui = Instance.new("ScreenGui", LP.PlayerGui)
gui.Name = "SilentAimUI"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(260,330)
main.Position = UDim2.fromOffset(60,220)
main.BackgroundColor3 = Color3.fromRGB(28,28,28)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,34)
title.Text = "ESP MENU"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BackgroundTransparency = 1

title.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingMain = true
		dragStart = i.Position
		startPos = main.Position
	end
end)

-- ===== TOP BUTTON =====
local function topBtn(x,text,color)
	local b = Instance.new("TextButton", main)
	b.Size = UDim2.fromOffset(28,28)
	b.Position = UDim2.new(1,-x,0,6)
	b.Text = text
	b.BackgroundColor3 = color
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", b)
	return b
end

local closeBtn = topBtn(34,"X",Color3.fromRGB(170,50,50))
local minusBtn = topBtn(68,"-",Color3.fromRGB(70,70,70))

-- ===== BUTTON =====
local function makeBtn(y,text)
	local b = Instance.new("TextButton", main)
	b.Position = UDim2.fromOffset(12,y)
	b.Size = UDim2.fromOffset(236,28)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(50,50,50)
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", b)
	return b
end

local espBtn    = makeBtn(44,"ESP : ON")
local nameBtn   = makeBtn(76,"Name ESP : ON")
local hpBtn     = makeBtn(108,"HP ESP : ON")
local tracerBtn = makeBtn(140,"เส้นนำทาง : ON")

-- ===== SLIDER =====
local function slider(y)
	local label = Instance.new("TextLabel", main)
	label.Position = UDim2.fromOffset(12,y)
	label.Size = UDim2.fromOffset(236,18)
	label.TextColor3 = Color3.new(1,1,1)
	label.BackgroundTransparency = 1
	label.TextSize = 13

	local bar = Instance.new("Frame", main)
	bar.Position = UDim2.fromOffset(12,y+20)
	bar.Size = UDim2.fromOffset(236,8)
	bar.BackgroundColor3 = Color3.fromRGB(70,70,70)
	Instance.new("UICorner", bar)

	local fill = Instance.new("Frame", bar)
	fill.BackgroundColor3 = Color3.fromRGB(80,180,255)
	Instance.new("UICorner", fill)

	return label,bar,fill
end

local espLabel,espBar,espFill   = slider(180)
local nameLabel,nameBar,nameFill= slider(220)

-- ===== MINI =====
local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.fromOffset(56,56)
mini.Position = UDim2.fromOffset(20,300)
mini.Text = "🔥💀"
mini.TextSize = 20
mini.BackgroundColor3 = Color3.fromRGB(25,25,25)
mini.TextColor3 = Color3.new(1,1,1)
mini.Visible = false
mini.Active = true
Instance.new("UICorner", mini).CornerRadius = UDim.new(1,0)

mini.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingMini = true
		dragStart = i.Position
		startPos = mini.Position
	end
end)

-- ===== TOGGLE =====
local function toggle(btn,state,on,off)
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = state and on or off
	end)
	return function() return state end
end

local getESP    = toggle(espBtn,true,"ESP : ON","ESP : OFF")
local getName   = toggle(nameBtn,true,"Name ESP : ON","Name ESP : OFF")
local getHP     = toggle(hpBtn,true,"HP ESP : ON","HP ESP : OFF")
local getTracer = toggle(tracerBtn,true,"เส้นนำทาง : ON","เส้นนำทาง : OFF")

minusBtn.MouseButton1Click:Connect(function()
	main.Visible=false
	mini.Visible=true
end)
mini.MouseButton1Click:Connect(function()
	main.Visible=true
	mini.Visible=false
end)

-- ===== INPUT =====
UIS.InputEnded:Connect(function(i)
	if i.UserInputType==Enum.UserInputType.MouseButton1 then
		draggingMain=false
		draggingMini=false
		slidingEsp=false
		slidingName=false
	end
end)

UIS.InputChanged:Connect(function(i)
	if draggingMain then
		local d=i.Position-dragStart
		main.Position=startPos+UDim2.fromOffset(d.X,d.Y)
	end
	if draggingMini then
		local d=i.Position-dragStart
		mini.Position=startPos+UDim2.fromOffset(d.X,d.Y)
	end

	local function slide(bar,max)
		return math.clamp((i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)*max
	end
	if slidingEsp then espScale=math.floor(slide(espBar,300)) end
	if slidingName then nameScale=math.floor(slide(nameBar,300)) end
end)

espBar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then slidingEsp=true end end)
nameBar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then slidingName=true end end)

-- ===== CLOSE =====
closeBtn.MouseButton1Click:Connect(function()
	for _,v in pairs(ESP_CACHE) do
		for _,d in pairs(v) do d:Remove() end
	end
	gui:Destroy()
end)

-- ===== LOOP =====
RunService.RenderStepped:Connect(function()
	espFill.Size=UDim2.fromScale(espScale/300,1)
	nameFill.Size=UDim2.fromScale(nameScale/300,1)
	espLabel.Text="ESP Size : "..espScale
	nameLabel.Text="Name Size : "..nameScale

	local vp = Cam.ViewportSize
	local tracerStart = Vector2.new(vp.X/2, vp.Y*0.15)

	for _,p in ipairs(Players:GetPlayers()) do
		if p~=LP and p.Character then
			local hum=p.Character:FindFirstChildOfClass("Humanoid")
			local root=p.Character:FindFirstChild("HumanoidRootPart")
			local head=p.Character:FindFirstChild("Head")
			if not hum or hum.Health<=0 or not root or not getESP() then
				if ESP_CACHE[p] then
					for _,d in pairs(ESP_CACHE[p]) do d.Visible=false end
				end
				continue
			end

			if not ESP_CACHE[p] then
				ESP_CACHE[p]={
					box=Drawing.new("Square"),
					name=Drawing.new("Text"),
					hp=Drawing.new("Text"),
					line=Drawing.new("Line")
				}
				ESP_CACHE[p].box.Filled=false
				ESP_CACHE[p].box.Thickness=1.5
				ESP_CACHE[p].name.Center=true
				ESP_CACHE[p].hp.Center=true
				ESP_CACHE[p].line.Thickness=1.8
				ESP_CACHE[p].line.Color=Color3.fromRGB(80,180,255)
			end

			local r,on=Cam:WorldToViewportPoint(root.Position)
			if not on then
				for _,d in pairs(ESP_CACHE[p]) do d.Visible=false end
				continue
			end

			local s=espScale/100
			local w,hb=35*s,50*s

			local box=ESP_CACHE[p].box
			box.Size=Vector2.new(w,hb)
			box.Position=Vector2.new(r.X-w/2,r.Y-hb/2)
			box.Visible=true

			if getName() then
				local hpos=Cam:WorldToViewportPoint(head.Position+Vector3.new(0,0.6,0))
				local name=ESP_CACHE[p].name
				name.Text=p.Name
				name.Size=nameScale
				name.Position=Vector2.new(hpos.X,hpos.Y-16)
				name.Visible=true
			end

			if getHP() then
				local hp=ESP_CACHE[p].hp
				hp.Text="HP "..math.floor(hum.Health)
				hp.Size=13
				hp.Position=Vector2.new(r.X,r.Y+hb/2+2)
				hp.Color=hum.Health<40 and Color3.fromRGB(255,60,60) or Color3.fromRGB(60,255,60)
				hp.Visible=true
			end

			if getTracer() then
				local line=ESP_CACHE[p].line
				line.From=tracerStart
				line.To=Vector2.new(r.X,r.Y-hb/2)
				line.Visible=true
			end
		end
	end
end)
