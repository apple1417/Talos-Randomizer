SIGSTRM12GIS             �4��                  Signkey.EditorSignature�7��y��^Q����F�˖7}�tb��<f��aM�9*�TȊ��pX�?+�T�Kly��9P�%�AX9ԑl����RO�H͌���8Y3�r�ںm���yMzz|F���/���\r�����i�u����YZt���Մ ����K�	C�+	��|�IL���<t�j��7�
�#�&��\���t�ɞ�P.2��3�þ&o_��,jĵ!��CRL��@9�*�M����D�� P���_�RnNi��﻿-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
talosProgress:SetVar("DevIslandVisited")

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
���� 6�ňH��1��� �B�޽}.�h3}c,J5��,ʘ�7Y�=�FQ������ͤAq�*��*;����I�J��6W焜���QFD'�E/�v�Q��5���z%���8�",H��3����A7�{��qJnDV�b��h����Fψ�!8�W�v���N<B��SiH�x����vV,z[�xm��ގ���g�4�X\��l���{�wW�s�g��X�'5�b"������[6��g�S鷑�