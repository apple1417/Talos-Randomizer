SIGSTRM12GIS             � �t                  Signkey.EditorSignatureu�z\ɬ��%K1�M(����s=�1K�.�y��3͵�[Q�|c|UQ�`����OB�#J�0�rA�*��+��oit�z��_�x�t"V�S�c�z�VJ�7�����z���[,=�V���>k6%�S&,� �xӚ���3��b�����D��߽��A�Bz���6���"���&����l#%h �Z|xp�j���;Q���/F���$�S��O��(�\f���i�tPF%��,,]��W{��#�﻿--[[
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
paintItems[randomPaintItemIndex]:Show()S���@���n�����`^�}U�?x/���v�*Z�}�Ky~@�w!i�ϫ,�����
GYH��'�������^Ϡ�R����2#o�Dz���$}|��"N�tH}n6r�(q��Us�>sF[;��)Q�:'�l ��ZڳzJ�G�+�=����q6�$��/�=�h��=Uۯ&�p%��B��_f�.�.G_
[���u�$k�*�Р�Ά)�!�i��	�
90�f���7x�Y
�����Ҡ%.��d���q.