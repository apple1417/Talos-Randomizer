print("Loaded Randomizer_Startup.lua")

--[[
  We have to use prj_strCustomOccasion to communicate with world scripts, but unfortunatly it
   doesn't get saved between sessions, so we use a second var for that
]]--
prj_strCustomOccasion = ser_strBanList

globals.Randomizer = {}
globals.Randomizer._Descriptions = {
  AutoHints = "Change the default hint settings when you load into the options world",
  AutoStart = "Lets you skip the options world and start straight in A1, pre-specificing the options",
  Debug = "Turn debug mode on or odd"
}

local allHints = {
  {code = "a1g", name = "A1 Gate", offset = 0},
  {code = "ag", name = "A Gate", offset = 1},
  {code = "bg", name = "B Gate", offset = 2},
  {code = "cg", name = "C Gate", offset = 3},
  {code = "c", name = "Connector", offset = 4},
  {code = "h", name = "Cube", offset = 5},
  {code = "f", name = "Fan", offset = 6},
  {code = "r", name = "Recorder", offset = 7},
  {code = "p", name = "Platform", offset = 8},
  {code = "f1", name = "Floor 1", offset = 9},
  {code = "f2", name = "Floor 2", offset = 10},
  {code = "f3", name = "Floor 3", offset = 11},
  {code = "f4", name = "Floor 4", offset = 12},
  {code = "f5", name = "Floor 5", offset = 13},
  {code = "f6", name = "Floor 6", offset = 14}
}

-- It's better to store a table of hints and only convert in one place
local selectedHints = nil
local function loadHints()
  local o, m = string.match(prj_strCustomOccasion, "Randomizer_AutoHints(O?f?f?)=(%d-);")
  if o == nil or m == nil then
    selectedHints = nil
    return
  end
  local hintsVal = tonumber(m)
  selectedHints = {}
  for i = 1, #allHints do
    if hintsVal % 2 == 1 then
      selectedHints[allHints[i].code] = allHints[i]
    end
    hintsVal = mthFloorF(hintsVal / 2)
  end
end
local function saveHints()
  if selectedHints == nil then
    prj_strCustomOccasion = string.gsub(
      prj_strCustomOccasion,
      "Randomizer_AutoHintsO?f?f?=%d-;",
      "",
      1
    )
    ser_strBanList = prj_strCustomOccasion
    return
  end

  local hintsVal = 0
  for _, i in pairs(selectedHints) do
    hintsVal = hintsVal + mthPow2F(i.offset)
  end

  if string.match(prj_strCustomOccasion, "Randomizer_AutoHintsO?f?f?=(%d-);") == nil then
    prj_strCustomOccasion = prj_strCustomOccasion .. "Randomizer_AutoHints=" .. hintsVal .. ";"
    ser_strBanList = prj_strCustomOccasion
    return
  end

  prj_strCustomOccasion = string.gsub(
    prj_strCustomOccasion,
    "(Randomizer_AutoHintsO?f?f?)=%d-;",
    "%1=" .. hintsVal .. ";",
    1
  )
  ser_strBanList = prj_strCustomOccasion
end
loadHints()

globals.Randomizer.AutoHints = {}
globals.Randomizer.AutoHints._Descriptions = {
  add = "Adds a hint that should be automatically selected",
  default = "Revert to default AutoHints settings",
  list = "Show all hints currently set to be automatically selected",
  remove = "Removes a hint from being automatically selected",
  setRaw = "Overwrite the raw value for what hints are selected",
  toggle = "Turn on or off AutoHints, while saving all your settings"
}
globals.Randomizer.AutoHints.toggle = function()
  local m = string.match(prj_strCustomOccasion, "Randomizer_AutoHints(O?f?f?)=%d-;")
  if m == nil then
    print("No Auto Hints options specified")
    return
  end
  if #m == 0 then
    prj_strCustomOccasion = string.gsub(
      prj_strCustomOccasion,
      "Randomizer_AutoHints=(%d-);",
      "Randomizer_AutoHintsOff=%1;",
      1
    )
    print("Disabled Auto Hints")
  else
    prj_strCustomOccasion = string.gsub(
      prj_strCustomOccasion,
      "Randomizer_AutoHintsOff=(%d-);",
      "Randomizer_AutoHints=%1;",
      1
    )
    print("Enabled Auto Hints")
  end
  ser_strBanList = prj_strCustomOccasion
end

globals.Randomizer.AutoHints.list = function()
  local o = string.match(prj_strCustomOccasion, "Randomizer_AutoHints(O?f?f?)=%d-;")
  if o == nil or selectedHints == nil then
    print("No Auto Hints options specified - will use defaults")
    return
  end
  if #o == 0 then
    print("Auto Hints are currently on")
  else
    print("Auto Hints are currently off - will use defaults")
  end
  print("Selected hints:")
  for _, i in pairs(selectedHints) do
    print(i.name)
  end
  print()
end

globals.Randomizer.AutoHints.default = function()
  selectedHints = nil
  saveHints()
end

local validHints = "Valid Values: 'A1G', 'AG', 'BG', 'CG', 'C', 'H', 'F', 'R', 'P', 'F1', 'F2', 'F3', 'F4', 'F5', 'F6'"
local function eachHint(arranger, add)
  if type(arranger) ~= "string" then
    return "Invalid argument '" .. arranger .. "', expected a string"
  end

  -- Process the input a bit to allow multiple input forms
  local original = arranger
  arranger = string.gsub(
    string.gsub(
      string.gsub(
        string.lower(arranger),
        "[%s_-]+", ""
      ), "floor", "f"
    ), "gate", "g"
  )
  if string.sub(arranger, 1, 3) == "con" then
    arranger = "c"
  end
  if arranger == "cube" or string.sub(arranger, 1, 3) == "hex" then
    arranger = "h"
  end
  if arranger == "fan" then
    arranger = "f"
  end
  if string.sub(arranger, 1, 3) == "rec" then
    arranger = "r"
  end
  if string.sub(arranger, 1, 4) == "plat" then
    arranger = "p"
  end

  -- Actually add the hint
  local hint = nil
  for _, h in pairs(allHints) do
    if h.code == arranger then
      hint = h
      break
    end
  end
  if hint == nil then
    return "Unrecognised Hint '".. original .. "' \n" .. validHints
  end

  if selectedHints == nil then
    selectedHints = {
      f1 = allHints[10],
      f2 = allHints[11],
      f3 = allHints[12]
    }
  end

  if selectedHints[hint.code] and add then
    return "Hint '" .. original .. "' has already been added"
  elseif not selectedHints[hint.code] and not add then
    return "Hint '" .. original .. "' has already been removed"
  end

  if add then
    selectedHints[hint.code] = hint
  else
    selectedHints[hint.code] = nil
  end
  saveHints()
end

local function adjustHints(arg, add)
  if arg.n == 0 then
    print(validHints)
    return
  end

  for i=1, arg.n do
    local output = eachHint(arg[i], add)
    if output ~= nil then
      print(output)
      loadHints()
      return
    end
  end
  saveHints()
end

globals.Randomizer.AutoHints.add = function(...)
  adjustHints(arg, true)
end

globals.Randomizer.AutoHints.remove = function(...)
  adjustHints(arg, false)
end

globals.Randomizer.AutoHints.setRaw = function(val)
  if type(val) ~= "number" then
    print("Invalid argument, expected a number")
    return
  end
  if mthRoundF(val) ~= val or 0 > val or val > 32767 then
    print("Invalid number, expected an integer between 0 and 32,767")
    return
  end

  if string.match(prj_strCustomOccasion, "Randomizer_AutoHintsO?f?f?=(%d-);") == nil then
    prj_strCustomOccasion = prj_strCustomOccasion .. "Randomizer_AutoHints=" .. val .. ";"
    ser_strBanList = prj_strCustomOccasion
    return
  end

  prj_strCustomOccasion = string.gsub(
    prj_strCustomOccasion,
    "(Randomizer_AutoHintsO?f?f?)=%d-;",
    "%1=" .. val .. ";",
    1
  )
  ser_strBanList = prj_strCustomOccasion

  loadHints()
end

globals.Randomizer.AutoStart = {}
globals.Randomizer.AutoStart._Descriptions = {
  add = "Adds an option and it's value that should be set before the run starts",
  clear = "Clears all AutoStart settings",
  list = "Show all options that are currently set, and their values",
  remove = "Removes an option from being set before the run starts",
  toggle = "Turn on or off AutoStart, while saving all your settings"
}
globals.Randomizer.AutoStart.toggle = function()
  local m = string.match(prj_strCustomOccasion, "Randomizer_AutoStart(O?f?f?)={.-};")
  if m == nil then
    print("No Auto Start options specified")
    return
  end
  if #m == 0 then
    prj_strCustomOccasion = string.gsub(
      prj_strCustomOccasion,
      "Randomizer_AutoStart=({.-});",
      "Randomizer_AutoStartOff=%1;",
      1
    )
    print("Disabled Auto Start")
  else
    prj_strCustomOccasion = string.gsub(
      prj_strCustomOccasion,
      "Randomizer_AutoStartOff=({.-});",
      "Randomizer_AutoStart=%1;",
      1
    )
    print("Enabled Auto Start")
  end
  ser_strBanList = prj_strCustomOccasion
end

globals.Randomizer.AutoStart.list = function()
  local o, m = string.match(prj_strCustomOccasion, "Randomizer_AutoStart(O?f?f?)=({.-});")
  if o == nil or m == nil then
    print("No Auto Start options specified")
    return
  end
  if #o == 0 then
    print("Auto Start is currently on")
  else
    print("Auto Start is currently off")
  end
  print("Selected options:")
  for tal, val in string.gmatch(m, "'(.-)'=(%d+)") do
    print(tal .. ": " .. val)
  end
  print()
end

globals.Randomizer.AutoStart.clear = function()
  prj_strCustomOccasion = string.gsub(
    prj_strCustomOccasion,
    "Randomizer_AutoStartO?f?f?={.-};",
    "",
    1
  )
  ser_strBanList = prj_strCustomOccasion
end

globals.Randomizer.AutoStart.add = function(tal, val)
  if type(tal) ~= "string" or type(val) ~= "number" then
    print("Invalid arguments, expected a string and a number")
    return
  end
  if mthRoundF(val) ~= val or -2147483648 > val or val > 2147483647 then
    print("Invalid number, expected a signed 32-bit integer")
    return
  end
  local m = string.match(prj_strCustomOccasion, "Randomizer_AutoStartO?f?f?={(.-)};")
  if m == nil then
    prj_strCustomOccasion = prj_strCustomOccasion .. "Randomizer_AutoStart={'" .. tal .. "'=" .. val .. "};"
    ser_strBanList = prj_strCustomOccasion
    return
  end
  m = string.gsub(m, "'" .. tal .. "'=%d+,?", "", 1)
  if #m ~= 0 then
    m = m .. ","
  end
  m = m .. "'" .. tal .. "'=" .. val

  prj_strCustomOccasion = string.gsub(
    prj_strCustomOccasion,
    "(Randomizer_AutoStartO?f?f?)={.-};",
    "%1={" .. m .. "};",
    1
  )
  ser_strBanList = prj_strCustomOccasion
end

globals.Randomizer.AutoStart.remove = function(tal)
  if type(tal) ~= "string" then
    print("Invalid argument, expected a string")
    return
  end
  local m = string.match(prj_strCustomOccasion, "Randomizer_AutoStartO?f?f?={(.-)};")
  local new = string.gsub(m, "'" .. tal .. "'=%d+,?", "", 1)

  if new == nil then
    print("String is not currently an Auto Start option")
    return
  end

  if #new == 0 then
    globals.Randomizer.AutoStart.clear()
    return
  end

  prj_strCustomOccasion = string.gsub(
    prj_strCustomOccasion,
    "(Randomizer_AutoStartO?f?f)={.-};",
    "%1={" .. new .. "};",
    1
  )
  ser_strBanList = prj_strCustomOccasion
end

globals.Randomizer.Debug = {}
globals.Randomizer.Debug._Descriptions = {
  off = "Turns debug mode on",
  on = "Turns debug mode on"
}
globals.Randomizer.Debug.on = function()
  if cht_bEnableCheats == 0 then
    print("Cheats must be enabled")
    return
  end
  ctdSetVar("Randomizer_Debug")
  print("Enabled Debug Mode")
end

globals.Randomizer.Debug.off = function()
  if cht_bEnableCheats == 0 then
    print("Cheats must be enabled")
    return
  end
  ctdClearVar("Randomizer_Debug")
  print("Disabled Debug Mode")
end

-- Add all the help functions into the tables

-- Function that actually prints out the help dialog
local function printSubValues(base, name)
  print("Subvalues of '" .. name .. "'")
  for k, v in pairs(base) do
    local output = k .. ": " ..type(v)
    if base._Descriptions ~= nil and base._Descriptions[k] ~= nil then
      output = output .. "  - " .. base._Descriptions[k]
    elseif k == "help" then
      output = output .. "  - Show this message"
    end
    if string.sub(k, 1, 1) ~= "_" then
      print(output)
    end
  end
  print()
end

-- Recursive function to actually add the help function
local function setupHelp(base, prefix)
  prefix = prefix or ""
  for k, sub in pairs(base) do
    if type(sub) == "table" and string.sub(k, 1, 1) ~= "_" then
      local name = prefix .. "." .. k
      sub.help = function()
        printSubValues(sub, name)
      end
      setupHelp(sub, name)
    end
  end
end

setupHelp(globals.Randomizer, "globals.Randomizer")
-- Have to manually add the outermost help function because we don't want to add it to other tables
globals.Randomizer.help = function()
  printSubValues(globals.Randomizer, "globals.Randomizer")
end
