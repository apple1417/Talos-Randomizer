SIGSTRM12GIS             ���	                  Signkey.EditorSignature�6�6wo$&yow Ҽ��D2A��'��[���k�=�45?ځ�3r%�<l���_]}D���B�Z���K&]���'�s���@�:4H�I�
�-��h3�Q��8h�	6��>b�xj
���Jܽ"��U��<�_~5 �*��z|1�v�ݖ�>��-��m����l�+vt���-�,2�
ʉ#L�g�������G-#���H�*/���0g5Q�A��.�D�i�7����IH4_і=���=`�﻿-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)

if talosProgress:IsVarSet("Randomizer_NoGates") then
  Gates:AssureOpened()
end

Wait(CustomEvent("Randomizer_Finished"))
eternalizeText:SetText(eternalizeText:GetTextConfig(), "Seed: " .. talosProgress:GetCodeValue("Randomizer_Seed"), true)
trancendenceText:SetText(trancendenceText:GetTextConfig(), "Seed: " .. talosProgress:GetCodeValue("Randomizer_Seed"), true)

if talosProgress:IsVarSet("Randomizer_Portals") then
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
      portalList[i]:SetPlacement(OOB)
    else
      portalList[i]:SetPlacement(portalLocations[locationNum])
      if talosProgress:IsVarSet("Randomizer_Debug") then
        conWarningF(string.format("Placing %s at %s\n", portalList[i]:GetName(),  portalNames[locationNum]))
      end
    end
  end
else
  DevIslandNumber:Disappear()
end

local A1Location = talosProgress:GetCodeValue("A1")
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
O�97�8�y�a�BQo�i�N��5�y���8ޞe^���#��!�y��>����	�P5�����e+�C,O��ʒ��v3M,5��s�B�+���v�U�S�A>A"=y�yBZ�K.1$�rA��:���Ԉ*g��� gK$��V�Z�0�$4�&X��e%'�n�H�Z1�M��id�-1����6V�m�/Y�e�������U�A�z\/�q�#��e��6�R�N��T"�����g���L�+GwR�Ze