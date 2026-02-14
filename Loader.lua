-- Loader.lua
if getgenv().ESP_LOADED then return end
getgenv().ESP_LOADED = true

local url = "loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/981bf5b6ee1b6a07950828c3811197c24f0f191705425dccf125f75808a32fee/download"))()"

local success, err = pcall(function()
    loadstring(game:HttpGet(url))()
end)

if not success then
    warn("ESP Load Failed :", err)
end
