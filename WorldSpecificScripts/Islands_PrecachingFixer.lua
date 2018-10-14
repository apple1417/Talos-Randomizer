SIGSTRM12GIS             k��@                  Signkey.EditorSignature����@*�#��w=�����v�ܶ����u~ �r�6L�
�A��$z��F5w&ؖ��pW3�x�1k}Pί���?���T�?M�*n��~��(z�0�����?7�*{�4�>
#aFa�׬��؛��NMX��++V��oT��Dv����0n:�@�W�E�<�O��F/k�#>ȹ�`\���ypPN���M�s��n+�m���7_��Hf�ϥ��8���FB���f���/��'R~_��G�ۍ�1﻿Wait(CustomEvent("Randomizer_Generated"))

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
end7KI�+��N��MY��E�M�/*Z'U�@�O`3ϣE1�wU?�5�*I��n��gXPc���*����N�v9g�Y�c���rxѪ�����@n6�U��\_j�őw꜁��"�"�LK��^��{� ����%�!v���pG!�����'��V��s<aQ�'�N*��B�V����T��+��(�g�*��g�5-K�p�@^R���P�����_�4iJ�%�1�AHc��(Q�jA��U�#�WM)*#