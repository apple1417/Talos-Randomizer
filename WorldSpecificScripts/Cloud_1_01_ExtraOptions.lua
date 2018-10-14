SIGSTRM12GIS             �zR                  Signkey.EditorSignature��^0����rK����QB��u�i[���IRI�-�#[\T������H��Z1�o���I���TnpQ�ꍔ��l�m���\�3�f�ϗ�>��ւ ���s!��_�xPs��Lx�6���c����=��(��z��oV+��=�*<TxQ
P���R������͛��/���FI8_l^z�*�Ӗ���sҙ�Ex"ۦ(�U#�D߄)��c�]�Kq�K�!���Uy�_2�O��|ή�B�AT�J��:���﻿Wait(CustomEvent("Randomizer_Finished"))

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
endM�������u�7g"N��0�;�nd��y�cS�G��6�o�P@T�f��zL�'$��~�RD�'�R���'qlo��њ���|=zt�JR*.vG��fq��j�O�3��``3���'+@Q�9b���]�a����#Z�:�t$��@�~�b#�*_J8F�穈�3΁�����r��T���åc}\�0ߔQ+,2}2�D����!v��t�ߊJF�J]@���R�yD\�~�����o��@<�