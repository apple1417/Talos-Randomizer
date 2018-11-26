SIGSTRM12GIS             ve�                  Signkey.EditorSignature7]�Wg&��<�`\�*��bg2�_#9����߀�t7M�Jf�Nl��n6����ff/�G&{+�mp|�L��M�^7˪�V��,�نK8S��B���[�.�f�Nm�Uc���B(D@:zn3B����f�� ���;a=K�u#!V#�%���q��`_X �0��J]�D�lq�Jk���o�2�d��w�q�s���l7���#E��W�uv"�$�3�	��N�
��n������x!�蒣�
��:��R\a�̥��9�﻿Wait(CustomEvent("Randomizer_Generated"))

-- I can cut a bunch of stuff from the normal script in this one

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)
local print = worldGlobals.print
local printError = worldGlobals.printError


-- Jetpack
RunAsync(function()
   -- player : CPlayerPuppetEntity
  local player = Wait(Event(worldInfo.PlayerBorn)):GetBornPlayer()
  -- This will probably be expanded
  local jetpack = talosProgress:GetCodeValue("Randomizer_Jetpack")
  if jetpack == 1 then
    player:AddJetpack()
  end
end)


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
    "Randomizer_Seed", "Randomizer_Mode", "Randomizer_Scavenger", "Randomizer_Loop", "Randomizer_Moody",
    "Randomizer_ExtraSeed"
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



-- Random Items
if talosProgress:GetCodeValue("Randomizer_RandItems") ~= 0 then
  RunAsync(function()
    local seed = talosProgress:GetCodeValue("Randomizer_ExtraSeed")
    local world = worldInfo:GetWorldFileName();
    for i = 1, #world do
      seed = seed + string.byte(world, i)
    end
    
    for i=1, #allItems do
      seed = (214013 * seed + 2531011) % 2147483648
      
      local index = 1
      if talosProgress:GetCodeValue("Randomizer_RandItems") == 1 then
        --[[
          Weighting for Balanced mode, based off amounts usually in game:
          Crowbar               1
          Cube                 88
          EnergyRod           145
          FanItem              63
          Jammer               72
          Jetpack               1
          NexusAxe              2
          NexusShield           6
          PaintBucket          99
          Sword                 1
          MessageInABottle01    1
          MessageInABottle02    1
          StatuePartLArm        1
          StatuePartLeftFoot    1
          StatuePartLeftLeg     1
          StatuePartLHand       1
          StatuePartRArm        1
          StatuePartRHand       1
          StatuePartRightFoot   1
          StatuePartRightLeg    1
          StatuePartTorso       1
          StatuePartTorsoBack   1
        ]]--        
        local selected = seed % 490
        if selected >   0 then index = index + 1 end
        if selected >  88 then index = index + 1 end
        if selected > 233 then index = index + 1 end
        if selected > 296 then index = index + 1 end
        if selected > 368 then index = index + 1 end
        if selected > 369 then index = index + 1 end
        if selected > 371 then index = index + 1 end
        if selected > 377 then index = index + 1 end
        if selected > 476 then 
          index = 10 + (selected - 477)
        end
      else
        --[[
          Weighting for "Uniform" mode
          Statue parts and message in a bottle are kind of
           annoyingly common otherwise
          Crowbar              10
          Cube                 10
          EnergyRod            10
          FanItem              10
          Jammer               10
          Jetpack              10
          NexusAxe             10
          NexusShield          10
          PaintBucket          10
          Sword                10
          MessageInABottle01    5
          MessageInABottle02    5
          StatuePartLArm        1
          StatuePartLeftFoot    1
          StatuePartLeftLeg     1
          StatuePartLHand       1
          StatuePartRArm        1
          StatuePartRHand       1
          StatuePartRightFoot   1
          StatuePartRightLeg    1
          StatuePartTorso       1
          StatuePartTorsoBack   1
        ]]--
        local selected = seed % 120
        if selected < 100 then
          index = mthFloorF(selected/10) + 1
        elseif 100 <= selected  and selected < 105 then
          index = 11
        elseif 105 <= selected and selected < 110 then
          index = 12
        elseif 110 <= selected then
          index = 13 + (selected - 110)
        end
      end
      
      -- newItem : CGenericItemEntity
      -- oldItem : CGenericItemEntity
      local newItem = allSpawners[index]:SpawnOne()
      local oldItem = allItems[i]
      
      local OOB = oldItem:GetPlacement()
      OOB.vy = -4000
      
      newItem:SetPlacement(oldItem:GetPlacement())
      oldItem:SetPlacement(OOB)
    end      
  end)
end^oJ��-�j�T��?��ϸ�����qN�u�h>�������zQ'e��W��Vl=^F�a�3��C�x�1S�C�B�	�_Q��hm��Dq,1��@�ǭ�ӎ�B�/T%2@� ,�� :l���9��j�r�{�f%�]���	Rԥ�{��~���8�D��J�����ٚ:% 8��`;��}����q�����yڤB3P�'�os��H�:����!�=���<��ZH���vi�