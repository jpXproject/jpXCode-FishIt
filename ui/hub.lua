-- jpXCode Hub UI
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local Core = _G.jpXCore

local Gui = Instance.new("ScreenGui")
Gui.Name = "jpXCodeHub"
Gui.ResetOnSpawn = false
Gui.Parent = LP.PlayerGui

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.fromOffset(280,200)
Frame.Position = UDim2.fromScale(0.03,0.3)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.BorderSizePixel = 0
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,10)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,30)
Title.Text = "jpXCode • Fish It"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1

-- Button
local Btn = Instance.new("TextButton", Frame)
Btn.Position = UDim2.fromOffset(15,45)
Btn.Size = UDim2.fromOffset(250,30)
Btn.Text = "Auto Fish : OFF"
Btn.Font = Enum.Font.Gotham
Btn.TextSize = 13
Btn.TextColor3 = Color3.new(1,1,1)
Btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,6)

Btn.MouseButton1Click:Connect(function()
    Core.Fishing.Enabled = not Core.Fishing.Enabled
    Btn.Text = "Auto Fish : "..(Core.Fishing.Enabled and "ON" or "OFF")
end)

-- GPS
local GPSLabel = Instance.new("TextLabel", Frame)
GPSLabel.Position = UDim2.fromOffset(15,85)
GPSLabel.Size = UDim2.fromOffset(250,45)
GPSLabel.BackgroundTransparency = 1
GPSLabel.TextColor3 = Color3.fromRGB(200,200,200)
GPSLabel.Font = Enum.Font.Gotham
GPSLabel.TextSize = 12
GPSLabel.TextXAlignment = Left
GPSLabel.TextYAlignment = Top

-- Fish
local FishLabel = Instance.new("TextLabel", Frame)
FishLabel.Position = UDim2.fromOffset(15,140)
FishLabel.Size = UDim2.fromOffset(250,30)
FishLabel.BackgroundTransparency = 1
FishLabel.TextColor3 = Color3.fromRGB(255,180,80)
FishLabel.Font = Enum.Font.GothamBold
FishLabel.TextSize = 12

RunService.Heartbeat:Connect(function()
    local g = Core.GPS
    GPSLabel.Text = string.format(
        "GPS:\nX %.1f | Y %.1f | Z %.1f",
        g.X, g.Y, g.Z
    )
    FishLabel.Text = "Last Fish: "..Core.Detector.LastFish
end)
