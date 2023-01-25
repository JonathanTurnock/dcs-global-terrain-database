--[[
    Script to return a a JSON representation of the item passed in.

    Start from _G to explore global namespace, and drill down.

    Strings and Numbers are simply printed, tables, functions etc need to be explored

    Calling as is produces the following

    {
      "AI": "table",
      "Airbase": "table",
      "Controller": "table",
      "Disposition": "table",
      "ED_FINAL_VERSION": true,
      "ED_PUBLIC_AVAILABLE": true,
      "Group": "table",
      "Object": "table",
      "SceneryObject": "table",
      "Spot": "table",
      "StaticObject": "table",
      "Unit": "table",
      "VoiceChat": "table",
      "Weapon": "table",
      "_APP_VERSION": "2.8.1.34667",
      "_ARCHITECTURE": "x86_64",
      "_G": "table",
      "_VERSION": "Lua 5.1",
      "addAirbase": "function",
      "addParking": "function",
      "alt": 0,
      "assert": "function",
      "atmosphere": "table",
      "cache": "table",
      "class": "function",
      "coalition": "table",
      "collectgarbage": "function",
      "console": "table",
      "coord": "table",
      "coroutine": "table",
      "country": "table",
      "db_path": "./Scripts/Database/",
      "debug": "table",
      "desc": "table",
      "doZipFile": "function",
      "dofile": "function",
      "env": "table",
      "error": "function",
      "from_base64": "function",
      "gcinfo": "function",
      "getUtm": "function",
      "getfenv": "function",
      "getmetatable": "function",
      "httpd": "table",
      "httpd_start": "function",
      "httpd_step": "function",
      "io": "table",
      "ipairs": "function",
      "land": "table",
      "lat": 45.129497060329,
      "lfs": "table",
      "load": "function",
      "loadfile": "function",
      "loadstring": "function",
      "log": "table",
      "lon": 34.265515188456,
      "math": "table",
      "merge_all_units_to_AGGRESSORS": "function",
      "missionCommands": "table",
      "module": "function",
      "nStart": 17,
      "net": "table",
      "newproxy": "function",
      "next": "function",
      "os": "table",
      "package": "table",
      "pairs": "function",
      "pcall": "function",
      "point": "table",
      "print": "function",
      "radio": "table",
      "rawequal": "function",
      "rawget": "function",
      "rawset": "function",
      "require": "function",
      "safe_require": "function",
      "scorelist": "table",
      "select": "function",
      "setfenv": "function",
      "setmetatable": "function",
      "socket": "table",
      "string": "table",
      "table": "table",
      "timer": "table",
      "tonumber": "function",
      "tostring": "function",
      "trigger": "table",
      "troopsPath": "./Scripts/Database/troops/",
      "type": "function",
      "unpack": "function",
      "world": "table",
      "xpcall": "function"
    }

    This code is under MIT licence, you can find the complete file at https://opensource.org/licenses/MIT
]]--
local function getMeta (data) 
    local meta = {}

    for k,v in pairs(data) do
        local t = type(v)

        if t == 'string' or t == 'number' or t == 'nil' or t == 'boolean' then
            meta[k] = v
        else
            meta[k] = type(v)
        end
    end
    return meta
end

return getMeta(_G)
