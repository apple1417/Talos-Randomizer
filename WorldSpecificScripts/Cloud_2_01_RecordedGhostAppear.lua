SIGSTRM12GIS             �=-                  Signkey.EditorSignature1��.�*�P��b����}O60�\.3G'FIs ?�ۡ�c��y�����2U�nzN��&fŐBJ5ּ��P/����k�*�4����,`�Ltf�/]hJZq�}�E���1�wD"#��˧-�^3���*���b� kB�c\L�HGK�$0���d�]�#w���"󬅪)e�U�����
���u6j9S6��k*�>#�)~=7WY3~'��߮$qLx!;:�q:+I�H^��cJ��$y����﻿Wait(CustomEvent("Randomizer_Finished"))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local sigilNum = talosProgress:GetCodeValue("319_SPM_000_PM_008")
local RoD = worldGlobals.allTetros[sigilNum]

local elohimVoice_Cease = Depfile("Content/Talos/Locales/enu/Sounds/Voiceovers/Elohim/Elohim-050_Cease.ogg")
local elohimVoice_InTimeOf = Depfile("Content/Talos/Locales/enu/Sounds/Voiceovers/Elohim/Elohim-051_In_the_time_of_your_ancestors.ogg")

RunHandled(WaitForever,
  On(Event(RoD.Picked)), 
  function()
    detector_StartGhost:Recharge()
    Wait(Event(detector_StartGhost.Activated))
    local recordedGhost = botManager:SpawnGhostNPC("Recorded Ghost", mkrSpawnPlace)
    animMover_GhostSound:PlayAnim("Default")
    soundGhostScream:PlayLooping()
    Wait(Delay(5))
    worldGlobals.ElohimSayOnce(elohimVoice_Cease, 0)  
    Wait(Delay(1.5))
    soundGhostScream:Stop()
    Wait(Delay(2))
    worldGlobals.ElohimSayOnce(elohimVoice_InTimeOf, 0)  
  end)ZB��/}�����KU�Z��Z�X*#QǷ눇Wԛ���Ҝ��������7	<7v¢�c���r�˸�H�3mpY�(p���{	�j6�`���wu����_�@I�y��(��3�<+�Ie��Q�b�|��&˖�_r���������@wce�x�vj>��8��K�DP�ZTIs�7yTڌnm�������O��܍��DG"�޲P4CIKZ�ȣ��E�L��X�-Z�����ʴ��bu>