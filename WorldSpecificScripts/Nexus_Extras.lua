SIGSTRM12GIS             ���K                  Signkey.EditorSignaturez_��*�q����	l�5}P����+�$��9����0k�r����_��/P�$�FV�o\�@`&>s�B�t_�F��a���
�7����@H`
�G�|~SZ��O�<dg��Բ0���HMҀ����<G���G�)H�]����m��̤)���#�EL�H@�xlIc�DD+��)��+��"IC9~{$̐a����������m$�Z��g;��x[�eá�}os�X,�Q�Z4�Y�N�R���g´﻿--[[
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
  BLowerBumpWall:Disable()
  BLowerBumpDetector:Deactivate()
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
  -- We get rid of the bump wall once you're through the gate
  if BLowerArranger:IsSolved() then
    BLowerBumpWall:Disable()
    BLowerBumpDetector:Deactivate()
  else
    RunAsync(function()
      Wait(Event(BLowerArranger.Solved))
      BLowerBumpWall:Disable()
      BLowerBumpDetector:Deactivate()
    end)
    RunAsync(function()
      -- This will never trigger if you solve the arranger
      Wait(Event(BLowerBumpDetector.Activated))
      Wait(Delay(1.25))
      worldInfo:ShowMessageToAll("Where do you think you're going?")
    end)
  end
-- Start in C
elseif 18 <= A1Location then
  ALowerGate:Disappear()
  ALowerArranger:Disappear()
  ALowerLight:Deactivate()
  BLowerGate:Disappear()
  BLowerArranger:Disappear()
  BLowerWalls:Disappear()
  BLowerBumpWall:Disable()
  BLowerBumpDetector:Deactivate()  
  BLowerLight:Deactivate()
  CUpperGate:Disappear()
  CUpperArranger:Disappear()
  CUpperLight:Deactivate()
end>�����@	�!b~|�8>����&nn�`SWP�=82J%&@�*��Vo�����we@{q�N����\��s. ���4�H�:�7#��k������섀�	����_��=�_i���9&�?/�|�q��!<� �D�b �7���ǌS�\�<,��+������· Ǔy^β�,Z�
��4�oJ�w>Ip�@@��9M���*��ռ|P0=�ű�$O���v>��ö��e���%`�S�BG�ߏ�A�@�