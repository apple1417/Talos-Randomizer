SIGSTRM12GIS             �ǪU                  Signkey.EditorSignature�s���Ě�b1)�H�544 �ʕ����WP!�7��y^(�7w� =2��hؐ��BR���1�ƈ�hW�=��`3�~`J����z�5E��X���H��7���|�����­��������^f�a�)E7ch�QiAY����K<���A����@r��}37�=��ɏc�����eA��Ț���$�`��|hP�d|ڇy��O������Uu�&$�	��mK߸�u<�F���Y�^$�L})h���!}F1*j;�d-�﻿-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local lastMode = 1

talosProgress:SetVarValue("Randomizer_Mode", 1)
talosProgress:SetVar("Randomizer_ShowAll")

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
      talosProgress:SetVarValue("Randomizer_Mode", index)
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
  
  OnEvery(Event(ShowAll.Activated)),
  function()
    talosProgress:SetVar("Randomizer_ShowAll")
  end,
  OnEvery(Event(ShowAll.Deactivated)),
  function()
    talosProgress:ClearVar("Randomizer_ShowAll")
  end,
  
  OnEvery(Event(Portals.Activated)),
  function()
    talosProgress:SetVar("Randomizer_Portals")
  end,
  OnEvery(Event(Portals.Deactivated)),
  function()
    talosProgress:ClearVar("Randomizer_Portals")
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
)b�B) 3������C�=qv��)�uP:N$��b:F��kD��x@��1����;5�X@���{q���ʦ��b/UB� cBɏ��K�_�ͳ���X�Z�*����:�7J��sC�r��1u�K����hw�hJ��ד �*.��OI[{�VK����!U��cC��:4 �T&�;�1�@y�>z�/9�9�l��]Qn|*�a$�8�9e��w��Zw!�9@X$���z�N��h����h�