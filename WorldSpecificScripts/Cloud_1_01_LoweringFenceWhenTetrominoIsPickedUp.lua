SIGSTRM12GIS             t3L�                  Signkey.EditorSignatureA������o}A�n�i���Xa�e�b>!;0�r��Gݤ�tKDԿ���\��Ȱ|�ۘ����`��P��a�uG��f�o��e*@}0�3����g-<, �؟�+U�$�_�6-��1�^U*���~/�u����3�̾!�AA!��)^_Dd�����i�*,'�+,��n@m�:����hN��� X6E�5�ѱ�3���[�K�5y
�rRH�V�x=���
�����?���-�fǣ��Eέ����_﻿Wait(Delay(0.2))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local tetromino = worldGlobals.allTetros[talosProgress:GetCodeValue(thisScript:GetName())]

if tetromino:IsPicked() then
  LoweringFence:AssureOpened()
else
  Wait(Event(tetromino.Picked))
  LoweringFence:Open()
end
�*�>V�}���{Rߝ�7����be����2�-O�R/���;�2�����&�����\.����
���;9Z�e0	��C��Y�cx���7�&$�3ݪl���U��_��f�6�o��G�82��bq��Hs}�@�M��s��)JQ��Kk�KLo�J�ץNѴ!���$�3O�fI�2�!��.vpH��7���==A�n�b����A���Ć��̿f�}��Jpq�#E�"'���_Kq���Ƀ�9˵�