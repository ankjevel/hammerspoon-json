local mod = {}

local pasteboard = require("hs.pasteboard")
local json = require("hs.json")
local f = string.format

-- json
function mod.json()
  local current = pasteboard.getContents()
  local toJson = nil
  local format = f("eval(%s)", current)

  ok, result = hs.osascript._osascript(format, "JavaScript")

  if ok then
    toJson = json.encode(result)
    hs.alert.show(toJson)
    pasteboard.setContents(toJson)
  end
end

function mod.registerDefaultBindings(mods, key)
  mods = mods or {"cmd", "alt", "ctrl"}
  key = key or "J"
  hs.hotkey.bind(mods, key, mod.json)
end

return mod
