SIGSTRM12GIS             I	��                  Signkey.EditorSignature9_E+�)�����m���M�����5/��Г�~�A&I#U�ڜ�⒯]L�ӕ��Cݪ�I�j�Ҩw(F=��Q^�@ֵ�D�w�U9I�����Rp%�5R|�H2X�ܫ�9�1������}+S9��l	;�u�q���z�$� roĪ'��T�}Qƭ���Va��3̑Z[��l�����mC+�;1�=c���~^�� �POMˏ���:�<`j�Zx���{P)��9fm�"L69�즷&�﻿--[[
  This is the big script, the one that does everything
  It's in every world but A and B messenger
  It generates the full random sigil/portal configuration
  This is the oldest script in the whole project, there'll be stuff
   that looks weird
]]--

--[[
  The normal print function doesn't output to console in game,
   only in the editor
  The con__F() functions don't print a newline, and only accept
   one argument, so these are just some nice wrappers
]]--
local function print(...)
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

-- Make them accessable to other scripts
worldGlobals.print = print
worldGlobals.printWarning = printWarning
worldGlobals.printError = printError

print("Loaded Randomizer v12.0.1")

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)
local PROB_BOTH_HUBS = 25

--[[
  Debug mode is kind of hidden, you need to use a command to activate it,
   but everything tends to work now so it doesn't need a switch
]]--
local DEBUG = talosProgress:IsVarSet("Randomizer_Debug")

-- Where the magic happens
if not talosProgress:IsVarSet("Randomizer_Generated") then
  print("Randomizing...")
  -- We have to store this as a number, so converted it for readability
  local randomization_mode = talosProgress:GetCodeValue("Randomizer_Mode")
  if randomization_mode == -1 then
    randomization_mode = 1
    talosProgress:SetVarValue("Randomizer_Mode", 1)
  end
  local modes = {"None", "Default", "60fps", "Fully Random", "Intended", "Hardmode", "60FPS Hardmode"}
  randomization_mode = modes[randomization_mode + 1]
  print("Using randomization mode: ".. randomization_mode)

  local seed = talosProgress:GetCodeValue("Randomizer_Seed")
  if seed == -1 then
    seed = mthRndRangeL(0, 2147483647)
    talosProgress:SetCode("Randomizer_Seed", seed)
  end
  print("Using Seed", seed)

  --[[
    Linear congruential generator using Microsoft VC++ seeds
    Unlike the built-in, we can seed this
    Gives intergers from min to max inclusive
    Thanks Darkid :)
  ]]--
  local function rand(min, max)
    seed = (214013 * seed + 2531011) % 2147483648
    if min == max then return min end
    return (seed % (max - (min - 1))) + min
  end

  -- Set the few things that are normally random based on seed
  talosProgress:SetVarValue("PaintItemSeed", rand(0, 8909478))
  talosProgress:SetVarValue("Code_Floor4", rand(1, 999))
  talosProgress:SetVarValue("Code_Floor5", rand(1, 999))
  local codeF6 = 0
  for i=1,3 do
    local digit = rand(4, 9) -- Yes this is right
    talosProgress:SetVarValue("Code_Floor6" .. tostring(i), digit)
    -- This line means you can guess the code without visiting each world
    talosProgress:SetVar("Code_Floor6DigitSeen" .. tostring(i))
    codeF6 = codeF6*10 + digit
  end
  talosProgress:SetVarValue("Code_Floor6", codeF6)

  -- Again we can only save numbers, so this is how tetros are ordered
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
    ["NZ3"] =126, ["NZ4"] =127, ["NZ5"] =128, ["NZ6"] =129
  }

  --[[
    More readable names than just the marker names we save them as
    The sigil names are the same as in MarkerNames.txt, with the
     world name as a prefix
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
    ["C6-Seven Doors"] = "234_SPM_000_PM_015", ["C6-Star"] = "Cloud_3_06_SRT_SPM_000_PM_008", ["C6-Circumlocution"] = "226_SPM_000_PM_039", ["C6-Two Way Street"] = "112_SPM_000_PM_034",
    ["C7-Carrier Pigeons"] = "230_SPM_000_PM_019", ["C7-DMS"] = "308_SPM_000_PM_017", ["C7-Star"] = "Cloud_3_07_SRT_SPM_000_PM_021", ["C7-Prison Break"] = "227_SPM_002_PM_033", ["C7-Crisscross"] = "233_SPM_000_PM_015",
    ["C*-Unreachable Garden"] = "235_SRT_SPM_000_PM_037", ["C*-Nexus"] = "320_SRT_SPM_000_PM_046", ["C*-Cobweb"] = "504_SRT_SPM_000_PM_021",
    ["CM-Star"] = "Islands_01_SRT_SPM_000_PM_003", ["F0-Star"] = "Secret_28_SRT_SPM_000_PM_004", ["F3-Star"] = "LeapOfFaith_PM_010"
  }

  --[[
    The sigils are ordered here according to the numbering of sigil
     from earlier and the levels those sigils are normally in
    The first item in this list corosponds with the sigil with id 1,
     "**1" or ABTU Star
  ]]--
  local markers = {
    "A3-ABTU Star", "A2-Star", "A3-Clock Star", "A4-Star", "A1-Star",
    "A5-FC Star", "A5-Two Boxes Star", "A6-Star", "A7-Star", "B1-Star",
    "B2-Star", "B3-Star", "B4-TRA Star", "B5-Obelisk Star", "B7-Star",
    "B7-BSbS Star", "C1-Star", "C2-Star", "C3-Star", "C4-Oubliette Star",
    "C4-Throne Room Star", "C5-Dumbwaiter Star", "C5-Time Flies Star", "B4-Sphinx Star", "F3-Star",
    "CM-Star", "C5-UCAJ Star", "F0-Star", "C6-Star", "C7-Star",
    "A1-PaSL", "A5-Two Boxes", "A1-Beaten Path", "A1-Outnumbered", "A1-OtToU",
    "B4-Self Help", "B5-SES", "A2-Guards", "A5-YKYMCTS", "A7-LFI",
    "A5-Over the Fence", "A5-OLB", "A7-Trapped Inside", "B4-Double-Plate", "A1-ASooR",
    "A2-Hall of Windows", "A3-Stashed for Later", "A6-Mobile Mindfield", "A*-JfW", "B*-Merry Go Round",
    "B*-Peekaboo", "C*-Unreachable Garden", "C*-Nexus", "A*-Nervewrecker", "B*-Cat's Cradle",
    "A*-DDM", "C*-Cobweb", "B7-BSbS", "B3-Blown Away", "A1-Trio",
    "A2-Suicide Mission", "B1-WtaD", "B6-Crisscross", "B7-BLoM", "B1-Third Wheel",
    "B2-Tomb", "A1-Peephole", "A3-ABTU", "A3-Swallowed the Key", "A4-Branch it Out",
    "A4-Above All That", "B1-Over the Fence", "B1-RoD", "B2-MotM", "B3-Sunshot",
    "B6-JDaW", "A4-Push it Further", "A4-DCtS", "B1-SaaS", "B2-Moonshot",
    "B5-Plates", "B6-Egyptian Arcade", "B7-AFaF", "C1-Conservatory", "C4-Armory",
    "C5-Time Flies", "B7-WLJ", "C1-MIA", "C3-Jammer Quarantine", "C6-Circumlocution",
    "A3-AEP", "A6-Deception", "A6-Door too Far", "A7-Two Buzzers", "B2-Higher Ground",
    "B3-Eagle's Nest", "B4-ABUH", "B4-WAtC", "B5-Two Jammers", "C7-DMS",
    "A7-WiaL", "C2-ADaaF", "C3-Three Connectors", "C5-Time Crawls", "C5-Dumbwaiter",
    "C6-Seven Doors", "C7-Carrier Pigeons", "B5-Iron Curtain", "C2-Rapunzel", "C4-Oubliette",
    "C6-Two Way Street", "A7-Pinhole", "B3-Woosh", "B4-TRA", "B4-RPS",
    "C1-Labyrinth", "C2-Cemetery", "C3-BSLS", "C4-Stables", "C4-Throne Room",
    "C5-UCaJ", "C7-Prison Break", "C7-Crisscross", "A5-FC", "A6-Bichromatic",
    "B5-Chambers", "C1-Blowback", "C2-Short Wall", "C3-Weathertop"
  }

  --[[
    This list has two purposes:
     1. Hold the sigils for each arranger
     2. Let the marker unlocking that happens later check what's unlocked
    #2 is the reason for the weird name
  ]]--
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

  -- Make sure some vars that default to 0 are set, so everything works from a clearTalosProgress()
  if not talosProgress:IsVarSet("Randomizer_Loop") then
    talosProgress:SetVarValue("Randomizer_Loop", 0)
  end
  if not talosProgress:IsVarSet("Randomizer_Moody") then
    talosProgress:SetVarValue("Randomizer_Moody", 0)
  end

  -- If scavenger hunt mode is on decide what ending we're doing
  local scavenger = talosProgress:GetCodeValue("Randomizer_Scavenger")
  local scavengerMode = ""
  if scavenger == -1 then
    scavenger = 0
    talosProgress:SetVarValue("Randomizer_Scavenger", 0)
  end
  if scavenger then
    local sModes = {"Connector Clip", "F2 Clip", "F3 Clip"}
    --[[
      This one's no fun in short, you either need to hope for multiple
       star worlds in first hub or spend forever guessing the code
    ]]--
    if scavenger == 2 then
      table.insert(sModes, "F1+F6")
    end
    scavengerMode = rand(1, #sModes)
    -- The only one you can actually do intended
    if randomization_mode == "Intended" then
      scavengerMode = 4
    end
    talosProgress:SetVarValue("Randomizer_ScavengerMode", scavengerMode)
    scavengerMode = sModes[scavengerMode]

    if DEBUG then
      print("Using scavenger hunt mode: " .. scavengerMode)
    end
  end

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
  local loop = talosProgress:GetCodeValue("Randomizer_Loop")
  local portals = talosProgress:IsVarSet("Randomizer_Portals")
  if loop ~= 0 then
    if DEBUG then
      print("Möbius mode is on")
    end
    if portals then
      -- TODO: double check Sattolo's algorithm works
      for index=2, #portalOrder do
        local otherIndex = rand(1, index - 1)
        portalOrder[index], portalOrder[otherIndex] = portalOrder[otherIndex], portalOrder[index]
      end
    else
      table.remove(portalOrder)
      table.insert(portalOrder, 1, "CMessenger")
    end
  elseif portals then
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
    --[[
      Intended kind of breaks if you spawn outside of A, there's
       just not enough space to put all the sigils
      Short scavenger limits you to one hub so it just kind of
       sucks making you walk to another to get items
    ]]--
    if randomization_mode == "Intended" or scavenger == 1 then
      index = rand(1, 8)
    end
    if index < 8 then
      startHub = "A"
    elseif index == 8 then
      index = 9
      startHub = "A"
    elseif 9 <= index and index < 16 then
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

  --[[
    Based on the portal configuration we need to make some more lists
     to help us unlock worlds properly
  ]]--
  local open = {}
  local WorldANames = {}
  local WorldBNames = {}
  local WorldCNames = {}
  for index=1, #portalOrder do
    local name = portalOrder[index]
    if DEBUG and portals then
      if loop ~= 0 then
        printWarning(string.format("Portal leaving %s is %s", name, portalIndexes[index]))
      else
        printWarning(string.format("Portal marker %s is %s", portalIndexes[index], name))
      end
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

  --[[
    Check if a world is accessible
    This does not necessarily  mean a set of markers will unlock
  ]]--
  local function isWorldOpen(world)
    if world == "A1" then return true end
    -- An empty list still evaluates to true
    if randomization_mode == "Intended" and locked["A1 Gate"] then return false end
    if (scavenger + loop) ~= 0 then return true end

    local starOverride = true
    local num = talosProgress:GetCodeValue(world)
    -- Is this a star world?
    if num == 8 or num == 17 or num == 25 then
      starOverride = not (locked["A Star"] or locked["B Star"] or locked["C Star"])
    end

    return starOverride and open[world]
  end

  --[[
    These lists create the softlock prevention
    Because we use arbitray functions we can add modes with arbitray
     restrictions just by making new lists
    The list entries are formatted as follows:
    {function() [if to unlock], {"list", "of, "markers"}, "world"},
    If no world is given OR the world is not recognised it will
     always be checked, otherwise we can save some iterations and
     add it later, when it's actually unlocked
  ]]--
  if randomization_mode == "Default" then
    markers = {
      {function() return isWorldOpen("A1") end, {
        "A1-Peephole", "A1-PaSL", "A1-Outnumbered", "A1-ASooR",
        "A1-OtToU", "A1-Trio", "A1-Beaten Path", "A1-Star"
      }},
      {function() return isWorldOpen("A2") end, {
        "A2-Hall of Windows", "A2-Guards", "A2-Suicide Mission", "A2-Star"
      }, "A2"},
      {function() return isWorldOpen("A3") end, {
        "A3-ABTU Star", "A3-ABTU", "A3-AEP", "A3-Swallowed the Key",
        "A3-Stashed for Later", "A3-Clock Star"
      }, "A3"},
      {function() return isWorldOpen("A4") end, {
        "A4-Push it Further", "A4-Branch it Out", "A4-Above All That", "A4-Star"
      }, "A4"},
      {function() return isWorldOpen("A4") and not locked["Connector"] end, {
        "A4-DCtS"
      }, "A4"},
      {function() return isWorldOpen("A5") end, {
        "A5-Two Boxes", "A5-Two Boxes Star", "A5-Over the Fence", "A5-YKYMCTS",
        "A5-OLB", "A5-FC", "A5-FC Star",
      }, "A5"},
      {function() return isWorldOpen("A6") end, {
        "A6-Mobile Mindfield", "A6-Deception", "A6-Door too Far", "A6-Bichromatic",
        "A6-Star"
      }, "A6"},
      {function() return isWorldOpen("A7") end, {
        "A7-Two Buzzers", "A7-Pinhole", "A7-LFI", "A7-WiaL",
        "A7-Trapped Inside", "A7-Star"
      }, "A7"},
      {function() return isWorldOpen("A8") end, {
        "A*-DDM", "A*-Nervewrecker", "A*-JfW"
      }, "A8"},
      {function() return isWorldOpen("B1") end, {
        "B1-SaaS", "B1-WtaD", "B1-Third Wheel", "B1-Over the Fence",
        "B1-RoD", "B1-Star"
      }, "B1"},
      {function() return isWorldOpen("B2") end, {
        "B2-Higher Ground", "B2-Tomb", "B2-MotM", "B2-Moonshot",
        "B2-Star"
      }, "B2"},
      {function() return isWorldOpen("B3") end, {
        "B3-Sunshot", "B3-Blown Away", "B3-Eagle's Nest", "B3-Woosh",
        "B3-Star"
      }, "B3"},
      {function() return isWorldOpen("B4") end, {
        "B4-TRA", "B4-ABUH", "B4-Double-Plate", "B4-Self Help",
        "B4-RPS", "B4-WAtC", "B4-TRA Star"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Connector"] end, {
        "B4-Sphinx Star"
      }, "B4"},
      {function() return isWorldOpen("B5") end, {
        "B5-Plates", "B5-Two Jammers", "B5-Iron Curtain", "B5-SES",
        "B5-Chambers"
      }, "B5"},
      {function() return isWorldOpen("B5") and ((not locked["Connector"] and not locked["Fan"]) or not locked["Cube"]) end, {
        "B5-Obelisk Star"
      }, "B5"},
      {function() return isWorldOpen("B6") end, {
        "B6-Egyptian Arcade", "B6-JDaW", "B6-Crisscross"
      }, "B6"},
      {function() return isWorldOpen("B7") end, {
        "B7-WLJ", "B7-AFaF", "B7-BSbS Star", "B7-BSbS",
        "B7-BLoM"
      }, "B7"},
      {function() return isWorldOpen("B7") and not locked["Fan"] end, {
        "B7-Star"
      }, "B7"},
      {function() return isWorldOpen("B8") end, {
        "B*-Merry Go Round", "B*-Cat's Cradle", "B*-Peekaboo"
      }, "B8"},
      {function() return isWorldOpen("C1") end, {
        "C1-Labyrinth", "C1-Conservatory", "C1-Blowback", "C1-Star"
      }, "C1"},
      {function() return isWorldOpen("C1") and not locked["Cube"] end, {
        "C1-MIA"
      }, "C1"},
      {function() return isWorldOpen("C2") end, {
        "C2-Cemetery", "C2-ADaaF", "C2-Rapunzel", "C2-Short Wall",
        "C2-Star"
      }, "C2"},
      {function() return isWorldOpen("C3") end, {
        "C3-Three Connectors", "C3-BSLS", "C3-Jammer Quarantine", "C3-Weathertop",
        "C3-Star"
      }, "C3"},
      {function() return isWorldOpen("C4") end, {
        "C4-Stables", "C4-Armory", "C4-Oubliette Star", "C4-Oubliette",
        "C4-Throne Room Star"
      }, "C4"},
      {function() return isWorldOpen("C4") and not locked["Cube"] end, {
        "C4-Throne Room"
      }, "C4"},
      {function() return isWorldOpen("C5") end, {
        "C5-Time Crawls", "C5-Dumbwaiter", "C5-Time Flies", "C5-UCaJ",
        "C5-Time Flies Star"
      }, "C5"},
      {function() return isWorldOpen("C5") and not locked["Cube"] end, {
        "C5-UCAJ Star", "C5-Dumbwaiter Star"
      }, "C5"},
      {function() return isWorldOpen("C6") end, {
        "C6-Two Way Street", "C6-Circumlocution", "C6-Seven Doors", "C6-Star"
      }, "C6"},
      {function() return isWorldOpen("C7") end, {
        "C7-Prison Break", "C7-Carrier Pigeons", "C7-Crisscross", "C7-DMS",
        "C7-Star"
      }, "C7"},
      {function() return isWorldOpen("C8") end, {
        "C*-Nexus"
      }, "C8"},
      {function() return isWorldOpen("C8") and (not locked["Connector"] or not locked["Cube"]) end, {
        "C*-Cobweb", "C*-Unreachable Garden"
      }, "C8"},
      {function() return isWorldOpen("CMessenger") end, {
        "CM-Star"
      }, "CMessenger"},
      {function() return not locked["F1"] and (not locked["Connector"] or not locked["F3"]) end, {
        "F0-Star"
      }},
      {function() return not locked["F1"] and not locked["F3"] end, {
        "F3-Star"
      }}
    }
  elseif randomization_mode == "60fps" then
    markers = {
      {function() return isWorldOpen("A1") end, {
        "A1-Peephole", "A1-PaSL", "A1-Outnumbered", "A1-ASooR",
        "A1-OtToU", "A1-Trio", "A1-Beaten Path", "A1-Star"
      }},
      {function() return isWorldOpen("A2") end, {
        "A2-Hall of Windows", "A2-Guards", "A2-Suicide Mission", "A2-Star"
      }, "A2"},
      {function() return isWorldOpen("A3") end, {
        "A3-ABTU Star", "A3-ABTU", "A3-AEP", "A3-Swallowed the Key",
        "A3-Stashed for Later", "A3-Clock Star"
      }, "A3"},
      {function() return isWorldOpen("A4") end, {
        "A4-Push it Further", "A4-Branch it Out", "A4-Above All That", "A4-Star"
      }, "A4"},
      {function() return isWorldOpen("A4") and not locked["Connector"] end, {
        "A4-DCtS"
      }, "A4"},
      {function() return isWorldOpen("A5") end, {
        "A5-Two Boxes", "A5-Two Boxes Star", "A5-Over the Fence", "A5-YKYMCTS",
        "A5-FC", "A5-FC Star",
      }, "A5"},
      {function() return isWorldOpen("A5") and (not locked["Connector"] or not locked["Cube"]) end, {
        "A5-OLB"
      }, "A5"},
      {function() return isWorldOpen("A6") end, {
        "A6-Mobile Mindfield", "A6-Deception", "A6-Door too Far", "A6-Bichromatic",
        "A6-Star"
      }, "A6"},
      {function() return isWorldOpen("A7") end, {
        "A7-Two Buzzers", "A7-Pinhole", "A7-LFI", "A7-WiaL",
        "A7-Trapped Inside", "A7-Star"
      }, "A7"},
      {function() return isWorldOpen("A8") end, {
        "A*-DDM", "A*-Nervewrecker", "A*-JfW"
      }, "A8"},
      {function() return isWorldOpen("B1") end, {
        "B1-RoD"
      }, "B1"},
      {function() return isWorldOpen("B1") and not locked["Cube"] end, {
        "B1-Over the Fence"
      }, "B1"},
      {function() return isWorldOpen("B1") and (not locked["Connector"] or not locked["Cube"]) end, {
        "B1-WtaD", "B1-SaaS", "B1-Third Wheel", "B1-Star"
      }, "B1"},
      {function() return isWorldOpen("B2") end, {
        "B2-Higher Ground", "B2-Tomb", "B2-Moonshot", "B2-Star"
      }, "B2"},
      {function() return isWorldOpen("B2") and not locked["Cube"] end, {
        "B2-MotM"
      }, "B2"},
      {function() return isWorldOpen("B3") and not locked["Cube"] end, {
        "B3-Sunshot", "B3-Blown Away", "B3-Star", "B3-Eagle's Nest",
        "B3-Woosh"
      }, "B3"},
      {function() return isWorldOpen("B4") and (not locked["Cube"] or not locked["Recorder"]) end, {
        "B4-Self Help"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Connector"] end, {
        "B4-TRA", "B4-WAtC"
      }, "B4"},
      {function() return isWorldOpen("B4") and ((not locked["Connector"] and not locked["Cube"]) or not locked["Recorder"]) end, {
        "B4-Double-Plate", "B4-RPS"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Connector"] and not locked["Cube"] end, {
        "B4-ABUH", "B4-TRA Star"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Connector"] and (not locked["Cube"] or not locked["Fan"]) end, {
        "B4-Sphinx Star"
      }, "B4"},
      {function() return isWorldOpen("B5") end, {
        "B5-Iron Curtain", "B5-Chambers"
      }, "B5"},
      {function() return isWorldOpen("B5") and not locked["Cube"] end, {
        "B5-Plates", "B5-SES", "B5-Obelisk Star"
      }, "B5"},
      {function() return isWorldOpen("B5") and (not locked["Cube"] or not locked["Recorder"]) end, {
        "B5-Two Jammers"
      }, "B5"},
      {function() return isWorldOpen("B6") end, {
        "B6-Egyptian Arcade", "B6-Crisscross"
      }, "B6"},
      {function() return isWorldOpen("B6") and not locked["Connector"] end, {
        "B6-JDaW"
      }, "B6"},
      {function() return isWorldOpen("B7") end, {
        "B7-WLJ", "B7-AFaF"
      }, "B7"},
      {function() return isWorldOpen("B7") and (not locked["Connector"] or not locked["Cube"]) end, {
        "B7-BSbS", "B7-BSbS Star"
      }, "B7"},
      {function() return isWorldOpen("B7") and not locked["Cube"] end, {
        "B7-BLoM"
      }, "B7"},
      {function() return isWorldOpen("B7") and not locked["Fan"] end, {
        "B7-Star"
      }, "B7"},
      {function() return isWorldOpen("B8") end, {
        "B*-Merry Go Round", "B*-Peekaboo"
      }, "B8"},
      {function() return isWorldOpen("B8") and not locked["Connector"] and not locked["Cube"] end, {
        "B*-Cat's Cradle"
      }, "B8"},
      {function() return isWorldOpen("C1") end, {
        "C1-Labyrinth", "C1-Conservatory", "C1-Blowback", "C1-Star"
      }, "C1"},
      {function() return isWorldOpen("C1") and not locked["Cube"] end, {
        "C1-MIA"
      }, "C1"},
      {function() return isWorldOpen("C2") end, {
        "C2-Cemetery", "C2-ADaaF", "C2-Rapunzel", "C2-Short Wall",
        "C2-Star"
      }, "C2"},
      {function() return isWorldOpen("C3") end, {
        "C3-BSLS", "C3-Jammer Quarantine", "C3-Weathertop", "C3-Star"
      }, "C3"},
      {function() return isWorldOpen("C3") and not locked["Cube"] end, {
        "C3-Three Connectors"
      }, "C3"},
      {function() return isWorldOpen("C4") end, {
        "C4-Stables"
      }, "C4"},
      {function() return isWorldOpen("C4") and not locked["Connector"] and (not locked["Cube"] or not locked["Recorder"] or not locked ["Platform"]) end, {
        "C4-Oubliette"
      }, "C4"},
      {function() return isWorldOpen("C4") and not locked["Connector"] end, {
        "C4-Armory"
      }, "C4"},
      {function() return isWorldOpen("C4") and not locked["Cube"] end, {
        "C4-Throne Room"
      }, "C4"},
      {function() return isWorldOpen("C4") and (not locked["Cube"] or not locked["Fan"]) end, {
        "C4-Throne Room Star"
      }, "C4"},
      {function() return isWorldOpen("C4")and ((not locked["Connector"] and not locked["Cube"]) or (not locked["Recorder"] and not locked["Platform"])) end, {
        "C4-Oubliette Star"
      }, "C4"},
      {function() return isWorldOpen("C5") end, {
        "C5-Time Crawls", "C5-Time Flies", "C5-Time Flies Star"
      }, "C5"},
      {function() return isWorldOpen("C5") and not locked["Cube"] end, {
        "C5-Dumbwaiter", "C5-UCaJ", "C5-UCAJ Star", "C5-Dumbwaiter Star"
      }, "C5"},
      {function() return isWorldOpen("C6") end, {
        "C6-Two Way Street", "C6-Circumlocution", "C6-Seven Doors", "C6-Star"
      }, "C6"},
      {function() return isWorldOpen("C7") end, {
        "C7-Carrier Pigeons"
      }, "C7"},
      {function() return isWorldOpen("C7") and not locked["Cube"] end, {
        "C7-Prison Break", "C7-Crisscross", "C7-DMS", "C7-Star"
      }, "C7"},
      {function() return isWorldOpen("C8") end, {
        "C*-Nexus"
      }, "C8"},
      {function() return isWorldOpen("C8") and not locked["Cube"] end, {
        "C*-Unreachable Garden", "C*-Cobweb"
      }, "C8"},
      {function() return isWorldOpen("CMessenger") end, {
        "CM-Star"
      }, "CMessenger"},
      {function() return not locked["F1"] and (not locked["Connector"] or not locked["F3"]) end, {
        "F0-Star"
      }},
      {function() return not locked["F1"] and not locked["F2"] and not locked["F3"] and not locked["Cube"] end, {
        "F3-Star"
      }}
    }
  elseif randomization_mode == "Intended" then
    markers = {
      {function() return isWorldOpen("A1") end, {
        "A1-Peephole", "A1-Outnumbered", "A1-ASooR", "A1-OtToU",
        "A1-Beaten Path", "A1-Star"
      }},
      {function() return isWorldOpen("A1") and not locked["A1 Gate"] end, {
        "A1-PaSL", "A1-Trio"
      }},
      {function() return isWorldOpen("A2") end, {
        "A2-Hall of Windows", "A2-Guards", "A2-Suicide Mission", "A2-Star"
      }, "A2"},
      {function() return isWorldOpen("A3") end, {
        "A3-ABTU Star", "A3-ABTU", "A3-AEP", "A3-Swallowed the Key",
        "A3-Stashed for Later", "A3-Clock Star"
      }, "A3"},
      {function() return isWorldOpen("A4") and not locked["Connector"] end, {
        "A4-Push it Further", "A4-Branch it Out", "A4-Above All That", "A4-Star",
        "A4-DCtS"
      }, "A4"},
      {function() return isWorldOpen("A5") and not locked["Connector"] end, {
         "A5-Two Boxes Star"
      }, "A5"},
      {function() return isWorldOpen("A5") and not locked["Cube"] end, {
        "A5-Two Boxes", "A5-FC", "A5-FC Star"
      }, "A5"},
      {function() return isWorldOpen("A5") and not locked["Connector"] and not locked["Cube"] end, {
        "A5-OLB", "A5-Over the Fence", "A5-YKYMCTS"
      }, "A5"},
      {function() return isWorldOpen("A6") end, {
        "A6-Mobile Mindfield"
      }, "A6"},
      {function() return isWorldOpen("A6") and not locked["Connector"] end, {
        "A6-Deception", "A6-Bichromatic"
      }, "A6"},
      {function() return isWorldOpen("A6") and not locked["Cube"] end, {
        "A6-Star"
      }, "A6"},
      {function() return isWorldOpen("A6") and not locked["Connector"] and not locked["Cube"] end, {
        "A6-Door too Far"
      }, "A6"},
      {function() return isWorldOpen("A7") and not locked["Connector"] end, {
        "A7-LFI", "A7-Pinhole", "A7-WiaL", "A7-Trapped Inside",
        "A7-Star"
      }, "A7"},
      {function() return isWorldOpen("A7") and not locked["Connector"] and not locked["Cube"] end, {
        "A7-Two Buzzers"
      }, "A7"},
      {function() return isWorldOpen("A8") end, {
        "A*-Nervewrecker", "A*-JfW"
      }, "A8"},
      {function() return isWorldOpen("A8") and not locked["Fan"] end, {
        "A*-DDM"
      }, "A8"},
      {function() return isWorldOpen("B1") and not locked["Connector"] end, {
        "B1-WtaD", "B1-SaaS", "B1-Third Wheel", "B1-Star"
      }, "B1"},
      {function() return isWorldOpen("B1") and not locked["Cube"] end, {
        "B1-Over the Fence", "B1-RoD"
      }, "B1"},
      {function() return isWorldOpen("B2") end, {
        "B2-Higher Ground"
      }, "B2"},
      {function() return isWorldOpen("B2") and not locked["Connector"] end, {
        "B2-Tomb", "B2-Star"
      }, "B2"},
      {function() return isWorldOpen("B2") and not locked["Cube"] and not locked["Fan"] end, {
        "B2-MotM"
      }, "B2"},
      {function() return isWorldOpen("B2") and not locked["Cube"] and not locked["Fan"] end, {
        "B2-Moonshot"
      }, "B2"},
      {function() return isWorldOpen("B3") and not locked["Cube"] and not locked["Fan"] end, {
        "B3-Sunshot"
      }, "B3"},
      {function() return isWorldOpen("B3") and not locked["Connector"] and not locked["Cube"] and not locked["Fan"] end, {
        "B3-Blown Away", "B3-Star", "B3-Eagle's Nest", "B3-Woosh"
      }, "B3"},
      {function() return isWorldOpen("B4") and not locked["Recorder"] end, {
        "B4-Self Help", "B4-Double-Plate"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Connector"] and not locked["Cube"] end, {
        "B4-TRA", "B4-TRA Star"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Connector"] and not locked["Recorder"] end, {
        "B4-WAtC"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Cube"] and not locked["Recorder"] end, {
        "B4-RPS"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Connector"] and not locked["Cube"] and not locked["Fan"] end, {
        "B4-ABUH", "B4-Sphinx Star"
      }, "B4"},
      {function() return isWorldOpen("B5") and not locked["Recorder"] end, {
        "B5-Two Jammers"
      }, "B5"},
      {function() return isWorldOpen("B5") and not locked["Connector"] and not locked["Cube"] and not locked["Fan"] end, {
        "B5-SES", "B5-Obelisk Star", "B5-Iron Curtain", "B5-Chambers"
      }, "B5"},
      {function() return isWorldOpen("B5") and not locked["Connector"] and not locked["Cube"] and not locked["Fan"] and not locked["Recorder"] end, {
        "B5-Plates"
      }, "B5"},
      {function() return isWorldOpen("B6") end, {
        "B6-Egyptian Arcade"
      }, "B6"},
      {function() return isWorldOpen("B6") and not locked["Connector"] end, {
        "B6-JDaW", "B6-Crisscross"
      }, "B6"},
      {function() return isWorldOpen("B7") end, {
        "B7-WLJ",
      }, "B7"},
      {function() return isWorldOpen("B7") and not locked["Connector"] end, {
        "B7-BSbS"
      }, "B7"},
      {function() return isWorldOpen("B7") and not locked["Cube"] end, {
        "B7-BLoM",
      }, "B7"},
      {function() return isWorldOpen("B7") and not locked["Cube"] and not locked["Fan"] end, {
        "B7-Star"
      }, "B7"},
      {function() return isWorldOpen("B7") and not locked["Connector"] and not locked["Cube"] and not locked["Fan"] end, {
        "B7-AFaF", "B7-BSbS Star"
      }, "B7"},
      {function() return isWorldOpen("B8") and not locked["Connector"] end, {
        "B*-Merry Go Round"
      }, "B8"},
      {function() return isWorldOpen("B8") and not locked["Connector"] and not locked["Cube"] end, {
        "B*-Cat's Cradle"
      }, "B8"},
      {function() return isWorldOpen("B8") and not locked["Connector"] and not locked["Recorder"] end, {
        "B*-Peekaboo"
      }, "B8"},
      {function() return isWorldOpen("C1") end, {
        "C1-Labyrinth",
      }, "C1"},
      {function() return isWorldOpen("C1") and not locked["Connector"] end, {
        "C1-Conservatory", "C1-Star"
      }, "C1"},
      {function() return isWorldOpen("C1") and not locked["Connector"] and not locked["Cube"] and not locked["Fan"] end, {
        "C1-Blowback", "C1-MIA"
      }, "C1"},
      {function() return isWorldOpen("C2") and not locked["Connector"] and not locked["Cube"] end, {
        "C2-Cemetery"
      }, "C2"},
      {function() return isWorldOpen("C2") and not locked["Recorder"] and not locked["Platform"] end, {
        "C2-Short Wall"
      }, "C2"},
      {function() return isWorldOpen("C2") and not locked["Cube"] and not locked["Recorder"] and not locked["Platform"] end, {
        "C2-Rapunzel", "C2-Star"
      }, "C2"},
      {function() return isWorldOpen("C2") and not locked["Connector"] and not locked["Cube"] and not locked["Recorder"] and not locked["Platform"] end, {
        "C2-ADaaF"
      }, "C2"},
      {function() return isWorldOpen("C3") and not locked["Connector"] and not locked["Cube"] and not locked["Fan"] end, {
        "C3-BSLS", "C3-Jammer Quarantine", "C3-Weathertop", "C3-Three Connectors",
        "C3-Star"
      }, "C3"},
      {function() return isWorldOpen("C4") and not locked["Connector"] end, {
        "C4-Stables"
      }, "C4"},
      {function() return isWorldOpen("C4") and not locked["Connector"] and not locked["Cube"] end, {
        "C4-Armory"
      }, "C4"},
      {function() return isWorldOpen("C4") and not locked["Connector"] and not locked["Cube"] and not locked["Fan"] end, {
        "C4-Throne Room", "C4-Throne Room Star"
      }, "C4"},
      {function() return isWorldOpen("C4") and not locked["Connector"] and not locked["Cube"] and not locked["Recorder"] and not locked["Platform"] end, {
        "C4-Oubliette", "C4-Oubliette Star"
      }, "C4"},
      {function() return isWorldOpen("C5") and not locked["Cube"] end, {
        "C5-UCAJ Star"
      }, "C5"},
      {function() return isWorldOpen("C5") and not locked["Connector"] and not locked["Cube"] end, {
        "C5-UCaJ"
      }, "C5"},
      {function() return isWorldOpen("C5") and not locked["Connector"] and not locked["Cube"] and not locked["Fan"] end, {
        "C5-Dumbwaiter"
      }, "C5"},
      {function() return isWorldOpen("C5") and not locked["Connector"] and not locked["Cube"] and not locked["Recorder"] end, {
        "C5-Time Crawls"
      }, "C5"},
      {function() return isWorldOpen("C5") and not locked["Connector"] and not locked["Cube"] and not locked["Fan"] and not locked["Recorder"] end, {
        "C5-Time Flies", "C5-Time Flies Star", "C5-Dumbwaiter Star"
      }, "C5"},
      {function() return isWorldOpen("C6") end, {
        "C6-Two Way Street"
      }, "C6"},
      {function() return isWorldOpen("C6") and not locked["Connector"] and not locked["Cube"] end, {
        "C6-Circumlocution"
      }, "C6"},
      {function() return isWorldOpen("C6") and not locked["Connector"] and not locked["Recorder"] end, {
        "C6-Seven Doors", "C6-Star"
      }, "C6"},
      {function() return isWorldOpen("C7") and not locked["Connector"] and not locked["Recorder"] end, {
        "C7-Crisscross"
      }, "C7"},
      {function() return isWorldOpen("C7") and not locked["Connector"] and not locked["Cube"] and not locked["Fan"] end, {
        "C7-Prison Break", "C7-Carrier Pigeons", "C7-DMS", "C7-Star"
      }, "C7"},
      {function() return isWorldOpen("C8") and not locked["Connector"] and not locked["Cube"] end, {
        "C*-Nexus", "C*-Cobweb"
      }, "C8"},
      {function() return isWorldOpen("C8") and not locked["Connector"] and not locked["Cube"] and not locked["Recorder"] and not locked["Platform"] end, {
        "C*-Unreachable Garden"
      }, "C8"},
      {function() return isWorldOpen("CMessenger") end, {
        "CM-Star"
      }, "CMessenger"},
      {function() return not locked["F1"] and not locked["Connector"] end, {
        "F0-Star"
      }}
      -- Yes F3 star is missing, it's explained further down
    }
  elseif randomization_mode == "Hardmode" then
    markers = {
      {function() return isWorldOpen("A1") end, {
        "A1-Peephole", "A1-PaSL", "A1-Outnumbered", "A1-ASooR",
        "A1-OtToU", "A1-Trio", "A1-Beaten Path", "A1-Star"
      }},
      {function() return isWorldOpen("A2") end, {
        "A2-Hall of Windows", "A2-Guards", "A2-Suicide Mission", "A2-Star"
      }, "A2"},
      {function() return isWorldOpen("A3") end, {
        "A3-ABTU Star", "A3-ABTU", "A3-AEP", "A3-Swallowed the Key",
        "A3-Stashed for Later", "A3-Clock Star"
      }, "A3"},
      {function() return isWorldOpen("A4") end, {
        "A4-Push it Further", "A4-Branch it Out", "A4-Above All That", "A4-Star",
        "A4-DCtS"
      }, "A4"},
      {function() return isWorldOpen("A5") end, {
        "A5-Two Boxes", "A5-Two Boxes Star", "A5-Over the Fence", "A5-YKYMCTS",
        "A5-OLB", "A5-FC", "A5-FC Star",
      }, "A5"},
      {function() return isWorldOpen("A6") end, {
        "A6-Mobile Mindfield", "A6-Deception", "A6-Door too Far", "A6-Bichromatic",
        "A6-Star"
      }, "A6"},
      {function() return isWorldOpen("A7") end, {
        "A7-Two Buzzers", "A7-Pinhole", "A7-LFI", "A7-WiaL",
        "A7-Trapped Inside", "A7-Star"
      }, "A7"},
      {function() return isWorldOpen("A8") end, {
        "A*-DDM", "A*-Nervewrecker", "A*-JfW"
      }, "A8"},
      {function() return isWorldOpen("B1") end, {
        "B1-SaaS", "B1-WtaD", "B1-Third Wheel", "B1-Over the Fence",
        "B1-RoD", "B1-Star"
      }, "B1"},
      {function() return isWorldOpen("B2") end, {
        "B2-Higher Ground", "B2-Tomb", "B2-MotM", "B2-Moonshot",
        "B2-Star"
      }, "B2"},
      {function() return isWorldOpen("B3") end, {
        "B3-Sunshot", "B3-Blown Away", "B3-Eagle's Nest", "B3-Woosh",
        "B3-Star"
      }, "B3"},
      {function() return isWorldOpen("B4") end, {
        "B4-TRA", "B4-ABUH", "B4-Double-Plate", "B4-Self Help",
        "B4-RPS", "B4-WAtC", "B4-TRA Star"
      }, "B4"},
      {function() return isWorldOpen("B4") and (not locked["Connector"] or not locked["Cube"]) end, {
        "B4-Sphinx Star"
      }, "B4"},
      {function() return isWorldOpen("B5") end, {
        "B5-Plates", "B5-Two Jammers", "B5-Iron Curtain", "B5-SES",
        "B5-Chambers"
      }, "B5"},
      {function() return isWorldOpen("B5") and ((not locked["Connector"] and not locked["Fan"]) or not locked["Cube"]) end, {
        "B5-Obelisk Star"
      }, "B5"},
      {function() return isWorldOpen("B6") end, {
        "B6-Egyptian Arcade", "B6-JDaW", "B6-Crisscross"
      }, "B6"},
      {function() return isWorldOpen("B7") end, {
        "B7-WLJ", "B7-AFaF", "B7-BSbS Star", "B7-BSbS",
        "B7-BLoM"
      }, "B7"},
      {function() return isWorldOpen("B7") and (not locked["Cube"] or not locked["Fan"]) end, {
        "B7-Star"
      }, "B7"},
      {function() return isWorldOpen("B8") end, {
        "B*-Merry Go Round", "B*-Cat's Cradle", "B*-Peekaboo"
      }, "B8"},
      {function() return isWorldOpen("C1") end, {
        "C1-Labyrinth", "C1-Conservatory", "C1-Blowback", "C1-MIA",
        "C1-Star"
      }, "C1"},
      {function() return isWorldOpen("C2") end, {
        "C2-Cemetery", "C2-ADaaF", "C2-Rapunzel", "C2-Short Wall",
        "C2-Star"
      }, "C2"},
      {function() return isWorldOpen("C3") end, {
        "C3-Three Connectors", "C3-BSLS", "C3-Jammer Quarantine", "C3-Weathertop",
        "C3-Star"
      }, "C3"},
      {function() return isWorldOpen("C4") end, {
        "C4-Stables", "C4-Armory", "C4-Oubliette Star", "C4-Oubliette",
        "C4-Throne Room", "C4-Throne Room Star"
      }, "C4"},
      {function() return isWorldOpen("C5") end, {
        "C5-Time Crawls", "C5-Dumbwaiter", "C5-Time Flies", "C5-UCaJ",
        "C5-Time Flies Star", "C5-UCAJ Star", "C5-Dumbwaiter Star"
      }, "C5"},
      {function() return isWorldOpen("C6") end, {
        "C6-Two Way Street", "C6-Circumlocution", "C6-Seven Doors", "C6-Star"
      }, "C6"},
      {function() return isWorldOpen("C7") end, {
        "C7-Prison Break", "C7-Carrier Pigeons", "C7-Crisscross", "C7-DMS",
        "C7-Star"
      }, "C7"},
      {function() return isWorldOpen("C8") end, {
        "C*-Nexus", "C*-Cobweb", "C*-Unreachable Garden"
      }, "C8"},
      {function() return isWorldOpen("CMessenger") end, {
        "CM-Star"
      }, "CMessenger"},
      {function() return not locked["F1"] and (not locked["Connector"] or not locked["F3"]) end, {
        "F0-Star"
      }},
      {function() return not locked["F1"] and not locked["F3"] end, {
        "F3-Star"
      }}
    }
  elseif randomization_mode == "60FPS Hardmode" then
    markers = {
      {function() return isWorldOpen("A1") end, {
        "A1-Peephole", "A1-PaSL", "A1-Outnumbered", "A1-ASooR",
        "A1-OtToU", "A1-Trio", "A1-Beaten Path", "A1-Star"
      }},
      {function() return isWorldOpen("A2") end, {
        "A2-Hall of Windows", "A2-Guards", "A2-Suicide Mission", "A2-Star"
      }, "A2"},
      {function() return isWorldOpen("A3") end, {
        "A3-ABTU Star", "A3-ABTU", "A3-AEP", "A3-Swallowed the Key",
        "A3-Stashed for Later", "A3-Clock Star"
      }, "A3"},
      {function() return isWorldOpen("A4") end, {
        "A4-Push it Further", "A4-Branch it Out", "A4-Above All That", "A4-Star",
        "A4-DCtS"
      }, "A4"},
      {function() return isWorldOpen("A5") end, {
        "A5-Two Boxes", "A5-Two Boxes Star", "A5-Over the Fence", "A5-YKYMCTS",
        "A5-OLB", "A5-FC", "A5-FC Star",
      }, "A5"},
      {function() return isWorldOpen("A6") end, {
        "A6-Mobile Mindfield", "A6-Deception", "A6-Door too Far", "A6-Bichromatic",
        "A6-Star"
      }, "A6"},
      {function() return isWorldOpen("A7") end, {
        "A7-Two Buzzers", "A7-Pinhole", "A7-LFI", "A7-WiaL",
        "A7-Trapped Inside", "A7-Star"
      }, "A7"},
      {function() return isWorldOpen("A8") end, {
        "A*-DDM", "A*-Nervewrecker", "A*-JfW"
      }, "A8"},
      {function() return isWorldOpen("B1") end, {
        "B1-SaaS", "B1-WtaD", "B1-Third Wheel", "B1-Over the Fence",
        "B1-RoD", "B1-Star"
      }, "B1"},
      {function() return isWorldOpen("B2") end, {
        "B2-Higher Ground", "B2-Tomb", "B2-MotM", "B2-Moonshot",
        "B2-Star"
      }, "B2"},
      {function() return isWorldOpen("B3") and not locked["Cube"] end, {
        "B3-Sunshot", "B3-Blown Away", "B3-Eagle's Nest", "B3-Woosh",
        "B3-Star"
      }, "B3"},
      {function() return isWorldOpen("B4") end, {
        "B4-Self Help", "B4-WAtC"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Connector"] end, {
        "B4-TRA", "B4-TRA Star", "B4-Sphinx Star"
      }, "B4"},
      {function() return isWorldOpen("B4") and not locked["Connector"] and (not locked["Cube"] or not locked["Fan"]) end, {
        "B4-ABUH"
      }, "B4"},
      {function() return isWorldOpen("B4") and ((not locked["Connector"] and not locked["Cube"]) or not locked["Recorder"]) end, {
        "B4-Double-Plate", "B4-RPS"
      }, "B4"},
      {function() return isWorldOpen("B5") end, {
        "B5-Plates", "B5-Two Jammers", "B5-Iron Curtain", "B5-SES",
        "B5-Chambers"
      }, "B5"},
      {function() return isWorldOpen("B5") and ((not locked["Connector"] and not locked["Fan"]) or not locked["Cube"]) end, {
        "B5-Obelisk Star"
      }, "B5"},
      {function() return isWorldOpen("B6") end, {
        "B6-Egyptian Arcade", "B6-JDaW", "B6-Crisscross"
      }, "B6"},
      {function() return isWorldOpen("B7") end, {
        "B7-WLJ", "B7-AFaF", "B7-BSbS Star", "B7-BSbS",
        "B7-BLoM"
      }, "B7"},
      {function() return isWorldOpen("B7") and (not locked["Cube"] or not locked["Fan"]) end, {
        "B7-Star"
      }, "B7"},
      {function() return isWorldOpen("B8") end, {
        "B*-Merry Go Round", "B*-Cat's Cradle", "B*-Peekaboo"
      }, "B8"},
      {function() return isWorldOpen("C1") end, {
        "C1-Labyrinth", "C1-Conservatory", "C1-Blowback", "C1-MIA",
        "C1-Star"
      }, "C1"},
      {function() return isWorldOpen("C2") end, {
        "C2-Cemetery", "C2-ADaaF", "C2-Rapunzel", "C2-Short Wall",
        "C2-Star"
      }, "C2"},
      {function() return isWorldOpen("C3") end, {
        "C3-Three Connectors", "C3-BSLS", "C3-Jammer Quarantine", "C3-Weathertop",
        "C3-Star"
      }, "C3"},
      {function() return isWorldOpen("C4") end, {
        "C4-Stables", "C4-Armory", "C4-Throne Room", "C4-Throne Room Star"
      }, "C4"},
      {function() return isWorldOpen("C4") and not locked["Cube"] end, {
        "C4-Oubliette Star"
      }, "C4"},
      {function() return isWorldOpen("C4") and (not locked["Connector"] or not locked["Cube"] or not locked["Recorder"] or not locked["Platform"]) end, {
        "C4-Oubliette"
      }, "C4"},
      {function() return isWorldOpen("C5") end, {
        "C5-Time Crawls", "C5-Dumbwaiter", "C5-Time Flies", "C5-UCaJ",
        "C5-Time Flies Star", "C5-UCAJ Star", "C5-Dumbwaiter Star"
      }, "C5"},
      {function() return isWorldOpen("C6") end, {
        "C6-Two Way Street", "C6-Circumlocution", "C6-Seven Doors", "C6-Star"
      }, "C6"},
      {function() return isWorldOpen("C7") end, {
        "C7-Prison Break", "C7-Carrier Pigeons", "C7-Crisscross", "C7-DMS",
        "C7-Star"
      }, "C7"},
      {function() return isWorldOpen("C8") end, {
        "C*-Nexus", "C*-Unreachable Garden"
      }, "C8"},
      {function() return isWorldOpen("C8") and not locked["Cube"] end, {
        "C*-Cobweb"
      }, "C8"},
      {function() return isWorldOpen("CMessenger") end, {
        "CM-Star"
      }, "CMessenger"},
      {function() return not locked["F1"] and (not locked["Connector"] or not locked["F3"]) end, {
        "F0-Star"
      }},
      {function() return not locked["F1"] and not locked["F3"] end, {
        "F3-Star"
      }}
    }
  end

  --[[
    Based on the marker lists randomize the sigils
    This will work with any mode you define in the lists
  ]]--
  if randomization_mode == "Default" or randomization_mode == "60fps"
     or randomization_mode == "Intended" or randomization_mode == "Hardmode"
     or randomization_mode == "60FPS Hardmode" then
    local checkGates = true
    local arrangerStage = 0
    local availableMarkers = 0
    local openMarkers = {}

    --[[
      In scavenger hunt or loop mode you don't have to deal with
       doors, so we can disable that softlock protection
    ]]--
    if (scavenger + loop) ~= 0 then
      checkGates = false
      locked["A1 Gate"] = {"DJ1", "DJ2", "DZ1"}
      locked["A Gate"]  = {"DI1", "DJ3", "DL1", "DZ2"}
      locked["B Gate"]  = {"DI2", "DL2", "DT1", "DT2", "DZ3"}
      locked["C Gate"]  = {"DJ4", "DJ5", "DL3", "DT3", "DT4", "DZ4"}
    end

    --[[
      We just have a list of the world names in each hub, we want the indexes
       of the marker lists using those worlds
    ]]--
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
    -- For scavenger hunt we have all worlds open
    if scavenger ~= 0 then
      accessableArrangers = {}
    end
    if loop ~= 0 or scavenger == 2 then
      WorldA = addWorldMarkers(WorldA)
      WorldB = addWorldMarkers(WorldB)
      WorldC = addWorldMarkers(WorldC)
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
            talosProgress:SetCode(translate[randMarker], tetroIndexes[sigils[i]])
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

    --[[
      F3 star has issues with the intended mode, as explained later,
       so we manually set it to either a star or a grey sigil here
       before it can cause problems
      In scavenger hunts we don't want this because intended ones
       can only be F1+F6, and if this locks a grey it's uncompletable
      We fix the missing marker later
    ]]--
    if randomization_mode == "Intended" and scavenger == 0 then
      local sigil = ""
      local marker = "F3-Star"
      -- Weighted based on the amount of sigils of each type
      local sigilIndex = rand(1, 39)
      if sigilIndex <= 9 then
        -- Place a grey sigil (9/39)
        sigil = table.remove(locked["F6"], sigilIndex)
      else
        -- Place a star (30/39)
        sigil = table.remove(locked["A Star"], 1)
      end
      talosProgress:SetCode(translate[marker], tetroIndexes[sigil])
      tetroIndexes[sigil] = nil
      if DEBUG then
        printWarning(string.format("Placed %s at marker %s", sigil, marker))
      end
      -- Also while we're here fix A1 gate
      locked["A1 Gate"] = {"DJ1", "DJ2", "DZ1"}
    end

    --[[
      This loop is what actually does it all
      The basic idea is as follows:
       1. Work out what markers are currently unlocked
       2. Pick a random arranger
       3. Place the sigils for that arranger in the unlocked spots
       4. Repeat
      This is complicated by the facts that:
       1. You can easily run out of markers to place sigils
       2. You can softlock by entering the wrong hub world
      So we have a bunch of extra logic to try prevent both issues
    ]]--
    while arrangerStage ~= -1 or #accessableArrangers > 0 do
      -- To make sure I don't hit the instruction limit per frame
      Wait(CustomEvent("OnStep"))

      -- Find the markers that are currently accessable
      local toRemove = {}
      for i=1, #closedMarkers do
        local index = closedMarkers[i]
        --printError(markers[index][3])
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

      -- Chose what arrangers can be picked
      if arrangerStage ~= -1 then
        -- In scavenger hunt mode we only want the specific arrangers for each ending
        if scavenger ~= 0 then
          --[[
            Intended always needs A1 Gate
            Because the others don't it's kind of awkward using arrangerStage
          ]]--
          if randomization_mode == "Intended" and locked["A1 Gate"] then
            accessableArrangers = {"A1 Gate"}
          else
            if scavengerMode == "Connector Clip" then
              accessableArrangers = {"Connector", "F1"}
            elseif scavengerMode == "F2 Clip" then
              accessableArrangers = {"Cube", "F1", "F2"}
            elseif scavengerMode == "F3 Clip" then
              accessableArrangers = {"F1", "F3"}
            elseif scavengerMode == "F1+F6" then
              accessableArrangers = {"F1", "F6"}
            end
            arrangerStage = -1
          end
        elseif randomization_mode == "Intended"then
          --[[
            Because of how restrictive Intended is we need a special unlocking order,
             the default one breaks every time
            The order we use instead is:
            1. A1 Gate
            2. First Hub Items (Connector, Cube)
            3. Other Hubs
            4. Other Items
            5. Star Worlds
            6. F1
            7. Rest of Tower
            Note that this does mean F3 star could only ever be a grey sigil
            Looking at the restrictions it could theoretically also be a star,
             which is why we set it earlier
          ]]--
          if arrangerStage == 0 then
            accessableArrangers = {"A1 Gate"}
            arrangerStage = 1
          elseif arrangerStage == 1 then
            accessableArrangers = {"Connector", "Cube"}
            arrangerStage = 2
          elseif arrangerStage == 2 and #accessableArrangers == 0 then
            accessableArrangers = {startHub .. " Gate"}
            arrangerStage = 3
          elseif arrangerStage == 3 then
            if startHub == "A" then
              accessableArrangers =  {"B Gate", "C Gate"}
            elseif startHub == "B" then
              accessableArrangers =  {"A Gate", "C Gate"}
            elseif startHub == "C" then
              accessableArrangers =  {"A Gate", "B Gate"}
            end
            arrangerStage = 4
          elseif arrangerStage == 4 and #accessableArrangers == 0 then
            if startHub == "A" then
              accessableArrangers = {"Fan", "Recorder", "Platform"}
            elseif startHub == "B" then
              accessableArrangers = {"Connector", "Cube", "Platform"}
            elseif startHub == "C" then
              accessableArrangers = {"Connector", "Cube", "Fan", "Recorder"}
            end
            arrangerStage = 5
          elseif arrangerStage == 5 and #accessableArrangers == 0 then
              accessableArrangers = {"A Star", "B Star", "C Star"}
              arrangerStage = 6
          elseif arrangerStage == 6 and #accessableArrangers == 0 then
            accessableArrangers = {"F1"}
            arrangerStage = 7
          elseif arrangerStage == 7 then
            accessableArrangers = {"F2", "F3", "F4", "F5", "F6"}
            arrangerStage = -1
          end
        --[[
          The default unlocking order is as follows:
          1. Hubs
          2. Items
          3. Star worlds
          4. F1 + F2 + F3
          5. Everything else
          This does restrict certain combinations (e.g. you have to visit a star world to leave
           your starting hub), but it ends up distributing the sigils much more nicely than
           the old orders that did
        ]]--
        else
          if arrangerStage == 0 then
            if arranger == "A Gate" then
              table.insert(accessableArrangers, "B Gate")
              table.insert(accessableArrangers, "C Gate")
              arrangerStage = 1
            elseif arranger == "B Gate" then
              table.insert(accessableArrangers, "A Gate")
              table.insert(accessableArrangers, "C Gate")
              arrangerStage = 1
            elseif arranger == "C Gate" then
              table.insert(accessableArrangers, "A Gate")
              table.insert(accessableArrangers, "B Gate")
              arrangerStage = 1
            end
          elseif arrangerStage == 1 and #accessableArrangers == 0 then
            table.insert(accessableArrangers, "Connector")
            table.insert(accessableArrangers, "Cube")
            table.insert(accessableArrangers, "Fan")
            table.insert(accessableArrangers, "Recorder")
            table.insert(accessableArrangers, "Platform")
            arrangerStage = 2
          elseif arrangerStage == 2 and #accessableArrangers == 0 then
            table.insert(accessableArrangers, "A Star")
            table.insert(accessableArrangers, "B Star")
            table.insert(accessableArrangers, "C Star")
            arrangerStage = 3
          elseif arrangerStage == 3 and #accessableArrangers == 0 then
            table.insert(accessableArrangers, "F1")
            table.insert(accessableArrangers, "F2")
            table.insert(accessableArrangers, "F3")
            arrangerStage = 4
          elseif arrangerStage == 4 and #accessableArrangers == 0 then
            table.insert(accessableArrangers, "F4")
            table.insert(accessableArrangers, "F5")
            table.insert(accessableArrangers, "F6")
            table.insert(accessableArrangers, "A1 Gate")
            arrangerStage = -1
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
     K���/�;b+�$$�uH��8-i���~���y��b禽��ǆ�/�Ț�W��W�gHeVj&3� ��8��� ܶ�x���v��u����� /�)�|��Tq���w�,쑲�I�.�Ty�&6�X�c�����P0�7��������g^ʲ���������佲#0z9:Ɏ��+X<C��8�ȠN�!��V,�����P��L�tֲ:�bQ��pR�?"��c�Έճ�{��vڂ�,���n    required sigils outside of the first hub
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

            -- For the intended mode we don't want to re-create this list
            if randomization_mode ~= "Intended" then
              locked["A1 Gate"] = {"DJ1", "DJ2", "DZ1"}
            end

            -- Only one of these will be left in the table by this point
            for i=1, #accessableArrangers do
              -- "**Gate" - > "A Gate", "B Gate" and "C Gate" but not "A1 Gate"
              if string.sub(accessableArrangers[i], 3, 6) == "Gate" then
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
            --[[
              Otherwise we're only opening one hub, and we need to make sure you
               can't visit the wrong one
            ]]--
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

            --[[
              For the intended mode we've already placed A1 Gate, which means:
              1. We don't want to re-set locked["A1"]
              2. We don't need to lock the sigils that were already placed
            ]]--
            if randomization_mode == "Intended" then
              locked["A1 Gate"] = nil
              if uniqueSigils[1] == "DJ1" then
                uniqueSigils = {"DJ4", "DJ5"}
              end
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
                  talosProgress:SetCode(translate[randMarker], tetroIndexes[uniqueSigils[i]])
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
      elseif not checkGates then
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
  --[[
    For scavenger hunt, Fully Random and None will always place all
     the sigils, but for the other modes we need to make sure we
     actually do that too
  ]]--
  if scavenger ~= 0 then
    Wait(CustomEvent("OnStep"))
    local allArrangers = {
      "A1 Gate", "A Gate", "B Gate", "C Gate",
      "A Star", "B Star", "C Star",
      "Connector", "Cube", "Fan", "Recorder", "Platform",
      "F1", "F2", "F3", "F4", "F5", "F6"
    }
    -- Find all markers that are still available
    local allMarkers = {}
    for i=1, #markers do
      for j=1, #markers[i][2] do
        table.insert(allMarkers, markers[i][2][j])
      end
    end
    -- Intended has no F3 Star marker in the global list
    if randomization_mode == "Intended" then
      table.insert(allMarkers, "F3-Star")
    end
    --[[
      Place the remaining sigils at the remaining markers
      There's no need to randomize this because you won't see
       these sigils anyway
    ]]--
    for i=1, #allArrangers do
      local arranger = locked[allArrangers[i]]
      if arranger ~= nil then
        for j=1, #arranger do
          local sigil = arranger[j]
          local marker = table.remove(allMarkers, 1)
          talosProgress:SetCode(translate[marker], tetroIndexes[sigil])
          tetroIndexes[sigil] = nil
        end
      end
    end
  end

  --[[
    Fully Random ignores all that logic to do simple knuth randomization
     over everything
  ]]--
  elseif randomization_mode == "Fully Random" then
    for i = 1, #markers do
      local otherMarker = markers[rand(1, i)]
      if DEBUG then
        print(string.format("Swapping %s with %s", markers[i], otherMarker))
      end
      talosProgress:SetCode(translate[markers[i]], talosProgress:GetCodeValue(translate[otherMarker]))
      talosProgress:SetCode(translate[otherMarker], i)
    end

  --[[
    When there is no randomization we'll still have the default marker list,
     which happens to have all the markers in the order of their sigil
     numbers, which means we can just use a single for loop to set them all
  ]]--
  elseif randomization_mode == "None" then
    for i=1, 129 do
      talosProgress:SetCode(translate[markers[i]], i)
    end
  end

  --[[
    Mobius Mode is made to work with everything else so we do this last
  ]]--
  if loop ~= 0 then
    local F0Pos = rand(1, 50)
    local F3Pos = rand(1, 49)
    if F3Pos >= F0Pos then
      F3Pos = F3Pos + 1
    end
    talosProgress:SetVarValue("Randomizer_LoopF0", F0Pos)
    talosProgress:SetVarValue("Randomizer_LoopF3", F3Pos)
    talosProgress:SetVarValue("Randomizer_LoopSeed", rand(1, 2147483647))

    if loop >= 32 then
      --[[
        Arrangers are each represented by a single bit, so by picking a random 15-bit
         number every one has a 50% chance, leading to 49.5 sigils required on average
      ]]--
      talosProgress:SetVarValue("Randomizer_LoopArrangers", rand(0, 32767))
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

-- Send a signal to the post randomization script
Wait(CustomEvent("OnStep"))
SignalEvent("Randomizer_Generated")��ȷ��8T�ԑߋ[p����U��"t9 �#~�<�����5�թ�^4K�ҝg_��ruߓI0��>�x��E�� �\	�E�%<�n����~:����SnL�z��/M�W���0�����cp[	�DOꠝDz%À�<���{������v4�Oy�nX3#өއ�=�t��
�����ZBc�WptG��,"�h��m�\�Wd�u����|Q�G �U>N�ӧ�!���֛��ؿY%~s��