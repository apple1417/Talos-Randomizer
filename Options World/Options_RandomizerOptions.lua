SIGSTRM12GIS             �7                  Signkey.EditorSignatureJ�a*�3&�-jBbs�*a�Se�E���l�um����H5M���(��orO�o�D��~�@�R�a7
$'��JٰE�i���$�c�I"����T������նi��`� #>�"��}�xeꕜ�Q½���{�~mH�_�W*���W+H6�貔+��iq���^�V�#��D�̋T8f9������Ĉ��<r�J��? �5"��D�c��`̡CA��^�����%��p�+�����﻿--[[
  This one is a lot of the same, (re)setting options when you
   toggle switches
]]--

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local lastMode = 1
local scavenger = false

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
      talosProgress:SetVarValue("Randomizer_Mode", 0)
    end
  end,
  
  OnEvery(Event(NoGates.Activated)),
  function()
    if scavenger then
      NoGates:Deactivate()
    else
      talosProgress:SetVar("Randomizer_NoGates")
    end
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
    if scavenger then
      ShowAll:Deactivate()
    else
      talosProgress:SetVar("Randomizer_ShowAll")
    end
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
  
  
  OnEvery(Event(Scavenger.Activated)),
  function()
    talosProgress:SetVar("Randomizer_Scavenger")
    ShowAll:Deactivate()
    NoGates:Deactivate()
    scavenger = true
  end,
  OnEvery(Event(Scavenger.Deactivated)),
  function()
    talosProgress:ClearVar("Randomizer_Scavenger")
    scavenger = false
  end
)F��.9�i��^���$�V�:Lۨ��N�Ƭ.n �����Pmk��'Ȧ�]6߰6K������շˑ��cQKg��)e�tid�X ���,祫(�W�����;f���k��XlNr:}�O�Zf����Ӫ?u|���K7���C���eOQa�J.��^qJga]�=dD�cV�N�<us|(_o�.������b/W,L�4 ���i���R� �xl�����_=yi�����Xl�P���k%�