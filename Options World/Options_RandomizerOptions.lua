SIGSTRM12GIS             ۊ��                  Signkey.EditorSignature�͆Mn�t���)~Zq�������NOd��qS��~m3�OD���sll������T<��C�n�w���������keE�I��i
�B����s�g�i1��d�y8e�}���0Ђ��O(Q1�CJU�?{~��y���/���^s]UZW��5�jz�O��f��~.a�%��k���Y�.y	qA�T��Ѻ�WW� �0�oh��8��g�u
����˩!j���i��� �+�� W�s��Iq���:��^�+wyʛ﻿--[[
  This one is a lot of the same, (re)setting options when you
   toggle switches
]]--

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local lastMode = 1
local scavenger = 0

talosProgress:SetVarValue("Randomizer_Mode", 1)
talosProgress:SetVarValue("Randomizer_Scavenger", 0)
talosProgress:SetVar("Randomizer_ShowAll")

local seed = "Random Seed"
local seedPtr = seedDisplay:GetTextConfig()
local allOptions = {
  NoGates, UnlockItems, ShowAll, Portals,
  Scavenger
}

--[[
  The buttons are just static models, we need to manually enable usage
  We also need to disable all the lights
]]--
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
  
  OnEvery(Any(Events(Modes.Activated))),
  function(event)
    local index = event.any.signaledIndex
    -- Prevents an infinite loop
    if index ~= lastMode then
      -- Scavenger doesn't allow fully random
      if scavenger ~= 0 and index == 3 then
        Modes[3]:Deactivate()
      else
        if lastMode == 0 then
          NoRandom:Deactivate()
        else
          Modes[lastMode]:Deactivate()
        end
        lastMode = index
        talosProgress:SetVarValue("Randomizer_Mode", index)
      end
    end
  end,
  OnEvery(Any(Events(Modes.Deactivated))),
  function(event)
    local index = event.any.signaledIndex
    if index == lastMode then
      Modes[index]:Activate()
    end
  end,
  OnEvery(Event(NoRandom.Activated)),
  function()
    -- Prevents an infinite loop
    if lastMode ~= 0 then
      -- Scavenger doesn't allow no random
      if scavenger ~= 0 then
        NoRandom:Deactivate()
      else
        Modes[lastMode]:Deactivate()
        lastMode = 0
        talosProgress:SetVarValue("Randomizer_Mode", 0)
      end
    end    
  end,
  OnEvery(Event(NoRandom.Deactivated)),
  function()
    if lastMode == 0 then
      NoRandom:Activate()
    end    
  end,  
  
  OnEvery(Event(NoGates.Activated)),
  function()
    talosProgress:SetVar("Randomizer_NoGates")
  end,
  OnEvery(Event(NoGates.Deactivated)),
  function()
    if scavenger then
      NoGates:Activate()
    else
      talosProgress:ClearVar("Randomizer_NoGates")
    end
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
  
  OnEvery(Any(Events(Scavenger.Activated))),
  function(event)
    local index = event.any.signaledIndex
    if index ~= scavenger then
      if scavenger ~= 0 then
        Scavenger[scavenger]:Deactivate()
      end
      scavenger = index
      talosProgress:SetVarValue("Randomizer_Scavenger", index)
      ShowAll:Deactivate()
      NoGates:Activate()
      if lastMode == 0 or lastMode == 3 then
        Modes[3]:Deactivate()
        NoRandom:Deactivate()
        lastMode = 1
        Modes[1]:Activate()
      end
    end
  end,
  OnEvery(Any(Events(Scavenger.Deactivated))),
  function(event)
    local index = event.any.signaledIndex
    if index == scavenger then
      scavenger = 0
      talosProgress:SetVarValue("Randomizer_Scavenger", 0)
    end
  end,
  
  OnEvery(Event(RandomizeAll.Activated)),
  function()
    RandomizeAll:Deactivate()
    local index = mthRndRangeL(0, #Modes)
    if index == 0 then
      NoRandom:Activate()
    else
      Modes[index]:Activate()
    end
    -- Same as pressing the random button, can't just do that though
    seed = tostring(mthRndRangeL(0, 999999))
    seedDisplay:SetText(seedPtr, seed, true)
    talosProgress:SetVarValue("Randomizer_Seed", tonumber(seed))    
    --[[
      Deactivate all currently selected options to try make it fairer
      Otherwise you can get 'stuck' in scavenger preventing signs from
       coming on again
      Deactivate() works fine on groups
    ]]--
    for i=1, #allOptions do
      allOptions[i]:Deactivate()
    end
    --[[
      Toggles switches randomly
      If it picks a switch group it will only toggle a single switch
       in that group
      This is so that *any* scavenger hunt has the same chance as the
       other options, normally 2 switches would mean twice as likely
    ]]--
    local loops = mthRndRangeL(1, #allOptions)
    for i=0, loops do
      local index = mthRndRangeL(1, #allOptions)
      local switch = allOptions[index]
      if #switch ~= 0 then
        switch = switch[mthRndRangeL(1, #switch)]
      end
      if switch:IsActivated() then
        switch:Deactivate()
      else
        switch:Activate()
      end
    end
  end,
  
  -- For switches where we want to make it clear that they do nothing
  OnEvery(Any(Events(NoFunction.Activated))),
  function(event)
    local index = event.any.signaledIndex
    NoFunction[index]:Deactivate()
  end,
  
  OnEvery(Any(Events(numbers.Used))),
  function(event)
    local index = event.any.signaledIndex
    local failSeed = true
    if seed == "Random Seed" or tonumber(seed) < 214748365 then
      if seed == "Random Seed" then
        seed = ""
      end
      if index == 10 then
        seed = seed .. "0"
      else
        seed = seed .. tostring(index)
      end
      -- We can only store 32 bit numbers, and negatives break the prng
      if tonumber(seed) <= 2147483647 then
        seedDisplay:SetText(seedPtr, seed, true)
        talosProgress:SetVarValue("Randomizer_Seed", tonumber(seed))
        failSeed = false
      else
        seed = talosProgress:GetCodeValue("Randomizer_Seed")
      end
    end
    --[[
      This goes in a RunAsync() so that you can press other buttons
       while the selected one goes through the animation
    ]]--
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
  
  -- The rest of these are basically all the same
  OnEvery(Event(backspace.Used)),
  function()
    if seed ~= "Random Seed" then
      if #seed <= 1 then
        seed = "Random Seed"
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
    if seed ~= "Random Seed" then
      seed = "Random Seed"
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
    seed = tostring(mthRndRangeL(0, 999999))
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
)P~z�#㦷�d���Y�����R\�N�\+l�_F�A��7X�A+�Kߏ�MX�v�i�a�ؓ��Q��bu���sY��~5�̿�ˣO�#\��Y=�܀��v��N4.x���8*��mk:�8�]l����M#��ۧ]���M;��i�<\O5��s�G�9	���~�Z԰�2*V��� ��5�kq�03s��"���n7���FB���m.�ы�\7����]�;W�z�k9&L�KQ