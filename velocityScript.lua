-- velocityScript.lua
-- This script applies velocity to the player’s HumanoidRootPart to simulate jump shot momentum

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local shooting = false
local shootForce = Vector3.new(0, 50, 100) -- Adjust upward (Y) and forward (Z) force here
local shootDuration = 0.5 -- Duration in seconds to apply velocity

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

-- Example keybind: Press E to shoot (for testing)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.E then
        startShooting()
    end
end)
