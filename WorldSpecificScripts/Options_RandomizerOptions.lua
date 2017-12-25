SIGSTRM12GIS             ;-t3                  Signkey.EditorSignature��
��Sw���p�Xנ)=e��\����������E�G�:~I�u%x�d��0��'�K�2��Y9���-��#����-��Kz&iy#ɡ�fA1A	�H�&���7%�v*��{�M�[���������{ߟ�d�R��l�g�Z���v�
 �p+�������f�3Q�Vet�K>�&��ZCᘰ ����]��Q
�5��x{ܚd� �[s��N��҈�Su��i�u�W�J�=D�����>l��﻿local lastMode = 1
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)

talosProgress:SetCode("Randomizer_Mode", 1)

RunHandled(
  function()
    WaitForever()
  end,

  OnEvery(Any(Events(Modes.Activated))),
  function(event)
    local index = event.any.signaledIndex
    Modes[lastMode]:Deactivate()
    lastMode = index
    talosProgress:SetCode("Randomizer_Mode", index)
  end,
  OnEvery(Any(Events(Modes.Deactivated))),
  function(event)
    local index = event.any.signaledIndex
    if lastMode == index then
      Modes[1]:Activate()
      talosProgress:SetCode("Randomizer_Mode", 1)      
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
    talosProgress.SetVar("Randomizer_UnlockItems")
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
)S�[AS�t�LƎZ�������|���F�?q�w�1@w���8hy�hI�;W^�]�����t���
QmR�;#�A^Bx�G�����9�h���c�ĀA��!��u(z,��|3E|��W�8df��O�=Zg�J���0FOWۡa��lH%jԑ��hv��us?�#k��p��3���,}��X� �?���$�cGP9��(�`x3b��\>>V0�	K��}e9�E�v]��w�8�K MVm{�ȹx�