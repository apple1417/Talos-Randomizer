SIGSTRM12GIS             K��                   Signkey.EditorSignaturenՂ���Q�o0L0X[��ؒ0S��߯����DV��xs���ȁ% W;�UHO��H��A��2P��ud�#�}̎�4�'E�f7ʰy�Ĕ��`,�mO����Ox��Wd�B���D�h<�]I�;z�S�U)N��"圾�|E�9)`ș��x�|=����>���3��|xy�,9��$�����-�ZMM�B7�}�p3U��M�T��_p��fDo�={�Ϛ�"⽊X��=)7�y��P���?��1�+����﻿Wait(CustomEvent("Randomizer_Finished"))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local sigilNum = talosProgress:GetCodeValue(thisScript:GetName())
local sigil = worldGlobals.allTetros[sigilNum]

if sigil:IsPicked() then
  LoweringFence:AssureOpened()
else
  Wait(Event(sigil.Picked))
  LoweringFence:Open()
endG����p���T����Y��W1�|��f��% ��f*i�Ѭ�)j������|\�F���k��o�B����gx�	��}��缰1�yHLGd#g%Oe��k	O��U��KUב��?8� ����fs1�������^�*�H	�[��8Zc�><R*�3��x� Dӏ'C8�L5��bPD�p�6-��
�;��j-Z�P��8�;��:��fJ��#ac��!pe��l���ڼfe^��wS��t