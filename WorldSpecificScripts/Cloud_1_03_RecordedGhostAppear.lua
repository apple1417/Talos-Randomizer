SIGSTRM12GIS             x�+                  Signkey.EditorSignature���Jc}�`�?�Yͭ\A`J��=�|�bx`R��J�ALmx�sV���7���s	G/mj�-!����d|GoxjaA�å�����5J�'�mi���d�wfD�b�+��`��^����M�D�.����}&)�)�	�G�4/S.�$����`I�M�)���PP�b��H�Ȟ��mP��yd%�1�q�O&,�&��Q�لGaxq����4Kl(���Vn�<��bN�M a�&��I;�`�T7m�ޠ﻿Wait(CustomEvent("Randomizer_Finished"))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local sigilNum = talosProgress:GetCodeValue("015_SRT_SPM_000_PM_018")
local ABTU = worldGlobals.allTetros[sigilNum]
sigilNum = talosProgress:GetCodeValue("020_SPM_000_PM_014")
local SwallowedKey = worldGlobals.allTetros[sigilNum]

RunHandled(WaitForever,
  On(Any(Event(ABTU.Picked), Event(SwallowedKey.Picked))), 
  function()
    detectors_015_020_Exit:Recharge()
    Wait(Any(Events(detectors_015_020_Exit.Activated)))
    local recordedGhost = botManager:SpawnGhostNPC("Recorded Ghost", mkrSpawnPlace)
  end
)h�lf�^_��5��sG� ��ꗾ�ֺ�T�Z���B�$�I�);RՀIc}*~�M���h�4B&��~#I�n�$�<��>]����4H��P �u�K˂�~�"U�[xpn���[+À��I_[��{!I��5���W�'o� -�CO�5hX�Ec��:�	r�b	:�EZ���MR����Zlz��\8OE���A�}�U|f-Bw%$�<y���_���������,(#?G��H}	�����'�'�i����6��@�