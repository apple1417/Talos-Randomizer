SIGSTRM12GIS             h�25                  Signkey.EditorSignatureQ!���LX�{�||�w������ڞ7�hg��pS��D�[砩<%|
ؽV2�Cΐ�C.��5���&.�����L�1�p�Z�l!O�C^�6O|9�r��a��l�Ɲ����dt���$�>n�_=��4��E�|"��ױ(�� O�P�l�:��Tu(:�/��r�.��Q�*2L�]D�ߟ-eoYS� r�����F���J��E�ڠ0��a���]�p���U�{��j���G����+X�2j� /ә﻿-- I've changed stuff, but, assuming you already had paint, this is functionally identical
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
paintItems[randomPaintItemIndex]:Show()
f�7�DղK���nX����/��d�J -m�f�x��)�2  �ftʛI��NO�bf�L�jI5%�S�0�<��;��d*�!�P{Ҥ���@�L!>�O�w}�.yꪜy>f�� �N_��ۓ���]�u)R:N���)m���H�����%0=��DQ�-�W��ߩ�N�%��m�����pm��\YXeԗ��
5dj��+�i_�-R���G5��7g�?�4$�&܁�p��F�0#��b Q`�E�