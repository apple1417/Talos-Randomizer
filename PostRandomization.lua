SIGSTRM12GIS             �6��                  Signkey.EditorSignature��:+�^���i�<��]��p��A���+���XzGgW"̵z�s�i��p���s7��wȤ��Œ̬e�ҵ������:8l����O� ����Gv�G�>����*��H-u�{��˙�w������$��r8A��t.?�h��*x�x����]�w)��-�Pd�Բ�Y�H��Q�� �/I9⢌��>��w3	j�~���ZP��M
4����_ˎ�����=p���g&p�� ������S�V��T9J2�V﻿Wait(CustomEvent("Randomizer_Generated"))
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



-- Place sigils
if worldInfo:GetWorldFileName() == "Content/Talos/Levels/Randomizer/DeveloperIsland.wld" then
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
    local sigil = worldGlobals.allTetros[sigilNum]
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



--[[
  Move portals to the correct positions
  Nexus can cheat a little so we use another script for that
  Moving portals leaves the base behind, so we have useless ones as our
   markers, which we then get rid of so that animations don't overlap
]]--
if worldInfo:GetWorldFileName() ~= "Content/Talos/Levels/Randomizer/Nexus.wld" then
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
  worldGlobals.portal = allPortals[portalNum]

  local emptyPos = emptyPortal:GetPlacement()
  local portalPos = worldGlobals.portal:GetPlacement()
  emptyPortal:SetPlacement(portalPos)
  worldGlobals.portal:SetPlacement(emptyPos)

  if DEBUG then
    printWarning(string.format("Placing %s at %s", worldGlobals.portal:GetName(),  emptyPortal:GetName()))
  end
end



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
      local sigil = worldGlobals.allTetros[sigilNum]
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

  disableTetros()
  RunHandled(
    WaitForever,
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
end



-- Deal with the mobius mode endings
if talosProgress:GetCodeValue("Randomizer_Loop") ~= 0 and worldInfo:GetWorldFileName() ~= "Content/Talos/Levels/Randomizer/Nexus.wld" then
  local function finished(str)
    if not talosProgress:IsVarSet("Randomizer_LoopDone") then
      worldInfo:ShowMessageToAll("Goal Achived:\n" .. str)
      talosProgress:SetVar("Randomizer_LoopDone")
      talBackupAndSaveTalosProgress(worldInfo)
    end
    local messengerPos = messengerPortal:GetPlacement()
    local portalPos = worldGlobals.portal:GetPlacement()
    messengerPortal:SetPlacement(portalPos)
    worldGlobals.portal:SetPlacement(messengerPos)
    if DEBUG then
      conInfoF("Goal achieved, replacing portal " .. worldGlobals.portal:GetName() .. " with Messenger_Ending_Portal")
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

  local options = {}
  local optionsVal = talosProgress:GetCodeValue("Randomizer_Loop")
  for index=1, 31 do
    options[index] = optionsVal % 2 == 1
    optionsVal = mthFloorF(optionsVal / 2)
  end

  local _, _, worldName = string.find(worldInfo:GetWorldFileName(), "/([^/]-)%.wld")
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
    F0 = worldGlobals.allTetros[talosProgress:GetCodeValue("Secret_28_SRT_SPM_000_PM_004")]
    F3 = worldGlobals.allTetros[talosProgress:GetCodeValue("LeapOfFaith_PM_010")]
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

  RunHandled(
    function()
      WaitForever()
    end,
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
elseif worldInfo:GetWorldFileName() ~= "Content/Talos/Levels/Randomizer/Nexus.wld" then-- If mobius mode is off
  for i=1, #LoopArrangers do
    LoopArrangers[i]:Disappear()
  end
end

-- Send a signal to all other scripts that might error if randomization hasn't finished
Wait(CustomEvent("OnStep"))
SignalEvent("Randomizer_Finished")t�@����֏iр�y�^9+׈'��]$�!'db��F?���E�C_�3�3{�[���a��A겓Y.Q��e���]X,�I3�y�&˦�F�j�c�K��F8o��+Κ<��B�Q,�dv8�-D�kxi?�@4��-��n����4�GW8��;��u)� ��;j�7��qN��fV�z&����i`2�:�7�z�F�����^�-Z`f2�Z���ɲ�����Ա��j�5�@��M���z06�K�s