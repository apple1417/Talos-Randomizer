SIGSTRM12GIS             ��oe                  Signkey.EditorSignature������@:��S+�њ�����[=ia�������ͨ��g������f�J����6�L6���R���|�:��%��--+Po�L9��ں��e�����"�0�>D�����F��� �q���Q�]GM��4r�̝�~z�5 ����!u�� 5�h��:���ms���l<f�$b��݊q��h�̃�R��߻9z;���Ee:Lە�� �����h�d�e�����~OYD�Ԭs��s���C$�﻿-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)

if talosProgress:IsVarSet("Randomizer_NoGates") then
  Gates:AssureOpened()
end

if talosProgress:IsVarSet("Randomizer_Portals") then
  Wait(CustomEvent("Randomizer_Finished"))
  
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
    end
  end
end
,��6���G���A�+iGl�����bi�ĸL����e��[3'W5��S�
;�ek��H� ���lqdE%���ޫ�>�������w���*Wq�y��f��gwH���I(|�nR[�J��ZJ(��ucgaj���4���
�b>�1Fa񖚞Lh�-(�3�lMt����,��IQ�s!���Xq���=��p#�����@m%��;u�.W�6e2��Ȗ��ġB��p:�2� 
��K�T\��M�