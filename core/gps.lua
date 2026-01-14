-- GPS System
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer

local GPS = {
    X = 0,
    Y = 0,
    Z = 0
}

local function GetHRP()
    local char = LP.Character
    if not char then return end
    return char:FindFirstChild("HumanoidRootPart")
end

RunService.Heartbeat:Connect(function()
    local hrp = GetHRP()
    if hrp then
        local p = hrp.Position
        GPS.X, GPS.Y, GPS.Z = p.X, p.Y, p.Z
    end
end)

return GPS
