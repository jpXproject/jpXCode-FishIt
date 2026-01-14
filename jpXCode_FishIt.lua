--[[ 
    jpXCode Fish It Hub
    Clean • Stable • No Lynxx
    Author: jpXCode
]]

-- ===== SERVICES =====
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local LP = Players.LocalPlayer

-- ===== CHARACTER =====
local function GetChar()
    local c = LP.Character or LP.CharacterAdded:Wait()
    return c, c:WaitForChild("HumanoidRootPart")
end

-- ===== CORE STATE =====
local Core = {
    AutoFish = false,
    FishStats = {},
    LastFish = "None"
}

-- =====================================================
-- 🎣 FISH DETECTOR (REAL, SERVER-BASED)
-- =====================================================
for _,obj in ipairs(RS:GetDescendants()) do
    if obj:IsA("RemoteEvent") then
        obj.OnClientEvent:Connect(function(...)
            for _,arg in ipairs({...}) do
                if typeof(arg) == "string" and #arg < 40 then
                    Core.LastFish = arg
                    Core.FishStats[arg] = (Core.FishStats[arg] or 0) + 1
                end
            end
        end)
    end
end

-- =====================================================
-- 🎣 FISH TRIGGER
-- =====================================================
local function TriggerFishing()
    local char = GetChar()
    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        tool:Activate()
    end
end

task.spawn(function()
    while task.wait(1.2) do
        if Core.AutoFish then
            TriggerFishing()
        end
    end
end)

-- =====================================================
-- 🧭 GPS SYSTEM
-- =====================================================
local GPS = {X=0,Y=0,Z=0}

RunService.Heartbeat:Connect(function()
    local _,hrp = GetChar()
    local p = hrp.Position
    GPS.X, GPS.Y, GPS.Z = p.X, p.Y, p.Z
end)

-- =====================================================
-- 🖥️ UI jpXCode
-- =====================================================
local Gui = Instance.new("ScreenGui", LP.PlayerGui)
Gui.Name = "jpXCodeHub"
Gui.ResetOnSpawn = false

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.fromOffset(260,180)
Frame.Position = UDim2.fromScale(0.03,0.3)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.BorderSizePixel = 0

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,10)

-- TITLE
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,30)
Title.Text = "jpXCode • Fish It"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.BackgroundTransparency = 1

-- AUTO FISH BUTTON
local Btn = Instance.new("TextButton", Frame)
Btn.Position = UDim2.fromOffset(15,45)
Btn.Size = UDim2.fromOffset(230,30)
Btn.Text = "Auto Fish : OFF"
Btn.Font = Enum.Font.Gotham
Btn.TextSize = 13
Btn.TextColor3 = Color3.new(1,1,1)
Btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,6)

Btn.MouseButton1Click:Connect(function()
    Core.AutoFish = not Core.AutoFish
    Btn.Text = "Auto Fish : "..(Core.AutoFish and "ON" or "OFF")
end)

-- GPS LABEL
local GPSLabel = Instance.new("TextLabel", Frame)
GPSLabel.Position = UDim2.fromOffset(15,85)
GPSLabel.Size = UDim2.fromOffset(230,45)
GPSLabel.BackgroundTransparency = 1
GPSLabel.TextColor3 = Color3.fromRGB(200,200,200)
GPSLabel.Font = Enum.Font.Gotham
GPSLabel.TextSize = 12
GPSLabel.TextXAlignment = Left
GPSLabel.TextYAlignment = Top

-- FISH LABEL
local FishLabel = Instance.new("TextLabel", Frame)
FishLabel.Position = UDim2.fromOffset(15,130)
FishLabel.Size = UDim2.fromOffset(230,30)
FishLabel.BackgroundTransparency = 1
FishLabel.TextColor3 = Color3.fromRGB(255,180,80)
FishLabel.Font = Enum.Font.GothamBold
FishLabel.TextSize = 12

RunService.Heartbeat:Connect(function()
    GPSLabel.Text = string.format(
        "GPS:\nX %.1f | Y %.1f | Z %.1f",
        GPS.X, GPS.Y, GPS.Z
    )
    FishLabel.Text = "Last Fish: "..Core.LastFish
end)

-- =====================================================
-- 🌍 GLOBAL ACCESS
-- =====================================================
_G.jpXCode = Core
