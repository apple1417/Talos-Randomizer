SIGSTRM12GIS             Mp                  Signkey.EditorSignaturex�/��^8�[���ee��(����dhB�Szx��S�-D߼x�e��(�<�:0�y���Q��:	2��������B�ܭA�$��m�
 �����t��a����B�ɀ*҇��J������S����:R$�vE���/C���mI[�?��ip�>�
v`��>w1Q��i�
���{1i����f qG��Oߜ80e}>�agB��T�&�1���u�B�Em;��*^0XEdqM�m
�z^�﻿--Wait(CustomEvent("Randomizer_Finished"))
Wait(Delay(0.1))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local sigilNum = talosProgress:GetCodeValue("015_SRT_SPM_000_PM_018")
local ABTU = worldGlobals.allTetros[worldGlobals.tetros[sigilNum]]
sigilNum = talosProgress:GetCodeValue("020_SPM_000_PM_014")
local SwallowedKey = worldGlobals.allTetros[worldGlobals.tetros[sigilNum]]

RunHandled(WaitForever,
  On(Any(Event(ABTU.Picked), Event(SwallowedKey.Picked))), 
  function()
    detectors_015_020_Exit:Recharge()
    Wait(Any(Events(detectors_015_020_Exit.Activated)))
    local recordedGhost = botManager:SpawnGhostNPC("Recorded Ghost", mkrSpawnPlace)
  end
)
 

E��f��0�g ��/��i�&R���{�֎�ύCY�~[�$��B+��k�*F@��p�ܕF.Z\x�|�/5.��dEP��3u���Z���=y<m���b]���3r7Q�/�E�Za-�p~}f�o.���j��8��Vv�-�!��m��E�5�"���H<'�>�n���G�e#H�}����!)�H��T��� ���LF�;H�Cy��<���:��|�+Z�kӡ�s_G��{��Z�ö��
C