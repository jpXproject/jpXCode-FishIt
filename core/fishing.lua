-- Auto Fishing Engine
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local Fishing = {
    Enabled = false
}

local function GetTool()
    local char = LP.Character
    if not char then return end
    return char:FindFirstChildOfClass("Tool")
end

function Fishing.Trigger()
    local tool = GetTool()
    if tool then
        tool:Activate()
    end
end

task.spawn(function()
    while task.wait(1.2) do
        if Fishing.Enabled then
            Fishing.Trigger()
        end
    end
end)

return Fishing
