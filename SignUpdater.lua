SIGSTRM12GIS             Nһ�                  Signkey.EditorSignature2�
Jd�h-�g�OɧU6	siʛ�OtO�.�p� ��o�p�^��L5j2���������[�bz�qܶHe��,f|��l��0�Uc�n]�A&4���ߵ5	V w�%z��HCYC�N㾱Ю���g_�
)i��56p�,���4�v�־f��Eꑝ%��`�T�Yc��i{@����[Y�F�t��{Y�*x�%<�5�߼?D�g�����h��A�,j��P��I_�?�ftj\���y��A!�:��f�X﻿--Wait(CustomEvent("Randomizer_Finished"))
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
    if sigil:IsPicked() then
      local colour = string.sub(sigil:GetName(), 1, 1)
      local type = string.sub(sigil:GetName(), 2, 2)
      text[colour][index]:SetText(textPtr[colour][index], icons[type], true)
      text["Default"][index]:SetText(textPtr["Default"][index], "✘", true)
    elseif showAll then
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
)� ˏ@�d�^%�ij|����M��A�#_����d����*�8���'��Jj���YY�@�	Q���EV�B)D�2}X���1�ko�]� i��¬�dQ���D�2�x)��p���? �Z��v/E{�͇�U��'(��C Q�.� {��ל���%�e��j��4^p_���t�2�򒮀��e9s���J.��hМ��M�g^iBH�a���0Ř��^�+
e�,�I �I�:�"ɷ�� ��n�