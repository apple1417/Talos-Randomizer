SIGSTRM12GIS             �9�                  Signkey.EditorSignature?hx�Q"�F��8��d��<F�r�73+���d"H;�Y�{��w�r��L���E�K����Ng��}��=���ǹI���]	�Ɇ�kC��*�N�9� N�m��cL�k�H�/rV@��l��x���\�7 Q���0�(!C���Z�&�¬⻳�zh�fށ�}�O��p�N�'��^ϊ��-)���DQ��mI�m����)��^���y�#�����"ޱ��Z��PӺ���x���)*Z�R?�����﻿GatesOfEternityFlare:Deactivate()
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
GatesOfEternityParticles:Start()�3�<)j�/7�=K�l�d��z�J۞�c0����`�kSc�n��b;ՖÕ��3g!mg���r��M{����Wa�Q��tQ@���ZHU���I�^΋XOI�F���'�cB�md*�=Z�7��+`L�~�k������K��}#��E%.y&TH��S��A�Z�F'�,�͢�K����B_�	c����F�f�w�{0'���ULdx�YD��	Gc��*��R�`(jn�œ
�b7yW��ԥ��