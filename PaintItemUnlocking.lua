SIGSTRM12GIS             ��&                  Signkey.EditorSignature���`X�}@���09�{����˘Q��(}Y���D�ҝ��U{l���;�憭�u&7����;1~�+{�� 8�NO�{"�[z�VTdyz�x@g�A��C#�Ra�X���fׄ��g��v������;�5`qi+)#h��F������o #����!x�~(����=�rr����y�i�2�`5Y(;�"(��ۃ��Wa�.��A�r܎Џ<C��*V�����`<[x�1.�\�.F�Ff���I$���﻿--[[
  So for some reason paint messages don't work here
  Because paint is absolutly needed we decided to just always unlock it
  This lets us optimize the script a bit, no need to use a RunHandled(),
   but this is still functionally equivalent, with the same paint sets
]]--
Wait(Delay(0.00001))

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
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local randomSeed = talosProgress:GetCodeValue("PaintItemSeed")
if randomSeed == -1 then
  randomSeed = mthRoundF(mthRndF()*8909478)
  talosProgress:SetCode("PaintItemSeed", randomSeed)
end
local worldName = string.match(worldGlobals.worldInfo:GetWorldFileName(), "([^/]+)%.wld$")
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
paintItems[randomPaintItemIndex]:Show()7DRhT(��%z��Ϣ���D��L����k\Z��}� ���$�|���zGi��[�!,Р�`P�;JC�E�i�壤Q�����Ҫ��_7�VI�*�%�<8Y��Ҵ�i�O��䦻�~���Rn�+�8��T�TBp�\BU��{��刂.��L�a���
���Ů#��ҧk�j�J�M6a܆�
���(w|'�z���h�}wN�_K�[��{vr��w�w����\��R�섾��X���z,˘��)�ۜ�