SIGSTRM12GIS             (��?                  Signkey.EditorSignatureU�����zf�N�&��Ak�����1j--%��.Z�Y��-j��X��3NE�h�7�-S��FG�{X�Z1���Ƣ{���<�4��y��r���#k�>�s9�,醾�͆r�J
=�'�١�Y��?�&������������l�{�LZ2ޘ������%ttu��ע�<̲[�<�D/�p�58�x���l���2�W�<ЛB��ODZ���Fo`u�����O	�%��0}�D#��Y[[7�R;Y��﻿Wait(CustomEvent("Randomizer_Generated"))

--[[
  This script deals with setting up the world after randomization
  This is stuff like moving sigils and portals into position, as
   well as dealing with mobius endings and moody sigil locking
]]--

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local print = worldGlobals.print
local printWarning = worldGlobals.printWarning
local printError = worldGlobals.printError
local DEBUG = talosProgress:IsVarSet("Randomizer_Debug")

--[[
  It's not fun assigning all tetros to this list, so we let other
   scripts use it as well, saving a bunch of work
]]--
worldGlobals.allTetros = {
   s1,  s2,  s3,  s4,  s5,  s6,  s7,  s8,  s9, s10,
  s11, s12, s13, s14, s15, s16, s17, s18, s19, s20,
  s21, s22, s23, s24, s25, s26, s27, s28, s29, s30,
  DI1, DI2,
  DJ1, DJ2, DJ3, DJ4, DJ5,
  DL1, DL2, DL3,
  DT1, DT2, DT3, DT4,
  DZ1, DZ2, DZ3, DZ4,
  EL1, EL2, EL3, EL4,
  EO1,
  ES1, ES2, ES3, ES4,
  MI1,
  MJ1,
  ML1, ML2, ML3, ML4,
  MO1,
  MS1, MS2,
  MT1, MT2, MT3, MT4, MT5, MT6, MT7, MT8, MT9, MT10,
  MZ1, MZ2, MZ3, MZ4,
  NI1, NI2, NI3, NI4, NI5, NI6,
  NJ1, NJ2, NJ3, NJ4,
  NL1, NL2, NL3, NL4, NL5, NL6, NL7, NL8, NL9, NL10,
  NO1, NO2, NO3, NO4, NO5, NO6, NO7,
  NS1, NS2, NS3, NS4,
  NT1, NT2, NT3, NT4, NT5, NT6, NT7, NT8, NT9, NT10, NT11, NT12,
  NZ1, NZ2, NZ3, NZ4, NZ5, NZ6
}
worldGlobals.worldMarkers = worldMarkers
worldGlobals.currentWorld = worldInfo:GetWorldFileName()

local allTetros = worldGlobals.allTetros
local currentWorld = worldGlobals.currentWorld

--[[
  Send a signal to all other scripts that might error if randomization
   hasn't finished or those worldGlobals values haven't been assigned
]]--
SignalEvent("Randomizer_Finished")

-- Checksum
RunAsync(function()
  local allMarkers = {
    "001_SPM_000_PM_005", "001a_SPM_000_PM_008", "005_SPM_000_PM_009", "006_SPM_000_PM_003",
    "007_SPM_000_PM_006", "008_SPM_000_PM_016", "011_SPM_000_PM_009", "012_SPM_000_PM_004",
    "013_SPM_000_PM_006", "015_SRT_SPM_000_PM_017", "015_SRT_SPM_000_PM_018", "017_SPM_000_PM_023",
    "020_SPM_000_PM_014", "107_SPM_000_PM_007", "108_SPM_000_PM_012", "111_SPM_000_PM_012",
    "112_SPM_000_PM_034", "113_SPM_000_PM_036", "114_SPM_000_PM_032", "115_SRT_TAM_004_PM_016",
    "117_SRT_SPM_000_PM_028", "118_SPM_000_PM_062", "119_SRT_SPM_000_PM_033", "120_SPM_000_PM_029",
    "201_SPM_000_PM_013", "201_SRT_SPM_000_PM_004", "202b_SPM_000_PM_004", "202c_SPM_000_PM_003",
    "202d_SPM_000_PM_002", "202e_SPM_000_PM_004", "202f_SPM_000_PM_003", "203_SPM_000_PM_011",
    "204_SPM_000_PM_004", "205_SPM_000_PM_003", "206_SPM_000_PM_021", "207_SPM_000_PM_005",
    "208_SPM_000_PM_014", "209_SPM_000_PM_012", "210_SPM_000_PM_015", "211_SPM_000_PM_008",
    "212_SPM_000_PM_017", "213_SPM_000_PM_010", "214_SRT_SPM_000_PM_025", "215_SPM_000_PM_013",
    "216_SPM_000_PM_015", "217_SPM_000_PM_040", "218_SPM_000_PM_016", "219_SPM_000_PM_008",
    "220_SPM_000_PM_032", "221_SPM_002_PM_001", "222_SPM_004_PM_001", "223_SPM_000_PM_009",
    "224_SRT_SPM_000_PM_071", "224_SRT_SPM_000_PM_091", "225_SPM_000_PM_044", "226_SPM_000_PM_039",
    "227_SPM_002_PM_033", "229_SPM_000_PM_070", "230_SPM_000_PM_019", "232_SPM_000_PM_012",
    "233_SPM_000_PM_015", "234_SPM_000_PM_015", "235_SRT_SPM_000_PM_037", "238_SPM_000_PM_018",
    "239_SPM_000_PM_018", "244_SPM_000_PM_008", "244_SRT_SPM_000_PM_006", "300a_SPM_000_PM_007",
    "301_SPM_000_PM_010", "302_SPM_000_PM_008", "303_SPM_000_PM_010", "305_SPM_000_PM_004",
    "306_SRT_SPM_000_PM_016", "308_SPM_000_PM_017", "309_SPM_000_PM_018", "310_SPM_000_PM_024",
    "311_SPM_000_PM_041", "312_SPM_000_PM_032", "313_SPM_000_PM_016", "314_SPM_000_PM_012",
    "315_TAM_002_PM_001", "316_SPM_000_PM_014", "317_SPM_000_PM_024", "318_SPM_000_PM_026",
    "319_SPM_000_PM_008", "320_SRT_SPM_000_PM_046", "321_SPM_000_PM_005", "322_SPM_000_PM_008",
    "328_SPM_000_PM_016", "401_SPM_004_PM_008", "402_SPM_000_PM_020", "403_SPM_000_PM_015",
    "404_SPM_000_PM_022", "405_SRT_SPM_000_PM_047", "405_SRT_SPM_000_PM_050", "407_SPM_000_PM_018",
    "408_SPM_000_PM_033", "408_SRT_SPM_000_PM_034", "409_SPM_000_PM_024", "411_SRT_SPM_000_PM_014",
    "414_SPM_000_PM_007", "416_SPM_000_PM_026", "417_SPM_000_PM_029", "418_SPM_000_PM_014",
    "504_SRT_SPM_000_PM_021", "Cloud_1_02_SRT_SPM_000_PM_016", "Cloud_1_02_SRT_SPM_001_PM_003", "Cloud_1_03_SRT_SPM_000_PM_005",
    "Cloud_1_04_SRT_SPM_000_PM_007", "Cloud_1_06_SRT_SPM_000_PM_007", "Cloud_1_07_SRT_SPM_000_PM_021", "Cloud_2_01_SRT_SPM_000_PM_004",
    "Cloud_2_02_SRT_SPM_000_PM_039", "Cloud_2_03_SRT_SPM_002_PM_013", "Cloud_2_04_SRT_SPM_000_PM_017", "Cloud_2_04_SRT_SPM_002_PM_002",
    "Cloud_2_05_SRT_TAM_003_PM_003", "Cloud_2_07_SRT_TAM_001_PM_004", "Cloud_3_01_SRT_SPM_000_PM_017", "Cloud_3_02_SRT_TAM_001",
    "Cloud_3_03_SRT_SPM_000_PM_069", "Cloud_3_05_SRT_SPM_000_PM_035", "Cloud_3_05_SRT_SPM_002_PM_016", "Cloud_3_05_SRT_SPM_003_PM_012",
    "Cloud_3_06_SRT_SPM_000_PM_008", "Cloud_3_07_SRT_SPM_000_PM_021", "Islands_01_SRT_SPM_000_PM_003", "LeapOfFaith_PM_010",
    "Secret_28_SRT_SPM_000_PM_004",
    "PaintItemSeed", "Code_Floor4", "Code_Floor5", "Code_Floor6",
    "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "ADevIsland",
    "B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8",
    "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "CMessenger",
    "Randomizer_Seed", "Randomizer_Mode", "Randomizer_Scavenger", "Randomizer_Loop", "Randomizer_Moody"
  }
  
  --[[
    Fletcher Checksum
    Uses all values in the list above
    Not really that useful anymore, but helped worked out when people
     were getting different things on the same seed
  ]]--
  local sum1 = 0
  local sum2 = 0
  for index=1, #allMarkers do
    local value = talosProgress:GetCodeValue(allMarkers[index])
    if value == -1 then
      printError("'" .. allMarkers[index] .. "' does not have a value assigned to it\n")
    end
    sum1 = (sum1 + value*index) % 65536
    sum2 = (sum2 + sum1) % 65536
  end
  local checksum = sum1 * 65536 + sum2
  
  -- Get printable versions of other vars that affect sigil arrangement
  local seed = talosProgress:GetCodeValue("Randomizer_Seed")
  local modeList = {"None", "Default", "60fps", "Fully Random", "Intended", "Hardmode", "60FPS Hardmode"}
  local mode = modeList[talosProgress:GetCodeValue("Randomizer_Mode") + 1]
  local portals = "Disabled"
  if talosProgress:IsVarSet("Randomizer_Portals") then
    portals = "Enabled"
  end
  local scavengerList = {"Disabled", "Short", "Full"}
  local scavenger = scavengerList[talosProgress:GetCodeValue("Randomizer_Scavenger") + 1]
  local loop = "Disabled"
  local loopVar = talosProgress:GetCodeValue("Randomizer_Loop")
  if loopVar ~= 0 then
    loop =  string.format("%02X", loopVar)
  end
  
  
  print("")
  print("Seed: " .. seed)
  print("Mode: " .. mode)
  print("Random Portals: " .. portals)
  print("Scavenger Hunt: " .. scavenger)
  print("Möbius Mode: ".. loop)
  print(string.format("Checksum: %08X", checksum))
  print("")
end)

-- Jetpack
RunAsync(function()
   -- player : CPlayerPuppetEntity
  local player = Wait(Event(worldInfo.PlayerBorn)):GetBornPlayer()
  if currentWorld ~= "Content/Talos/Levels/Randomizer/Nexus.wld" then
    -- This will probably be expanded
    local jetpack = talosProgress:GetCodeValue("Randomizer_Jetpack")
    if jetpack == 1 then
      player:AddJetpack()
    end
  end
end)



-- Place sigils
RunAsync(function()
  if currentWorld == "Content/Talos/Levels/Randomizer/DeveloperIsland.wld" then
    talosProgress:SetVar("DevIslandVisited")
  else
    local acceptableSigils = false
    if talosProgress:GetCodeValue("Randomizer_Scavenger") ~= 0 then
      local sModes = {"Connector Clip", "F2 Clip", "F3 Clip", "F1+F6"}
      local scavengerMode =  sModes[talosProgress:GetCodeValue("Randomizer_ScavengerMode")]
      if scavengerMode == "Connector Clip" then
        acceptableSigils = {["ML1"] = true, ["MT1"] = true, ["MT2"] = true,
                            ["NL1"] = true, ["NL2"] = true, ["NZ1"] = true, ["NZ2"] = true}
      elseif scavengerMode == "F2 Clip" then
        acceptableSigils = {["ML2"] = true, ["MT3"] = true, ["MT4"] = true, ["MZ1"] = true,
                            ["NL1"] = true, ["NL2"] = true, ["NZ1"] = true, ["NZ2"] = true,
                            ["NL3"] = true, ["NL4"] = true, ["NL5"] = true, ["NL6"] = true, ["NO1"] = true, ["NT1"] = true, ["NT2"] = true, ["NT3"] = true, ["NT4"] = true}
      elseif scavengerMode == "F3 Clip" then
        acceptableSigils = {["NL1"] = true, ["NL2"] = true, ["NZ1"] = true, ["NZ2"] = true,
                            ["NI1"] = true, ["NI2"] = true, ["NI3"] = true, ["NI4"] = true, ["NJ1"] = true, ["NJ2"] = true, ["NL7"] = true, ["NL8"] = true, ["NS1"] = true, ["NZ3"] = true}
      elseif scavengerMode == "F1+F6" then
        acceptableSigils = {["NL1"] = true, ["NL2"] = true, ["NZ1"] = true, ["NZ2"] = true,
                            ["EL1"] = true, ["EL2"] = true, ["EL3"] = true, ["EL4"] = true, ["EO1"] = true, ["ES1"] = true, ["ES2"] = true, ["ES3"] = true, ["ES4"] = true}
      end
      -- In the intended mode we also accept A1 gate
      if talosProgress:GetCodeValue("Randomizer_Mode") == 4 then
        acceptableSigils["DJ1"] = true
        acceptableSigils["DJ2"] = true
        acceptableSigils["DZ1"] = true
      end
    end
    -- Move sigils to the correct positions
    for i=1, #worldMarkers do
      local worldMarker = worldMarkers[i]
      local sigilNum = talosProgress:GetCodeValue(worldMarker:GetName())
      local sigil = allTetros[sigilNum]
      assert(sigil ~= nil, "Marker " .. worldMarker:GetName() .. " does not have a sigil assigned to it!")
      -- For scavenger hunt, decide if to actually move the sigils
      if not acceptableSigils or acceptableSigils[sigil:GetName()] then
        sigil:SetPlacement(worldMarker:GetPlacement())
        if DEBUG then
          printWarning(string.format("Moving %s to %s", sigil:GetName(), worldMarker:GetName()))
        end
      end
    end
  end
end)



--[[
  Move portals to the correct positions
  Nexus can cheat a little so we use another script for that
  Moving portals leaves the base behind, so we have useless ones as our
   markers, which we then get rid of so that animations don't overlap
]]--
-- portal : CPhaseInPortalEntity
local portal = nil
RunAsync(function()
  if currentWorld ~= "Content/Talos/Levels/Randomizer/Nexus.wld" then
    local allPortals = {
      A1, A2, A3, A4, A5, A6, A7, A8, ADevIsland,
      B1, B2, B3, B4, B5, B6, B7, B8,
      C1, C2, C3, C4, C5, C6, C7, C8, CMessenger,
      A1_I, A2_I, A3_I, A4_I, A5_I, A6_I, A7_I, A8_I, ADevIsland_I,
      B1_I, B2_I, B3_I, B4_I, B5_I, B6_I, B7_I, B8_I,
      C1_I, C2_I, C3_I, C4_I, C5_I, C6_I, C7_I, C8_I, CMessenger_I
    }
  
    local portalNum = talosProgress:GetCodeValue(emptyPortal:GetName())
    assert(portalNum > 0, "Portal " .. emptyPortal:GetName() .. " does not have a location assigned to it!")
    if talosProgress:GetCodeValue("Randomizer_Loop") ~= 0 then
      portalNum = portalNum + 26
    end
    portal = allPortals[portalNum]
  
    local emptyPos = emptyPortal:GetPlacement()
    local portalPos = portal:GetPlacement()
    emptyPortal:SetPlacement(portalPos)
    portal:SetPlacement(emptyPos)
  
    if DEBUG then
      printWarning(string.format("Placing %s at %s", portal:GetName(),  emptyPortal:GetName()))
    end
  end
end)



-- Make sure the correct sigils are uncollectable for moody
if talosProgress:GetCodeValue("Randomizer_Moody") ~= 0 then
  local colours = {
    ["*"] = 1,
    ["D"] = 2,
    ["E"] = 3,
    ["M"] = 4,
    ["N"] = 5
  }
  local shapes = {
    ["*"] = 1,
    ["I"] = 2,
    ["J"] = 3,
    ["L"] = 4,
    ["O"] = 5,
    ["S"] = 6,
    ["T"] = 7,
    ["Z"] = 8,
  }
  
  local checkColour = talosProgress:GetCodeValue("Randomizer_Moody") % 2 == 1
  local checkShape = talosProgress:GetCodeValue("Randomizer_Moody") > 1
  
  local function disableTetros()
    for i=1,#worldMarkers do
      local sigilNum = talosProgress:GetCodeValue(worldMarkers[i]:GetName())
      local sigil = allTetros[sigilNum]
      local sigilColour = colours[string.sub(sigil:GetName(), 1, 1)]
      local sigilShape = shapes[string.sub(sigil:GetName(), 2, 2)]
  
      if checkColour and sigilColour == talosProgress:GetCodeValue("Randomizer_MoodyColour") then
        sigil:DisablePicking()
      elseif checkShape and sigilShape == talosProgress:GetCodeValue("Randomizer_MoodyShape") then
        sigil:DisablePicking()
      else
        sigil:EnablePicking()
      end
    end
  end

  RunAsync(function()  
    disableTetros()
    RunHandled(WaitForever,
      OnEvery(CustomEvent("TetrominoAwarded")),
      -- event : CTetrominoAwardedScriptEvent
      function(event)
        local sigil = event:GetTetromino()
        talosProgress:SetVarValue("Randomizer_MoodyColour", colours[string.sub(sigil, 1, 1)])
        talosProgress:SetVarValue("Randomizer_MoodyShape", shapes[string.sub(sigil, 2, 2)])
        talBackupAndSaveTalosProgress(worldInfo)
        disableTetros()
      end
    )
  end)
end



-- Deal with the mobius mode endings
local LOOP_ARRANGER_HIDE_PERCENT = 40
if talosProgress:GetCodeValue("Randomizer_Loop") ~= 0 and currentWorld ~= "Content/Talos/Levels/Randomizer/Nexus.wld" then
  local function finished(str)
    if not talosProgress:IsVarSet("Randomizer_LoopDone") then
      worldInfo:ShowMessageToAll("Goal Achived:\n" .. str)
      talosProgress:SetVar("Randomizer_LoopDone")
      talBackupAndSaveTalosProgress(worldInfo)
    end
    local messengerPos = messengerPortal:GetPlacement()
    local portalPos = portal:GetPlacement()
    messengerPortal:SetPlacement(portalPos)
    portal:SetPlacement(messengerPos)
    if DEBUG then
      print("Goal achieved, replacing portal " .. portal:GetName() .. " with Messenger_Ending_Portal")
    end
  end
  if talosProgress:IsVarSet("Randomizer_LoopDone") then
    finished()
  end

  local seed = talosProgress:GetCodeValue("Randomizer_LoopSeed")
  local function loopHideArranger()
    seed = (214013 * seed + 2531011) % 2147483648
    return (seed % 100) < LOOP_ARRANGER_HIDE_PERCENT
  end
  
  RunAsync(function()
    local options = {}
    local optionsVal = talosProgress:GetCodeValue("Randomizer_Loop")
    for index=1, 31 do
      options[index] = optionsVal % 2 == 1
      optionsVal = mthFloorF(optionsVal / 2)
    end
  
    local _, _, worldName = string.find(currentWorld, "/([^/]-)%.wld")
    local worldIndexes = {
      ["Cloud_1_01"] =  1, ["Cloud_1_02"] =  3, ["Cloud_1_03"] =  5, ["Cloud_1_04"] =  7,
      ["Cloud_1_05"] =  9, ["Cloud_1_06"] = 11, ["Cloud_1_07"] = 13, ["Cloud_1_08"] = 15,
      ["Cloud_2_01"] = 17, ["Cloud_2_02"] = 19, ["Cloud_2_03"] = 21, ["Cloud_2_04"] = 23,
      ["Cloud_2_05"] = 25, ["Cloud_2_06"] = 27, ["Cloud_2_07"] = 29, ["Cloud_2_08"] = 31,
      ["Cloud_3_01"] = 33, ["Cloud_3_02"] = 35, ["Cloud_3_03"] = 37, ["Cloud_3_04"] = 39,
      ["Cloud_3_05"] = 41, ["Cloud_3_06"] = 43, ["Cloud_3_07"] = 45, ["Cloud_3_08"] = 47,
      ["Islands_01"] = 49, ["DeveloperIsland"] = -1
    }
    local world = worldIndexes[worldName]
    local F0Pos = talosProgress:GetCodeValue("Randomizer_LoopF0")
    local F3Pos = talosProgress:GetCodeValue("Randomizer_LoopF3")
    local F0 = nil
    local F3 = nil
    if worldName ~= "DeveloperIsland" then
      F0 = allTetros[talosProgress:GetCodeValue("Secret_28_SRT_SPM_000_PM_004")]
      F3 = allTetros[talosProgress:GetCodeValue("LeapOfFaith_PM_010")]
      if F0Pos == world or talosProgress:IsVarSet("Randomizer_LoopShowAll") then
        F0:SetPlacement(LoopMarkers[1]:GetPlacement())
        if DEBUG then
          printWarning(string.format("Moving %s to LoopMarker1", F0:GetName()))
        end
      elseif F0Pos == world + 1 then
        F0:SetPlacement(LoopMarkers[2]:GetPlacement())
        if DEBUG then
          printWarning(string.format("Moving %s to LoopMarker2", F0:GetName()))
        end
      end
      if F3Pos == world + 1 or talosProgress:IsVarSet("Randomizer_LoopShowAll") then
        F3:SetPlacement(LoopMarkers[2]:GetPlacement())
        if DEBUG then
          printWarning(string.format("Moving %s to LoopMarker2", F3:GetName()))
        end
      elseif F3Pos == world then
        F3:SetPlacement(LoopMarkers[1]:GetPlacement())
        if DEBUG then
          printWarning(string.format("Moving %s to LoopMarker1", F3:GetName()))
        end
      end
    end
  
    for _=1, world*5 do
      loopHideArranger()
    end
    for i=1, #LoopArrangers do
      if loopHideArranger() and not talosProgress:IsVarSet("Randomizer_LoopShowAll") and worldName ~= "DeveloperIsland" then
        if DEBUG then
          print("Hiding Arranger: " .. LoopArrangers[i]:GetName())
        end
        LoopArrangers[i]:Disappear()
      end
    end
  
    -- Setup the requirements for Random Arrangers, don't need to do it every time we get a sigil
    local allSigilCounts = {
    -- DI DJ DL DT DZ  EL EO ES  MI MJ ML MO MS MT MZ  NI NJ NL NO NS NT NZ
      {0, 2, 0, 0, 1,  0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0}, -- A1 Gate
      {1, 1, 1, 0, 1,  0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0}, -- A Gate
      {1, 0, 1, 2, 1,  0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0}, -- B Gate
      {0, 2, 1, 2, 1,  0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0}, -- C Gate
  
      {0, 0, 0, 0, 0,  0, 0, 0,  0, 0, 1, 0, 0, 2, 0,  0, 0, 0, 0, 0, 0, 0}, -- Connector
      {0, 0, 0, 0, 0,  0, 0, 0,  0, 0, 1, 0, 0, 2, 1,  0, 0, 0, 0, 0, 0, 0}, -- Cube
      {0, 0, 0, 0, 0,  0, 0, 0,  0, 0, 1, 0, 1, 2, 1,  0, 0, 0, 0, 0, 0, 0}, -- Fan
      {0, 0, 0, 0, 0,  0, 0, 0,  0, 1, 0, 0, 1, 2, 1,  0, 0, 0, 0, 0, 0, 0}, -- Recorder
      {0, 0, 0, 0, 0,  0, 0, 0,  1, 0, 1, 1, 0, 2, 1,  0, 0, 0, 0, 0, 0, 0}, -- Platform
  
      {0, 0, 0, 0, 0,  0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  0, 0, 2, 0, 0, 0, 2}, -- F1
      {0, 0, 0, 0, 0,  0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  0, 0, 4, 1, 0, 4, 0}, -- F2
      {0, 0, 0, 0, 0,  0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  4, 2, 2, 0, 1, 0, 1}, -- F3
      {0, 0, 0, 0, 0,  0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  0, 1, 1, 2, 2, 4, 2}, -- F4
      {0, 0, 0, 0, 0,  0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  2, 1, 1, 4, 1, 4, 1}, -- F5
  
      {0, 0, 0, 0, 0,  4, 1, 4,  0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0}, -- F6
  
      ["key"] = {"DI", "DJ", "DL", "DT", "DZ", "EL", "EO", "ES", "MI", "MJ", "ML",
                 "MO", "MS", "MT", "MZ", "NI", "NJ", "NL", "NO", "NS", "NT", "NZ"}
    }
    local neededArrangerSigils = {0, 0, 0, 0, 0,  0, 0, 0,  0, 0, 0, 0, 0, 0, 0,  0, 0, 0, 0, 0, 0, 0}
    if options[6] then
      local arrangers = talosProgress:GetCodeValue("Randomizer_LoopArrangers")
      for i=1, #allSigilCounts do
        if arrangers % 2 == 1 then
          for j=1, #neededArrangerSigils do
            neededArrangerSigils[j] = neededArrangerSigils[j] + allSigilCounts[i][j]
          end
        end
        arrangers = mthFloorF(arrangers / 2)
      end
    end
    RunHandled(WaitForever,
      OnEvery(CustomEvent("TetrominoAwarded")),
      function()
        local collected = talosProgress:GetInventoryTetrominoes()..talosProgress:GetUsedupTetrominoes()
    
        if talosProgress:GetCodeValue("Randomizer_Scavenger") ~= 0 then
          local sModes = {"Connector Clip", "F2 Clip", "F3 Clip", "F1+F6"}
          local scavengerMode =  sModes[talosProgress:GetCodeValue("Randomizer_ScavengerMode")]
          local acceptableSigils = {}
          if scavengerMode == "Connector Clip" then
            acceptableSigils = {"ML1;", "MT1;", "MT2;",
                                "NL1;", "NL2;", "NZ1;", "NZ2;"}
          elseif scavengerMode == "F2 Clip" then
            acceptableSigils = {"ML2;", "MT3;", "MT4;", "MZ1;",
                                "NL1;", "NL2;", "NZ1;", "NZ2;",
                                "NL3;", "NL4;", "NL5;", "NL6;", "NO1;", "NT1;", "NT2;", "NT3;", "NT4;"}
          elseif scavengerMode == "F3 Clip" then
            acceptableSigils = {"NL1;", "NL2;", "NZ1;", "NZ2;",
                                "NI1;", "NI2;", "NI3;", "NI4;", "NJ1;", "NJ2;", "NL7;", "NL8;", "NS1;", "NZ3;"}
          elseif scavengerMode == "F1+F6" then
            acceptableSigils = {"NL1;", "NL2;", "NZ1;", "NZ2;",
                                "EL1;", "EL2;", "EL3;", "EL4;", "EO1;", "ES1;", "ES2;", "ES3;", "ES4;"}
          end
          -- In the intended mode we also accept A1 gate
          if talosProgress:GetCodeValue("Randomizer_Mode") == 4 then
            table.insert(acceptableSigils, "DJ1;")
            table.insert(acceptableSigils, "DJ2;")
            table.insert(acceptableSigils, "DZ1;")
          end
          local allScavenger = true
          for i=1, #acceptableSigils do
            local _, count = string.gsub(collected, acceptableSigils[i], "")
            if count == 0 then
              allScavenger = false
            end
          end
          if allScavenger then
            finished("Finished Scavenger Hunt")
          end
        end
    
        if options[1] then
          local _, sigilCount = string.gsub(collected, "[DMNE%*][IJLOSTZ%*]%d+;", "")
          if sigilCount == 129 then
            finished("Collected All Sigils")
          end
        end
    
        if options[2] then
          local _, count = string.gsub(collected, "[DMNE%*]I%d+;", "")
          if count >= 9 then
            finished("Collected All 'I' Sigils")
          end
          local _, count = string.gsub(collected, "[DMNE%*]J%d+;", "")
          if count >= 10 then
            finished("Collected All 'J' Sigils")
          end
          local _, count = string.gsub(collected, "[DMNE%*]L%d+;", "")
          if count >= 21 then
            finished("Collected All 'L' Sigils")
          end
          local _, count = string.gsub(collected, "[DMNE%*]O%d+;", "")
          if count >= 9 then
            finished("Collected All 'O' Sigils")
          end
          local _, count = string.gsub(collected, "[DMNE%*]S%d+;", "")
          if count >= 10 then
            finished("Collected All 'S' Sigils")
          end
          local _, count = string.gsub(collected, "[DMNE%*]T%d+;", "")
          if count >= 26 then
            finished("Collected All 'T' Sigils")
          end
          local _, count = string.gsub(collected, "[DMNE%*]Z%d+;", "")
          if count >= 14 then
            finished("Collected All 'Z' Sigils")
          end
          local _, count = string.gsub(collected, "[DMNE%*]%*%d+;", "")
          if count >= 30 then
            finished("Collected All Stars")
          end
        end
    
        if options[3] then
          local _, count = string.gsub(collected, "D[IJLOSTZ%*]%d+;", "")
          if count >= 18 then
            finished("Collected All Green Sigils")
          end
          local _, count = string.gsub(collected, "M[IJLOSTZ%*]%d+;", "")
          if count >= 23 then
            finished("Collected All Yellow Sigils")
          end
          local _, count = string.gsub(collected, "N[IJLOSTZ%*]%d+;", "")
          if count >= 49 then
            finished("Collected All Red Sigils")
          end
          local _, count = string.gsub(collected, "E[IJLOSTZ%*]%d+;", "")
          if count >= 9 then
            finished("Collected All Grey Sigils")
          end
          local _, count = string.gsub(collected, "%*[IJLOSTZ%*]%d+;", "")
          if count >= 30 then
            finished("Collected All Stars")
          end
        end
    
        if options[4] then
          local _, count = string.gsub(collected, "[DMN][IJLOSTZ]%d+;", "")
          if count >= 90 then
            finished("Unlocked Eternalize Ending")
          end
        end
    
        if options[5] then
          local totals = {["I"] = 0, ["J"] = 0, ["L"] = 0, ["O"] = 0, ["S"] = 0, ["T"] = 0, ["Z"] = 0}
          for shape, _ in pairs(totals) do
            local _, count = string.gsub(collected, "N" .. shape .. "%d+;", "")
            totals[shape] = totals[shape] + count
          end
          local _, greys = string.gsub(collected, "E[IJLOSTZ%*]%d+;", "")
    
          local floorCount = {
            {["I"] = 0, ["J"] = 0, ["L"] = 2, ["O"] = 0, ["S"] = 0, ["T"] = 0, ["Z"] = 2},
            {["I"] = 0, ["J"] = 0, ["L"] = 4, ["O"] = 1, ["S"] = 0, ["T"] = 4, ["Z"] = 0},
            {["I"] = 4, ["J"] = 2, ["L"] = 2, ["O"] = 0, ["S"] = 1, ["T"] = 0, ["Z"] = 1},
            {["I"] = 0, ["J"] = 1, ["L"] = 1, ["O"] = 2, ["S"] = 2, ["T"] = 4, ["Z"] = 2},
            {["I"] = 2, ["J"] = 1, ["L"] = 1, ["O"] = 4, ["S"] = 1, ["T"] = 4, ["Z"] = 1}
          }
          for i=1, #floorCount do
            for j=i+1, #floorCount + 1 do
              -- Need a copy of floorCount[i] rather than a reference
              local requirements = {}
              for k, v in pairs(floorCount[i]) do
                requirements[k] = v
              end
    
              if j <= #floorCount then
                for shape, amount in pairs(floorCount[j]) do
                  requirements[shape] = requirements[shape] + amount
                end
              end
    
              local complete = true
              for shape, _ in pairs(totals) do
                if totals[shape] < requirements[shape] then
                  complete = false
                  break
                end
              end
              if j == #floorCount + 1 then
                complete = complete and greys >= 9
              end
    
              if complete then
                finished("Collected all sigils for F" .. i .. " & F" .. j)
              end
            end
          end
        end
    
        if options[6] then
          local collectedAll = true
          for index=1, #allSigilCounts.key do
            local pattern = allSigilCounts.key[index] .. "%d+;"
            local _, count = string.gsub(collected, pattern, "")
            if count < neededArrangerSigils[index] then
              collectedAll = false
              break
            end
          end
          if collectedAll then
            finished("Completed all Random Arrangers")
          end
        end
      end
    )
  end)
elseif currentWorld ~= "Content/Talos/Levels/Randomizer/Nexus.wld" then-- If mobius mode is off
  for i=1, #LoopArrangers do
    LoopArrangers[i]:Disappear()
  end
end��T�Q� ��徭\i~��lv2�h��Y�V��z��#�Q�x���ȉ~���QsK<c���,�d$�p���b�O��R���n>��I,����CW)b�v�<w*q� L:es嵓n��wjC�=2>�8�VtK��h5��SlZ���j�6xG	�q���F"{�ܕ����/�i7�ܭ�;O�2�~�2�NX�1.|���[�C�.$�8�&}���f$+@�ۋ]5k��f��,#j;Ӎ��'^B�C�)o�3�S��ݘc