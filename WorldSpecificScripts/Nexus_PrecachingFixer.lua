SIGSTRM12GIS             t�D                  Signkey.EditorSignature3���G6�8d4�w��eۂ�씾+�*�̳%:Q��N��Hꝏ�"����e�"j9��g�v|�:�S���7������R	q��.��j���+7��`ջ��1	�y��4O�/! ��6=E���ECҝ��vD�6�Y��p��v�+0���b�)�/"�j[3�Ġ`������l��~�3?��<Az��E�h�/���a�Dq�M�J�*�|��:%A�ʠ���LW�l(�McѳeS�I����Ӕ+_��﻿-- We want to get the player, but also have to wait for rando setup to finish
local event = Wait(All(Event(worldInfo.PlayerBorn), CustomEvent("Randomizer_Finished")))
 -- player : CPlayerPuppetEntity
local player = event.all[1]:GetBornPlayer()

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
  
  --[[
    The basic idea for Nexus is to cache everything in the player's hub with
     high priority, and everything else on standard    
  ]]--
  local function cacheA()
    cache("Islands_02", true)
    cache("Islands_03", false)
    for i=1, #fileNames do
      cache(fileNames[i], i <= 9)
    end
  end
  
  local function cacheB()
    cache("Islands_02", false)
    cache("Islands_03", true)
    for i=1, #fileNames do
      cache(fileNames[i], 10 <= i and i <= 17)
    end
  end
  
  local function cacheC()
    cache("Islands_02", false)
    cache("Islands_03", false)
    for i=1, #fileNames do
      cache(fileNames[i], 18 <= i)
    end
  end
  
  local function cacheAll()
    cache("Islands_02", false)
    cache("Islands_03", false)
    for i=1, #fileNames do
      cache(fileNames[i], false)
    end
  end

  -- Use the player's y value to try work out what world they're likely to visit next
  local y = player:GetPlacement().vy
  if -100 < y and y <= 0 then
    cacheA()
  elseif -200 < y and y <= -100 then
    cacheB()
  elseif y <= -200 then
    cacheC()
  else
    cacheAll()
  end
  
  -- If the player goes down an elevator try redo caching, in case they don't reset
  RunHandled(WaitForever,
    OnEvery(Event(AButton.Used)),
    cacheA,
    OnEvery(Event(BButton.Used)),
    cacheB,
    OnEvery(Event(CButton.Used)),
    cacheC
  )
end"`f�d9ٶ���>���\ђQb!̑_�w=)5��?l��bb68}0��u^]�Զ���q�.�dU7�fÖT�ӯY�P�@1U:̈N��9턌�ӵPÕ�t�FdVH~�����nd�ʊ ĿM�Gz�Af��F[�;o3骆}����s�����聲G�"l�#(�$��"7~�r�ޫ~��{���ݡ���P�(tLW��%G+���dQo��������U�CjMPC�Wp�s���)���Tz�
s(&l