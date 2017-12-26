SIGSTRM12GIS             .Ԣ                  Signkey.EditorSignature� �&�T��1�>�DM�m0�83���$��g�$
3P��E�O� �{vA|Q�����ԓ��)g�:~��䍴�<���z.�)Z�BO�˓m���?9�$�E��,����2j#�k�Vf]��D+���c_�޷���&*�'�*��V������Y���daO�xg�;HE-*�y���f�{M�yu�"4i�����iL�L 1�ZT�~��#:d����+�|�]��~E��Of��[���m 3>2W�G��﻿local lastMode = 1
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)

talosProgress:SetCode("Randomizer_Mode", 1)

RunHandled(
  function()
    WaitForever()
  end,

  OnEvery(Any(Events(Modes.Activated))),
  function(event)
    local index = event.any.signaledIndex
    if index ~= lastMode then
      Modes[lastMode]:Deactivate()
      lastMode = index
      talosProgress:SetCode("Randomizer_Mode", index)
    end
  end,
  OnEvery(Any(Events(Modes.Deactivated))),
  function(event)
    local index = event.any.signaledIndex
    if index == lastMode then
      Modes[index]:Activate()
    end
  end,

  OnEvery(Event(NoGates.Activated)),
  function()
    talosProgress:SetVar("Randomizer_NoGates")
  end,
  OnEvery(Event(NoGates.Deactivated)),
  function()
    talosProgress:ClearVar("Randomizer_NoGates")
  end,

  OnEvery(Event(UnlockItems.Activated)),
  function()
    talosProgress:SetVar("Randomizer_UnlockItems")
  end,
  OnEvery(Event(UnlockItems.Deactivated)),
  function()
    talosProgress:ClearVar("Randomizer_UnlockItems")
  end,    
  
  --[[
  OnEvery(Event(Option.Activated)),
  function()
    talosProgress:SetVar("Randomizer_Option")
  end,
  OnEvery(Event(Option.Deactivated)),
  function()
    talosProgress:ClearVar("Randomizer_Option")
  end,
  ]]--  

  OnEvery(Any(Events(NoFunction.Activated))),
  function(event)
    local index = event.any.signaledIndex
    NoFunction[index]:Deactivate()
  end
)Sud-�e*�l��h�>�����-��K�.gR��5ڑ����q�-q?��,Fn����J>�	�C�- �#�q��8
PP)���p�H6Y����oQj����f�L���ÉeB�>����	?�v*�a}���n-�l����)����vZ�tr#���	���dё��#订&Y~c00�����ԣOү< FJ|{�0���L��ˉ=w�}MCQ^L �J4�� Eb���ѕ*V��?5I�B,().��]y�Q.߶