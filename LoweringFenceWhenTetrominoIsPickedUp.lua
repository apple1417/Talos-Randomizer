SIGSTRM12GIS             ��                  Signkey.EditorSignature"���c��1����g�Am0���v�  R�-�oD�P��I���'�5��U����38A�y�0Lm�#à������1�12n��۠�t�����
�����
����9���q���9*:��Uu��O%]��K���8w	& ��`Fw�E�l|/�Sa�0LX����	L�W]�򀽃>�R,��1si-�m��ڰ��u-�J�C�\¿��6�|��ϩ%Yh�"�����G���( ���\�`�Z#�jL&��J_YL﻿--[[
  Normally these gates are bound to a single sigil, but we need to
   work out what that sigil actually is
  This is actually really commonly used, so we take the script name
   as marker name, because that lets us get away with using a
   single script everywhere
]]--

Wait(CustomEvent("Randomizer_Finished"))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local sigilNum = talosProgress:GetCodeValue(thisScript:GetName())
local sigil = worldGlobals.allTetros[sigilNum]

if sigil:IsPicked() then
  LoweringFence:AssureOpened()
else
  Wait(Event(sigil.Picked))
  LoweringFence:Open()
endI��X��q5˿�I�+Vu2J[Z&_�L)ԥ\3Z{M{��]����Ƞҏ
Iԃ�k��_���aj~��b�� XY��W��*��΀��|�#K�ta��P��Qw����k	��� ��w�~��">��oX����@N�]�]"*��S����T*3.,7u<A!yM�Z��*a��-����Ȕ��6��\��	e���GԆn[d�����W�j���"7�m�3N��1R]��A�Z��T'�2�,)� ��s4���