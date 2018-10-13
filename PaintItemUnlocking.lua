SIGSTRM12GIS             ́��                  Signkey.EditorSignature-}�-a���;��j��h�K:h�5V#c��S���_�qv�1 ��p�ջ�opxٖ�ZѮ/4z_�K��-��M%ߺ�)�:�}ؼ
B�n�|�P������`�o�b��$)|��?���Sv(D)�,�!���L���c���d���Eߧz�3�/�r<�q���3��bR�JO�ЄtY��y������1�>�x�'݂k�~��7�����N��C�w���;[#�Z w;��:���0b̼�䟀;Ӛ﻿--[[
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
local talosProgress = nexGetTalosProgress(worldInfo)
local randomSeed = talosProgress:GetCodeValue("PaintItemSeed")
if randomSeed == -1 then
  randomSeed = mthRoundF(mthRndF()*8909478)
  talosProgress:SetCode("PaintItemSeed", randomSeed)
end
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
paintItems[randomPaintItemIndex]:Show()5��P:�����Բ}V�<�Jo����V�{��R� +�%�$#��B���&�4�ZO�1��ez�9�A���昗NH*	<	P�Y��,	��9X$��ݽ���S���@@h����o��mf��nF`[g����S��	s�ꬥ<r�����WT,̽͵��8#b�}vARm��\�j�ފ��
 +���N��,�TJ�Qd0���"��E|NԖE���	��KCWm}K\�u�]�+�ڛt������	�xaC�