SIGSTRM12GIS             0O��                  Signkey.EditorSignatureL�Z��M�bFΦ�a��5�Zvu�0ݝ{��֛RƌL�C`j��Ϛ��[��kS�S�&�~\���JI�$GV%�#��@��fq|-���M�Y݄K3�?}/���eG6��+�%����ƗrX,JcE+�/0-�'��m{�0G�������>�d<?���A�W�2h��T��6Do)3�hR�B��7��� T��j��i�Ř1�i����U�V��=:� �8r�W����Y��)'Y�y��B2﻿local event = Wait(All(Event(worldInfo.PlayerBorn),
                       CustomEvent("Randomizer_Finished")))
-- player : CPlayerPuppetEntity
local player = event.all[1]:GetBornPlayer()

worldInfo:ActivateTimer(10000000)
local ANIMATION_LENGTH = 3
local LOWER_DISTANCE = 3.1
-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

local function lowerDoor(index, amount)
  -- pos : QuatVect
  local pos = fences[index]:GetPlacement()
  pos.vy = pos.vy - amount
  fences[index]:SetPlacement(pos)
  pos = arrangers[index]:GetPlacement()
  pos.vy = pos.vy - amount
  arrangers[index]:SetPlacement(pos)
end

local sigils = {}
for i = 1, #worldGlobals.Randomizer.worldMarkers do
  local sigilNum = talosProgress:GetCodeValue(worldGlobals.Randomizer.worldMarkers[i]:GetName())
  local sigil = worldGlobals.Randomizer.allTetros[sigilNum]
  sigil:DisablePicking()
  table.insert(sigils, sigil)
end

local lowered = {}
for i = 1, #arrangers do
  if arrangers[i]:IsSolved() or sigils[i]:IsPicked() then
    lowerDoor(i, LOWER_DISTANCE)
    lowered[i] = true
    barriers[i]:Disable()
    sigils[i]:EnablePicking()
  end
end

RunHandled(WaitForever,
  OnEvery(Any(Events(arrangers.Solved))),
  function(event)
    RunAsync(function()
      local index = event.any.signaledIndex
      if lowered[index] then
        return
      end

      lowered[index] = true      
      barriers[index]:Disable()
      sigils[index]:EnablePicking()

      Wait(Delay(1))

      local startTime = worldInfo:GetTimePassedFromTimer()
      local lastTime = startTime
      sounds[index]:PlayOnce()
      while true do
        local currentTime = worldInfo:GetTimePassedFromTimer()
        if currentTime - startTime >= ANIMATION_LENGTH then
          break
        end

        local amount = LOWER_DISTANCE * (currentTime - lastTime)/ANIMATION_LENGTH
        lowerDoor(index, amount)
        lastTime = currentTime
        Wait(CustomEvent("OnStep"))
      end
    end)
  end,
  OnEvery(Any(Events(Cheater.Activated))),
  function(event)
    local index = event.any.signaledIndex
    if lowered[index] then
      return
    end
    
    cheaterSound:PlayOnce()
    while Cheater[index]:IsPointInArea(player:GetPlacement():GetVect(), 1) do
      Wait(CustomEvent("OnStep"))
    end
    
    Cheater[index]:Recharge()
  end
)
>��^�=��9�o^�f��+�OWdR���}:��7�����d�'KJp��a�^f�{�K�*s��v��c��#����/r�K �����c$g�u̻���}�L)]���Ǔ}������BL�..�dǑ�"�����5��k�����b8�r�6�5�k�����g3.i3�ڱ�=��mݣ��JM=�,Σ��r����ԢY4�f,ǌ�*��=e~��KQ]+��o�j��j=�� J{)�l�� ��[�J�ݫ�