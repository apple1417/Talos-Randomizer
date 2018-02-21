SIGSTRM12GIS             V�x\                  Signkey.EditorSignature0��x�@OFc���ix�iJT��WȒ]R�J��+:S�I���Q˷�m&u��P@��C͝�s�ਚ���KS7dx��6�T`��O8b�>���#��ҔZ?�0�'���>��A!�B��qzT^�� �Cu[$3���48o������O؂���M�S�T��w�=A�����S�ey1�ԇ��v�����1u�`b����U�Z�5�|?�k��դG�\O:d�#F�j]���|����0�C�﻿-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)


local allPortals = {
  A1, A2, A3, A4, A5, A6, A7, A8, ADevIsland,
  B1, B2, B3, B4, B5, B6, B7, B8,
  C1, C2, C3, C4, C5, C6, C7, C8, CMessenger
}

local portalNum = 9
if talosProgress:IsVarSet("Randomizer_Generated") then
  portalNum = talosProgress:GetCodeValue(emptyPortal:GetName())
end
local portal = allPortals[portalNum]
      
local emptyPos = emptyPortal:GetPlacement()
local portalPos = portal:GetPlacement()
emptyPortal:SetPlacement(portalPos)
portal:SetPlacement(emptyPos)
<*�cS|�7�B[@�}�#�RC<�}�o���^�.S�����Y,Y0���9e�osMr�>T���y۝�0m!��[�E��B����H! ��0���6��1����~�խ6��������E;*����}I[�B���[D�����/��y��Ӧ -\.9e�z"�]��]؈��>%:���>��ۮ�1�2��`��l&��Փ7S�yCR�a��o��cB����~����~�������j�Z���dH�