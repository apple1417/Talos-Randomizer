SIGSTRM12GIS             ��b                  Signkey.EditorSignaturej���B:��UM���s�YW1z(�G됬�Si_n��iE�g�`v2Q�R�Rx�X?���4�s~}�I��U22��}+&��F�~EK�u/������
W!y@�[2:s=�F�w �˳�a7���+M5B^�Ф8�_���U�$�Lb3���="��?�#C:mOK�:���g�v(à
N��+sV"�����������̿f�f�a��+�ȴC�<k�|��<D�Cw��|��k��*��'�2̴���﻿print("Loaded randomizer v4")

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

if not talosProgress:IsVarSet("Randomizer_Generated") then
  print("Generating Sigil Configuration")
  local mode = talosProgress:GetCodeValue("Randomizer_Mode")
  if mode == -1 then
    mode = 1
  end
  print("Using Mode", mode)

  local seed = talosProgress:GetCodeValue("Randomizer_Seed")
  if seed == -1 then
    seed = mthRndRangeL(0, 0x7fffffff)
    talosProgress:SetCode("Randomizer_Seed", seed)
  end
  print("Using Seed", seed)
  
  --[[
  Blum Blum Shub Randomizer
   Unlike the built-in, we can seed this
   Any 32-bit value (and a few more) should be possible
   Haven't checked but it shouldn't be possible to timeout the script
    with a bad seed
  ]]--
  while seed % 53327 == 0 or seed % 95651 == 0 do
    seed = seed + 1
  end
  local rngState =  4 + seed^2 % 0x13007bd4d
  local function rand(min, max)
    rngState = rngState^2 % 0x13007bd4d
    return mthFloorF((rngState * (max - min))/0x13007bd4c + min)
  end
  
  talosProgress:SetVarValue("PaintItemSeed", rand(0, 8909478))
  
  -- Only really works with tables indexed by numbers
  local function joinTables(...)
    if arg.n == 1 then return arg[1] end
    local out = {}
    for i=1,arg.n do
      for j=1,#arg[i] do
        table.insert(out, arg[i][j])
      end
    end
    return out
  end

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
    ["A1 Gate"] = {"DJ1", "DJ2", "DZ1"},
    ["A Gate"] = {"DI1", "DJ3", "DL1", "DZ2"},
    ["B Gate"] = {"DI2", "DL2", "DT1", "DT2", "DZ3"},
    ["C Gate"] = {"DJ4", "DJ5", "DL3", "DT3", "DT4", "DZ4"},
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
  
  -- Default
  if mode == 1 then
    markers = {
      -- A
      [function() return true end] = {
        "001a_SPM_000_PM_008", "001_SPM_000_PM_005", "005_SPM_000_PM_009", "006_SPM_000_PM_003",
        "007_SPM_000_PM_006", "008_SPM_000_PM_016", "011_SPM_000_PM_009", "012_SPM_000_PM_004",
        "013_SPM_000_PM_006", "015_SRT_SPM_000_PM_017", "015_SRT_SPM_000_PM_018", "017_SPM_000_PM_023",
        "020_SPM_000_PM_014", "107_SPM_000_PM_007", "108_SPM_000_PM_012", "111_SPM_000_PM_012",
        "201_SPM_000_PM_013", "201_SRT_SPM_000_PM_004", "202b_SPM_000_PM_004", "202c_SPM_000_PM_003",
        "202e_SPM_000_PM_004", "202f_SPM_000_PM_003", "220_SPM_000_PM_032", "204_SPM_000_PM_004",
        "207_SPM_000_PM_005", "209_SPM_000_PM_012", "210_SPM_000_PM_015", "211_SPM_000_PM_008",
        "212_SPM_000_PM_017", "218_SPM_000_PM_016", "244_SPM_000_PM_008", "244_SRT_SPM_000_PM_006",
        "303_SPM_000_PM_010", "305_SPM_000_PM_004", "Cloud_1_02_SRT_SPM_000_PM_016", "Cloud_1_02_SRT_SPM_001_PM_003",
        "Cloud_1_03_SRT_SPM_000_PM_005", "Cloud_1_04_SRT_SPM_000_PM_007", "Cloud_1_06_SRT_SPM_000_PM_007", "Cloud_1_07_SRT_SPM_000_PM_021"
      },
      [function() return not locked["Connector"] end] = {
        "202d_SPM_000_PM_002"
      },
      -- B
      [function() return not locked["B Gate"] end] = {
        "113_SPM_000_PM_036", "118_SPM_000_PM_062", "120_SPM_000_PM_029", "203_SPM_000_PM_011",
        "205_SPM_000_PM_003", "206_SPM_000_PM_021", "208_SPM_000_PM_014", "213_SPM_000_PM_010",
        "215_SPM_000_PM_013", "221_SPM_002_PM_001", "222_SPM_004_PM_001", "223_SPM_000_PM_009",
        "224_SRT_SPM_000_PM_071", "224_SRT_SPM_000_PM_091", "238_SPM_000_PM_018", "239_SPM_000_PM_018",
        "300a_SPM_000_PM_007", "301_SPM_000_PM_010", "302_SPM_000_PM_008", "310_SPM_000_PM_024",
        "311_SPM_000_PM_041", "314_SPM_000_PM_012", "315_TAM_002_PM_001", "316_SPM_000_PM_014",
        "319_SPM_000_PM_008", "321_SPM_000_PM_005", "322_SPM_000_PM_008", "401_SPM_004_PM_008",
        "402_SPM_000_PM_020", "407_SPM_000_PM_018", "409_SPM_000_PM_024", "414_SPM_000_PM_007",
        "Cloud_2_01_SRT_SPM_000_PM_004", "Cloud_2_02_SRT_SPM_000_PM_039", "Cloud_2_03_SRT_SPM_002_PM_013", "Cloud_2_04_SRT_SPM_000_PM_017"
      },
      [function() return not locked["B Gate"] and not locked["Connector"] end] = {
        "Cloud_2_04_SRT_SPM_002_PM_002"
      },
      [function() return not locked["B Gate"] and not locked["Connector"] and not locked["Fan"] end] = {
        "Cloud_2_05_SRT_TAM_003_PM_003"
      },
      [function() return not locked["B Gate"] and not locked["Fan"] end] = {
        "Cloud_2_07_SRT_TAM_001_PM_004"
      },
      -- C
      [function() return not locked["C Gate"] end] = {
        "112_SPM_000_PM_034", "114_SPM_000_PM_032", "216_SPM_000_PM_015", "217_SPM_000_PM_040",
        "219_SPM_000_PM_008", "225_SPM_000_PM_044", "226_SPM_000_PM_039", "227_SPM_002_PM_033",
        "229_SPM_000_PM_070", "230_SPM_000_PM_019", "232_SPM_000_PM_012", "233_SPM_000_PM_015",
        "234_SPM_000_PM_015", "308_SPM_000_PM_017", "309_SPM_000_PM_018", "312_SPM_000_PM_032",
        "313_SPM_000_PM_016", "317_SPM_000_PM_024", "318_SPM_000_PM_026", "328_SPM_000_PM_016",
        "403_SPM_000_PM_015", "404_SPM_000_PM_022", "405_SRT_SPM_000_PM_047", "405_SRT_SPM_000_PM_050",
        "408_SPM_000_PM_033", "408_SRT_SPM_000_PM_034", "416_SPM_000_PM_026", "417_SPM_000_PM_029",
        "418_SPM_000_PM_014", "Cloud_3_01_SRT_SPM_000_PM_017", "Cloud_3_02_SRT_TAM_001", "Cloud_3_03_SRT_SPM_000_PM_069",
        "Cloud_3_05_SRT_SPM_003_PM_012", "Cloud_3_06_SRT_SPM_000_PM_008", "Cloud_3_07_SRT_SPM_000_PM_021", "Islands_01_SRT_SPM_000_PM_003"
      },
      [function() return not locked["C Gate"] and not locked["Cube"] end] = {
        "Cloud_3_05_SRT_SPM_002_PM_016", "Cloud_3_05_SRT_SPM_000_PM_035"
      },
      -- A Star
      [function()
        if not locked["A Star"] and not locked["B Star"] and not locked["C Star"] then
          return true
        end        
        return not locked["A Star"] and locked["B Gate"] and locked["C Gate"]
      end] = {
        "115_SRT_TAM_004_PM_016", "117_SRT_SPM_000_PM_028", "119_SRT_SPM_000_PM_033"
      },
      -- B Star
      [function() return not locked["A Star"] and not locked["B Star"] and not locked["C Star"] end] = {
        "214_SRT_SPM_000_PM_025", "306_SRT_SPM_000_PM_016", "411_SRT_SPM_000_PM_014"
      },
      -- C Star
      [function() return not locked["A Star"] and not locked["B Star"] and not locked["C Star"] end] = {
        "235_SRT_SPM_000_PM_037", "320_SRT_SPM_000_PM_046", "504_SRT_SPM_000_PM_021"
      },
      -- Nexus
      [function() return not locked["F3"] end] = {
        "LeapOfFaith_PM_010"
      },
      [function() return (not locked["Connector"] and not locked["C Gate"] and not locked["F1"]) or not locked["F3"] end] = {
        "Secret_28_SRT_SPM_000_PM_004"
      }
    }
    
  -- 60FPS
  elseif mode == 2 then
    markers = {
      -- A
      [function() return true end] = {
        "001a_SPM_000_PM_008", "001_SPM_000_PM_005", "005_SPM_000_PM_009", "006_SPM_000_PM_003",
        "007_SPM_000_PM_006", "008_SPM_000_PM_016", "011_SPM_000_PM_009", "012_SPM_000_PM_004",
        "013_SPM_000_PM_006", "015_SRT_SPM_000_PM_017", "015_SRT_SPM_000_PM_018", "017_SPM_000_PM_023",
        "020_SPM_000_PM_014", "107_SPM_000_PM_007", "108_SPM_000_PM_012", "111_SPM_000_PM_012",
        "201_SPM_000_PM_013", "201_SRT_SPM_000_PM_004", "202b_SPM_000_PM_004", "202c_SPM_000_PM_003",
        "202e_SPM_000_PM_004", "202f_SPM_000_PM_003", "220_SPM_000_PM_032", "204_SPM_000_PM_004",
        "207_SPM_000_PM_005", "209_SPM_000_PM_012", "210_SPM_000_PM_015", "211_SPM_000_PM_008",
        "212_SPM_000_PM_017", "218_SPM_000_PM_016", "244_SPM_000_PM_008", "244_SRT_SPM_000_PM_006",
        "303_SPM_000_PM_010", "305_SPM_000_PM_004", "Cloud_1_02_SRT_SPM_000_PM_016", "Cloud_1_02_SRT_SPM_001_PM_003",
        "Cloud_1_03_SRT_SPM_000_PM_005", "Cloud_1_04_SRT_SPM_000_PM_007", "Cloud_1_06_SRT_SPM_000_PM_007", "Cloud_1_07_SRT_SPM_000_PM_021"
      },
      [function() return not locked["Connector"] end] = {
        "202d_SPM_000_PM_002"
      },
      -- B
      [function() return not locked["B Gate"] end] = {
        "113_SPM_000_PM_036", "118_SPM_000_PM_062", "120_SPM_000_PM_029", "213_SPM_000_PM_010",
        "223_SPM_000_PM_009", "224_SRT_SPM_000_PM_071", "224_SRT_SPM_000_PM_091", "311_SPM_000_PM_041",
        "315_TAM_002_PM_001", "319_SPM_000_PM_008", "Cloud_2_02_SRT_SPM_000_PM_039"
      },
      [function() return not locked["B Gate"] and not locked["Connector"] end] = {
        "206_SPM_000_PM_021", "208_SPM_000_PM_014", "215_SPM_000_PM_013", "301_SPM_000_PM_010",
        "414_SPM_000_PM_007"
      },
      [function() return not locked["B Gate"] and not locked["Connector"] and not locked["Cube"] end] = {
        "310_SPM_000_PM_024", "Cloud_2_04_SRT_SPM_000_PM_017"
      },
      [function() return not locked["B Gate"] and not locked["Connector"] and not locked["Fan"] end] = {
        "Cloud_2_05_SRT_TAM_003_PM_003"
      },
      [function()
        return not locked["B Gate"]
               and ((not locked["Connector"] and not locked["Cube"])
                    or not locked["Recorder"])
      end] = {
        "321_SPM_000_PM_005", "407_SPM_000_PM_018"
      },
      [function() return not locked["B Gate"] and (not locked["Connector"] or not locked["Cube"]) end] = {
        "203_SPM_000_PM_011", "205_SPM_000_PM_003", "302_SPM_000_PM_008", "Cloud_2_01_SRT_SPM_000_PM_004"
      },
      [function() return not locked["B Gate"] and (locked["Connector"] or not locked["Cube"]) end] = {
        "401_SPM_004_PM_008", "409_SPM_000_PM_024"
      },
      [function() return not locked["B Gate"] and not locked["Connector"] and (not locked["Cube"] or not locked["Fan"]) end] = {
        "Cloud_2_04_SRT_SPM_002_PM_002"
      },
      [function() return not locked["B Gate"] and not locked["Cube"] end] = {
        "221_SPM_002_PM_001", "222_SPM_004_PM_001", "238_SPM_000_PM_018", "300a_SPM_000_PM_007",
        "314_SPM_000_PM_012", "316_SPM_000_PM_014", "402_SPM_000_PM_020", "Cloud_2_03_SRT_SPM_002_PM_013"
      },
      [function() return not locked["B Gate"] and (not locked["Cube"] or not locked["Recorder"]) end] = {
        "239_SPM_000_PM_018", "322_SPM_000_PM_008"
      },
      [function() return not locked["B Gate"] and not locked["Fan"] end] = {
        "Cloud_2_07_SRT_TAM_001_PM_004"
      },
      -- C
      [function() return not locked["C Gate"] end] = {
        "112_SPM_000_PM_034", "114_SPM_000_PM_032", "216_SPM_000_PM_015", "217_SPM_000_PM_040",
        "219_SPM_000_PM_008", "226_SPM_000_PM_039",
        "229_SPM_000_PM_070", "230_SPM_000_PM_019", "232_SPM_000_PM_012",
        "234_SPM_000_PM_015", "312_SPM_000_PM_032",
        "317_SPM_000_PM_024", "318_SPM_000_PM_026", "328_SPM_000_PM_016",
        "403_SPM_000_PM_015",
        "408_SPM_000_PM_033", "416_SPM_000_PM_026", "417_SPM_000_PM_029",
        "418_SPM_000_PM_014", "Cloud_3_01_SRT_SPM_000_PM_017", "Cloud_3_02_SRT_TAM_001", "Cloud_3_03_SRT_SPM_000_PM_069",
        "Cloud_3_05_SRT_SPM_003_PM_012", "Cloud_3_06_SRT_SPM_000_PM_008", "Islands_01_SRT_SPM_000_PM_003"
      },
      [function() return not locked["C Gate"] and not locked["Connector"] end] = {
        "313_SPM_000_PM_016"
      },
      [function()
        return not locked["C Gate"] and not locked["Connector"]
               and (not locked["Cube"] or not locked["Recorder"] or not locked["Platform"])
      end] = {
        "405_SRT_SPM_000_PM_050"
      },
      [function() return not locked["C Gate"] and not locked["Cube"] end] = {
        "225_SPM_000_PM_044", "227_SPM_002_PM_033", "233_SPM_000_PM_015", "308_SPM_000_PM_017",
        "309_SPM_000_PM_018", "404_SPM_000_PM_022", "Cloud_3_05_SRT_SPM_002_PM_016", "Cloud_3_05_SRT_SPM_000_PM_035",
        "Cloud_3_07_SRT_SPM_000_PM_021" 
      },
      [function() return not locked["C Gate"] and (not locked["Cube"] or not locked["Fan"]) end] = {
        "408_SRT_SPM_000_PM_034"
      },
      [function()
        return not locked["C Gate"]
               and ((not locked["Connector"] and not locked["Cube"])
                   or (not locked["Recorder"] and not locked["Platform"]))
      end] = {
        "405_SRT_SPM_000_PM_047"
      },
      -- A Star
      [function()
        if not locked["A Star"] and not locked["B Star"] and not locked["C Star"] then
          return true
        end        
        return not locked["A Star"] and locked["B Gate"] and locked["C Gate"]
      end] = {
        "115_SRT_TAM_004_PM_016", "117_SRT_SPM_000_PM_028", "119_SRT_SPM_000_PM_033"
      },
      -- B Star
      [function() return not locked["A Star"] and not locked["B Star"] and not locked["C Star"] end] = {
        "214_SRT_SPM_000_PM_025", "411_SRT_SPM_000_PM_014"
      },
      [function()
        return not locked["A Star"] and not locked["B Star"] and not locked["C Star"]
               and not locked["Connector"] and not locked["Cube"]
      end] = {
        "306_SRT_SPM_000_PM_016"
      },
      -- C Star
      [function()
        return not locked["A Star"] and not locked["B Star"] and not locked["C Star"]
               and not locked["Connector"]
      end] = {
        "320_SRT_SPM_000_PM_046"
      },
      [function()
        return not locked["A Star"] and not locked["B Star"] and not locked["C Star"]
               and not locked["Connector"] and not locked["Cube"]
      end] = {
        "504_SRT_SPM_000_PM_021"
      },
      [function()
        return (not locked["A Star"] and not locked["B Star"] and not locked["C Star"])
                and ((not locked["Connector"] and not locked["Cube"]) 
                     or (not locked["Cube"] and not locked["Fan"]))
      end] = {
        "235_SRT_SPM_000_PM_037",
      },
      -- Nexus
      [function() return (not locked["F3"] and not locked["Cube"]) or not locked["F5"] end] = {
        "LeapOfFaith_PM_010"
      },
      [function() return (not locked["Connector"] and not locked["C Gate"] and not locked["F1"]) or not locked["F3"] end] = {
        "Secret_28_SRT_SPM_000_PM_004"
      }
    }
  end
  
  --[[
  Both Default and 60FPS can use the same code here, just need
   to have defined the marker list first
  ]]--
  if mode == 1 or mode == 2 then
    local arranger = ""
    local accessableArrangers = {"A Gate", "A Star", "Connector", "Cube"}
    local accessableMarkers = {}
    
    while #accessableArrangers > 0 do
      local index = rand(1, #accessableArrangers)
      local arranger = accessableArrangers[index]
      table.remove(accessableArrangers, index)
      
      if arranger == "A Gate" then
        table.insert(accessableArrangers, "B Gate")
        table.insert(accessableArrangers, "C Gate")
        table.insert(accessableArrangers, "F1")
      elseif arranger == "B Gate" then
        table.insert(accessableArrangers, "Fan")
        table.insert(accessableArrangers, "Recorder")
        table.insert(accessableArrangers, "B Star")
      elseif arranger == "C Gate" then
        table.insert(accessableArrangers, "Platform")
        table.insert(accessableArrangers, "C Star")
      elseif arranger == "F1" then
        table.insert(accessableArrangers, "F2")
        table.insert(accessableArrangers, "F3")
        table.insert(accessableArrangers, "F6")
      elseif arranger == "F3" then
        table.insert(accessableArrangers, "F4")
      elseif arranger == "F4" then
        table.insert(accessableArrangers, "F5")
      end
      
      for requirements, newMarkers in pairs(markers) do
        if requirements() then
          accessableMarkers = joinTables(accessableMarkers, newMarkers)
          accessableMarkers[requirements] = nil
          markers[requirements] = nil
        end
      end
      
      local sigils = locked[arranger]
      for _,v in pairs(sigils) do
        local index = rand(1, #accessableMarkers)
        --assert(not talosProgress:IsVarSet(accessableMarkers[index]), "Marker " .. accessableMarkers[index] .. " has already been selected")
        talosProgress:SetCode(accessableMarkers[index], tetroIndexes[v])
        table.remove(accessableMarkers, index)
        tetroIndexes[v] = nil
      end
      locked[arranger] = nil       
    end
    
    local sigils = locked["A1 Gate"]
    for _,v in pairs(sigils) do
      local index = rand(1, #accessableMarkers)
      talosProgress:SetCode(accessableMarkers[index], tetroIndexes[v])
      table.remove(accessableMarkers, index)
      tetroIndexes[v] = nil
    end
  
  -- Fully Random
  elseif mode == 3 then
    -- Knuth randomization
    for i = 1, #markers do
      local otherMarker = markers[rand(1, i)]
      talosProgress:SetCode(markers[i], talosProgress:GetCodeValue(otherMarker))
      talosProgress:SetCode(otherMarker, i)
    end
  end
  
  talosProgress:SetVar("Randomizer_Generated")
end

-- Move sigils onto markers in this world
for _, worldMarker in pairs(worldMarkers) do
  local sigilNum = talosProgress:GetCodeValue(worldMarker:GetName())
  local sigil = worldGlobals.allTetros[sigilNum]
  assert(sigil ~= nil, "Marker " .. worldMarker:GetName() .. " does not have a sigil assigned to it!")
  sigil:SetPlacement(worldMarker:GetPlacement())
end

SignalEvent("Randomizer_Finished")#����yxڼ���v���]���q@��NvQ�}&ۓ�$��������M���KhF���=�p�%�'<��@}˅��L%�i}G��9�Dw榢P�(M̙�R�ٗs�|�5�p�'��h�h*a��v��K�d�
��L�-5��l1�M�%pQ.H�e�(������c&���3�;�Y݃���9���N��4�QFe�>Ć����;�!��U� 񉍬�GR=���[p*�=�����C�U�x��H����<\