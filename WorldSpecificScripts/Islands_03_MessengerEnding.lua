SIGSTRM12GIS             Q�n�                  Signkey.EditorSignatureN������1�c�)_�Q�q�Z�v��)&����S7��E�����J�m��xn^|�EI���75eȳ�rW�:��c�c��B�Q�hoU�aW����}BT?'���3H���2 �������t����0XЬ��p&�B���:v?uFݩ�hNx*�p�c�pn�����B�y��4lp1��?L�H��{E��*�3ƃC�S4��)�rh�Z�-����n�?I��Q;)��=M8�V;/
NQ���T��݆(��﻿--[[
  Added a sign showing seed here, but like the terminal I only want
   it to be active for messenger ending
]]--

RunHandled(WaitForever,
  On(Event(Chapter_IslandStart.Started)),
  function()
      terminal:Disappear()
      sign:Disappear()
  end,
  On(Event(Chapter_MessengerEnd.Started)),
  function()
      -- hide messenger that is laying in the coffin
      MessengerInCoffin:Disappear(false)
      Coffin:PlayAnimStay("Closed")
      -- talosProgress : CTalosProgress
      local talosProgress = nexGetTalosProgress(worldInfo)
      text:SetText(text:GetTextConfig(), "Seed: " .. talosProgress:GetCodeValue("Randomizer_Seed"), true)
      talosProgress:SetVar("MessengerEnding")
      arranger:Disappear()
      arrangerStand:Disappear()
      Wait(Event(terminal.Stopped))  
      -- when terminal has stopped, player should have selected its
      -- epitaph so add it to the tombstones
      tombstones:AddPlayersEpitaph(i)
      -- and start the cutscene
      ChapterCutSceneMessengerEnding:Start()
  end
)
����@1����1F��]����>٨J���b��J4`����bl�0w���"��՞q�1��L D��"��Ǒ��)o *�/�Ux���{H/!<"�4���[N�%�
?��~�'r�}:e��4.��5�ʨR���h��v��l�Xk�m72��:����$��)�e-�m��[�(��{n��pՀ��/D7��~�L���,1@�6 �r�E0y>]�Q����lE�ﳣ�O�[E���QA#_�R_