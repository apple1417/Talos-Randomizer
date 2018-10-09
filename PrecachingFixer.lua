SIGSTRM12GIS             �6�m                  Signkey.EditorSignaturel\�Ճ{;� -��ɚ�gYAr^�H�e5���D
^T��&�B�g�`q�cKf��:+K�ڝ	�tAM�O��R2䒇���D�g;
�hB�!�mi`{ts`h�~����i!l~�V���bh}�e�@��C�>vk�W�(f�/z�5���]�N������{b&8��,�4�Xn��tk�c�t-���i��nmK�,l\�z����%{����X����@O���o�L5y����\`��aX﻿Wait(CustomEvent("Randomizer_Finished"))

--[[
  Workshop maps in general break precaching, let alone when the next world
   to cache can vary from playthrough to playthrough, so I have to manually
   re-implement it
]]--


-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
--[[
  Caching causes a bunch of log lines, which spam the console and are kind
   of annoying, so if debug mode is on don't do anything
]]
if not talosProgress:IsVarSet("Randomizer_Debug") then
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
    "Cloud_1_01", "Cloud_1_02", "Cloud_1_03", "Cloud_1_04",
    "Cloud_1_05", "Cloud_1_06", "Cloud_1_07", "Cloud_1_08",
    "Cloud_1_01", "Cloud_1_02", "Cloud_1_03", "Cloud_1_04",
    "Cloud_1_05", "Cloud_1_06", "Cloud_1_07", "Cloud_1_08",  
    "Islands_01"
  }
  local shortNames = {
    "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "ADevIsland",
    "B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8",
    "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "CMessenger"
  }
  local fileToShort = {}
  for i=1, #fileNames do
    fileToShort[fileNames[i]] = shortNames[i]
  end
  
  -- Trims out the folder structure and the filetype
  local currentWorld = string.sub(worldInfo:GetWorldFileName(), 33, -5)
  
  --[[
    If we're in standard mode we always want to cache Nexus with high
     priority
    We'll also cache everything in the same hub with standard priority,
     it's going to take long enough to get between the other worlds that
     Nexus can deal with it
  ]]--
  if talosProgress:GetCodeValue("Randomizer_Loop") == 0 then
    cache("Nexus", true)
    local portalPos = talosProgress:GetCodeValue(fileToShort[currentWorld])
    local minIndex = 0
    local maxIndex = 26
    if portalPos <= 9 then
     minIndex = 0
      maxIndex = 9
      cache("Islands_02", false)
    elseif 10 <= portalPos and portalPos <= 17 then
      minIndex = 10
      maxIndex = 17
      cache("Islands_03", false)
    else
      minIndex = 18
      maxIndex = 26 
    end
    
    for i=1, #shortNames do
      local index = talosProgress:GetCodeValue(shortNames[i])
      if minIndex <= index and index <= maxIndex then
        cache(fileNames[i], false)
      end
    end
    
  --[[
    In mobius mode we of course never visit Nexus, so instead we cache
     the next two worlds with high priority, and then the next 8 with
     standard
    If you're just looping through worlds I have a feeling it still won't
     keep up, though nothing I can really do about it
  ]]--
  else
    local nextIndex = talosProgress:GetCodeValue(fileToShort[currentWorld])
    cache(fileNames[nextIndex], true)
    nextIndex = talosProgress:GetCodeValue(shortNames[nextIndex])
    cache(fileNames[nextIndex], true)    
    for _=1, 8 do
      nextIndex = talosProgress:GetCodeValue(shortNames[nextIndex])
      cache(fileNames[nextIndex], false)
    end
  end
end�� ��dK�_h:�f�{�T����xs�����4p�څ.���7��}�w�O�}+��j�,��V
��P�M(v�=��B�vf�'���ʘ@!��!���]�s	Δa}CX
�DC/����4ʁ F+�:�˶#�<#�kw�JQ�R��ҋ�!Z�%(E樓��𴸺9C����K�B5k(G�YA*,2�'�hOz�>+X��"� }���pK�Q��XAJ���`ʪ�u�(��W����� �2ʤ�