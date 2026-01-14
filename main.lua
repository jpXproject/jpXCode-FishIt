-- =====================================
-- jpXCode CLEAN-UP SYSTEM
-- =====================================

pcall(function()
    -- 1. Matikan loop / thread lama
    if _G.jpXCore and _G.jpXCore._connections then
        for _, conn in pairs(_G.jpXCore._connections) do
            if typeof(conn) == "RBXScriptConnection" then
                conn:Disconnect()
            end
        end
    end

    -- 2. Hancurkan UI lama
    local pg = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
    if pg then
        for _, gui in ipairs(pg:GetChildren()) do
            if gui.Name:find("jpX") or gui.Name:find("FishIt") then
                gui:Destroy()
            end
        end
    end

    -- 3. Hancurkan CoreGui (kalau executor inject di sana)
    local cg = game:GetService("CoreGui")
    for _, gui in ipairs(cg:GetChildren()) do
        if gui.Name:find("jpX") then
            gui:Destroy()
        end
    end

    -- 4. Reset global state
    _G.jpXCore = nil
    _G.jpXLoaded = nil

    print("[jpXCode] Previous script cleaned")
end)

task.wait(0.2)
