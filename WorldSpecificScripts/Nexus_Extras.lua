SIGSTRM12GIS             L%�~                  Signkey.EditorSignature�BTk$�GI�o`d{w�q��j���;hL\C,Z
���k�	�OP#�Ű�Z5��0�����v�uL�s{�⚕� ��0n,��7�����=y�}?�v]�HJ#��^�:k�N�@�k=bVY!���!�	�
�c�9�g���e���.-�)�%ڂ�=�7B0��ǭ��t�_������^S��O�D|���4P�xV���/h���;F�
���Rm�rh�V��JI��AbD�I��w�^t��lj�Z�ʚ�����﻿--[[
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
end
���#p�B��*�yZ?s@J�v����@�Wx���K����h��Ōd�(s�$�p6ůUg)���h�bn���!����xG�N
���|Q�t�[H�G�5/E�?�|b��ǌă_�F��g˔g�N�/6|6m� vw!q�����������TW9���8�+9R��>�߬6C�Y�Δ���O�����	��ι�лyC��$���P�H��WmGU͘������ˇǓk��ή	�qn�~�.