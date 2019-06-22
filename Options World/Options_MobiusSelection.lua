SIGSTRM12GIS             a
<�                  Signkey.EditorSignature8���|���KhN޷;����y8X�7&���4I%Țbs����H8� �G��M&_}�/�ը{�.�����^�	��P⩔�����T�-+ug�����_}�'?i_���
��FO��MD�bÅ�y�A��M�#�����v�8j L�3y.DnD�\���9P[v����Xt��\�� ���·�;��]����܎)k���h�E%TC�St�y���v�e�v�!Bd�v;�t�ν�k��[���VC﻿Wait(CustomEvent("Randomizer_OptionsConstantsLoaded"))
local Mobius = worldGlobals.Randomizer.Mobius

local offset = GreenButtons[1]:GetPlacement():GetVect() - GrayButtons[1]:GetPlacement():GetVect()
offset = offset / 2

for i = 1, #Mobius.AsArray do
  GrayButtons[i]:EnableUsage()
  GrayTexts[i]:SetText(
    GrayTexts[i]:GetTextConfig(),
    Mobius.AsArray[i].name,
    true
  )
  GreenTexts[i]:SetText(
    GreenTexts[i]:GetTextConfig(),
    Mobius.AsArray[i].name,
    true
  )
end

local emptyButton = {}
for i = #Mobius.AsArray + 1, #GrayButtons do
  emptyButton[i] = true
  GrayButtons[i]:EnableUsage()
end

-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldInfo)

local currentSettings = 0
RunHandled(WaitForever,
  OnEvery(Any(Events(GrayButtons.Used))),
  function(event)
    local index = event.any.signaledIndex
    if emptyButton[index] then
      worldGlobals.Randomizer.pressButton(GrayButtons[index], nil, offset, true)
    else       
      worldGlobals.Randomizer.pressButton(
        GrayButtons[index], GreenButtons[index],
        offset, false,
        function()
          currentSettings = currentSettings + Mobius.AsArray[index].mask
          talosProgress:SetVarValue(
            Mobius.talosProgress,
            currentSettings
          )
        end
      )
    end
  end,
  OnEvery(Any(Events(GreenButtons.Used))),
  function(event)
    local index = event.any.signaledIndex
       
    worldGlobals.Randomizer.pressButton(
      GreenButtons[index], GrayButtons[index],
      offset, false,
      function()
        currentSettings = currentSettings - Mobius.AsArray[index].mask
        if (currentSettings == 0) then
          talosProgress:ClearVar(Mobius.talosProgress)        
        else
          talosProgress:SetVarValue(
            Mobius.talosProgress,
            currentSettings
          )
        end
      end
    )
  end  
)^mi#�d���W����Eq)�,Vc��C��Ěim�R\zUx���^�5]���ȕ�X�b���	�M�#�}ۥܝbKG��t�e l�{�b�:��Ldd����?g~�����V��/[��zwL�az�QRҷ���&��P�t��w`�Ö�_ΔR��m����i1�����C����2>�5j7Ǳ���2=?� mS�zL���~^���D~XK<(䆽��5�ʑ0a��%�^i�ð��C%����]� 