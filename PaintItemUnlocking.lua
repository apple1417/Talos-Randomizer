SIGSTRM12GIS             ���                  Signkey.EditorSignature��t���upKL?��S���N~A7hR�<>8m���3�M� ]���A��n~��a�8<g<^�U5�P7�*Z 6��hڧA�">�x��2,�Rr�p�6}:ӷ[|%�*�đ�C�~�*��Z9@y:֡�o-�N�!S�Hx���$����+��KH�����4wo����Y�k�g��'sPi�\�C �H���
�i�_����eVv��d
"�������2�k����V�`�/=G����EcqDW﻿--[[
  So for some reason paint messages don't work here
  Because paint is absolutly needed we decided to just always unlock it
  This lets us optimize the script a bit, no need to use a RunHandled(),
   but this is still functionally equivalent, with the same paint sets
]]--
Wait(CustomEvent("Randomizer_Finished"))

local function RandomFomStringChars(str, multiplier)
  local len = #str
  local sum = 0
  local offset = 32
  for i = 1, len do
    sum = (string.byte(str, i) - offset)*multiplier
  end
  return sum
end

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(thisScript)
local randomSeed = talosProgress:GetCodeValue("PaintItemSeed")

local worldName = string.match(worldGlobals.currentWorld, "([^/]+)%.wld$")
if randomSeed < 0 then
  randomSeed = -randomSeed
end
local multiplier = randomSeed % 8
if multiplier == 0 then
  multiplier = 1
end
local randomIndex = randomSeed + RandomFomStringChars(worldName, multiplier)
if randomIndex < 0 then
  randomIndex = -randomIndex
end
local randomPaintItemIndex = 1 + randomIndex % #paintItems
paintItems[randomPaintItemIndex]:Show()o;�n�^���̭ݬTy@e���8p�dY8n*��̆�i�[���NK-��<���nnҨ���?3琒���PPn��ˤm&�L�PgϿ�W%�I�`�n�(u�*t��R!kU��� ٶi�Ӆ�$8�̯���{�˞�����3j���*��Ad�eQ�
a��;k�k8�L���-H>%j�<��7p (IU�7x\WQ�6�!�����V X�Ps�9��`�y� �6z�$El.W	 ������o