local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local lp = Players.LocalPlayer

local function getHRP()
    local char = lp.Character
    if not char then return end
    return char:FindFirstChild("HumanoidRootPart")
end

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "jpX_GPS"
gui.Parent = lp:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(180, 70)
frame.Position = UDim2.fromOffset(10, 10)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0

Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.fromScale(1,1)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1,1,1)
label.Font = Enum.Font.Gotham
label.TextSize = 12
label.TextXAlignment = Left
label.TextYAlignment = Center
label.Text = "GPS\nX: --\nY: --\nZ: --"

-- Update
local conn = RunService.Heartbeat:Connect(function()
    local hrp = getHRP()
    if not hrp then return end

    local p = hrp.Position
    label.Text = string.format(
        "GPS\nX: %.1f\nY: %.1f\nZ: %.1f",
        p.X, p.Y, p.Z
    )
end)

table.insert(_G.jpXCore._connections, conn)

return {
    GetPosition = function()
        local hrp = getHRP()
        return hrp and hrp.Position
    end
}
