SIGSTRM12GIS             L��                  Signkey.EditorSignatureJtI8ڐ�h3X�����>^�XbV5>�{Wׁ�z��H]j��!-]V��o�=�i;����G4�598J�I#s�UG����D
0��3���%�;"���x��L~� �^#����ړ��CV���gh��\���P�Yh��$ʺb�3��4�h�3*�w&g�EUE�Ux�(�ŰE���6G��	T����m'�-�!�x�^Gʰ��,�b�U ��h�*�K�0�f�;��2<��.R�م��U����﻿Wait(CustomEvent("Randomizer_Finished"))

local Randomizer = worldGlobals.Randomizer
local talosProgress = nexGetTalosProgress(worldInfo)
if not talosProgress:IsVarSet(Randomizer.MiscFlags.shownChecksum) then
  talosProgress:SetVar(Randomizer.MiscFlags.shownChecksum)
  
  local sum1 = 0
  local sum2 = 0
  for index=1, #Randomizer.ChecksumMarkers do
    local value = talosProgress:GetCodeValue(Randomizer.ChecksumMarkers[index])
    sum1 = (sum1 + value*index) % 65536
    sum2 = (sum2 + sum1) % 65536
  end
  local checksum = string.format("%08X", sum1 * 65536 + sum2)
  
  local textOrder = {
    "Randomizer_Overlay_Start"
  }
  for char in string.gmatch(checksum, ".") do
    table.insert(textOrder, "Randomizer_Overlay_Hex_" .. char)
  end
  table.insert(textOrder, "Randomizer_Overlay_End")
  
  terminal:EnableOverlayRendering(true)
  for _, text in pairs(textOrder) do
    terminal:AddTerminalText(text)
    Wait(CustomEvent(terminal, "TerminalEvent_2"))
  end
  terminal:ClearTexts()
  terminal:EnableOverlayRendering(false)
end<���K�aA�J���S`>.����W�+*�
��㸖��Z����4�-v�n����ĈM����lG8&���7���?�Q�hʎ�n�rW-���Ozi����pwUK^b䣇5�l�J�-I�gyEH5x�Θ�ݜϬǑb���Xϗ4���H��lF.�9��:������JB�T��y�=��(�)RN7kꕙ�ɰ˵_`��QtH���yBf�p����2�K�t�뿽M�(ޯz�y_�pf���,�jm*Fke
