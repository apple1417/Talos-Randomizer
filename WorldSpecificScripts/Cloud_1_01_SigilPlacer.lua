SIGSTRM12GIS             ��<                  Signkey.EditorSignaturewn����}�k�z#=�i5��@"s�]��(� ��_������q>�p�X�M�#�p:Y!����O�1��M=�)��
�k��$��s%2r��1?W|qi�E����Ś�X���^{���Q�C���͐��u '�+�2C�6:)k��1ށ�zc]ڊ�v�}pǿ)a"+!����?�a����hS��OF���~����Z�$�f:n��}Zw����	�Ћ���߲�<Gj�%pd�a��&A��<﻿Wait(Delay(0.15))

local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
worldGlobals.allTetros = { s1,  s2,  s3,  s4,  s5,  s6,  s7,  s8,  s9, s10, -- 10
                          s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, -- 20
                          s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, -- 30
                          DI1, DI2, -- 32
                          DJ1, DJ2, DJ3, DJ4, DJ5, -- 37
                          DL1, DL2, DL3, -- 40
                          DT1, DT2, DT3, DT4, -- 44
                          DZ1, DZ2, DZ3, DZ4, -- 48
                          EL1, EL2, EL3, EL4, -- 52
                          EO1, -- 53
                          ES1, ES2, ES3, ES4, -- 57
                          MI1, -- 58
                          MJ1, -- 59
                          ML1, ML2, ML3, ML4, -- 63
                          MO1, -- 64
                          MS1, MS2, -- 66
                          MT1, MT2, MT3, MT4, MT5, MT6, MT7, MT8, MT9, MT10, -- 76
                          MZ1, MZ2, MZ3, MZ4, -- 80
                          NI1, NI2, NI3, NI4, NI5, NI6, -- 86
                          NJ1, NJ2, NJ3, NJ4, -- 90
                          NL1, NL2, NL3, NL4, NL5, NL6, NL7, NL8, NL9, NL10, -- 100
                          NO1, NO2, NO3, NO4, NO5, NO6, NO7, -- 107
                          NS1, NS2, NS3, NS4, -- 111
                          NT1, NT2, NT3, NT4, NT5, NT6, NT7, NT8, NT9, NT10, NT11, NT12, -- 123
                          NZ1, NZ2, NZ3, NZ4, NZ5, NZ6} -- 129

print(worldGlobals.allTetros)
                          
for _, marker in pairs(worldMarkers) do
  local index = talosProgress:GetCodeValue(marker:GetName())
  if index ~= -1 then
    worldGlobals.allTetros[index]:SetPlacement(marker:GetPlacement())
    print(index, worldGlobals.allTetros[index]:GetName())
  else print(marker:GetName()) end
endg�N7��ܚ�PlU�-���9.��j�x��rZ�F���1���z�m�V�wi���\��3<�ҏ@��K���K)�[�]�"y1��C\,R<�iH��:�Z�!��m!��>��l�)U�O�R?Xy�d���T��J>P%,�,~�r�#�7�]�#n�����2��W� ����j����$S�����v�u ��?,���=��!�u�K>�窎��Xu��(�?��Ǻ���~`�j���E�=6��