SIGSTRM12GIS             ܬ�                  Signkey.EditorSignaturej�_��z֪�p��z'�1�\T�H��Ƥ[$;b|EsК��#a-��߮T�����Hn�ks[=+������/���������u�B�zlww�����pOל���J� �9$°��C�|�|P��?��ÀB��	�&Y"�o/"�U[��Z�y�_*��9EOz}�ռ�'�׳�����\�+�A�����A����5���Ѕ�ߊ��a+�Js�0���6���]�*�<�W�<j�x�ͅ%�?Cow���sȜ�﻿--[[
  Normally these gates are bound to a single sigil, but we need to
   work out what that sigil actually is
  This is actually really commonly used, so we take the script name
   as marker name, because that lets us get away with using a
   single script everywhere
]]--

Wait(CustomEvent("Randomizer_Finished"))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local sigilNum = talosProgress:GetCodeValue(thisScript:GetName())
local sigil = worldGlobals.Randomizer.allTetros[sigilNum]

if sigil:IsPicked() then
  LoweringFence:AssureOpened()
else
  Wait(Event(sigil.Picked))
  LoweringFence:Open()
endT���yQ5` t�G���*�Es��x���=ZE�T�v�jJG���ۯH��6_#�	�_�"6S�$!D�����������9�:Y�\��8���fǋl˃�&��j��}�����<���?�m���x�T�~w��0x~"��;�Z�*�]fud���Ğ���p���IN�K�0�%F�O�w�q��?�b7��.�`0NxI���qTGڴ5�����Q���������9�r��2� �aE�r�j��@ Q��