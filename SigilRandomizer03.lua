SIGSTRM12GIS             ��M                  Signkey.EditorSignature3_����f=b�#тOT�6�9Uc�Bk�HaC�A���Tό^ݞ
.~�����"�A��9A˟�/΃�芶���;`j�����p����U:�z��[︱*�C��Ն�է�d��pg����0���`D~S��$�%�:��j�3-ُy���+�$���JgE�[���+4E��a��^�ٟ|���}? K>�5�F��=���;����o=/K��@�1��m<��<kC*�Q�17�ŎA�S�F﻿local function randomFromTable(table)
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



--Wait(CustomEvent("Randomizer_Gen02"))
Wait(Delay(0.10))
print(3)

if talosProgress:GetCodeValue("Randomizer_Generated") == -1 then
  local picked = ""
  local allRequired = worldGlobals.allRequired
  local sigilsRemaining = worldGlobals.sigilsRemaining
  
  for sigilIndex=66,129 do
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
  talosProgress:SetCode("Randomizer_Generated", 1)
  print("done")
end�8e�Z�q�<_4� ���Ó�AڎYA�o����N�L����5�bE�|�bWaA��/��q���	Jc������>5�^v��ә_��~�E.�!�l2�ST2"��$x��	S�E)F�	�e�5����|�2F _e�۟d�LJ������!EO�]�&��wF�RD��ᣇ��OFIU����X���!A.��BP�O�`S��CH� �ٕ����(�D��汄�a"�]�U�u�;F��ن�B�3���5