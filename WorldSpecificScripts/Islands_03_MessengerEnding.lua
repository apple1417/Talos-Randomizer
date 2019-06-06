SIGSTRM12GIS             �$��                  Signkey.EditorSignature�E<HH��l�+C����=�6!��#)E��H�a�B,�mΊ��aN��U���<n
���V���p�c�� x�D*Cbq3]�Ż J�'�$����+���I|���/�x���`�?�,Fr�����qX�X7:H��7N� R�붂⨌!��@K|�r�A���Un�z�G�2M���>B��D))y2œ�k��BFU�K������;��%�<���.�U}r�(Do�YM��Q�D���P��K�_���ٖx��N��﻿--[[
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
      text:SetText(text:GetTextConfig(), "Seed: " .. talosProgress:GetCodeValue(worldGlobals.Randomizer.Seed.talosProgress), true)

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
���O4:��#�;�sP'���{=@���	�N$�`5j�O;%L;9����v��nBV�J��)}���c��{�>s���͍�>�#Qn߉��0ʘt�i�i��	��@�da~�)�ڤ���K�~?�t�w	ʧ䩗Y��
� ��#�)�8*�˷*�����{�Q�A��z�5�� ����U����@��(�Xt+}�x�<0fRͽ�"$@��D���Uruَ����M�~��s ��d��A��3��2<�22 7t