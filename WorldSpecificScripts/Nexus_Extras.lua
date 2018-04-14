SIGSTRM12GIS             ����                  Signkey.EditorSignature�K<:�>�v�zpPȆޟ�^��F��e4�@�7>�+�$��z�R	���(��{����c�­\� �Q��P�d��4�-R�a�p���LE����3��ڗ2�C��"�3���W�#2'Wi�^��6��S#��~b��dßDca����^�.[H.&)��S�=��]�\�%��L�8'�p�Rxm�+@wA��m��)��j`| Y�[���[�R�<�7�Lإ��'ĥb;�)�mR�J�u1��$﻿--[[
  Like "Cloud_1_01_ExtraOptions" there are just a bunch of small
   things we need to do to properly setup this world, all put
   into this script
]]--

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)

-- It's easier to open all gates, even the ones that'll dissapear later
if talosProgress:IsVarSet("Randomizer_NoGates") then
  Gates:AssureOpened()
end

Wait(CustomEvent("Randomizer_Finished"))
-- Want the seeds to show up on signs by each ending
eternalizeText:SetText(eternalizeText:GetTextConfig(), "Seed: " .. talosProgress:GetCodeValue("Randomizer_Seed"), true)
trancendenceText:SetText(trancendenceText:GetTextConfig(), "Seed: " .. talosProgress:GetCodeValue("Randomizer_Seed"), true)

-- Because Nexus already has all the portals we can just shuffle them around
if talosProgress:IsVarSet("Randomizer_Portals") then
  --[[
    Because people had trouble remembering dev island was a thing we give
     it a normal portal outline when random portals are on
  ]]--
  DevIslandCover:Disappear()
  
  local portalNames = {
    "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "ADevIsland",
    "B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8",
    "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C8", "CMessenger"
  }
  local portalList = {
    A1, A2, A3, A4, A5, A6, A7, A8, ADevIsland,
    B1, B2, B3, B4, B5, B6, B7, B8,
    C1, C2, C3, C4, C5, C6, C7, C8, CMessenger
  }
  
  local portalLocations = {}
  for i=1, #portalList do
    portalLocations[i] = portalList[i]:GetPlacement()
  end
  local OOB = thisScript:GetPlacement()
  
  for i=1, #portalNames do
    local locationNum = talosProgress:GetCodeValue(portalNames[i])
    if locationNum < 0 then
      conErrorF("Portal " .. portalNames[i] .. " does not have a location assigned to it!\n")
      -- To make sure you notice, incase you're not looking at console
      portalList[i]:SetPlacement(OOB)
    else
      portalList[i]:SetPlacement(portalLocations[locationNum])
      if talosProgress:IsVarSet("Randomizer_Debug") then
        conWarningF(string.format("Placing %s at %s\n", portalList[i]:GetName(),  portalNames[locationNum]))
      end
    end
  end
else
  -- When random portals are off we want to keep dev island hidden
  DevIslandNumber:Disappear()
end

--[[
  Because you can't solve arrangers from behind we need to have
   extra gates incase random portals puts you outside of A
]]--
local A1Location = talosProgress:GetCodeValue("A1")
local Scavenger = talosProgress:IsVarSet("Randomizer_Scavenger")
-- Start in A
if A1Location <= 9 then
  AUpperGate:Disappear()
  AUpperArranger:Disappear()
  AUpperLight:Deactivate()
  BLowerGate:Disappear()
  BLowerArranger:Disappear()
  BLowerWalls:Disappear()
  BLowerLight:Deactivate()
  CLowerGate:Disappear()
  CLowerArranger:Disappear()
  CLowerLight:Deactivate()
  if Scavenger then
    ALowerGate:AssureOpened()
  end
-- Start in B
elseif 10 <= A1Location and A1Location <= 17 then
  ALowerGate:Disappear()
  ALowerArranger:Disappear()
  ALowerLight:Deactivate()
  BUpperGate:Disappear()
  BUpperArranger:Disappear()
  BUpperLight:Deactivate()
  CLowerGate:Disappear()
  CLowerArranger:Disappear()
  CLowerLight:Deactivate()
  if Scavenger then
    BLowerGate:AssureOpened()
  end  
-- Start in C
elseif 18 <= A1Location then
  ALowerGate:Disappear()
  ALowerArranger:Disappear()
  ALowerLight:Deactivate()
  BLowerGate:Disappear()
  BLowerArranger:Disappear()
  BLowerWalls:Disappear()
  BLowerLight:Deactivate()
  CUpperGate:Disappear()
  CUpperArranger:Disappear()
  CUpperLight:Deactivate()
  if Scavenger then
    CLowerGate:AssureOpened()
  end  
endn�8'Ǡ2���`�4��n�6�*]b��rk����/�� w;MM*�c_����R�S��_&�.m)�Wi~��L�C��Z��_¯wC����0� m^5u�A����٪ә���s�j�T'=�1F.�xN�L4��[�Be�����%M�Et>��對L�����]�`˜�;�ly�9�S���/�\���d~����]oz�B*�c��qH�����^��TC��^%H}}�H^���' �I�B\5�