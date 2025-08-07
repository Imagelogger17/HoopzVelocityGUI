-- velocityMobile.lua
-- Mobile-friendly velocity jump shot triggered by a ScreenGui button

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local shooting = false
local shootForce = Vector3.new(0, 50, 100)
local shootDuration = 0.5

local function startShooting()
    if shooting then return end
    shooting = true

    local startTime = tick()

    local connection
    connection = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        if elapsed < shootDuration then
            humanoidRootPart.Velocity = shootForce
        else
            shooting = false
            connection:Disconnect()
        end
    end)
end

-- This script expects a button named "ShootButton" under the same parent
local shootButton = script.Parent:WaitForChild("ShootButton")

shootButton.Activated:Connect(function()
    startShooting()
end)
