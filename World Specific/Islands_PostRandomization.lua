SIGSTRM12GIS             ۸�Z                  Signkey.EditorSignature��x����F���B.;o�=��Z��D���
�n2�Ǣ��v��Eh�eÂ�kfM�W���B�"�nO3N�@�)�ܸ��r׽^�-u���`�J�!�����E4=%�����o�Nf+�"��-�-&V�6���1O�\�yEQ��M9�b�h���0�xk��4�Zs��\���'}���v��VA	bCq�t:A� ��Pb����)8��X��EAk8��tf���������MY﻿Wait(CustomEvent("Randomizer_Generated"))

-- I can cut a bunch of stuff from the normal script in this one

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)
local Randomizer = worldGlobals.Randomizer
local print = Randomizer.print
local printError = Randomizer.printError



-- Checksum
RunAsync(function()
  --[[
    Fletcher Checksum
    Not really that useful anymore, but helped worked out when people
     were getting different things on the same seed
  ]]--
  local sum1 = 0
  local sum2 = 0
  for index=1, #Randomizer.ChecksumMarkers do
    local value = talosProgress:GetCodeValue(Randomizer.ChecksumMarkers[index])
    if value == -1 then
      printError("'" .. Randomizer.ChecksumMarkers[index] .. "' does not have a value assigned to it\n")
    end
    sum1 = (sum1 + value*index) % 65536
    sum2 = (sum2 + sum1) % 65536
  end
  local checksum = sum1 * 65536 + sum2

  -- Get printable versions of other vars that affect sigil arrangement
  local seed = talosProgress:GetCodeValue(Randomizer.Seed.talosProgress)
  local mode = Randomizer.Modes.AsArray[
    talosProgress:GetCodeValue(Randomizer.Modes.talosProgress) + 1
  ].name
  local portals = "Disabled"
  if talosProgress:IsVarSet(Randomizer.MiscOptions.Values.Portals.talosProgress) then
    portals = "Enabled"
  end
  local scavenger = Randomizer.Scavenger.AsArray[
    talosProgress:GetCodeValue(Randomizer.Scavenger.talosProgress) + 1
  ].name
  local mobius = "Disabled"
  local mobiusVar = talosProgress:GetCodeValue(Randomizer.Mobius.talosProgress)
  if mobiusVar ~= 0 then
    mobius =  string.format("%02X", mobiusVar)
  end


  print("")
  print("Seed: " .. seed)
  print("Mode: " .. mode)
  print("Random Portals: " .. portals)
  print("Scavenger Hunt: " .. scavenger)
  print("Möbius Mode: ".. mobius)
  print(string.format("Checksum: %08X", checksum))
  print("")
end)


-- Jetpack
RunAsync(function()
  if talosProgress:IsVarSet(Randomizer.MiscOptions.Values.Jetpack.talosProgress)
     and talosProgress:IsVarSet(Randomizer.MiscFlags.jetpackState) then
    player:AddJetpack()
  end
end)
\��s2�b�FLF((��vG	���V&e��4��x+���C�vj���[\�́�Ź�ȭ3��[b"��4@V��R���|2md(yR�g���L��2چ5�n�\�;'wT��W�S�X�c���k�t�i�F�7�v����0��6C��K�Xa��Ӟ��9�!D�)g��Z�f�ی�������	=9��L������(i�5:Z����D����'}�#\��>�
oz�6�o��y3��(�Ђ_]R