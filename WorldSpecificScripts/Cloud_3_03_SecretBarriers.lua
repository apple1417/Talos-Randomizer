SIGSTRM12GIS             ���                  Signkey.EditorSignature�iHv�Ɂ��^/O	*�����q�D-�⳩AM2����m�X�ek-4����1�L����&	��x��[>�Ibbҟ��oT[x��B��ąd���J���2�a�]�RB��_�2�&��QC%(��U�^�$��	�����JuZ���>�E���	{�BD�5���#4��T��R�Z�L��;�r�Z�A35o����V�C���n��t3�:V���?V�A�eİ��O�ڪ�f�V�v���`�﻿Wait(CustomEvent("Randomizer_Finished"))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local Sigils = {}
for k, v in pairs({"225_SPM_000_PM_044", "317_SPM_000_PM_024",
                   "229_SPM_000_PM_070", "318_SPM_000_PM_026",
                   "Cloud_3_03_SRT_SPM_000_PM_069"}) do
  local sigilNum = talosProgress:GetCodeValue(v)
  Sigils[k] = worldGlobals.allTetros[sigilNum]
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
)!��q�A�'��k[�+�po]>�����Ka�e��\���.f^��+~������]u@�"'<�l[���0�a�W8�5Ir�R��Y�Mc��CX�>-^*�xm��ϟ�4��!]Sc-D�����
(M?沐p��c	�2��1$�1��w��av�����O� ����%��F��!��m�o���S�5[P��:�м��o�/V}�T��%��1� ���R{�¶хeA�V8