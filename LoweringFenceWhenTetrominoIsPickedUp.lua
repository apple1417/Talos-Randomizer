SIGSTRM12GIS             ��BS                  Signkey.EditorSignature�l�ڏb=7l�&'�>�堧DE+fV���)�=�\�9��OM���:��F�	�lw�`M��~9[�������ڟ��I�ra�ڸ���q1��j��X+{D+�vy6;���+��:�Vݞ����L����w+p8� k��~р�����1��^<��0{Vk͵~�%e$��̡�V^��Ġ�F��n�(fA.����(���y�m,�3<�g��1��PQ ^����3�3^��|87t|�B0�c5#�p[�Wee�﻿Wait(Delay(0.1))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local tetromino = worldGlobals.allTetros[talosProgress:GetCodeValue(thisScript:GetName())]

if tetromino:IsPicked() then
  LoweringFence:AssureOpened()
else
  Wait(Event(tetromino.Picked))
  LoweringFence:Open()
end
���AT�wդa�]n����M��3m�ɖY#�������:+����J�����O���̨��!*ro�u�u��k�NdsNC嵃���C�L�)+U���8;�G͸HL�,���{ 06۬R��T��	�`h�"�N�t�E:�9�*�̮����B��sr��������m�;���H�e������뿜j�:Dw�����"e�\�l$�B[����<�7�'�]��6�@x�"��&��=�`u
�?�