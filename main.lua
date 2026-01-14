-- jpXCode Fish It Loader
-- Author: jpXCode

local BASE_URL = "https://raw.githubusercontent.com/USERNAME/jpXCode-FishIt/main/"

local function Load(path)
    return loadstring(game:HttpGet(BASE_URL .. path))()
end

-- Core
_G.jpXCore = {}
_G.jpXCore.Detector = Load("core/detector.lua")
_G.jpXCore.GPS      = Load("core/gps.lua")
_G.jpXCore.Fishing  = Load("core/fishing.lua")

-- UI
Load("ui/hub.lua")

print("[jpXCode] Hub loaded successfully")
