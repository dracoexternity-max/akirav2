-- Teleport Module
local module = {}
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function module:Init(Main)
    self.Main = Main
    self.Locations = {
        ["Premium Lake"] = Vector3.new(120, 50, -340),
        ["Deep Ocean"] = Vector3.new(-200, 30, 800),
        ["Sell Point"] = Vector3.new(45, 5, 120)
    }
end

function module:TeleportTo(Position)
    local Char = LocalPlayer.Character
    if Char and Char:FindFirstChild("HumanoidRootPart") then
        local Tween = TweenService:Create(Char.HumanoidRootPart, TweenInfo.new(2), {CFrame = CFrame.new(Position)})
        Tween:Play()
        Tween.Completed:Wait()
    end
end

function module:GetLocations()
    return self.Locations
end

return module