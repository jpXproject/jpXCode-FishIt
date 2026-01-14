-- jpXCode Fish It Loader (STABLE)

local BASE_URL = "https://raw.githubusercontent.com/jpXproject/jpXCode-FishIt/main/"

local function Load(path)
    local ok, result = pcall(function()
        return game:HttpGet(BASE_URL .. path)
    end)

    if not ok or not result or result == "" then
        warn("[jpXCode] HttpGet FAILED:", path)
        return nil
    end

    local fn, err = loadstring(result)
    if not fn then
        warn("[jpXCode] Loadstring error:", err)
        return nil
    end

    return fn()
end

_G.jpXCore = {}

_G.jpXCore.GPS      = Load("core/gps.lua")
_G.jpXCore.Detector = Load("core/detector.lua")
_G.jpXCore.Fishing  = Load("core/fishing.lua")

Load("ui/hub.lua")

print("✅ jpXCode FishIt loaded")
