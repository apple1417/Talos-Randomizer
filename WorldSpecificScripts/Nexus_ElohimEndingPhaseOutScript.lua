SIGSTRM12GIS             [�st                  Signkey.EditorSignature0ZJkA&�z�%K���,���쌓�����Dz��L�`�^Ný�n����E$f��b�-�o�sh��r�.����ե�?��9�1�t�9�0����`�
�(��A��nk�֚\�Ql�~rr���v͟��'�8q���Â�=l��Y�� ��>�H�^��������w��T�[�!\n�M,n5�~^���R�ۛ�c����"o#�er�I����F7��E��󾑲TZ}یH��S.��M��﻿--[[
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

      exitPortal:Enable(true)
    end
  end
)�W �KŬM=m{�$�4��_[�<�0��-wm��m@��*��{���x����}ۢ��X�n��R�g�Ƨ/��M����; c��$ƛ��eK^z7;>����N���Y ���8u���(I�r	i��$�6���+`:qU��O;A>`�f �},˗ʡ�Y�)��� �l{?��#S������j��h�xq$��[�ޡ��(��VP
0��iS1E��թ��^���!��O�@���p(��/m�Ec�