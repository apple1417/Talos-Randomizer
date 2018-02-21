SIGSTRM12GIS             EP��                  Signkey.EditorSignatureF����St��n9�,F��^^����I���+���W: r"���'X��+��T_S�xКw���@= ��K=9�&.O&�G<�����Nr?m��=�,䲰�|_A(jj�TS�����͵
��RsN#Q�]Z1���D
�)rRQ�HZ��y6� �/:�uWh�s�U;H�D�E�*%/�G�K�l�m�3�8���iHqSm�oܜ������to��sv�GL�c���H�5n��*��p�h,~�cJ�h��嗦���v﻿-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)

if talosProgress:IsVarSet("Randomizer_NoGates") then
  Gates:AssureOpened()
end

Wait(CustomEvent("Randomizer_Finished"))
eternalizeText:SetText(eternalizeText:GetTextConfig(), "Seed: " .. talosProgress:GetCodeValue("Randomizer_Seed"), true)
trancendenceText:SetText(trancendenceText:GetTextConfig(), "Seed: " .. talosProgress:GetCodeValue("Randomizer_Seed"), true)

if talosProgress:IsVarSet("Randomizer_Portals") then
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
#�G��(�����HJ���={f���D� �I!G��+�ݎ�x��bws���s��,J�{ɼ�}���4�(�1�t��D��Y_�!=gۋn�U`�ͦ\�.FʞZͱުV��%�[��;���v�qaw�i�t���vc��C݅0G�� PyYqq�}�� X�y��~��#
�6�{�+�̣�w�F{2n� ݬ����
M��jo�2����U�xT0tK˓�Y_^��{�h�[��w|=���mA