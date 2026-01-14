-- Fish Detector (REAL)
local RS = game:GetService("ReplicatedStorage")

local Detector = {
    LastFish = "None",
    Stats = {}
}

for _,obj in ipairs(RS:GetDescendants()) do
    if obj:IsA("RemoteEvent") then
        obj.OnClientEvent:Connect(function(...)
            for _,arg in ipairs({...}) do
                if typeof(arg) == "string" and #arg < 40 then
                    Detector.LastFish = arg
                    Detector.Stats[arg] = (Detector.Stats[arg] or 0) + 1
                end
            end
        end)
    end
end

return Detector
