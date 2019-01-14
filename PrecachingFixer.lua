SIGSTRM12GIS             ���                  Signkey.EditorSignature-<SՍ:c���|{v)ez����	i_H?y�K2�]��yԟ�:&�l�%���&�$�S~<��jyYӯȄD%�����0�fGF��^�Kq�H��[�N�".����5����>&�Х���cR��#<�Q��z���z��EZ�uA�K�#���&��⠺���}b3_qވ�`�ӛ��;�(r��A?o}���Q�i�w��:���?���[�`�CO�d&�Y$R���7�����3e��I��%FzP﻿Wait(CustomEvent("Randomizer_Finished"))

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
  local fileToShort = {}
  for i=1, #fileNames do
    fileToShort[fileNames[i]] = shortNames[i]
  end
  
  -- Trims out the folder structure and the filetype
  local currentWorld = string.sub(worldGlobals.currentWorld, 33, -5)
  
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
     the next two worlds with high priority, and then the next 6 with
     standard
    If you're just looping through worlds I have a feeling it still won't
     keep up, though nothing I can really do about it
  ]]--
  else
    local nextIndex = talosProgress:GetCodeValue(fileToShort[currentWorld])
    cache(fileNames[nextIndex], true)
    nextIndex = talosProgress:GetCodeValue(shortNames[nextIndex])
    cache(fileNames[nextIndex], true)    
    for _=1, 6 do
      nextIndex = talosProgress:GetCodeValue(shortNames[nextIndex])
      cache(fileNames[nextIndex], false)
    end
  end
end*R��mVc}.�b�0���.wɠ&xb� �jh3b�8&���zy���r-��3��p������j���
�Ԩq%���[���h�Ȱ�N�<u��W�?�T���CU[���������Yw�FhdH�͏�,����
@�d��G��ⲧ6���[����p�⨘�>g�l�bE�\�d|ܔޭ�9�KϬȸ��|�ҝ"�&"���v��6t����aSи�Q���z�����w� *���x�OF�eQM�jA	g