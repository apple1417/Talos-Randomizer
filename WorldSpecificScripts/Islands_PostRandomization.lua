SIGSTRM12GIS             �1                  Signkey.EditorSignature��H3Si��|��I�5Ӄw�qpqw4���#�!7�R���N��Z��P��D�>�s�8��w$mN�
�������v��Y>���J�C[�����A�5lu��$�ȳ�?9[%��pZk�Z�j�}=}��m���3�_Vj)�$E*���^�Ю�%}��	ނK��\��ۻ�oiJ{,W�C=�֧�G� x|cf��m����K2ֲ��W��%�&�L>t\QzX��;�r�G�ͺˢbG�0�﻿Wait(CustomEvent("Randomizer_Generated"))

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
���ȎM�Gd�T������y��������D��p'#\�1<6@���IPs�����&L���;���ǚ��	�t˙#1���n��a����2�6��~�ř�QZ7%��o�;�H�$�`*��&}�_�u�6�ܕ�rNv��8�)h��x���+��5w�ن�0�}���3v����l#�J�;,� 8�`n����8UF��$5�4�5v~P:G����?!�/N8�	8��p����|�����M�sk�