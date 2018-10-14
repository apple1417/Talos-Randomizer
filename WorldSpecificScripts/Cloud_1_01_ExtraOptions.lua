SIGSTRM12GIS             "�6                  Signkey.EditorSignatureM쥞3OP �b3������[��Z��!L�
��������"Y�/��'�{$�N^��x&"�f�%�yvM�Ri��I���Ws�{�����<�`<���E��;�K��j��Rl�c��������?2��+5��bX����
�S�}�f pA���*�4��Qi� ���8�.�h��1�����A���<
�����[�|-I�����_����J�$f���\14�)3E$m:n��5a﻿Wait(CustomEvent("Randomizer_Finished"))

--[[
  There are a few extra things we need to do to get everything setup
   properly, they're all in this script
]]--

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)
local print = worldGlobals.print
local printWarning = worldGlobals.printWarning
local printError = worldGlobals.printError

-- Can't do this in options world because we can't undo it
if talosProgress:IsVarSet("Randomizer_UnlockItems") then
  talosProgress:AssureUnlockedMechanic("MechanicCube")
  talosProgress:AssureUnlockedMechanic("MechanicRods")
  talosProgress:AssureUnlockedMechanic("MechanicFan")
  talosProgress:AssureUnlockedMechanic("MechanicShield")
  talosProgress:AssureUnlockedMechanic("MechanicTime")
  prjOnMechanicLockingChanged(worldInfo)
end

-- Might need to open the gate
if talosProgress:IsVarSet("Randomizer_NoGates") then
  Gate:AssureOpened()
end

-- Arranger Hints for mobius, here for same reason as items
if talosProgress:GetCodeValue("Randomizer_Loop") >= 32 then
  local allArrangers = {
    A1Gate, AGate, BGate, CGate,
    Connector, Cube, Fan, Recorder, Platform,
    F1, F2, F3, F4, F5, F6
  }
  
  local arrangers = talosProgress:GetCodeValue("Randomizer_LoopArrangers")
  for index=1, 15 do
    if arrangers % 2 == 1 then
      -- currentArranger : CPuzzleData
      local currentArranger = allArrangers[index]
      talosProgress:FakeSeenArranger(currentArranger)
    end
    arrangers = mthFloorF(arrangers / 2)
  end
end

-- Give a warning about A1 gate, don't want to get rid of the arranger
if mode ~= "None" and mode ~= "Intended" and not Arranger:IsSolved() then
  Arranger:DontSaveProgressWhenSolved()
  RunHandled(function() WaitForever() end,
    OnEvery(Event(Arranger.Enter)),
    function()
      worldInfo:ShowMessageToAll("WARNING: Solving this gate can cause softlocks. There are other ways around it.")
    end,
    OnEvery(Event(Arranger.Solved)),
    function()
      worldInfo:ShowMessageToAll("Last chance, if you reset checkpoint now it won't be saved. (Use the pause menu, DON'T hold {plcmdHome})")
    end
  )
end(鱱�.S׎U���s�����ɮ�"d��;;���V�2��"xA�g�F>�-]�H�3}�8R	�Δ�[�i����A����ٮwo$�3y�b.@K  �f;'Oc-�q%��G0�[V\N�����W�Wh~�v|��dYu)���X=g
�Qh�o����O(��e�ǁ�TM�}9���9b����#�����bAL�%��y�`�)��vO�VS�$�Vu�D7�b
<D
F�e#{��qc���||,\ �
�n���G�