if getgenv().ESP_LOADED then return end
getgenv().ESP_LOADED = true

local correctKey = "hubpot"
local url = "https://raw.githubusercontent.com/Potter8899/esp-loader/main/Main.lua"

-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "KeyUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 140)
frame.Position = UDim2.new(0.5, -130, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "Enter Key"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(1,-20,0,40)
box.Position = UDim2.new(0,10,0,40)
box.PlaceholderText = "ใส่คีย์..."
box.Text = ""

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(1,-20,0,40)
btn.Position = UDim2.new(0,10,0,90)
btn.Text = "Confirm"

btn.MouseButton1Click:Connect(function()
	if box.Text == correctKey then
		gui:Destroy()

		local success, err = pcall(function()
			loadstring(game:HttpGet(url))()
		end)

		if not success then
			warn("ESP Load Failed:", err)
		end
	else
		box.Text = "คีย์ผิด"
	end
end)
