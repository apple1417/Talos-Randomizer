SIGSTRM12GIS             ���9                  Signkey.EditorSignatureQx7�n�3΂6GC��Q~��d� (l�*r�F�B�ÿ-g{���@䶾66�,�6�D$��審��x�Dzi ���{��*�.i%XF�Ü�.��zZ�H�a�'*�8(�<(���X�S��0Q��O�h��r���s����Y�#�����*]����)T�a2�n�7LU%�.�i�Dk�8�9��OG��6^m�f�H=ll�C�r��͗���d����.w_~�hF���Ѽ|�֠��$�� ���﻿local function randomFromTable(table)
  return table[mthRndRangeL(0, #table)]
end

local function randomChance(chance)
  return mthRndF() <= chance
end

local function tableIndex(table, value)
  for _, v in pairs(table) do
    if v == value then
      return index
    end
  end
end

local function inTable(table, value)
  for _, v in pairs(table) do
    if v == value then
      return true
    end
  end
end

local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)



--Wait(CustomEvent("Randomizer_Gen01"))
Wait(Delay(0.05))
print(2)

if talosProgress:GetCodeValue("Randomizer_Generated") == -1 then
  local picked = ""
  local allRequired = worldGlobals.allRequired
  local sigilsRemaining = worldGlobals.sigilsRemaining
  
  for sigilIndex=1,65 do
    if not inTable(allRequired, sigilIndex) then
      picked = randomFromTable(sigilsRemaining)
      if picked ~= nil then
        table.remove(sigilsRemaining, tableIndex(sigilsRemaining, picked))
        talosProgress:SetCode(picked, sigilIndex)
        print(picked, sigilIndex)
      end
    end
  end
  
  worldGlobals.allRequired = allRequired
  worldGlobals.sigilsRemaining = sigilsRemaining
  SignalEvent("Randomizer_Gen02")
end�i�ap� ��3y�(a�e�i�՝�M�7��B~�d���#<�1 g*��GԪ  �I�V N�S��z����ZK��ߙ�v;`��8=l�$c/�/ɨV�����/^ /p����o�<|E{��7��꓾��G��OjȮp���js�i�B�NX~Um6�f|�'K1��B!��_��.�:��|!8qc|��2}k��﮴ʛ�H!��{�`��M�b��-˦�)i�t��ڧ��ν i1����;$_V��v