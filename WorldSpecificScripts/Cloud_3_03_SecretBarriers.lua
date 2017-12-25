SIGSTRM12GIS             ���                  Signkey.EditorSignature�;W�y#��;�߱=��k^Fs�������z�����g�{�/���t�J$��*<_�}iΐ�H<s@��r����.�<kyGJ����?�&���lw$��a9�Yk����6^���6���t8�ۊ�>��a���)ϰ&��q����g�1XsRY~�}P�Č[�_Q�e�t����@��dLÕM;S.y�GuY�!���%i,�#	�l[��t�����̏�=R� y#���6LJt�﻿--Wait(CustomEvent("Randomizer_Finished"))
Wait(Delay(0.1))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local Sigils = {}
for k, v in pairs({"225_SPM_000_PM_044", "317_SPM_000_PM_024",
                   "229_SPM_000_PM_070", "318_SPM_000_PM_026",
                   "Cloud_3_03_SRT_SPM_000_PM_069"}) do
  local sigilNum = talosProgress:GetCodeValue(v)
  Sigils[k] = worldGlobals.allTetros[worldGlobals.tetros[sigilNum]]
end

local function SetupSecretDoors()
  local progress = nexGetTalosProgress(worldGlobals.worldInfo)
  local strPickedInstances = progress:GetInventoryTetrominoes() .. progress:GetUsedupTetrominoes()
 
  local ctPicked = 0
  for i=1,#Sigils do
  -- sigil : CGenericItemEntity
    local sigil = Sigils[i]
    local strName = sigil:GetName()
    if string.match(strPickedInstances, strName..";") then
      ctPicked = ctPicked+1
      if ctPicked<5 then
        Door[ctPicked]:Open()
      else
        PlasmaDoor:ForceOpen()
      end
    end
  end
end

SetupSecretDoors()

RunHandled(
  function()
    WaitForever()
  end,
  OnEvery(Any(Event(Sigils[1].Picked), Event(Sigils[2].Picked),
              Event(Sigils[3].Picked), Event(Sigils[4].Picked),
              Event(Sigils[5].Picked))), function()
    SetupSecretDoors()
  end
)
��
��U�����*;�nĻ��]x�S�|�gE�~;�ei�������E�p�����L�D8?X�{�������F*� �L������mn��6ԟ�	���o^����)V4b3E��.˩�'#��pM���H�r(ht�/�J���G�ԹZ��ȨsB����@��;֫�Π��8�sO�eaC[gԠ*^��U!���̟��o9��LȀ�U�Y������M�eG�gsk��/D� ���j�t�0M0KjE-��D��