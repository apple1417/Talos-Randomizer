SIGSTRM12GIS             �v�                  Signkey.EditorSignaturek�b����q��x��}]�����W/�L��1Y�5��֦Mu��p��	�z=ͯ�B��������&66��g�5����l���N�+�.�hpW>;�0%�ļ0P�I�6ؼ�;{��#ŠKU���b����\JA�;����uT3�`�1$b��7�K� ���?n4�[l�d���{$�6�kD]��oD�����pCU;=���n�8*y�/h�d�pB��_@-����/�{���S���3`h[��Z?H��^�﻿--[[
  Normally this is part of the portal numbering script
  It doesn't really fit, the script even says they should be
   separated, so when I rewrote it I did just that

]]--

GatesOfEternityFlare:Deactivate()
SmokeParticles:Start()
Door:Lock()
OpenedHeavenDoorGlow:Disappear()
ClosedHeavenDoorGlow:Appear()
HeavenGatesLight:Deactivate()

local talosProgress = nexGetTalosProgress(worldInfo)
if not talosProgress:IsVarSet("GatesOfEternityOpened") then
  Wait(CustomEvent("GatesOfEternityOpened"))
end

GatesOfEternityFlare:Activate()
SmokeParticles:Stop()
Door:AssureOpened()
OpenedHeavenDoorGlow:Appear()
ClosedHeavenDoorGlow:Disappear()
HeavenGatesLight:Activate()
GatesOfEternityParticles:Start()
X��H\l?:�{��v8D�����ٖX�:�e%���D��
l��4#RArd����S5
�;��5Œ�b�:��;)�#�'y��G߯]�����O�΄��ҙ�R�`4^C��ӒfF���i�[����n��}_`�9�F��gY��hcG�`�/@�>���|"����b��T�:W*S�B˞.�o��ܧc�r=���JT���C�df��BB"#����E�:>\b]v�-�I�(����R�gԭ��"4��|m