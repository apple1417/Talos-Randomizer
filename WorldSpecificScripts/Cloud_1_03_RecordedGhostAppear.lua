SIGSTRM12GIS             }��                  Signkey.EditorSignature\���(�{OۜI	�E�(Iu��2J���)j'V����4=HXh�C�k�KT����َ�sٕ�\���/�,��)���f�����T��VL:ȕ	���E���i�'6���?}>х�~�]"��昷��J�$hڠF�αpM��1���<GV|�?V���L��&�gw"�R2�Cx��ʨ��T�D�@[�;O6o�RG1{���A��oA;�!�Xi���Eڮ����'2!z��Li�؛��d�P(u̙`FS����R<"�j��﻿Wait(Delay(0.1))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local ABTU = worldGlobals.allTetros[talosProgress:GetCodeValue("015_SRT_SPM_000_PM_018")]
local SwallowedKey = worldGlobals.allTetros[talosProgress:GetCodeValue("020_SPM_000_PM_014")]

RunHandled(WaitForever,
  On(Any(Event(ABTU.Picked), Event(SwallowedKey.Picked))), 
  function()
    detectors_015_020_Exit:Recharge()
    Wait(Any(Events(detectors_015_020_Exit.Activated)))
    local recordedGhost = botManager:SpawnGhostNPC("Recorded Ghost", mkrSpawnPlace)
  end)
 

�9�T�z>-�A\j�����<n�5g�U�<T)��x�,������A���?Nh�I�;>�즏{b�]�=�O��X����]��|����n�;�ί�Ɯ�cB�M|�- W�Q���e^��1��*N�y��ԫ�*��}A��EIf�u�z���\�wHF6'���i�7���Z�cbG0
+��\��2I?��7Ы�﫭����Q8�UZ�FV1z����d�"Ȅ��yG=�`�D
���3�	iX7lL{�