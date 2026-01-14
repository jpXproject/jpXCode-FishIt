-- jpXCoreFishing.lua
-- Injected core fishing for Fish It
-- UI compatible with Lynxx

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local Core = {}
Core.Enabled = false
Core.Stats = {}
Core.LastFish = "None"

-- ===== CHARACTER SAFE GET =====
local function GetChar()
    local char = LocalPlayer.Character
    if not char then return end
    return char, char:FindFirstChild("HumanoidRootPart")
end

-- ===== FISH DETECTOR (REAL) =====
for _,obj in ipairs(ReplicatedStorage:GetDescendants()) do
    if obj:IsA("RemoteEvent") then
        obj.OnClientEvent:Connect(function(...)
            for _,arg in ipairs({...}) do
                if typeof(arg) == "string" then
                    Core.LastFish = arg
                    Core.Stats[arg] = (Core.Stats[arg] or 0) + 1
                end
            end
        end)
    end
end

-- ===== TRIGGER FISHING =====
function Core.Trigger()
    local char = GetChar()
    if not char then return end

    local tool = char:FindFirstChildOfClass("Tool")
    if tool then
        tool:Activate()
    end
end

-- ===== AUTO LOOP =====
task.spawn(function()
    while task.wait(1.2) do
        if Core.Enabled then
            Core.Trigger()
        end
    end
end)

-- ===== GLOBAL ACCESS FOR UI =====
_G.jpXFishCore = Core

return Core
