SIGSTRM12GIS             ���                  Signkey.EditorSignature���؂]���Z������'���=���q�d�m=��$X2��:�ß�@(5���.�{v��G*�;��h�d�FނrVR��u]n`+Y+TٗR��m7}fy�=����Wq���7�t	U'a�:~�#���K����v���uV����� 5�8�9��	ʌ4�8�3}�D����~��=�\+��W��7?��w�
��T����٬-����ك���cj����ȃ[���8~����,�8s��Ɗ�﻿--[[
  This script lets you skip the options world with specific options
   set via console command

  This clears a few vars, need to make sure it's done before we set them again
  We also just need to delay a bit to be able to load the next world
]]--
Wait(CustomEvent("Randomizer_OptionsConstantsLoaded"))
Wait(CustomEvent("OnStep"))

local occasion = prjGetCustomOccasion()
local args = string.match(occasion, "Randomizer_AutoStart={(.-)};")
if args ~= nil then
  talClearTalosProgress(worldInfo)
  
  -- talosProgress : CTalosProgress
  local talosProgress = nexGetTalosProgress(worldInfo)  
  for tal, val in string.gmatch(args, "'(.-)'=(%d+)") do
    talosProgress:SetVarValue(tal, val)
  end
  
  exitChapter:Start()
end
�D�-��[�����nP(�'l��U�ȦH[�Q%��s8�������R�d�Vba_6y�F��~7q�r��s�y����^@��q�Cj��;ltEA����At
�����R	�����K�A�꩹��MTϘr���iϨ���91�j�JTw���ڟ������4�0L�ڿ�.Ԏ
CI��Hހ֪�㥣$�)��=c��O��Ҝ��P�w�q�P��	����m �.�^Υ��^��@p�b���� <�w23=O�}� h