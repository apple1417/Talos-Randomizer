SIGSTRM12GIS             Ͽ�                  Signkey.EditorSignature	�0:K�A�OE�߫*#|U�p�O��]{)��y�&��������(V��O��2U����HK��c�O��7��<Q	�N���m<�pKܰZ�g�lғ��4a�i6k����*��hz�!}�_��kg�r�ӷ�Ta�$6�T���R���yu
��V&Ϡf�s�ωd����w4#npV?1[A���EM��3�8�=[�\�3瞎[����^QlGRR@��l&�[u L�6Jv�,Iv�X<"8>W1��u>��Y@Vyl﻿local function randomFromTable(table)
  return table[mthRndRangeL(0, #table)]
end

local function randomChance(chance)
  return mthRndF() <= chance
end

local function tableIndex(table, value)
  for _, v in pairs(table) do
    if v == value then
      return index
    end
  end
end

local function inTable(table, value)
  for _, v in pairs(table) do
    if v == value then
      return true
    end
  end
end

local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)

local sigilsA = {"005_SPM_000_PM_009", "107_SPM_000_PM_007", "006_SPM_000_PM_003", "011_SPM_000_PM_009", "007_SPM_000_PM_006", "012_SPM_000_PM_004", "001_SPM_000_PM_005", "Cloud_1_02_SRT_SPM_000_PM_016",
                 "008_SPM_000_PM_016", "001a_SPM_000_PM_008", "013_SPM_000_PM_006", "Cloud_1_02_SRT_SPM_001_PM_003",
                 "108_SPM_000_PM_012", "015_SRT_SPM_000_PM_018", "015_SRT_SPM_000_PM_017", "020_SPM_000_PM_014", "017_SPM_000_PM_023", "Cloud_1_03_SRT_SPM_000_PM_005",
                 "202c_SPM_000_PM_003", "202f_SPM_000_PM_003", "202b_SPM_000_PM_004", "Cloud_1_04_SRT_SPM_000_PM_007", "202d_SPM_000_PM_002",
                 "201_SPM_000_PM_013", "201_SRT_SPM_000_PM_004", "204_SPM_000_PM_004", "202e_SPM_000_PM_004", "207_SPM_000_PM_005", "244_SPM_000_PM_008",
                 "111_SPM_000_PM_012", "210_SPM_000_PM_015", "218_SPM_000_PM_016", "303_SPM_000_PM_010", "Cloud_1_06_SRT_SPM_000_PM_007",
                 "212_SPM_000_PM_017", "305_SPM_000_PM_004", "209_SPM_000_PM_012", "Cloud_1_07_SRT_SPM_000_PM_021", "202_SPM_000_PM_032", "211_SPM_000_PM_008"}
local sigilsB = {"203_SPM_000_PM_011", "302_SPM_000_PM_008", "316_SPM_000_PM_012", "319_SPM_000_PM_008", "205_SPM_000_PM_003", "Cloud_2_01_SRT_SPM_000_PM_004",
                 "213_SPM_000_PM_010", "Cloud_2_02_SRT_SPM_000_PM_039", "221_SPM_002_PM_001", "223_SPM_000_PM_009", "120_SPM_000_PM_029",
                 "300a_SPM_000_PM_007", "Cloud_2_03_SRT_SPM_002_PM_013", "222_SPM_004_PM_001", "401_SPM_004_PM_008", "409_SPM_000_PM_024",
                 "322_SPM_000_PM_008", "321_SPM_000_PM_005", "215_SPM_000_PM_013", "Cloud_2_04_SRT_SPM_000_PM_017", "407_SPM_000_PM_018", "310_SPM_000_PM_024", "414_SPM_000_PM_007", "Cloud_2_04_SRT_SPM_002_PM_002",
                 "314_SPM_000_PM_012", "238_SPM_000_PM_018", "239_SPM_000_PM_018", "311_SPM_000_PM_041", "315_TAM_002_PM_001",
                 "208_SPM_000_PM_014", "206_SPM_000_PM_021", "113_SPM_000_PM_036",
                 "224_SRT_SPM_000_PM_071", "118_SPM_000_PM_062", "301_SPM_000_PM_010", "224_SRT_SPM_PM_091", "402_SPM_000_PM_020", "Cloud_2_07_SRT_TAM_001_PM_004"}
local sigilsC = {"219_SPM_000_PM_008", "416_SPM_000_PM_026", "114_SPM_000_PM_032", "312_SPM_000_PM_032", "Cloud_3_01_SRT_SPM_000_PM_017",
                 "403_SPM_000_PM_015", "Cloud_3_02_SRT_TAM_001", "417_SPM_000_PM_029", "217_SPM_000_PM_040", "418_SPM_000_PM_014",
                 "225_SPM_000_PM_044", "317_SPM_000_PM_024", "229_SPM_000_PM_070", "318_SPM_000_PM_026", "Cloud_3_03_SRT_SPM_000_PM_069",
                 "313_SPM_000_PM_016", "405_SRT_SPM_000_PM_050", "405_SRT_SPM_000_PM_047", "216_SPM_000_PM_015", "408_SPM_000_PM_033", "408_SRT_SPM_000_PM_034",
                 "328_SPM_000_PM_016", "Cloud_3_05_SRT_SPM_033_PM_012", "232_SPM_000_PM_012", "309_SPM_000_PM_018", "Cloud_3_05_SRT_SPM_002_PM_016", "404_SPM_000_PM_022", "Cloud_3_05_SRT_SPM_000_PM_035",
                 "234_SPM_000_PM_015", "Cloud_3_06_SRT_SPM_000_PM_008", "226_SPM_000_PM_039", "112_SPM_000_PM_034",
                 "230_SPM_000_PM_019", "308_WPM_000_PM_017", "Cloud_3_07_SRT_SPM_000_PM_021", "227_SPM_002_PM_033", "233_SPM_000_PM_015",
                 "Islands_01_SRT_SPM_000_PM_003"}
local sigilsMisc = {"119_SRT_SPM_000_PM_033", "117_SRT_SPM_000_PM_028", "115_SRT_TAM_004_PM_016",
                    "214_SRT_SPM_000_PM_025", "306_SRT_SPM_000_PM_016", "411_SRT_SPM_000_PM_014",
                    "235_SRT_SPM_000_PM_037", "320_SRT_SPM_000_PM_046", "504_SRT_SPM_000_PM_021",
                    "Secret_28_SRT_SPM_000_PM_004", "LeapOfFaith_PM_010"}
local sigilsRemaining = {}

local requiredA = {31, 33, 38, 45}
local requiredB = {32, 39, 41, 42, 46}
local requiredC = {34, 35, 40, 43, 44, 47}
local allRequired = {} -- Probably better to hardcode this later
for _,v in pairs(requiredA) do table.insert(allRequired, v) end
for _,v in pairs(requiredB) do table.insert(allRequired, v) end
for _,v in pairs(requiredC) do table.insert(allRequired, v) end

local picked = ""

if talosProgress:GetCodeValue("Randomizer_Generated") == -1 then
  for _,sigilIndex in pairs(requiredA) do
    picked = randomFromTable(sigilsA)
    table.remove(sigilsA, tableIndex(sigilsA, picked))
    talosProgress:SetCode(picked, sigilIndex)
  end
  
  if randomChance(39/77) then -- sigilsB / (sigilsB + sigilsC)
    for _,sigilIndex in pairs(requiredB) do
      picked = randomFromTable(sigilsA)
      table.remove(sigilsA, tableIndex(sigilsA, picked))
      talosProgress:SetCode(picked, sigilIndex)
    end
    for _,v in pairs(sigilsA) do table.insert(sigilsRemaining, v) end
    for _,v in pairs(sigilsB) do table.insert(sigilsRemaining, v) end
    for _,sigilIndex in pairs(requiredC) do
      picked = randomFromTable(sigilsRemaining)
      table.remove(sigilsRemaining, tableIndex(sigilsRemaining, picked))
      talosProgress:SetCode(picked, sigilIndex)
    end
    for _,v in pairs(sigilsC) do table.insert(sigilsRemaining, v) end
  else
    for _,sigilIndex in pairs(requiredC) do
      picked = randomFromTable(sigilsA)
      table.remove(sigilsA, tableIndex(sigilsA, picked))
      talosProgress:SetCode(picked, sigilIndex)
    end
    for _,v in pairs(sigilsA) do table.insert(sigilsRemaining, v) end
    for _,v in pairs(sigilsC) do table.insert(sigilsRemaining, v) end
    for _,sigilIndex in pairs(requiredB) do
      picked = randomFromTable(sigilsRemaining)
      table.remove(sigilsRemaining, tableIndex(sigilsRemaining, picked))
      talosProgress:SetCode(picked, sigilIndex)
    end
    for _,v in pairs(sigilsB) do table.insert(sigilsRemaining, v) end
  end
  for _,v in pairs(sigilsMisc) do table.insert(sigilsRemaining, v) end
  
  for sigilIndex=1,129 do
    if not inTable(allRequired, sigilIndex) then
      picked = randomFromTable(sigilsRemaining)
      if picked ~= nil then
        table.remove(sigilsRemaining, tableIndex(sigilsRemaining, picked))
        talosProgress:SetCode(picked, sigilIndex)
      end
    end
  end
  
  talosProgress:SetCode("Randomizer_Generated", 1)
endj .����oE>ڄ�s%���������[^����0�lX��oE5�=,wIx���[�馞fя���1�x�(���$�@L�_�#1��_�|5�����ȢBV~� r��w25
��m$����t�_C�<��y+f�=��v��e���#�<j#�6=0BB/)3fld��m^rr|�X�D�-%��k�Q?O3	0��< ���S�q΄)}b�qY��>k F�	�2!o79}��6+�