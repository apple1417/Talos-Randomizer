SIGSTRM12GIS             �P0�                  Signkey.EditorSignature��᷇����fW�w��U���Ϧ�J�e��l�@�;<I�ݘ���'foe�Y�|���i�&��������@%8_Z�� 46�F���|�aB�T�D���9G�8�w�j�ĠE��AZXul�z�_W���#W�3I�`�n5�D��Ӄ_,�olp�Կb��5x*�־�ROo3Z�i}F:1t��Vm]��6Q|�@���8���~�ߤ� ��"���o�]�^mG�؛�h�z�p�i,����NB'�!����﻿Wait(CustomEvent("Randomizer_Generated"))

--[[
  Workshop maps in general break precaching, let alone when the next world
   to cache can vary from playthrough to playthrough, so I have to manually
   re-implement it
]]--


-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)
local printWarning = worldGlobals.printWarning
--[[
  Caching causes a bunch of log lines, which spam the console and are kind
   of annoying, so if debug mode is on don't do anything
]]
if talosProgress:IsVarSet("Randomizer_Debug") then
  printWarning("Disabling Precaching")
else
  local function cache(world, high)
    if high then
        worldInfo:AddToWorldCache_AsHighPriority("Content/Talos/Levels/Randomizer/" .. world .. ".wld")
    else
      worldInfo:AddToWorldCache("Content/Talos/Levels/Randomizer/" .. world .. ".wld")
    end
  end
  
  local fileNames = {
    "Cloud_1_01", "Cloud_1_02", "Cloud_1_03", "Cloud_1_04",
    "Cloud_1_05", "Cloud_1_06", "Cloud_1_07", "Cloud_1_08",
    "DeveloperIsland",
    "Cloud_2_01", "Cloud_2_02", "Cloud_2_03", "Cloud_2_04",
    "Cloud_2_05", "Cloud_2_06", "Cloud_2_07", "Cloud_2_08",
    "Cloud_3_01", "Cloud_3_02", "Cloud_3_03", "Cloud_3_04",
    "Cloud_3_05", "Cloud_3_06", "Cloud_3_07", "Cloud_3_08",  
    "Islands_01"
  }
  local shortNames = {
    "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "ADevIsland",
    "B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8",
    "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "CMessenger"
  }
  
  -- Trims out the folder structure and the filetype
  local currentWorld = string.sub(worldInfo:GetWorldFileName(), 33, -5)
  
  --[[
    We're always going to be in standard mode, so we always want to cache
     Nexus with high priority
    We'll also cache everything in the same hub with standard priority,
     it's going to take long enough to get between the other worlds that
     Nexus can deal with it
  ]]--
  cache("Nexus", true)
  local minIndex = 0
  local maxIndex = 26
  if currentWorld == "Islands02" then
    minIndex = 0
    maxIndex = 9
  else
    minIndex = 10
    maxIndex = 17
  end
    
  for i=1, #shortNames do
    local index = talosProgress:GetCodeValue(shortNames[i])
    if minIndex <= index and index <= maxIndex then
      cache(fileNames[i], false)
    end
  end
end���H��|���rd��K��E9BH����K©���2�sEa�Џ� ��_]_���=�樋�R +L�D�y�bYy�U��"/j*��E��e����P��#��� ���B�
�S:��NޟdH+34l�W���������;� !d˲�nI�f�Y �G&�Gq|/[�� ~��ȇ���	rzuj������/[���"�R%%�5���v;��?���V�� F|ac�{Q��5�0`������