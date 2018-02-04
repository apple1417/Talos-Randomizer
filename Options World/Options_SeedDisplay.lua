SIGSTRM12GIS             ��|                  Signkey.EditorSignaturer[Q��G�.(ھiw����&_d�1�P����Z*�k��c�ӳB�}���m}AS�_T=t�����Cr��h�C�u�"AEO���of�|�!A@uwۈ"���a-��?⧦{�]�S��ft����_��G� 5Vly�gd���*�T������.���C����Q�U��^O��Z@
�`�mf��^��
ŵ*�'<�)���?���(��Ҍ�V�짞3sT�C-&�%�M?)����
�j�﻿-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local seed = "No Seed"
local seedPtr = seedDisplay:GetTextConfig()

for index=1, #numbers do
  numbers[index]:EnableUsage()
  numberLights[index]:Deactivate()
end
backspace:EnableUsage()
backspaceLight:Deactivate()
clear:EnableUsage()
clearLight:Deactivate()
random:EnableUsage()
randomLight:Deactivate()

RunHandled(
  function()
    WaitForever()
  end,
  OnEvery(Any(Events(numbers.Used))),
  function(event)
    local index = event.any.signaledIndex
    local failSeed = true
    if seed == "No Seed" or tonumber(seed) < 1677722 then
      if seed == "No Seed" then
        seed = ""
      end
      if index == 10 then
        seed = seed .. "0"
      else
        seed = seed .. tostring(index)
      end
      if tonumber(seed) < 16777216 then
        seedDisplay:SetText(seedPtr, seed, true)
        talosProgress:SetVarValue("Randomizer_Seed", tonumber(seed))
        failSeed = false
      else
        seed = talosProgress:GetCodeValue("Randomizer_Seed")
      end
    end
    RunAsync(function()
      if failSeed then
        soundUseFail:PlayOnce()
      else
        soundUse:PlayOnce()
      end
      numbers[index]:PlayAnim("Push")
      numberLights[index]:Activate()
      Wait(Delay(0.6))
      numbers[index]:EnableUsage()
      numberLights[index]:Deactivate()
    end)
  end,
  OnEvery(Event(backspace.Used)),
  function()
    if seed ~= "No Seed" then
      if #seed <= 1 then
        seed = "No Seed"
        seedDisplay:SetText(seedPtr, seed, true)
        talosProgress:ClearVar("Randomizer_Seed")
      else
        seed = string.sub(seed, 1, -2)
        seedDisplay:SetText(seedPtr, seed, true)
        talosProgress:SetVarValue("Randomizer_Seed", tonumber(seed))
      end
      soundUse:PlayOnce()
    else
      soundUseFail:PlayOnce()
    end
    RunAsync(function()
      backspace:PlayAnim("Push")
      backspaceLight:Activate()
      Wait(Delay(0.6))
      backspace:EnableUsage()
      backspaceLight:Deactivate()
    end)
  end,
  OnEvery(Event(clear.Used)),
  function ()
    if seed ~= "No Seed" then
      seed = "No Seed"
      seedDisplay:SetText(seedPtr, seed, true)
      talosProgress:ClearVar("Randomizer_Seed")  
      soundUse:PlayOnce()
    else
      soundUseFail:PlayOnce()
    end
    RunAsync(function()
      clear:PlayAnim("Push")
      clearLight:Activate()
      Wait(Delay(0.6))
      clear:EnableUsage()
      clearLight:Deactivate()
    end)
  end,
  OnEvery(Event(random.Used)),
  function()
    seed = tostring(mthRndRangeL(0, 16777216))
    seedDisplay:SetText(seedPtr, seed, true)
    talosProgress:SetVarValue("Randomizer_Seed", tonumber(seed))
    soundUse:PlayOnce()
    RunAsync(function()
      random:PlayAnim("Push")
      randomLight:Activate()
      Wait(Delay(0.6))
      random:EnableUsage()
      randomLight:Deactivate()
    end)
  end
)��tq��B����z&�[#�l�3��T?��b�=���~�6=He�_)�`A2~�xX��QK�m5�y%�s���Y`�nD7*� ��f���P"Xv�1�p�&������j��<��.�i�k;�������nC�ͫ�c� N����0J��(_D�"SX�b4FF�!�q�>�N]�3�W�p��Y�0�������#��/��Ĉ$���e2��EK��K,3�(3��S��F��ߝ9h�vW