SIGSTRM12GIS             ��6�                  Signkey.EditorSignature=�'"�=X7�G0qm��<�%Ԋ���I��n�	.�
���\m6��@Ԙ�ȳ`���bD(:@���Els����߹E���U���#�4'j����F���cjѪ~+XL�LL�dW�����)�{�+z��o_W�3�щ�_�5�ٌ�,��%t��2]5���hsɀ��Rs�אϜm�/֣����T3�}$:��Ù����J�8=�0����n��'ػm]q|�B��PRumu��=��k �u�6�6T�{e�1t����Xq}﻿Wait(CustomEvent("Randomizer_OptionsConstantsLoaded"))
local Hints = worldGlobals.Randomizer.Hints

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

local offset = GreenButtons[1]:GetPlacement():GetVect() - GrayButtons[1]:GetPlacement():GetVect()
offset = offset / 2

for i=1, #GrayButtons do
  GrayButtons[i]:EnableUsage()
end

local currentHints = 0
talosProgress:SetVarValue(Hints.talosProgress, 0)
RunHandled(WaitForever,
  OnEvery(Any(Events(GrayButtons.Used))),
  function(event)
    local index = event.any.signaledIndex
    
    worldGlobals.Randomizer.pressButton(
      GrayButtons[index], GreenButtons[index],
      offset, false,
      function()
        currentHints = currentHints + Hints.AsArray[index].mask
        talosProgress:SetVarValue(Hints.talosProgress, currentHints)
      end
   )
  end,
  OnEvery(Any(Events(GreenButtons.Used))),
  function(event)
    local index = event.any.signaledIndex
    
    worldGlobals.Randomizer.pressButton(
      GreenButtons[index], GrayButtons[index],
      offset, false,
      function()
        currentHints = currentHints - Hints.AsArray[index].mask
        talosProgress:SetVarValue(Hints.talosProgress, currentHints)
      end
   )    
  end
)�~�$:���
�؍��X�E��V����a�
�)n]K���L�\(�`MkYa���'@
�x��pFѣ~��J��K����ֳhڽK �ź�ح�1 +|�ɿ�ˈ[��|�!�>]�,46���Ҙ�|]��o@2ųj��~��	��֮�M qe;��[R����[Cz8���'�����^����A�`�Hvd�����	3K/4�S��.�sI��mȀK�<?�4"(W�"��[�n�oOv���M��3a��F]�*