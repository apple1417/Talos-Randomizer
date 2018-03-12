SIGSTRM12GIS             ���                  Signkey.EditorSignature����8��u~e����3p��7h��oǚϸ�OM1G�9]��A�j�#e-�n�;�˫�2�n�q*�VN���'��}��#�C,�Ɵ=�v��{��%3��^sh�G3��Qw���u�a��{{g_���� ���y_��HQ�gp�������N���gb�h�b�"(k�.	���@_Nu������"���cV�U�g=�T����1��8�$_��*ޚ?���[�ڷZ2	c���8w�_b�P!o��JBe����﻿--[[
  Makes the world overview sign update properly
  Because normal signs can't be dynamically changed we do this with
   a total of 1530 text effects, in various locations and colours,
   which we can set to unicode strings that look like the tetrominoes
  These strings don't render properly in the editor but they work in game
  Nexus is a bit more complicated than in each world because we don't
   have handy marker lists available, we have to make them all
  We also need to split the text effects up by world
]]--
Wait(CustomEvent("Randomizer_Finished"))
-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local showAll = talosProgress:IsVarSet("Randomizer_ShowAll")

local icons = {
  ["I"]="▄▄",
  ["J"]="▐▄",
  ["L"]="▄▌",
  ["O"]="█",
  ["S"]="▗▛",
  ["T"]="▗▙",
  ["Z"]="▜▖",
  ["*"]="★"
} 

-- All these are in the same order as in the worlds, to be consistent
local allMarkers = {
["A1"] = {
  "001_SPM_000_PM_005",
  "007_SPM_000_PM_006",
  "006_SPM_000_PM_003",
  "005_SPM_000_PM_009",
  "012_SPM_000_PM_004",
  "011_SPM_000_PM_009",
  "Cloud_1_02_SRT_SPM_000_PM_016",
  "107_SPM_000_PM_007"
},
["A2"] = {
  "Cloud_1_02_SRT_SPM_001_PM_003",
  "001a_SPM_000_PM_008",
  "008_SPM_000_PM_016",
  "013_SPM_000_PM_006"
},
["A3"] = {
  "015_SRT_SPM_000_PM_018",
  "015_SRT_SPM_000_PM_017",
  "Cloud_1_03_SRT_SPM_000_PM_005",
  "108_SPM_000_PM_012",
  "020_SPM_000_PM_014",
  "017_SPM_000_PM_023"
},
["A4"] = {
  "202f_SPM_000_PM_003",
  "202d_SPM_000_PM_002",
  "Cloud_1_04_SRT_SPM_000_PM_007",
  "202b_SPM_000_PM_004",
  "202c_SPM_000_PM_003"
},
["A5"] = {
  "207_SPM_000_PM_005",
  "204_SPM_000_PM_004",
  "202e_SPM_000_PM_004",
  "244_SRT_SPM_000_PM_006",
  "244_SPM_000_PM_008",
  "201_SRT_SPM_000_PM_004",
  "201_SPM_000_PM_013"
},
["A6"] = {
  "111_SPM_000_PM_012",
  "Cloud_1_06_SRT_SPM_000_PM_007",
  "210_SPM_000_PM_015",
  "303_SPM_000_PM_010",
  "218_SPM_000_PM_016"
},
["A7"] = {
  "212_SPM_000_PM_017",
  "220_SPM_000_PM_032",
  "305_SPM_000_PM_004",
  "211_SPM_000_PM_008",
  "209_SPM_000_PM_012",
  "Cloud_1_07_SRT_SPM_000_PM_021"
},
["A Star"] = {
  "115_SRT_TAM_004_PM_016",
  "117_SRT_SPM_000_PM_028",
  "119_SRT_SPM_000_PM_033"
},
["B1"] = {
  "319_SPM_000_PM_008",
  "302_SPM_000_PM_008",
  "316_SPM_000_PM_014",
  "205_SPM_000_PM_003",
  "Cloud_2_01_SRT_SPM_000_PM_004",
  "203_SPM_000_PM_011"
},
["B2"] = {
  "120_SPM_000_PM_029",
  "221_SPM_002_PM_001",
  "223_SPM_000_PM_009",
  "213_SPM_000_PM_010",
  "Cloud_2_02_SRT_SPM_000_PM_039"
},
["B3"] = {
  "Cloud_2_03_SRT_SPM_002_PM_013",
  "401_SPM_004_PM_008",
  "300a_SPM_000_PM_007",
  "409_SPM_000_PM_024",
  "222_SPM_004_PM_001"
},
["B4"] = {
  "Cloud_2_04_SRT_SPM_000_PM_017",
  "215_SPM_000_PM_013",
  "Cloud_2_04_SRT_SPM_002_PM_002",
  "310_SPM_000_PM_024",
  "407_SPM_000_PM_018",
  "321_SPM_000_PM_005",
  "322_SPM_000_PM_008",
  "414_SPM_000_PM_007"
},
["B5"] = {
  "Cloud_2_05_SRT_TAM_003_PM_003",
  "239_SPM_000_PM_018",
  "314_SPM_000_PM_012",
  "315_TAM_002_PM_001",
  "311_SPM_000_PM_041",
  "238_SPM_000_PM_018"
},
["B6"] = {
  "206_SPM_000_PM_021",
  "208_SPM_000_PM_014",
  "113_SPM_000_PM_036"
},
["B7"] = {
  "224_SRT_SPM_000_PM_071",
  "118_SPM_000_PM_062",
  "224_SRT_SPM_000_PM_091",
  "301_SPM_000_PM_010",
  "402_SPM_000_PM_020",
  "Cloud_2_07_SRT_TAM_001_PM_004"
},
["B Star"] = {
  "306_SRT_SPM_000_PM_016",
  "411_SRT_SPM_000_PM_014",
  "214_SRT_SPM_000_PM_025"
},
["C1"] = {
  "312_SPM_000_PM_032",
  "114_SPM_000_PM_032",
  "Cloud_3_01_SRT_SPM_000_PM_017",
  "219_SPM_000_PM_008",
  "416_SPM_000_PM_026"
},
["C2"] = {
  "403_SPM_000_PM_015",
  "Cloud_3_02_SRT_TAM_001",
  "418_SPM_000_PM_014",
  "417_SPM_000_PM_029",
  "217_SPM_000_PM_040"
},
["C3"] = {
  "318_SPM_000_PM_026",
  "Cloud_3_03_SRT_SPM_000_PM_069",
  "317_SPM_000_PM_024",
  "225_SPM_000_PM_044",
  "229_SPM_000_PM_070"
},
["C4"] = {
  "216_SPM_000_PM_015",
  "313_SPM_000_PM_016",
  "408_SRT_SPM_000_PM_034",
  "408_SPM_000_PM_033",
  "405_SRT_SPM_000_PM_047",
  "405_SRT_SPM_000_PM_050"
},
["C5"] = {
  "Cloud_3_05_SRT_SPM_002_PM_016",
  "309_SPM_000_PM_018",
  "404_SPM_000_PM_022",
  "Cloud_3_05_SRT_SPM_000_PM_035",
  "328_SPM_000_PM_016",
  "Cloud_3_05_SRT_SPM_003_PM_012",
  "232_SPM_000_PM_012"
},
["C6"] = {
  "Cloud_3_06_SRT_SPM_000_PM_008",
  "234_SPM_000_PM_015",
  "226_SPM_000_PM_039",
  "112_SPM_000_PM_034"
},
["C7"] = {
  "233_SPM_000_PM_015",
  "227_SPM_002_PM_033",
  "308_SPM_000_PM_017",
  "Cloud_3_07_SRT_SPM_000_PM_021",
  "230_SPM_000_PM_019"
},
["C Star"] = {
  "235_SRT_SPM_000_PM_037",
  "320_SRT_SPM_000_PM_046",
  "504_SRT_SPM_000_PM_021"
}
}

local allTexts = {
["A1"] = {
  ["*"] = textStarA1,
  ["D"] = textDoorA1,
  ["E"] = textSecretA1,
  ["M"] = textMechanicalA1,
  ["N"] = textNexusA1,
  ["Default"] = textDefaultA1
},
["A2"] = {
  ["*"] = textStarA2,
  ["D"] = textDoorA2,
  ["E"] = textSecretA2,
  ["M"] = textMechanicalA2,
  ["N"] = textNexusA2,
  ["Default"] = textDefaultA2
},
["A3"] = {
  ["*"] = textStarA3,
  ["D"] = textDoorA3,
  ["E"] = textSecretA3,
  ["M"] = textMechanicalA3,
  ["N"] = textNexusA3,
  ["Default"] = textDefaultA3
},
["A4"] = {
  ["*"] = textStarA4,
  ["D"] = textDoorA4,
  ["E"] = textSecretA4,
  ["M"] = textMechanicalA4,
  ["N"] = textNexusA4,
  ["Default"] = textDefaultA4
},
["A5"] = {
  ["*"] = textStarA5,
  ["D"] = textDoorA5,
  ["E"] = textSecretA5,
  ["M"] = textMechanicalA5,
  ["N"] = textNexusA5,
  ["Default"] = textDefaultA5
},
["A6"] = {
  ["*"] = textStarA6,
  ["D"] = textDoorA6,
  ["E"] = textSecretA6,
  ["M"] = textMechanicalA6,
  ["N"] = textNexusA6,
  ["Default"] = textDefaultA6
},
["A7"] = {
  ["*"] = textStarA7,
  ["D"] = textDoorA7,
  ["E"] = textSecretA7,
  ["M"] = textMechanicalA7,
  ["N"] = textNexusA7,
  ["Default"] = textDefaultA7
},
["A Star"] = {
  ["*"] = textStarAStar,
  ["D"] = textDoorAStar,
  ["E"] = textSecretAStar,
  ["M"] = textMechanicalAStar,
  ["N"] = textNexusAStar,
  ["Default"] = textDefaultAStar
},
["B1"] = {
  ["*"] = textStarB1,
  ["D"] = textDoorB1,
  ["E"] = textSecretB1,
  ["M"] = textMechanicalB1,
  ["N"] = textNexusB1,
  ["Default"] = textDefaultB1
},
["B2"] = {
  ["*"] = textStarB2,
  ["D"] = textDoorB2,
  ["E"] = textSecretB2,
  ["M"] = textMechanicalB2,
  ["N"] = textNexusB2,
  ["Default"] = textDefaultB2
},
["B3"] = {
  ["*"] = textStarB3,
  ["D"] = textDoorB3,
  ["E"] = textSecretB3,
  ["M"] = textMechanicalB3,
  ["N"] = textNexusB3,
  ["Default"] = textDefaultB3
},
["B4"] = {
  ["*"] = textStarB4,
  ["D"] = textDoorB4,
  ["E"] = textSecretB4,
  ["M"] = textMechanicalB4,
  ["N"] = textNexusB4,
  ["Default"] = textDefaultB4
},
["B5"] = {
  ["*"] = textStarB5,
  ["D"] = textDoorB5,
  ["E"] = textSecretB5,
  ["M"] = textMechanicalB5,
  ["N"] = textNexusB5,
  ["Default"] = textDefaultB5
},
["B6"] = {
  ["*"] = textStarB6,
  ["D"] = textDoorB6,
  ["E"] = textSecretB6,
  ["M"] = textMechanicalB6,
  ["N"] = textNexusB6,
  ["Default"] = textDefaultB6
},
["B7"] = {
  ["*"] = textStarB7,
  ["D"] = textDoorB7,
  ["E"] = textSecretB7,
  ["M"] = textMechanicalB7,
  ["N"] = textNexusB7,
  ["Default"] = textDefaultB7
},
["B Star"] = {
  ["*"] = textStarBStar,
  ["D"] = textDoorBStar,
  ["E"] = textSecretBStar,
  ["M"] = textMechanicalBStar,
  ["N"] = textNexusBStar,
  ["Default"] = textDefaultBStar
},
["C1"] = {
  ["*"] = textStarC1,
  ["D"] = textDoorC1,
  ["E"] = textSecretC1,
  ["M"] = textMechanicalC1,
  ["N"] = textNexusC1,
  ["Default"] = textDefaultC1
},
["C2"] = {
  ["*"] = textStarC2,
  ["D"] = textDoorC2,
  ["E"] = textSecretC2,
  ["M"] = textMechanicalC2,
  ["N"] = textNexusC2,
  ["Default"] = textDefaultC2
},
["C3"] = {
  ["*"] = textStarC3,
  ["D"] = textDoorC3,
  ["E"] = textSecretC3,
  ["M"] = textMechanicalC3,
  ["N"] = textNexusC3,
  ["Default"] = textDefaultC3
},
["C4"] = {
  ["*"] = textStarC4,
  ["D"] = textDoorC4,
  ["E"] = textSecretC4,
  ["M"] = textMechanicalC4,
  ["N"] = textNexusC4,
  ["Default"] = textDefaultC4
},
["C5"] = {
  ["*"] = textStarC5,
  ["D"] = textDoorC5,
  ["E"] = textSecretC5,
  ["M"] = textMechanicalC5,
  ["N"] = textNexusC5,
  ["Default"] = textDefaultC5
},
["C6"] = {
  ["*"] = textStarC6,
  ["D"] = textDoorC6,
  ["E"] = textSecretC6,
  ["M"] = textMechanicalC6,
  ["N"] = textNexusC6,
  ["Default"] = textDefaultC6
},
["C7"] = {
  ["*"] = textStarC7,
  ["D"] = textDoorC7,
  ["E"] = textSecretC7,
  ["M"] = textMechanicalC7,
  ["N"] = textNexusC7,
  ["Default"] = textDefaultC7
},
["C Star"] = {
  ["*"] = textStarCStar,
  ["D"] = textDoorCStar,
  ["E"] = textSecretCStar,
  ["M"] = textMechanicalCStar,
  ["N"] = textNexusCStar,
  ["Default"] = textDefaultCStar
}
}

for world, markers in pairs(allMarkers) do
  local text = allTexts[world]
  local textPtr = {
    ["*"] = {},
    ["D"] = {},
    ["E"] = {},
    ["M"] = {},
    ["N"] = {},
    ["Default"] = {}
  }
  assert(#markers == #text.Default, string.format("%s has %s markers but %s sigils assigned to it", world, #markers, #text.Default))
  
  --[[
    Setup all text pointers for this world, and make sure all texts
     have the correct default message
  ]]--
  for k,v in pairs(text) do
    for i=1,#text[k] do
      textPtr[k][i] = text[k][i]:GetTextConfig()
      if k == "Default" then
        text[k][i]:SetText(textPtr[k][i], "?", true)
      else
        text[k][i]:ClearText(textPtr[k][i])
      end
    end
  end
  
  --[[
    This is really not setup properly to deal with it, so if
     random portals is on we just disable all the signs
  ]]--
  if not talosProgress:IsVarSet("Randomizer_Portals") then
    -- Sort the sigil list to prevent memorising spawn order
    local sigils = {}
    local stars = {}
    for i=1, #markers do
      local sigilNum = talosProgress:GetCodeValue(markers[i])
      if sigilNum <= 30 then
        table.insert(stars, sigilNum)
      else
        table.insert(sigils, sigilNum)
      end
    end
    table.sort(sigils)
    --[[
      The elements of each sign are indexed weirdly so I need to
       resort the list to work with it
    ]]--
    local allSigils = {}
    local half = mthCeilF(#sigils/2)
    for i=1, #sigils do
      if i > half then
        allSigils[2*(i-half)] = sigils[i]
      else
        allSigils[2*i-1] = sigils[i]
      end
    end
    for i=1, #stars do table.insert(allSigils, stars[i]) end
    
    --[[
      Fill each sign
      Unlike the scripts in each world we only need to do this once,
       none of the sigils in nexus have a sign, so to update the signs
       you'd have to visit another world, and coming back would re-run
       this script anyway
    ]]--
    for i=1, #allSigils do
      local sigil = worldGlobals.allTetros[allSigils[i]]
      local colour = string.sub(sigil:GetName(), 1, 1)
      local type = string.sub(sigil:GetName(), 2, 2)
      if sigil:IsPicked() then
        text[colour][i]:SetText(textPtr[colour][i], icons[type], true)
        text["Default"][i]:SetText(textPtr["Default"][i], "✘", true)
      -- If a sigil is not picked and showAll is false it'll remain '?'
      elseif showAll then
        text[colour][i]:SetText(textPtr[colour][i], icons[type], true)
        text["Default"][i]:ClearText(textPtr["Default"][i])
      end    
    end
  end
end��<6m����c� ��z�����D��������+���-�^��x���ď�0�O-���>�&������&�m��!$ɥ�oB�����j4�&߻Y ���5�l�3�Џ-J�>�C��K�]c=�#G+j,"ʸ!�<+�.I͖�y�o7Xe	�������6-B�x�W��V8���4.�i��ں�$���Ѓd�"��	]]�9�LB�k���m�>8�B��C�
"d:���L ���