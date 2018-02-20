SIGSTRM12GIS             �@�o                  Signkey.EditorSignatureN͠�dZ��1E4�;�V���aO��(0EⰎ����v�=�[�nك�`�̙F�)!T@�{k'b��h;��e�q-�ѷ���R;b
X� )��}F5i.������SJq�BA@�iMs%��ߒ�,�I	Xy��L%+N��J�Gh�vѬ��}`b�z�4�ٖ3Ut�E�ڮ�@�,��ǔd-�'��W����0����:r�t���{g%�1�PPj�vr�UL0�_Hf3���Ww݃���p��wҌ�����1{�+J�5﻿Wait(CustomEvent("Randomizer_Finished"))
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
  
  for k,v in pairs(text) do
    for i=1,#text[k] do
      textPtr[k][i] = text[k][i]:GetTextConfig()
      -- Assure all texts have the correct default message
      if k == "Default" then
        text[k][i]:SetText(textPtr[k][i], "?", true)
      else
        text[k][i]:ClearText(textPtr[k][i])
      end
    end
  end
  
  -- Bring stars to the end of the sigil list
  local allSigils = {}
  local starCount = 0
  local totalSigils = #markers
  for i,v in pairs(markers) do
    local sigilNum = talosProgress:GetCodeValue(v)
    -- currentSigil : CTetrominoItemInstance
    local currentSigil = worldGlobals.allTetros[sigilNum]
    local type = string.sub(currentSigil:GetName(), 2, 2)
    if type == "*" then
      allSigils[totalSigils - starCount] = currentSigil
      starCount = starCount + 1
    else
      allSigils[i - starCount] = currentSigil
    end
  end
  
  -- sigil : CTetrominoItemInstance
  for index,sigil in pairs(allSigils) do
    local colour = string.sub(sigil:GetName(), 1, 1)
    local type = string.sub(sigil:GetName(), 2, 2)
    if sigil:IsPicked() then
      text[colour][index]:SetText(textPtr[colour][index], icons[type], true)
      text["Default"][index]:SetText(textPtr["Default"][index], "✘", true)
    elseif showAll then
      text[colour][index]:SetText(textPtr[colour][index], icons[type], true)
      text["Default"][index]:ClearText(textPtr["Default"][index])
    end    
  end
end��8��T�q����<�0�)^�2�A�0���j��ƆV�s�f-��Y{$�c@΃�}���A|e&dPـT�1�}�V�pLe�i&�Q
����ܸc|:V:>�C㕖�*#��ZEo-��/0H�ޞ+k�Cd���@V���v��=���m�t;�]bd�޳���|�es�@�0պ�x���x�8g����M;;Pi�	'���Z<Ʋ�Q�/"�uɧ�)�.��Vj��+Y����R�