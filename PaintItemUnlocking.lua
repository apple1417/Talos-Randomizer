SIGSTRM12GIS             ���                  Signkey.EditorSignature�5l����ٳ.z�kg�)�]�Y�x�w���}#B�ɥ0h�)I�Y���O(?���6���0�/�daeg�9#G��c/�nJ�Ծ�2I1'Z�3( �hj���:Cr-8���W�G[�pL��^}S�=:��� oc���˕G*�,�!����EmU���#�5l��z�.c�:�/fRf�pP� ��W�����a�W�k2X&��`}����Y8|�"�[!"�'����1�
8t
�;#k"�%﻿-- I've changed stuff, but, assuming you already had paint, this is functionally identical
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

if multiplier > 4 then print(multiplier - 4) else print(multiplier) end

if multiplier == 0 then
  multiplier = 1
end
local randomIndex = randomSeed + RandomFomStringChars(worldName, multiplier)
if randomIndex < 0 then
  randomIndex = -randomIndex
end
local randomPaintItemIndex = 1 + randomIndex % #paintItems

print(randomPaintItemIndex)

paintItems[randomPaintItemIndex]:Show()
5��[����4k�\���%�Z�jliE:���0؏�hJ'%.߼��xwj�ǂ���GoS�J�.��yf~yR��h�@���v3ewgˢ"Œa�@ǅo ";�kqwa�f&|n?׻��J�o@(o��;��^6|��6��
ߣ�>�ʴ��XFzԏ�d|`N��>���W$ƺB[�L��������r���C�G�i��jnF��q�4�l`[�����Q�Y ��˛�O�%�ķv mf����cvPӒ�z��