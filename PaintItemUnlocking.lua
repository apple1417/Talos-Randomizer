SIGSTRM12GIS             �ȩ�                  Signkey.EditorSignature$�I����%]�P{�N��\%�,�F�hB�xe�/_���ߞ�N��� j�R��bt�O�U���V��"n9:���xJ���G[	�6;�m�u6��X2Ĝ�fe���1�Z��������Ū�����������}��bd�}b���~c��3
��[�r"�"�?���"�2��2AD�����B&��91P��ŭx����+>~�,��}��,5����i�0�G|�^%Ӈ݇�<hc�Zm�<�� �� �﻿-- nothing to do if messages are not available for current world
if not talPlayerMessagesAvailableForCurrentWorld(worldGlobals.worldInfo) then
  return
end

local function RandomFomStringChars(str, multiplier)
  local len = #str
  local sum = 0
  local offset = 32
  for i = 1, len do
    sum = (string.byte(str, i) - offset)*multiplier
  end
  return sum
end

local function ShowPaintBucketIfNecessary()
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
  local randomPaintItemIndex = 1 + randomIndex % #worldGlobals.paintItems
  worldGlobals.paintItems[randomPaintItemIndex]:Show()
  -- paint item was shown
  return true
end

RunAsync(function()
  -- wait for all other scripts/items to boot
  Wait(Delay(0.00001))
  -- nothing to do if there are no paint items in the world
  if worldGlobals.paintItems == nil then
    return
  end
  -- show paint bucket if necessary at start
  if ShowPaintBucketIfNecessary() then
    -- since paint item was shown, there is no need to handle message unlocking
    -- events and check if paint item should be shown again
    return
  end
  -- wait for message unlocking event until paint bucket is shown
  while true do
    Wait(CustomEvent("PlayerMessageUnlocked"))
    if ShowPaintBucketIfNecessary() then
      break
    end
  end
end)
_I��B#�BI�k�Fu�o�1b[j݂hqMۑ�8���Sel�v8pyp3����+�ہ�E���J�,%�6q���b7�������)��C9���P��;��äB~�mN����*��P���n�2y�?��_���S�2\s�5D8�֭7�ѕh�S�[���Ǩ��ugN>�g�����9X+�wd�ı��I� ?�'�@m,X��/���Xp�'�z`�������fa4����(�+:��^Ʌ��|���