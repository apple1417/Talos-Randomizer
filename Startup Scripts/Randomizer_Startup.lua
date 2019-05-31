print("Loaded Randomizer_Startup.lua")

-- There's probably a way to automate this but ehh
globals.Randomizer = {
  help = function()
    print("Subvalues of 'globals.Randomizer':")
    for k, v in pairs(globals.Randomizer) do
      print(k .. ": " ..type(v))
    end
    print()
  end,
  AutoStart = {
    help = function()
      print("Subvalues of 'globals.Randomizer.AutoStart'")
      for k, v in pairs(globals.Randomizer.AutoStart) do
        print(k .. ": " ..type(v))
      end
      print()
    end
  },
  Debug = {
    help = function()
      print("Subvalues of 'globals.Randomizer.Debug'")
      for k, v in pairs(globals.Randomizer.Debug) do
        print(k .. ": " ..type(v))
      end
      print()
    end
  }
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
    "(Randomizer_AutoStartO?f?f)={.-};",
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
