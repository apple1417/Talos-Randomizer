SIGSTRM12GIS             ��                  Signkey.EditorSignature�@��_�s�AD�)��v�0j���=LK2�)�NT��Z�[���?���V/��=B/�u�[i(et���iD�tU?�u���z�N5�6�@f*#��tH��+�4���G�<��ġ�
���5�P�a\�7�Wc��?EKI{��ʞ߫��k�-�#b���и'6k�3�K_�����T���5{���&�I(u�mn؏yȔBقE�NJC/Dp�����8�˵DN�w �6�4��.�P����s�J6zz�/F4��~﻿--Wait(CustomEvent("Randomizer_Finished"))
Wait(Delay(0.1))
-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local showAll = talosProgress:IsVarSet("Randomizer_ShowAll")

local icons = {
  ["I"]="▄▄",
  ["J"]="▐▄",
  ["L"]="▄▌",
  ["O"]="█",
  ["S"]="▜▖",
  ["T"]="▗▙",
  ["Z"]="▗▛",
  ["*"]="★"
} 

local text = {
  ["*"] = textStar,
  ["D"] = textDoor,
  ["E"] = textSecret,
  ["M"] = textMechanical,
  ["N"] = textNexus,
  ["Default"] = textDefault
}

local textPtr = {
  ["*"] = {},
  ["D"] = {},
  ["E"] = {},
  ["M"] = {},
  ["N"] = {},
  ["Default"] = {}
}

for k,v in pairs(text) do
  for i=1,#text[k] do
    textPtr[k][i] = text[k][i]:GetTextConfig()
    -- Assure all texts have the correct default message
    if k == "Default" then
      text[k][i]:SetText(textPtr[k][i], "?", true)
    else
      text[k][i]:ClearText(textPtr[k][i])
    end
  end
end

-- Bring stars to the end of the sigil list
local allSigils = {}
local starCount = 0
local totalSigils = #worldGlobals.worldMarkers
for i,v in pairs(worldGlobals.worldMarkers) do
  local sigilNum = talosProgress:GetCodeValue(v:GetName())
  -- currentSigil : CTetrominoItemInstance
  local currentSigil = worldGlobals.allTetros[sigilNum]
  local type = string.sub(currentSigil:GetName(), 2, 2)
  if type == "*" then
    allSigils[totalSigils - starCount] = currentSigil
    starCount = starCount + 1
  else
    allSigils[i - starCount] = currentSigil
  end
end

local function updateText()
  for index,sigil in pairs(allSigils) do
    -- sigil : CTetrominoItemInstance
    if sigil:IsPicked() or showAll then
      local colour = string.sub(sigil:GetName(), 1, 1)
      local type = string.sub(sigil:GetName(), 2, 2)
      text[colour][index]:SetText(textPtr[colour][index], icons[type], true)
      text["Default"][index]:ClearText(textPtr["Default"][index])
    end
  end
end

updateText()

RunHandled(
  function()
    WaitForever()
  end,
  OnEvery(CustomEvent("TetrominoAwarded")),
  function()  
    updateText()
  end
)���<��
�hN�dsy"n,#�����������1�zX��� �-<o�d�l�\����VnWdGWo� ��&��:����A�p%LG����p��R����{ /�9����P�W��w��%v�6Vyb?;â��|�x����v���7�5���?�x��=�'�̞R�"N��i�Wb [I>�3�3�E�?4P���e�@MM�Zy���������j�j� v���o�6���e0&I��0ds��O���