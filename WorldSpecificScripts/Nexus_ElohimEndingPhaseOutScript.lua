SIGSTRM12GIS             �l�B                  Signkey.EditorSignature|��uR|�D�Ah���k�=���n�e��g"��z�o�J*�V���8��j;�\^o�"�o�=d�8� ���o��_Lf��^[J	s)����g$���*����h27jD�����ϭ�_IF���s�ǣ�A]�>�J���{����F��K\�A��l�6}(>���L�C��|�*`��J-$*���n��^�v������ʤ[`��	�,Y�������&��Ë�w��!�U�Y��<﻿--[[
  Normally eternalize ending restarts the game - we want to do the same
  We copy all the options that were set (except seed) so it plays just
   like last time
]]--

exitPortal:Enable(false)
Wait(Event(terminal.Started))
EndCSLevelChapter:AddNextLevelToWorldCache()
-- talosProgress : CTalosProgress

RunHandled(
  WaitForever,
  OnEvery(Event(terminal.FinishedTyping)),
  function()
    local talosProgress = nexGetTalosProgress(worldInfo)
    if talosProgress:IsVarSet("StartEndOfGameCS") then

      Wait(Any(CustomEvent(terminal, "TerminalEvent_1"), Delay(10))) -- delay, just in case so we don't get stuck
      Ending_Gates_WhitenessAnimator:StartAnimation("TurningOn")
      -- award the achievement if player has already reached the top of the tower and came back to elohim ending
      if talosProgress:IsVarSet("ACH_ReachedTheTowerTop") then
        worldGlobals.worldInfo:AwardAchievementToAllPlayers("ChangedMyMind")
      end
      Wait(Delay(2.5))
      -- Copy randomizer options before we delete them
      local Mode = talosProgress:GetCodeValue("Randomizer_Mode")
      local NoGates = talosProgress:IsVarSet("Randomizer_NoGates")
      local UnlockItems = talosProgress:IsVarSet("Randomizer_UnlockItems")
      local ShowAll = talosProgress:IsVarSet("Randomizer_ShowAll")
      local Debug = talosProgress:IsVarSet("Randomizer_Debug")
      local Portals = talosProgress:IsVarSet("Randomizer_Portals")
      local Scavenger = talosProgress:GetCodeValue("Randomizer_Scavenger")
      -- This one is redundant, but I don't want to leave options out
      local Loop = talosProgress:GetCodeValue("Randomizer_Loop")
      local Moody = talosProgress:GetCodeValue("Randomizer_Moody")
      local Jetpack = talosProgress:IsVarSet("Randomizer_Jetpack")
      
      -- clear the talos progress (so we can start the game anew)
      talClearTalosProgress(exitPortal)
      -- set the variable saying that we've already finished the 
      -- game so the new beginning can be a little bit different
      local talosProgress = nexGetTalosProgress(worldInfo)
      talosProgress:SetVar("AlreadyFinishedGame")
      
      -- Set randomizer options again
      talosProgress:SetVarValue("Randomizer_Mode", Mode)
      if NoGates then talosProgress:SetVar("Randomizer_NoGates") end
      if UnlockItems then talosProgress:SetVar("Randomizer_UnlockItems") end
      if ShowAll then talosProgress:SetVar("Randomizer_ShowAll") end
      if Debug then talosProgress:SetVar("Randomizer_Debug") end
      if Portals then talosProgress:SetVar("Randomizer_Portals") end
      talosProgress:SetVarValue("Randomizer_Scavenger", Scavenger)
      talosProgress:SetVarValue("Randomizer_Loop", Loop)
      talosProgress:SetVarValue("Randomizer_Moody", Moody)
      if Jetpack then talosProgress:SetVar("Randomizer_Jetpack") end

      exitPortal:Enable(true)
    end
  end
)4U ��}
�C���,I�51~?6P��-R!T��:��[��T�CP�s�Bn�ɲR %�'�cbᅺa��j�(�gB'�vi����� $��;9�^N���"h����OE%����szo�>�3`�%]�}�D�����MNiިp �%=F���3��d��^�
䷵��ӵs���z김�򡝨��\w7�m�NI:�w�s���l�����o"��Ĺ�-Z#|�a�ZS���l��A���]�o�/�v9����y�