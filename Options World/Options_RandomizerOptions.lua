SIGSTRM12GIS             ���                  Signkey.EditorSignature\	y�v�v�.S9Y�qh.��G�-z�	'�iZ6���|�v�-�}=��D�N ��:���a���yB��YwG.�ݿz�����+�n0u/ ���Y	
��Uf�	)�@�m	����M~�����|;�u�1%(�\ct�W7��c���rF�@��X�����+!�p�JE�����f�t�X����:����(�f��m�d�,����P�pVgzW��W��,����S���C?��|�2��	�OO4j��﻿--[[
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
    scavenger = true
  end,
  OnEvery(Event(Scavenger.Deactivated)),
  function()
    talosProgress:ClearVar("Randomizer_Scavenger")
    scavenger = false
  end
)� s�q7W��g)�IY� �]s%�(��e�I<� ���{P^�pm�<���Xu19(G�s@[S��]Ao�(jЌ{�Yune;�x3��j���d~��QD�^V�(\����+�.m�CV��<�z��g�CyZ�y��%��v���c���c��Յ���M�~�WMZ*�Fȶ$��lv�����uqtU��gy�L�lB�2��-"�m�{�U�|^��,�a� ���u}dJ�6��;�K�,_���E�