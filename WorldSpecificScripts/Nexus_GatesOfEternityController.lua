SIGSTRM12GIS             [[��                  Signkey.EditorSignature݆2��̎2kP���I���Y4w]�xv�gNS�ѯ��;���E�8)�:V��l�_[���A�����5�L^�o΅v��Z�N�6���ŘB��8����L�����$��ڑ���~�aZn9@�Ͽ?j��Y��������Z��-�9F���X�Y+�4ma8��y]M�;�V.���q�����mT�&V����
{�K���⨚�$O���Hc�z��Xܨ��VA��I��>?�>e���bG��;<M/﻿--[[
  Normally this is part of the portal numbering script
  It doesn't really fit, the script even says they should be
   seperated, so when I rewrote it I did just that

]]--

GatesOfEternityFlare:Deactivate()
SmokeParticles:Start()
Door:Lock()
OpenedHeavenDoorGlow:Disappear()
ClosedHeavenDoorGlow:Appear()
HeavenGatesLight:Deactivate()

local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
if not talosProgress:IsVarSet("GatesOfEternityOpened") then
  Wait(CustomEvent("GatesOfEternityOpened"))
end

GatesOfEternityFlare:Activate()
SmokeParticles:Stop()
Door:AssureOpened()
OpenedHeavenDoorGlow:Appear()
ClosedHeavenDoorGlow:Disappear()
HeavenGatesLight:Activate()
GatesOfEternityParticles:Start(),�Jqʦ�>��NBj�����|�JDO�7-v��-ފ-���E��IP�j���gR���j��3��+P�?��؄�~���~���6,����8���0���r=�F�:�T�=�b��D��3#:V����c&��b.%��� l���2�_�\hȜ��B BK�H�'X#l/�[>_����PK+ #R�^����Y$|cj�F#m���;2��ePH ���M앪�.뺄\�f�ۮ]*,<0�Sja��G�