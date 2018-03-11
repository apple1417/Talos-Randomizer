SIGSTRM12GIS             yF[                  Signkey.EditorSignature���ʋ�n�\�k����2d�����]��*	��eP������o�P�h�����`��a���WC��7��i7BH7{��Ї��Bq��YC�)0�n����0/C�� ��p{Xv��y��&i���@����|�N���qq@,��~��t�)�ٹ8�>j�p�r�z|�Ȃ�}����}��DSba̺�����F O��P���f��T�%k��Zz�����y����-�i����m
�����x]�P�~﻿exitPortal:Enable(false)
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
) "��Zra�@�G�9a�R�h�W���,�l߽�ԥ+wʥ2�Wg<�� ��eo��N��XI��()�}��zg��
���&��
�[�}^ϳ��i3%=����^��i��jZ���#-��k�=Dz�V���Œ�!$�O�>k�Lʝ��\Y�H�SQ��b�Z�����`�Xݚl���p�An���)�Yܕ���ѻ��s�����}g���QI<������#m���xS	|թ����%�w�Ձ�=��'�>�Ŗ