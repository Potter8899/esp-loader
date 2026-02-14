getgenv().ESP_LOADED = nil
task.wait(1)

local correctKey = "hubpot"
local url = "https://raw.githubusercontent.com/Potter8899/esp-loader/main/Main.lua"

local player = game.Players.LocalPlayer


local bypassId = 9397840029

-- ถ้าตรงชื่อ หรือ ตรงไอดี = เข้าเลย
if player.Name == bypassName or player.UserId == bypassId then
    loadstring(game:HttpGet(url))()
    return
end

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,260,0,140)
frame.Position = UDim2.new(0.5,-130,0.5,-70)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.Text = "KEY SYSTEM"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-30,0,0)
close.Text = "X"
close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local box = Instance.new("TextBox", frame)
box.Name = "keyhere"
box.Size = UDim2.new(1,-20,0,40)
box.Position = UDim2.new(0,10,0,50)
box.PlaceholderText = "Key Here..."

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(1,-20,0,40)
btn.Position = UDim2.new(0,10,0,95)
btn.Text = "Confirm"

btn.MouseButton1Click:Connect(function()
	if box.Text == correctKey then
		gui:Destroy()
		loadstring(game:HttpGet(url))()
	else
		box.Text = "คีย์ผิด"
	end
end)
