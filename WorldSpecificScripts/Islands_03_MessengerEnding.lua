SIGSTRM12GIS             ���                  Signkey.EditorSignature���>���*,�=�ۥs&B�6)�¤���g�Gy�ɭ�e�Sw{k��F�1�-�n��q��Hŋ/0'�Y��A$��mEPy�P\�M�J���Y�%��e��,��P����X�����[s�yC%�0���� �Ԏ��ή��ZsI�X� �A�Є*���_�!�r��2�aL�q6���&}�-eD�<�)��{G��ezx�K=���,B�Js$C�jlҗ`�ՕM
��F�G-r0CΆ'���4�
KLn�>﻿RunHandled(WaitForever,
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
}��Q1���#�j���=8g�x$!��ax1�k�^湡��D�3�'OZ���4�Sn��+��j����p�V�:ׄ�]TC����Ih��n�+(U�����=��d��m�5

���j�k��4p��XM��)�#�1ZO�l���s_q����ܑ+/�e������� �,>g���ߕ\H��ún9�o���k�G�YQ<�����B�Çh��_qE�OMWBhl����6�q9.� �!�-$
 �g562N�t,W