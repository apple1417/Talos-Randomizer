SIGSTRM12GIS             ���                  Signkey.EditorSignature]5`��?V�U������h�_���P���f\@�{E�y�Ӧ5�
bfp����^1v����x��p٭bDi 
j7��B�J�g'(Є�"��k^B�]�z�#v�o&.�H>�^����~��i;� � �ŷ��!�S�9��Mh��L��sG��JB�]/;+�����剹�7 ��Y6�E��Hȴ(h�en�5�/�;�^͕gl���gR*W�i�i����]?r]΢$B1�"SN�ds��fC?�Xe}�﻿local function print(...)
  local out = ""
  for i=1,arg.n do
    out = out .. tostring(arg[i]) .. " "
  end
  out = string.sub(out, 1, -2) .. "\n"
  conInfoF(out)
end

local function printWarning(...)
  local out = ""
  for i=1,arg.n do
    out = out .. tostring(arg[i]) .. " "
  end
  out = string.sub(out, 1, -2) .. "\n"
  conWarningF(out)
end

local function printError(...)
  local out = ""
  for i=1,arg.n do
    out = out .. tostring(arg[i]) .. " "
  end
  out = string.sub(out, 1, -2) .. "\n"
  conErrorF(out)
end

print("Loaded Randomizer v9")

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

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local PROB_BOTH_HUBS = 25
local DEBUG = talosProgress:IsVarSet("Randomizer_Debug")

if not talosProgress:IsVarSet("Randomizer_Generated") then
  print("Randomizing...")
  local mode = talosProgress:GetCodeValue("Randomizer_Mode")
  if mode == -1 then
    mode = 1
  end
  print("Using Mode", mode)

  local seed = talosProgress:GetCodeValue("Randomizer_Seed")
  if seed == -1 then
    seed = mthRndRangeL(0, 2147483647)
    talosProgress:SetCode("Randomizer_Seed", seed)
  end
  print("Using Seed", seed)
  
  --[[
    Linear congruential generator using Microsoft VC++ seeds
    Unlike the built-in, we can seed this
    Thanks Darkid :)
  ]]--
  local function rand(min, max)
    seed = (214013 * seed + 2531011) % 2147483648
    if min == max then return min end
    return (seed % (max - (min - 1))) + min
  end

  talosProgress:SetVarValue("PaintItemSeed", rand(0, 8909478))
  talosProgress:SetVarValue("Code_Floor4", rand(1, 999))
  talosProgress:SetVarValue("Code_Floor5", rand(1, 999))
  local codeF6 = 0
  for i=1,3 do
    local digit = rand(4, 9) -- Yes this is right
    talosProgress:SetVarValue("Code_Floor6" .. tostring(i), digit)
    talosProgress:SetVar("Code_Floor6DigitSeen" .. tostring(i))
    codeF6 = codeF6*10 + digit
  end
  talosProgress:SetVarValue("Code_Floor6", codeF6)

  local tetroIndexes = {
    ["**1"] =  1, ["**2"] =  2, ["**3"] =  3, ["**4"] =  4, ["**5"] =  5,
    ["**6"] =  6, ["**7"] =  7, ["**8"] =  8, ["**9"] =  9, ["**10"]= 10,
    ["**11"]= 11, ["**12"]= 12, ["**13"]= 13, ["**14"]= 14, ["**15"]= 15,
    ["**16"]= 16, ["**17"]= 17, ["**18"]= 18, ["**19"]= 19, ["**20"]= 20,
    ["**21"]= 21, ["**22"]= 22, ["**23"]= 23, ["**24"]= 24, ["**25"]= 25,
    ["**26"]= 26, ["**27"]= 27, ["**28"]= 28, ["**29"]= 29, ["**30"]= 30,
    ["DI1"] = 31, ["DI2"] = 32, ["DJ1"] = 33, ["DJ2"] = 34, ["DJ3"] = 35,
    ["DJ4"] = 36, ["DJ5"] = 37, ["DL1"] = 38, ["DL2"] = 39, ["DL3"] = 40,
    ["DT1"] = 41, ["DT2"] = 42, ["DT3"] = 43, ["DT4"] = 44, ["DZ1"] = 45,
    ["DZ2"] = 46, ["DZ3"] = 47, ["DZ4"] = 48, ["EL1"] = 49, ["EL2"] = 50,
    ["EL3"] = 51, ["EL4"] = 52, ["EO1"] = 53, ["ES1"] = 54, ["ES2"] = 55,
    ["ES3"] = 56, ["ES4"] = 57, ["MI1"] = 58, ["MJ1"] = 59, ["ML1"] = 60,
    ["ML2"] = 61, ["ML3"] = 62, ["ML4"] = 63, ["MO1"] = 64, ["MS1"] = 65,
    ["MS2"] = 66, ["MT1"] = 67, ["MT2"] = 68, ["MT3"] = 69, ["MT4"] = 70,
    ["MT5"] = 71, ["MT6"] = 72, ["MT7"] = 73, ["MT8"] = 74, ["MT9"] = 75,
    ["MT10"]= 76, ["MZ1"] = 77, ["MZ2"] = 78, ["MZ3"] = 79, ["MZ4"] = 80,
    ["NI1"] = 81, ["NI2"] = 82, ["NI3"] = 83, ["NI4"] = 84, ["NI5"] = 85,
    ["NI6"] = 86, ["NJ1"] = 87, ["NJ2"] = 88, ["NJ3"] = 89, ["NJ4"] = 90,
    ["NL1"] = 91, ["NL2"] = 92, ["NL3"] = 93, ["NL4"] = 94, ["NL5"] = 95,
    ["NL6"] = 96, ["NL7"] = 97, ["NL8"] = 98, ["NL9"] = 99, ["NL10"]=100,
    ["NO1"] =101, ["NO2"] =102, ["NO3"] =103, ["NO4"] =104, ["NO5"] =105,
    ["NO6"] =106, ["NO7"] =107, ["NS1"] =108, ["NS2"] =109, ["NS3"] =110,
    ["NS4"] =111, ["NT1"] =112, ["NT2"] =113, ["NT3"] =114, ["NT4"] =115,
    ["NT5"] =116, ["NT6"] =117, ["NT7"] =118, ["NT8"] =119, ["NT9"] =120,
    ["NT10"]=121, ["NT11"]=122, ["NT12"]=123, ["NZ1"] =124, ["NZ2"] =125,
    ["NZ3"] =126, ["NZ4"] =127, ["NZ5"] =128, ["NZ6"] =129,
  }
  
  --[[
    These names are the same as in MarkerNames.txt, with the world
     name as a prefix
    "[World] Star" it has been changed to "[World]-Star"
    "CM-Star", "F0-Star", and "F3-Star" are the only other exceptions
  ]]--
  local translate = {
    ["A1-PaSL"] = "005_SPM_000_PM_009", ["A1-Beaten Path"] = "107_SPM_000_PM_007", ["A1-Outnumbered"] = "006_SPM_000_PM_003", ["A1-OtToU"] = "011_SPM_000_PM_009", ["A1-ASooR"] = "007_SPM_000_PM_006", ["A1-Trio"] = "012_SPM_000_PM_004", ["A1-Peephole"] = "001_SPM_000_PM_005", ["A1-Star"] = "Cloud_1_02_SRT_SPM_000_PM_016",
    ["A2-Guards"] = "008_SPM_000_PM_016", ["A2-Hall of Windows"] = "001a_SPM_000_PM_008", ["A2-Suicide Mission"] = "013_SPM_000_PM_006", ["A2-Star"] = "Cloud_1_02_SRT_SPM_001_PM_003",
    ["A3-Stashed for Later"] = "108_SPM_000_PM_012", ["A3-ABTU"] = "015_SRT_SPM_000_PM_018", ["A3-ABTU Star"] = "015_SRT_SPM_000_PM_017", ["A3-Swallowed the Key"] = "020_SPM_000_PM_014", ["A3-AEP"] = "017_SPM_000_PM_023", ["A3-Clock Star"] = "Cloud_1_03_SRT_SPM_000_PM_005",
    ["A4-Branch it Out"] = "202c_SPM_000_PM_003", ["A4-Above All That"] = "202f_SPM_000_PM_003", ["A4-Push it Further"] = "202b_SPM_000_PM_004", ["A4-Star"] = "Cloud_1_04_SRT_SPM_000_PM_007", ["A4-DCtS"] = "202d_SPM_000_PM_002",
    ["A5-Two Boxes"] = "201_SPM_000_PM_013", ["A5-Two Boxes Star"] = "201_SRT_SPM_000_PM_004", ["A5-YKYMCTS"] = "204_SPM_000_PM_004", ["A5-Over the Fence"] = "202e_SPM_000_PM_004", ["A5-OLB"] = "207_SPM_000_PM_005", ["A5-FC"] = "244_SPM_000_PM_008", ["A5-FC Star"] = "244_SRT_SPM_000_PM_006",
    ["A6-Mobile Mindfield"] = "111_SPM_000_PM_012", ["A6-Deception"] = "210_SPM_000_PM_015", ["A6-Door too Far"] = "218_SPM_000_PM_016", ["A6-Bichromatic"] = "303_SPM_000_PM_010", ["A6-Star"] = "Cloud_1_06_SRT_SPM_000_PM_007",
    ["A7-LFI"] = "212_SPM_000_PM_017", ["A7-Trapped Inside"] = "305_SPM_000_PM_004", ["A7-Two Buzzers"] = "209_SPM_000_PM_012", ["A7-Star"] = "Cloud_1_07_SRT_SPM_000_PM_021", ["A7-WiaL"] = "220_SPM_000_PM_032", ["A7-Pinhole"] = "211_SPM_000_PM_008",
    ["A*-JfW"] = "119_SRT_SPM_000_PM_033", ["A*-Nervewrecker"] = "117_SRT_SPM_000_PM_028", ["A*-DDM"] = "115_SRT_TAM_004_PM_016",
    ["B1-WtaD"] = "203_SPM_000_PM_011", ["B1-Third Wheel"] = "302_SPM_000_PM_008", ["B1-Over the Fence"] = "316_SPM_000_PM_014", ["B1-RoD"] = "319_SPM_000_PM_008", ["B1-SaaS"] = "205_SPM_000_PM_003", ["B1-Star"] = "Cloud_2_01_SRT_SPM_000_PM_004",
    ["B2-Tomb"] = "213_SPM_000_PM_010", ["B2-Star"] = "Cloud_2_02_SRT_SPM_000_PM_039", ["B2-MotM"] = "221_SPM_002_PM_001", ["B2-Moonshot"] = "223_SPM_000_PM_009", ["B2-Higher Ground"] = "120_SPM_000_PM_029",
    ["B3-Blown Away"] = "300a_SPM_000_PM_007", ["B3-Star"] = "Cloud_2_03_SRT_SPM_002_PM_013", ["B3-Sunshot"] = "222_SPM_004_PM_001", ["B3-Eagle's Nest"] = "401_SPM_004_PM_008", ["B3-Woosh"] = "409_SPM_000_PM_024",
    ["B4-Self Help"] = "322_SPM_000_PM_008", ["B4-Double-Plate"] = "321_SPM_000_PM_005", ["B4-TRA"] = "215_SPM_000_PM_013", ["B4-TRA Star"] = "Cloud_2_04_SRT_SPM_000_PM_017", ["B4-RPS"] = "407_SPM_000_PM_018", ["B4-ABUH"] = "310_SPM_000_PM_024", ["B4-WAtC"] = "414_SPM_000_PM_007", ["B4-Sphinx Star"] = "Cloud_2_04_SRT_SPM_002_PM_002",
    ["B5-SES"] = "314_SPM_000_PM_012", ["B5-Plates"] = "238_SPM_000_PM_018", ["B5-Two Jammers"] = "239_SPM_000_PM_018", ["B5-Iron Curtain"] = "311_SPM_000_PM_041", ["B5-Chambers"] = "315_TAM_002_PM_001", ["B5-Obelisk Star"] = "Cloud_2_05_SRT_TAM_003_PM_003",
    ["B6-Crisscross"] = "208_SPM_000_PM_014", ["B6-JDaW"] = "206_SPM_000_PM_021", ["B6-Egyptian Arcade"] = "113_SPM_000_PM_036",
    ["B7-AFaF"] = "224_SRT_SPM_000_PM_071", ["B7-WLJ"] = "118_SPM_000_PM_062", ["B7-BSbS"] = "301_SPM_000_PM_010", ["B7-BSbS Star"] = "224_SRT_SPM_000_PM_091", ["B7-BLoM"] = "402_SPM_000_PM_020", ["B7-Star"] = "Cloud_2_07_SRT_TAM_001_PM_004",
    ["B*-Merry Go Round"] = "214_SRT_SPM_000_PM_025", ["B*-Cat's Cradle"] = "306_SRT_SPM_000_PM_016", ["B*-Peekaboo"] = "411_SRT_SPM_000_PM_014",
    ["C1-Conservatory"] = "219_SPM_000_PM_008", ["C1-MIA"] = "416_SPM_000_PM_026", ["C1-Labyrinth"] = "114_SPM_000_PM_032", ["C1-Blowback"] = "312_SPM_000_PM_032", ["C1-Star"] = "Cloud_3_01_SRT_SPM_000_PM_017",
    ["C2-ADaaF"] = "403_SPM_000_PM_015", ["C2-Star"] = "Cloud_3_02_SRT_TAM_001", ["C2-Rapunzel"] = "417_SPM_000_PM_029", ["C2-Cemetery"] = "217_SPM_000_PM_040", ["C2-Short Wall"] = "418_SPM_000_PM_014",
    ["C3-Three Connectors"] = "225_SPM_000_PM_044", ["C3-Jammer Quarantine"] = "317_SPM_000_PM_024", ["C3-BSLS"] = "229_SPM_000_PM_070", ["C3-Weathertop"] = "318_SPM_000_PM_026", ["C3-Star"] = "Cloud_3_03_SRT_SPM_000_PM_069",
    ["C4-Armory"] = "313_SPM_000_PM_016", ["C4-Oubliette"] = "405_SRT_SPM_000_PM_050", ["C4-Oubliette Star"] = "405_SRT_SPM_000_PM_047", ["C4-Stables"] = "216_SPM_000_PM_015", ["C4-Throne Room"] = "408_SPM_000_PM_033", ["C4-Throne Room Star"] = "408_SRT_SPM_000_PM_034",
    ["C5-Time Flies"] = "328_SPM_000_PM_016", ["C5-Time Flies Star"] = "Cloud_3_05_SRT_SPM_003_PM_012", ["C5-Time Crawls"] = "232_SPM_000_PM_012", ["C5-Dumbwaiter"] = "309_SPM_000_PM_018", ["C5-Dumbwaiter Star"] = "Cloud_3_05_SRT_SPM_002_PM_016", ["C5-UCaJ"] = "404_SPM_000_PM_022", ["C5-UCAJ Star"] = "Cloud_3_05_SRT_SPM_000_PM_035",
    ["C6-Seven Doors"] = "234_SPM_000_PM_015", ["C6-Star"] = "Cloud_3_06_SRT_SPM_000_PM_008", ["C6-Circumlocution"] = "226_SPM_000_PM_039", ["C6-Two Way Steet"] = "112_SPM_000_PM_034",
    ["C7-Carrier Pigeons"] = "230_SPM_000_PM_019", ["C7-DMS"] = "308_SPM_000_PM_017", ["C7-Star"] = "Cloud_3_07_SRT_SPM_000_PM_021", ["C7-Prison Break"] = "227_SPM_002_PM_033", ["C7-Crisscross"] = "233_SPM_000_PM_015",
    ["C*-Unreachable Garden"] = "235_SRT_SPM_000_PM_037", ["C*-Nexus"] = "320_SRT_SPM_000_PM_046", ["C*-Cobweb"] = "504_SRT_SPM_000_PM_021",
    ["CM-Star"] = "Islands_01_SRT_SPM_000_PM_003", ["F0-Star"] = "Secret_28_SRT_SPM_000_PM_004", ["F3-Star"] = "LeapOfFaith_PM_010"
  }
  local toTranslate = false
  
  local markers = {
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
    "Secret_28_SRT_SPM_000_PM_004"
  }
  
  local locked = {
    ["A1 Gate"] = {}, -- All the greens get set later, as we need to 
    ["A Gate"] = {}, --   lock parts of them to make sure you can't
    ["B Gate"] = {}, --   enter the wrong hub and softlock, but which
    ["C Gate"] = {}, --   parts depends on the starting hub
    ["A Star"] = {"**1", "**2", "**3", "**4", "**5", "**6", "**7", "**8", "**9", "**10"},
    ["B Star"] = {"**11", "**12", "**13", "**14", "**15", "**16", "**17", "**18", "**19", "**20"},
    ["C Star"] = {"**21", "**22", "**23", "**24", "**25", "**26", "**27", "**28", "**29", "**30"},
    ["Connector"] = {"ML1", "MT1", "MT2"},
    ["Cube"] = {"ML2", "MT3", "MT4", "MZ1"},
    ["Fan"] = {"ML3", "MS1", "MT5", "MT6", "MZ2"},
    ["Recorder"] = {"MJ1", "MS2", "MT7", "MT8", "MZ3"},
    ["Platform"] = {"MI1", "ML4", "MO1", "MT9", "MT10", "MZ4"},
    ["F1"] = {"NL1", "NL2", "NZ1", "NZ2"},
    ["F2"] = {"NL3", "NL4", "NL5", "NL6", "NO1", "NT1", "NT2", "NT3", "NT4"},
    ["F3"] = {"NI1", "NI2", "NI3", "NI4", "NJ1", "NJ2", "NL7", "NL8", "NS1", "NZ3"},
    ["F4"] = {"NJ3", "NL9", "NO2", "NO3", "NS2", "NS3", "NT5", "NT6", "NT7", "NT8", "NZ4", "NZ5"},
    ["F5"] = {"NI5", "NI6", "NJ4", "NL10", "NO4", "NO5", "NO6", "NO7", "NS4", "NT9", "NT10", "NT11", "NT12", "NZ6"},
    ["F6"] = {"EL1", "EL2", "EL3", "EL4", "EO1", "ES1", "ES2", "ES3", "ES4"}
  }
  
  --[[
    Randomize Portals
    If the option is off all portals will be put in their normal
     spots, but we still need to set everything up so that we unlock
     markers properly
  ]]--
  local portalOrder = {
    "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "ADevIsland",
    "B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8",
    "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "CMessenger"
  }
  -- We need a copy of this list in the right order, hard-coding it is quicker
  local portalIndexes = {
    "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "ADevIsland",
    "B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8",
    "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "CMessenger"
  }
  local startHub = "A"
  if talosProgress:IsVarSet("Randomizer_Portals") then
    if DEBUG then
      print("Randomizing portal locations")
    end
    -- We'll leave A1 alone for now because it has a few extra requirements
    for index=#portalOrder, 2, -1 do
      local otherIndex = rand(2, index)
      portalOrder[index], portalOrder[otherIndex] = portalOrder[otherIndex], portalOrder[index]
    end
    --[[
      A1 can't be Star worlds or C Messenger, you spawn behind a
       gate/wodden barrier upon leaving
      These are spots 8, 17, 25, and 26
    ]]--
    local index = rand(1, 22)
    if index < 8 then
      startHub = "A"
    elseif 8 <= index and index < 16 then
      index = index + 1
      startHub = "B"
    elseif 16 <= index then
      index = index + 2
      startHub = "C"
    end
    if DEBUG then
      print("Starting in " .. startHub)
    end
    portalOrder[1], portalOrder[index] = portalOrder[index], portalOrder[1]
  end
  
  local open = {}
  local WorldANames = {}
  local WorldBNames = {}
  local WorldCNames = {}
  for index=1, #portalOrder do
    local name = portalOrder[index]
    if DEBUG and talosProgress:IsVarSet("Randomizer_Portals") then
      printWarning(string.format("Portal marker %s is %s", portalIndexes[index], name))
    end
    talosProgress:SetVarValue(name, index)
    -- These lists help us avoid instantly clogging the marker list
    local placedName = portalIndexes[index]
    if string.sub(placedName, 1, 1) == "A" then
      WorldANames[name] = true
    elseif string.sub(placedName, 1, 1) == "B" then
      WorldBNames[name] = true
    elseif string.sub(placedName, 1, 1) == "C" then
      WorldCNames[name] = true
    end
  end
  
  for _=1,100 do
    rand(0, 0)
  end
  
  local function isWorldOpen(world)
    if world == "A1" then return true end

    local starOverride = true
    local num = talosProgress:GetCodeValue(world)
    -- Is this a star world?
    if num == 8 or num == 17 or num == 25 then
      starOverride = not (locked["A Star"] or locked["B Star"] or locked["C Star"])
    end
    
    return starOverride and open[world]
  end
  
  --[[
    We can add modes with arbitray restrictions just by making new
     copies of this list
    The list entries are formatted as follows:
    {function() [if to unlock], {"list", "of, "markers"}, "world"},
    If no world is given OR the world is not recognised it will
     always be checked, otherwise we can save some iterations and
     add it later, when it's actually unlocked
  ]]--
  -- Default
  if mode == 1 then
    markers = {
      {function() return isWorldOpen("A1") end, {
        "001_SPM_000_PM_005", "005_SPM_000_PM_009", "006_SPM_000_PM_003", "007_SPM_000_PM_006",
        "011_SPM_000_PM_009", "012_SPM_000_PM_004", "107_SPM_000_PM_007", "Cloud_1_02_SRT_SPM_000_PM_016"
      }},
      {function() return isWorldOpen("A2") end, {
        "001a_SPM_000_PM_008", "008_SPM_000_PM_016", "013_SPM_000_PM_006", "Cloud_1_02_SRT_SPM_001_PM_003"
      }, "A2"},
      {function() return isWorldOpen("A3") end, {
        "015_SRT_SPM_000_PM_017", "015_SRT_SPM_000_PM_018", "017_SPM_000_PM_023", "020_SPM_000_PM_014",
        "108_SPM_000_PM_012", "Cloud_1_03_SRT_SPM_000_PM_005"
      }, "A3"},
      {function() return isWorldOpen("A4") end, {
        "202b_SPM_000_PM_004", "202c_SPM_000_PM_003", "202f_SPM_000_PM_003", "Cloud_1_04_SRT_SPM_000_PM_007"
      }, "A4"},
      {function() return isWorldOpen("A4") and not locked["Connector"] end, {
        "202d_SPM_000_PM_002"
      }, "A4"},
      {function() return isWorldOpen("A5") end, {
        "201_SPM_000_PM_013", "201_SRT_SPM_000_PM_004", "202e_SPM_000_PM_004", "204_SPM_000_PM_004",
        "207_SPM_000_PM_005", "244_SPM_000_PM_008", "244_SRT_SPM_000_PM_006",
      }, "A5"},
      {function() return isWorldOpen("A6") end, {
        "111_SPM_000_PM_012", "210_SPM_000_PM_015", "218_SPM_000_PM_016", "303_SPM_000_PM_010",
        "Cloud_1_06_SRT_SPM_000_PM_007"
      }, "A6"},
      {function() return isWorldOpen("A7") end, {
        "209_SPM_000_PM_012", "211_SPM_000_PM_008", "212_SPM_000_PM_017", "220_SPM_000_PM_032",
        "305_SPM_000_PM_004", "Cloud_1_07_SRT_SPM_000_PM_021"
      }, "A7"},
      {function() return isWorldOpen("A8") end, {
        "115_SRT_TAM_004_PM_016", "117_SRT_SPM_000_PM_028", "119_SRT_SPM_000_PM_033"
      }, "A8"},
      {function() return isWorldOpen("B1") end, {
        "205_SPM_000_PM_003", "203_SPM_000_PM_011", "302_SPM_000_PM_008", "316_SPM_000_PM_014",
        "319_SPM_000_PM_008", "Cloud_2_01_SRT_SPM_000_PM_004"
      }, "B1"},
      {function() return isWorldOpen("B2") end, {
        "120_SPM_000_PM_029", "213_SPM_000_PM_010", "221_SPM_002_PM_001", "223_SPM_000_PM_009",
        "Cloud_2_02_SRT_SPM_000_PM_039"
      }, "B2"},
      {function() return isWorldOpen("B3") end, {
        "222_SPM_004_PM_001", "300a_SPM_000_PM_007", "401_SPM_004_PM_008", "409_SPM_000_PM_024",
        "Cloud_2_03_SRT_SPM_002_PM_013"
      }, "B3"},
      {function() return isWorldOpen("B4") end, {
        "215_SPM_000_PM_013", "310_SPM_000_PM_024", "321_SPM_000_PM_005", "322_SPM_000_PM_008",
        "407_SPM_000_PM_018", "414_SPM_000_PM_007", "Cloud_2_04_SRT_SPM_000_PM_017"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Connector"] end, {
        "Cloud_2_04_SRT_SPM_002_PM_002"
      }, "B4"},
      {function() return isWorldOpen("B5") end, {
        "238_SPM_000_PM_018", "239_SPM_000_PM_018", "311_SPM_000_PM_041", "314_SPM_000_PM_012",
        "315_TAM_002_PM_001"
      }, "B5"},
      {function() return isWorldOpen("B5") and not locked["Connector"] and not locked["Fan"] end, {
        "Cloud_2_05_SRT_TAM_003_PM_003"
      }, "B5"},
      {function() return isWorldOpen("B6") end, {
        "113_SPM_000_PM_036", "206_SPM_000_PM_021", "208_SPM_000_PM_014"
      }, "B6"},
      {function() return isWorldOpen("B7") end, {
        "118_SPM_000_PM_062", "224_SRT_SPM_000_PM_071", "224_SRT_SPM_000_PM_091", "301_SPM_000_PM_010",
        "402_SPM_000_PM_020"       
      }, "B7"},
      {function() return isWorldOpen("B7") and not locked["Fan"] end, {
        "Cloud_2_07_SRT_TAM_001_PM_004"
      }, "B7"},
      {function() return isWorldOpen("B8") end, {
        "214_SRT_SPM_000_PM_025", "306_SRT_SPM_000_PM_016", "411_SRT_SPM_000_PM_014"
      }, "B8"},
      {function() return isWorldOpen("C1") end, {
        "114_SPM_000_PM_032", "219_SPM_000_PM_008", "312_SPM_000_PM_032", "416_SPM_000_PM_026",
        "Cloud_3_01_SRT_SPM_000_PM_017"
      }, "C1"},
      {function() return isWorldOpen("C2") end, {
        "217_SPM_000_PM_040", "403_SPM_000_PM_015", "417_SPM_000_PM_029", "418_SPM_000_PM_014",
        "Cloud_3_02_SRT_TAM_001"
      }, "C2"},
      {function() return isWorldOpen("C3") end, {
        "225_SPM_000_PM_044", "229_SPM_000_PM_070", "317_SPM_000_PM_024", "318_SPM_000_PM_026",
        "Cloud_3_03_SRT_SPM_000_PM_069"
      }, "C3"},
      {function() return isWorldOpen("C4") end, {
        "216_SPM_000_PM_015", "313_SPM_000_PM_016", "405_SRT_SPM_000_PM_047", "405_SRT_SPM_000_PM_050",
        "408_SPM_000_PM_033", "408_SRT_SPM_000_PM_034"
      }, "C4"},
      {function() return isWorldOpen("C5") end, {
        "232_SPM_000_PM_012", "309_SPM_000_PM_018", "328_SPM_000_PM_016", "404_SPM_000_PM_022",
        "Cloud_3_05_SRT_SPM_003_PM_012"
      }, "C5"},
      {function() return isWorldOpen("C5") and not locked["Cube"] end, {
        "Cloud_3_05_SRT_SPM_000_PM_035", "Cloud_3_05_SRT_SPM_002_PM_016"
      }, "C5"},
      {function() return isWorldOpen("C6") end, {
        "112_SPM_000_PM_034", "226_SPM_000_PM_039", "234_SPM_000_PM_015", "Cloud_3_06_SRT_SPM_000_PM_008"
      }, "C6"},
      {function() return isWorldOpen("C7") end, {
        "227_SPM_002_PM_033", "230_SPM_000_PM_019", "233_SPM_000_PM_015", "308_SPM_000_PM_017",
        "Cloud_3_07_SRT_SPM_000_PM_021"
      }, "C7"},
      {function() return isWorldOpen("C8") end, {
        "504_SRT_SPM_000_PM_021"
      }, "C8"},
      {function() return isWorldOpen("C8") and not locked["Connector"] end, {
        "320_SRT_SPM_000_PM_046", "235_SRT_SPM_000_PM_037"
      }, "C8"},
      {function() return isWorldOpen("CMessenger") end, {
        "Islands_01_SRT_SPM_000_PM_003"
      }, "CMessenger"},
      {function() return not locked[F1] and not locked["F3"] end, {
        "LeapOfFaith_PM_010"
      }},
      {function() return not locked["F1"] and (not locked["Connector"] or not locked["F3"]) end, {
        "Secret_28_SRT_SPM_000_PM_004"
      }}
    }
  -- 60FPS
  elseif mode == 2 then
    markers = {
      {function() return isWorldOpen("A1") end, {
        "001_SPM_000_PM_005", "005_SPM_000_PM_009", "006_SPM_000_PM_003", "007_SPM_000_PM_006",
        "011_SPM_000_PM_009", "012_SPM_000_PM_004", "107_SPM_000_PM_007", "Cloud_1_02_SRT_SPM_000_PM_016"
      }},
      {function() return isWorldOpen("A2") end, {
        "001a_SPM_000_PM_008", "008_SPM_000_PM_016", "013_SPM_000_PM_006", "Cloud_1_02_SRT_SPM_001_PM_003"
      }, "A2"},
      {function() return isWorldOpen("A3") end, {
        "015_SRT_SPM_000_PM_017", "015_SRT_SPM_000_PM_018", "017_SPM_000_PM_023", "020_SPM_000_PM_014",
        "108_SPM_000_PM_012", "Cloud_1_03_SRT_SPM_000_PM_005"
      }, "A3"},
      {function() return isWorldOpen("A4") end, {
        "202b_SPM_000_PM_004", "202c_SPM_000_PM_003", "202f_SPM_000_PM_003", "Cloud_1_04_SRT_SPM_000_PM_007"
      }, "A4"},
      {function() return isWorldOpen("A4") and not locked["Connector"] end, {
        "202d_SPM_000_PM_002"
      }, "A4"},
      {function() return isWorldOpen("A5") end, {
        "201_SPM_000_PM_013", "201_SRT_SPM_000_PM_004", "202e_SPM_000_PM_004", "204_SPM_000_PM_004",
        "207_SPM_000_PM_005", "244_SPM_000_PM_008", "244_SRT_SPM_000_PM_006",
      }, "A5"},
      {function() return isWorldOpen("A6") end, {
        "111_SPM_000_PM_012", "210_SPM_000_PM_015", "218_SPM_000_PM_016", "303_SPM_000_PM_010",
        "Cloud_1_06_SRT_SPM_000_PM_007"
      }, "A6"},
      {function() return isWorldOpen("A7") end, {
        "209_SPM_000_PM_012", "211_SPM_000_PM_008", "220_SPM_000_PM_032", "305_SPM_000_PM_004",
        "Cloud_1_07_SRT_SPM_000_PM_021"
      }, "A7"},
      {function() return isWorldOpen("A7") and not locked["Connector"] end, {
        "212_SPM_000_PM_017"
      }, "A7"},
      {function() return isWorldOpen("A8") end, {
        "115_SRT_TAM_004_PM_016", "117_SRT_SPM_000_PM_028", "119_SRT_SPM_000_PM_033"
      }, "A8"},
      {function() return isWorldOpen("B1") end, {
        "319_SPM_000_PM_008"
      }, "B1"},
      {function() return isWorldOpen("B1") and not locked["Cube"] end, {
        "316_SPM_000_PM_014"
      }, "B1"},
      {function() return isWorldOpen("B1") and (not locked["Connector"] or not locked["Cube"]) end, {
        "203_SPM_000_PM_011", "205_SPM_000_PM_003", "302_SPM_000_PM_008", "Cloud_2_01_SRT_SPM_000_PM_004"
      }, "B1"},
      {function() return isWorldOpen("B2") end, {
        "120_SPM_000_PM_029", "213_SPM_000_PM_010", "223_SPM_000_PM_009", "Cloud_2_02_SRT_SPM_000_PM_039"
      }, "B2"},
      {function() return isWorldOpen("B2") and not locked["Cube"] end, {
        "221_SPM_002_PM_001"
      }, "B2"},
      {function() return isWorldOpen("B3") and not locked["Cube"] end, {
        "222_SPM_004_PM_001", "300a_SPM_000_PM_007", "Cloud_2_03_SRT_SPM_002_PM_013"
      }, "B3"},
      {function() return isWorldOpen("B3") and (locked["Connector"] or not locked["Cube"]) end, {
        "401_SPM_004_PM_008", "409_SPM_000_PM_024"
      }, "B3"},      
      {function() return isWorldOpen("B4") and (not locked["Cube"] or not locked["Recorder"]) end, {
        "322_SPM_000_PM_008"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Connector"] end, {
        "215_SPM_000_PM_013", "414_SPM_000_PM_007"
      }, "B4"},
      {function() return isWorldOpen("B4") and ((not locked["Connector"] and not locked["Cube"]) or not locked["Recorder"]) end, {
        "321_SPM_000_PM_005", "407_SPM_000_PM_018"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Connector"] and not locked["Cube"] end, {
        "310_SPM_000_PM_024", "Cloud_2_04_SRT_SPM_000_PM_017"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Connector"] and (not locked["Cube"] or not locked["Fan"]) end, {
        "Cloud_2_04_SRT_SPM_002_PM_002"
      }, "B4"},
      {function() return isWorldOpen("B5") end, {
        "311_SPM_000_PM_041", "315_TAM_002_PM_001"
      }, "B5"},
      {function() return isWorldOpen("B5") and not locked["Cube"] end, {
        "238_SPM_000_PM_018", "314_SPM_000_PM_012"
      }, "B5"},
      {function() return isWorldOpen("B5") and (not locked["Cube"] or not locked["Recorder"]) end, {
        "239_SPM_000_PM_018"
      }, "B5"},
      {function() return isWorldOpen("B5") and not locked["Connector"] and not locked["Fan"] end, {
        "Cloud_2_05_SRT_TAM_003_PM_003"
      }, "B5"},
      {function() return isWorldOpen("B6") end, {
        "113_SPM_000_PM_036"
      }, "B6"},
      {function() return isWorldOpen("B6") and not locked["Connector"] end, {
        "206_SPM_000_PM_021", "208_SPM_000_PM_014"
      }, "B6"},
      {function() return isWorldOpen("B7") end, {
        "118_SPM_000_PM_062", "224_SRT_SPM_000_PM_071", "224_SRT_SPM_000_PM_091",
      }, "B7"},
      {function() return isWorldOpen("B7") and not locked["Connector"] end, {
        "301_SPM_000_PM_010"
      }, "B7"},
      {function() return isWorldOpen("B7") and not locked["Cube"] end, {
        "402_SPM_000_PM_020"
      }, "B7"},
      {function() return isWorldOpen("B7") and not locked["Fan"] end, {
        "Cloud_2_07_SRT_TAM_001_PM_004"
      }, "B7"},
      {function() return isWorldOpen("B8") end, {
        "214_SRT_SPM_000_PM_025", "411_SRT_SPM_000_PM_014"
      }, "B8"},
      {function() return isWorldOpen("B8") and not locked["Connector"] and not locked["Cube"] end, {
        "306_SRT_SPM_000_PM_016"
      }, "B8"},      
      {function() return isWorldOpen("C1") end, {
        "114_SPM_000_PM_032", "219_SPM_000_PM_008", "312_SPM_000_PM_032", "416_SPM_000_PM_026",
        "Cloud_3_01_SRT_SPM_000_PM_017"
      }, "C1"},
      {function() return isWorldOpen("C2") end, {
        "217_SPM_000_PM_040", "403_SPM_000_PM_015", "417_SPM_000_PM_029", "418_SPM_000_PM_014",
        "Cloud_3_02_SRT_TAM_001"
      }, "C2"},
      {function() return isWorldOpen("C3") end, {
        "229_SPM_000_PM_070", "317_SPM_000_PM_024", "318_SPM_000_PM_026", "Cloud_3_03_SRT_SPM_000_PM_069"
      }, "C3"},
      {function() return isWorldOpen("C3") and not locked["Cube"] end, {
        "225_SPM_000_PM_044"
      }, "C3"},
      {function() return isWorldOpen("C4") end, {
        "216_SPM_000_PM_015",
      }, "C4"},
      {function() return isWorldOpen("C4") and not locked["Connector"] and (not locked["Cube"] or not locked["Recorder"] or not locked ["Platform"]) end, {
        "405_SRT_SPM_000_PM_050",
      }, "C4"},
      {function() return isWorldOpen("C4") and not locked["Connector"] end, {
        "313_SPM_000_PM_016",
      }, "C4"},
      {function() return isWorldOpen("C4") and not locked["Cube"] end, {
        "408_SPM_000_PM_033",
      }, "C4"},
      {function() return isWorldOpen("C4") and (not locked["Cube"] or not locked["Fan"]) end, {
        "408_SRT_SPM_000_PM_034"
      }, "C4"},
      {function() return isWorldOpen("C4")and ((not locked["Connector"] and not locked["Cube"]) or (not locked["Recorder"] and not locked["Platform"])) end, {
        "405_SRT_SPM_000_PM_047"
      }, "C4"},
      {function() return isWorldOpen("C5") end, {
        "232_SPM_000_PM_012", "328_SPM_000_PM_016", "Cloud_3_05_SRT_SPM_003_PM_012"
      }, "C5"},
      {function() return isWorldOpen("C5") and not locked["Cube"] end, {
        "309_SPM_000_PM_018", "404_SPM_000_PM_022", "Cloud_3_05_SRT_SPM_000_PM_035", "Cloud_3_05_SRT_SPM_002_PM_016"
      }, "C5"},
      {function() return isWorldOpen("C6") end, {
        "112_SPM_000_PM_034", "226_SPM_000_PM_039", "234_SPM_000_PM_015", "Cloud_3_06_SRT_SPM_000_PM_008"
      }, "C6"},
      {function() return isWorldOpen("C7") end, {
        "230_SPM_000_PM_019"
      }, "C7"},
      {function() return isWorldOpen("C7") and not locked["Cube"] end, {
        "227_SPM_002_PM_033", "233_SPM_000_PM_015", "308_SPM_000_PM_017", "Cloud_3_07_SRT_SPM_000_PM_021"
      }, "C7"},      
      {function() return isWorldOpen("C8") and not locked["Connector"] end, {
        "320_SRT_SPM_000_PM_046"
      }, "C8"},
      {function() return isWorldOpen("C8") and not locked["Connector"] and not locked["Cube"] end, {
        "235_SRT_SPM_000_PM_037", "504_SRT_SPM_000_PM_021"
      }, "C8"},      
      {function() return isWorldOpen("CMessenger") end, {
        "Islands_01_SRT_SPM_000_PM_003"
      }, "CMessenger"},
      {function() return not locked["F1"] and not locked["F2"] and not locked["F3"] and not locked["Cube"] end, {
        "LeapOfFaith_PM_010"
      }},
      {function() return not locked["F1"] and (not locked["Connector"] or not locked["F3"]) end, {
        "Secret_28_SRT_SPM_000_PM_004"
      }}
    }
  end
  
  -- Based on the marker lists randomize the sigils
  if mode == 1 or mode == 2 then
    local checkGates = true
    local addDelay = true
    local allSpots = false
    local placedItems = false
    local placedStars = false
    local availableMarkers = 0
    local openMarkers = {}
    
    local closedMarkers = {}
    local WorldA = {}
    local WorldB = {}
    local WorldC = {}    
    for i=1, #markers do
      if WorldANames[markers[i][3]] then
        table.insert(WorldA, i)
      elseif WorldBNames[markers[i][3]] then
        table.insert(WorldB, i)
      elseif WorldCNames[markers[i][3]] then
        table.insert(WorldC, i)
      else
        table.insert(closedMarkers, i)
      end
    end
    
    -- Adds all markers from provided locations to the global lists
    local function addWorldMarkers(worlds)
      if not worlds then return end
      for i=1, #worlds do
        table.insert(closedMarkers, worlds[i])
        open[markers[worlds[i]][3]] = true
      end
    end
    
    local arranger = ""
    local accessableArrangers = {}
    local lastHubs = {}
    if startHub == "A" then
      accessableArrangers = {"A Gate"}
      locked["A Gate"] = {"DI1", "DJ3", "DL1", "DZ2"}
      WorldA = addWorldMarkers(WorldA)
      lastHubs = {"B Gate", "C Gate"}
    elseif startHub == "B" then
      accessableArrangers = {"B Gate"}
      locked["B Gate"] = {"DI2", "DL2", "DT1", "DT2", "DZ3"}
      WorldB = addWorldMarkers(WorldB)
      lastHubs = {"A Gate", "C Gate"}
    elseif startHub == "C" then
      accessableArrangers = {"C Gate"}
      locked["C Gate"] = {"DJ4", "DJ5", "DL3", "DT3", "DT4", "DZ4"} 
      WorldC = addWorldMarkers(WorldC)
      lastHubs = {"A Gate", "B Gate"}
    end
    
    -- Place the provided sigils in accessable areas
    local function placeSigils(sigils)
      for i=1, #sigils do
        local index = rand(1, availableMarkers)
        for j=1, #openMarkers do
          if index > #markers[openMarkers[j]][2] then
            index = index - #markers[openMarkers[j]][2]
          else
            local randMarker = table.remove(markers[openMarkers[j]][2], index)
            if toTranslate then
              talosProgress:SetCode(translate[randMarker], tetroIndexes[sigils[i]])
            else
              talosProgress:SetCode(randMarker, tetroIndexes[sigils[i]])
            end
            tetroIndexes[sigils[i]] = nil
            availableMarkers = availableMarkers - 1
            if #markers[openMarkers[j]][2] == 0 then
              table.remove(openMarkers, j)
            end
            if DEBUG then
              printWarning(string.format("Placed %s at marker %s", sigils[i], randMarker))
            end
            break
          end
        end
      end
    end

    while not allSpots or #accessableArrangers > 0 do
      -- To make sure I don't hit the instruction limit per frame
      if addDelay then
        Wait(CustomEvent("OnStep"))
      end
      addDelay = not addDelay
      
      -- Find the markers that are currently accessable
      local toRemove = {}
      for i=1, #closedMarkers do
        local index = closedMarkers[i]
        if markers[index][1]() then
          table.insert(openMarkers, index)
          table.insert(toRemove, i)
          availableMarkers = availableMarkers + #markers[index][2]
          if DEBUG then
            print("Added " .. #markers[index][2] .. " new markers")
          end
        end
      end
      -- If I don't do it this way it'll skip stuff when the indexes move down
      for i=1, #toRemove do
        table.remove(closedMarkers, toRemove[i] - (i - 1))
      end
      if DEBUG then
        print(availableMarkers .. " total markers accessable")
      end
      
      --[[
        To try make sure all spots unlock, and we don't end up skipping
         sigils we unlock arrangers in four steps:
        1. Hubs
        2. Star worlds
        3. Items + Tower to F3 (until all markers unlocked)
        4. Everything else
        This is probably  not 100% reliable, but that would need a full rewrite
      ]]--
      if not allSpots then
        if (WorldA or WorldB or WorldC) or (locked["A Star"] or locked["B Star"] or locked["C Star"]) then
          if (WorldA or WorldB or WorldC) then
            if arranger == "A Gate" and startHub == "A" then
              table.insert(accessableArrangers, "B Gate")
              table.insert(accessableArrangers, "C Gate")
            elseif arranger == "B Gate" and startHub == "B" then
              table.insert(accessableArrangers, "A Gate")
              table.insert(accessableArrangers, "C Gate")
            elseif arranger == "C Gate" and startHub == "C" then
              table.insert(accessableArrangers, "A Gate")
              table.insert(accessableArrangers, "B Gate")
            end
          elseif not placedStars then
            placedStars = true
            table.insert(accessableArrangers, "A Star")
            table.insert(accessableArrangers, "B Star")
            table.insert(accessableArrangers, "C Star")
          end          
        else
          if not placedItems then
            placedItems = true
            table.insert(accessableArrangers, "Connector")
            table.insert(accessableArrangers, "Cube")
            table.insert(accessableArrangers, "Fan")
            table.insert(accessableArrangers, "Recorder")
            table.insert(accessableArrangers, "Platform")
            table.insert(accessableArrangers, "F1")
            table.insert(accessableArrangers, "F3")
            if mode == 2 then
              table.insert(accessableArrangers, "F2")
            end
          elseif placedItems and #closedMarkers == 0 then
            allSpots = true
            if DEBUG then
              print("All markers unlocked")
            end
            table.insert(accessableArrangers, "F4")
            table.insert(accessableArrangers, "F5")
            table.insert(accessableArrangers, "F6")
            table.insert(accessableArrangers, "A1 Gate")
            -- 60fps needs F2 earlier, but not uncapped
            if mode ~= 2 then
              table.insert(accessableArrangers, "F2")
            end
          end
        end
      end
      
      local index = rand(1, #accessableArrangers)
      arranger = table.remove(accessableArrangers, index)
      local sigils = locked[arranger]
      locked[arranger] = nil
      if DEBUG then
        print("Selected " .. arranger .. " Arranger")
      end
      if not sigils then
        printError(arranger .. " does not have any sigils assigned to it")
      end
      
      --[[
        Make sure you can't go to the wrong hub first and softlock.
        Sometimes does this by unlocking both, but usually by hiding
         required sigils outside of the first hub
        Requires at least two sigils in each hub to always be unlockable
        Don't need to this do both times you unlock a new hub.
      ]]--
      if checkGates then
        if arranger == lastHubs[1] or arranger == lastHubs[2] then
          -- Sometimes we want both hubs to be accessable when you leave A
          if rand(0, 99) < PROB_BOTH_HUBS then
            if DEBUG then
              print("Both Hubs open after " .. startHub)
            end
            
            -- If so we're going to manually add the sigils for both
            if startHub == "A" then
              sigils = {"DI2", "DL2", "DT1", "DT2", "DZ3",
                        "DJ4", "DJ5", "DL3", "DT3", "DT4", "DZ4"}
            elseif startHub == "B" then
              sigils = {"DI1", "DJ3", "DL1", "DZ2",
                        "DJ4", "DJ5", "DL3", "DT3", "DT4", "DZ4"}     
            elseif startHub == "C" then
              sigils = {"DI1", "DJ3", "DL1", "DZ2",
                        "DI2", "DL2", "DT1", "DT2", "DZ3"}
            end
            
            -- If we're unlocking both we don't need to fix the other world
            locked["A1 Gate"] = {"DJ1", "DJ2", "DZ1"}
            
            -- Only one of these will be left in the table by this point
            for i=1, #accessableArrangers do
              local v = accessableArrangers[i]
              if v == "A Gate" or v == "B Gate" or v == "C Gate" then
                table.remove(accessableArrangers, i)
                break
              end
            end
            -- This stuff just does nothing if it's already nil
            locked["A Gate"] = nil
            locked["B Gate"] = nil
            locked["C Gate"] = nil
            WorldA = addWorldMarkers(WorldA)
            WorldB = addWorldMarkers(WorldB)
            WorldC = addWorldMarkers(WorldC)
          else
            if DEBUG then
              print(string.sub(arranger, 1, 1) .. " open after " .. startHub)
            end
            --[[
              Based on world order, these are the sigils that
               need to be locked:
              ABC and CBA -> JJJ lock
              BAC and CAB -> T lock
              ACB and BCA -> I lock
              We now get a list of these sigils to lock, and fix
               the sigils for the other gates
            ]]--
            local uniqueSigils = {}
            if arranger == "A Gate" then
              if startHub == "B" then
                uniqueSigils = {"DT3"}
                locked["C Gate"] = {"DJ4", "DJ5", "DL3", "DT4", "DZ4"}
              elseif startHub == "C" then
                uniqueSigils = {"DT1"}
                locked["B Gate"] = {"DI2", "DL2", "DT2", "DZ3"}
              end
              locked["A1 Gate"] = {"DJ1", "DJ2", "DZ1"}
              sigils = {"DI1", "DJ3", "DL1", "DZ2"}
              WorldA = addWorldMarkers(WorldA)
            elseif arranger == "B Gate" then
              if startHub == "A" then
                uniqueSigils = {"DJ1", "DJ4", "DJ5"}
                locked["A1 Gate"] = {"DJ2", "DZ1"}
                locked["C Gate"] = {"DL3", "DT3", "DT4", "DZ4"}
              elseif startHub == "C" then
                uniqueSigils = {"DJ1", "DJ2", "DJ3"}
                locked["A1 Gate"] = {"DZ1"}
                locked["A Gate"] = {"DI1", "DL1", "DZ2"}
              end
              sigils = {"DI2", "DL2", "DT1", "DT2", "DZ3"}
              WorldB = addWorldMarkers(WorldB)
            elseif arranger == "C Gate" then
              if startHub == "A" then
                uniqueSigils = {"DI2"}
                locked["B Gate"] = {"DL2", "DT1", "DT2", "DZ3"}
              elseif startHub == "B" then
                uniqueSigils = {"DI1"}
                locked["A Gate"] = {"DJ3", "DL1", "DZ2"}
              end
              locked["A1 Gate"] = {"DJ1", "DJ2", "DZ1"}
              sigils = {"DJ4", "DJ5", "DL3", "DT3", "DT4", "DZ4"}
              WorldC = addWorldMarkers(WorldC)
            end
            
            -- Find the markers this world unlocked
            local tempOpenMarkers = {}
            local tempAvailableMarkers = 0
            for i=1, #closedMarkers do
              local index = closedMarkers[i]
              if markers[index][1]() then
                table.insert(tempOpenMarkers, index)
                tempAvailableMarkers = tempAvailableMarkers + #markers[index][2]
              end
            end
            if DEBUG then
              print("Found " .. tempAvailableMarkers .. " newly-available spots")
            end
            
            -- Place the unique sigils in the new spots
            for i=1, #uniqueSigils do
              local index = rand(1, tempAvailableMarkers)
              for j=1, #tempOpenMarkers do
                if index > #markers[tempOpenMarkers[j]][2] then
                  index = index - #markers[tempOpenMarkers[j]][2]
                else
                  local randMarker = table.remove(markers[tempOpenMarkers[j]][2], index)
                  if toTranslate then
                    talosProgress:SetCode(translate[randMarker], tetroIndexes[uniqueSigils[i]])
                  else
                    talosProgress:SetCode(randMarker, tetroIndexes[uniqueSigils[i]])
                  end
                  tetroIndexes[uniqueSigils[i]] = nil
                  tempAvailableMarkers = tempAvailableMarkers - 1
                  --[[
                    We don't bother removing empty tables here,
                     unlike placeSigils(), because worst case we
                     iterate over it just twice more
                  ]]--
                  if DEBUG then
                    printWarning(string.format("Placed %s at marker %s", uniqueSigils[i], randMarker))
                  end            
                  break
                end
              end
            end
            if DEBUG then
              print("Finished locking unique sigils")
            end
          end
          -- We need to add A1 gate at some point, might as well do it here
          checkGates = false
        end
      else -- if not checkGates then
        if arranger == "A Gate" then
          WorldA = addWorldMarkers(WorldA)
        elseif arranger == "B Gate" then
          WorldB = addWorldMarkers(WorldB)
        elseif arranger == "C Gate" then
          WorldC = addWorldMarkers(WorldC)
        end
      end
      
      placeSigils(sigils)
    end
  
  -- Fully Random
  elseif mode == 3 then
    -- Knuth randomization
    for i = 1, #markers do
      local otherMarker = markers[rand(1, i)]
      if DEBUG then
        print(string.format("Swapping %s with %s", markers[i], otherMarker))
      end      
      talosProgress:SetCode(markers[i], talosProgress:GetCodeValue(otherMarker))
      talosProgress:SetCode(otherMarker, i)
    end
  end
  
  talosProgress:SetVar("Randomizer_Generated")
  talBackupAndSaveTalosProgress(worldInfo)
  if DEBUG then
    print("=======================\n Randomization Finished\n=======================")
  else
    print("Randomization Finished")
  end
end

-- Now that Randomization's finished we can use RunAsync()
RunAsync(function()
  -- Move sigils to the correct positions
  for i=1, #worldMarkers do
    local worldMarker = worldMarkers[i]
    local sigilNum = talosProgress:GetCodeValue(worldMarker:GetName())
    local sigil = worldGlobals.allTetros[sigilNum]
    assert(sigil ~= nil, "Marker " .. worldMarker:GetName() .. " does not have a sigil assigned to it!")
    sigil:SetPlacement(worldMarker:GetPlacement())
    if DEBUG then
      printWarning(string.format("Moving %s to %s", sigil:GetName(), worldMarker:GetName()))
    end
  end
end)

RunAsync(function()
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
      C1, C2, C3, C4, C5, C6, C7, C8, CMessenger
    }
    
    local portalNum = talosProgress:GetCodeValue(emptyPortal:GetName())
    local portal = allPortals[portalNum]
    
    local emptyPos = emptyPortal:GetPlacement()
    local portalPos = portal:GetPlacement()
    emptyPortal:SetPlacement(portalPos)
    portal:SetPlacement(emptyPos)
    
    if DEBUG then
      printWarning(string.format("Placing %s at %s", portal:GetName(),  emptyPortal:GetName()))
    end
  end
end)

Wait(CustomEvent("OnStep"))
SignalEvent("Randomizer_Finished")"�Tʢ4=���F+bD���ȸNs���<3��<��9���ƾ��W?7Sa��DGs�WxEC��E�X2���֎�X2~�96^�hM�e�őeOQݑϤ������*�-�XR���.����۴[D�4�?v�nƑ1�zx�q�	ɻN�t/M��U�`*d`�SԷ�W8��4�n@.�ՠ�����XM)��O���V����i��o�0h�w��A�X:� �J����{I��R%BE�o�'��vu