SIGSTRM12GIS             s��                  Signkey.EditorSignature.3�����[3K^`~u'���{��y;Gp���s�.{#C9���d/�l?~(�Hښ��\�c[C�43e�=�g$��#�f�������P$�[�8��#3��!��[~2)2�UN-9�:q���~��;��T����k�rft���;E�����M�� h��l�ʾ���óMS��Vd���G�s���#gP6��bVj�S/S?���Xs|�b\2��1(
Q'^�z,�<P�-��>7�G5�Sbiq﻿Wait(CustomEvent("Randomizer_Finished"))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local Sigils = {}
for k, v in pairs(worldGlobals.Randomizer.Puzzles.C3) do
  if k ~= "talosProgress" then
    local sigilNum = talosProgress:GetCodeValue(v.talosProgress)
    table.insert(Sigils, worldGlobals.Randomizer.allTetros[sigilNum])
  end
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
?X/�+������ء��5zÝ��-�c�1��RN_	@�X����)�E�KɖG�n��A�0��R�p�?��&O�Q� ���<��'	�%��g#]��B8
�Y���q'�D���s�V�ě�ܫ��Q�G+���Bd�#��!�<푱�(bI�I�<��~x�!��mSM��o���GR�o��V�G�i��*�{ځ�"F�%����R��(l��xW($��r\��Tq�8��X��� ۵���w�� x�f��#