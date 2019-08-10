print("Loaded Randomizer_Startup.lua")

globals.Randomizer = {}

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

globals.Randomizer.AutoHints = {}
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
end

globals.Randomizer.AutoHints.list = function()
  local o, m = string.match(prj_strCustomOccasion, "Randomizer_AutoHints(O?f?f?)=(%d-);")
  if o == nil or m == nil then
    print("No Auto Hints options specified")
    return
  end
  if #o == 0 then
    print("Auto Hints are currently on")
  else
    print("Auto Hints are currently off")
  end
  print("Selected hints:")
  local hintsVal = tonumber(m)
  for i = 1, #allHints do
    if hintsVal % 2 == 1 then
      print(allHints[i].name)
    end
    hintsVal = mthFloorF(hintsVal / 2)
  end
  print()
end

globals.Randomizer.AutoHints.clear = function()
  prj_strCustomOccasion = string.gsub(
    prj_strCustomOccasion,
    "Randomizer_AutoHintsO?f?f?=%d-;",
    "",
    1
  )
end

local function adjustHint(arranger, add)
  if type(arranger) ~= "string"then
    print("Invalid argument, expected a string")
    return
  end

  -- Process the input a bit to allow multiple input forms
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

  local selectedHint = nil
  for _, hint in pairs(allHints) do
    if hint.code == arranger then
      selectedHint = hint
      break
    end
  end
  if selectedHint == nil then
    print("Unrecognised Hint")
    print("Valid Values: 'A1G', 'AG', 'BG', 'CG', 'C', 'H', 'F', 'R', 'P', 'F1', 'F2', 'F3', 'F4', 'F5', 'F6'")
    return
  end

  local hintsVal = string.match(prj_strCustomOccasion, "Randomizer_AutoHintsO?f?f?=(%d-);")
  if hintsVal == nil then
    prj_strCustomOccasion = prj_strCustomOccasion .. "Randomizer_AutoHints=" .. mthPow2F(selectedHint.offset) .. ";"
    return
  else
    hintsVal = tonumber(hintsVal)
  end

  local offsetVal = mthPow2F(selectedHint.offset)
  if hintsVal/offsetVal % 2 == 1 and add then
    print("Hint has already been added")
    return
  elseif (hintsVal < offsetVal or hintsVal/offsetVal % 2 == 0) and not add then
    print("Hint has already been removed")
    return
  end

  if add then
    hintsVal = hintsVal + mthPow2F(selectedHint.offset)
  else
    hintsVal = hintsVal - mthPow2F(selectedHint.offset)
  end

  prj_strCustomOccasion = string.gsub(
    prj_strCustomOccasion,
    "(Randomizer_AutoHintsO?f?f?)=%d-;",
    "%1=" .. hintsVal .. ";",
    1
  )
end

globals.Randomizer.AutoHints.add = function(arranger)
  adjustHint(arranger, true)
end

globals.Randomizer.AutoHints.remove = function(arranger)
  adjustHint(arranger, false)
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
    return
  end

  prj_strCustomOccasion = string.gsub(
    prj_strCustomOccasion,
    "(Randomizer_AutoHintsO?f?f?)=%d-;",
    "%1=" .. val .. ";",
    1
  )
end

globals.Randomizer.AutoStart = {}
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
end

globals.Randomizer.Debug = {}
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
    print(k .. ": " ..type(v))
  end
  print()
end

-- Recursive function to actually add the help function
local function setupHelp(base, prefix)
  prefix = prefix or ""
  for k, sub in pairs(base) do
    if type(sub) == "table" then
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
