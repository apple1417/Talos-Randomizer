SIGSTRM12GIS             OY�r                  Signkey.EditorSignature��Iγ�K)7�x]*��Nt
�?�-~�ZLh@��p�8�vJ��/?Va\�}��h�HD�p��j��^���Z`�7�a��L�\$�Y4ߊ�n�=�D�Th����ZA�������r�|Q&��wy�����B$BzX&j�<�<xp���^�K� �ĽV���\����S�[�^�iߐy���������zG�[_<Z��%��IX�L���
��Q  _a�q�Ym!����	R�z�C﻿-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local lastMode = 1

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
  
  OnEvery(Event(ShowAll.Activated)),
  function()
    talosProgress:SetVar("Randomizer_ShowAll")
  end,
  OnEvery(Event(ShowAll.Deactivated)),
  function()
    talosProgress:ClearVar("Randomizer_ShowAll")
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
)�(���BG�`�璋��<Fy���>N����t\��vq��>�sF�ib�0�}�c�"����{��&��[V�C@�F���*��u�fz�������-�����;��BT���K�]˨0�W���lQj�C��^Qe�Or4{�0 ���rv  <�������{���sA����$E ��θ?8�h��9*7����D�H�>�U
Wp�k����®#�N�+Fhg4z�p����H}�����oՓ�pD�^K