SIGSTRM12GIS             ��*O                  Signkey.EditorSignatureW���5�;ؘM������Y�ODӨGɫ���,o]�n��$�_)̵��3�ލ� ���u��߇�ʾ���DhDq��L�i�_ۘ��J�hd��J��U{����TEV��k+"��\ 	�\ߛ,�1�V�K3U��M����W_Ҽ�PG=2@�૸�W]���⾰5sQ��Z���pJT5jE����]$g�C�3�~�3�ToR&H�)��mi]� �iO���-�ޤ�"ʎϊ�b_ �QQ�Q0�)#}�4﻿-- I've changed stuff, but, assuming you already had paint, this is functionally identical
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
paintItems[randomPaintItemIndex]:Show()�P��y�&8*�����W?�G��oZ{�j�/�3�@K9�m��G��$d��zT���zY�b��&|��Ij%��kQjkM�fP�D���4�Ymjm� ;��?�W<���~��O���D��$^� ���=��_�D��S����#�q��2� �p�W_�w���5�a�-������XGI��p��H]�,�n�H���	�� �u$P�'��8ė�	��d��	�|�8~~įÑ���zm�\[c��cq7