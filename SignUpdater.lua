SIGSTRM12GIS              �"5                  Signkey.EditorSignature|�K H�Ct�)�	ߎ}y�|��]a?}fm=��geE^i����S��?�7�v�d���1-_Ċ}��@l_��M��Fsm'�cɮ6�����V�率��R�$/�vI��۹7�9�-{�$����!5�m��.�������� �* ���-eƳ�H\5&Osh�t� R���X%�pkzl��>S�-����.< #���"�V��Y�Tr�MT��K�|	�r' ae/1�0�/<�����A �4��﻿Wait(CustomEvent("Randomizer_Finished"))
-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local showAll = talosProgress:IsVarSet("Randomizer_ShowAll")

local icons = {
  ["I"]="▄▄",
  ["J"]="▐▄",
  ["L"]="▄▌",
  ["O"]="█",
  ["S"]="▗▛",
  ["T"]="▗▙",
  ["Z"]="▜▖",
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
    local colour = string.sub(sigil:GetName(), 1, 1)
    local type = string.sub(sigil:GetName(), 2, 2)    
    -- sigil : CTetrominoItemInstance
    if sigil:IsPicked() then
      text[colour][index]:SetText(textPtr[colour][index], icons[type], true)
      text["Default"][index]:SetText(textPtr["Default"][index], "✘", true)
    elseif showAll then
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
)��qU��йYe�`��	��sNha!�<�f� ۋx<?���u�_�nS��YDVyKj�Yg���f'Hcu�f���,�>���u)��g1!�r>>CL��l�U��6�خ_}��f�&�K�b!���N���3��u���N�[T�&Pa9�t{��R�Q/��8(���>��"i�K�h�e3?q�vR��V��K٘�ٶ��|�ʶ�^��t�� ����Oϲ#���k�v.���7f���C��X�^=��