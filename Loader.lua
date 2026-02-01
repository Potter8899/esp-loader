-- Loader.lua
if getgenv().ESP_LOADED then return end
getgenv().ESP_LOADED = true

local url = "https://raw.githubusercontent.com/Potter8899/esp-loader/main/Main.lua"

local success, err = pcall(function()
	loadstring(game:HttpGet(url))()
end)

if not success then
	warn("ESP Load Failed :", err)
end
