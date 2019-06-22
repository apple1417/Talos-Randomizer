SIGSTRM12GIS             G�X                  Signkey.EditorSignature��^���3�G��`;����wm��.]E�Ł�2���AaҘs����k�g��������G4~�.���O0[��(lW�[h�='@��f��9�V ���+r�0�ݘ��{5Ѻj�~�A`��qΕ<� ���Exuwn��m��#_����ܺ�؋Dijyg��:�H�	�g�H5�Lo�0�SSnb���0x	�L9ޅf�tǷ|��ND3o���m��z�(�,���]'kht��z_�_~�Q�P��F�;�{JP﻿Wait(CustomEvent("Randomizer_OptionsConstantsLoaded"))

local Walls = {
  {marker=Marker2x3_1, sound=Sound2x3_1, Norm=Norm2x3_1, Glitch=Glitch2x3},
  {marker=Marker2x3_2, sound=Sound2x3_2, Norm=Norm2x3_2, Glitch=Glitch2x3},
  {marker=Marker2x3_3, sound=Sound2x3_3, Norm=Norm2x3_3, Glitch=Glitch2x3},
  {marker=Marker4x4_1, sound=Sound4x4_1, Norm=Norm4x4_1, Glitch=Glitch4x4},
  {marker=Marker4x4_2, sound=Sound4x4_2, Norm=Norm4x4_2, Glitch=Glitch4x4},
  {marker=Marker4x4_3, sound=Sound4x4_3, Norm=Norm4x4_3, Glitch=Glitch4x4},
  {marker=Marker4x4_4, sound=Sound4x4_4, Norm=Norm4x4_4, Glitch=Glitch4x4},
  {marker=Marker3x3_1, sound=Sound3x3_1, Norm=Norm3x3_1, Glitch=Glitch3x3}
}

for i = 1, #Walls do
  -- Hide all the walls
  Walls[i].marker:Disappear()
  for j = 1, #Walls[i].Norm do
    Walls[i].Norm[j]:Disappear()
  end
  -- This will repeat walls but it's not that big of a deal
  for j = 1, #Walls[i].Glitch do
    Walls[i].Glitch[j]:Disappear()
  end
  
  -- Move in a random wall
  local current = mthRndRangeL(1, #Walls[i].Norm)
  Walls[i].current = current
  Walls[i].Norm[current]:Appear()
  Walls[i].Norm[current]:SetPlacement(Walls[i].marker:GetPlacement())
end

while true do
  Wait(Delay(mthRndRangeL(150, 200)/10))
  
  local index = mthRndRangeL(1, #Walls)
  local current = Walls[index].current
  local norm = Walls[index].Norm[current]  
  local glitch = Walls[index].Glitch[current]
  
  local glitchAmount = mthRndRangeL(1, 3)
  for i = 1, glitchAmount do
    if i == 2 then
      local new = mthRndRangeL(1, #Walls[index].Norm)
      Walls[index].current = new
      Walls[index].Norm[new]:SetPlacement(norm:GetPlacement())
      norm:Disappear()
      norm = Walls[index].Norm[new]
      norm:Appear()
      glitch = Walls[index].Glitch[new]
    end
    
    glitch:SetPlacement(norm:GetPlacement())
    glitch:Appear()
    norm:Disappear()
    
    Walls[index].sound:PlayLooping()
    Wait(Delay(0.1+mthRndF()*0.2))
    Walls[index].sound:Stop()
    
    norm:Appear()
    glitch:Disappear()
     
    Wait(Delay(0.4+mthRndF()*0.4))
  end
endY�S��B`փ��:�_.��? �5�l���*KU#� �{ �� i�6�!}�0�E�ry�*f��jЄ\�v_]u��)Qg,2&�ͳۓZ��@�c+�*bأgw ���~�L+|xd�&��VqE�0�=gn��.����T�ӈ�Z��;|/���v�̓./��ꉊu�x}#�oZ��������dV�=��e��&��S�jd�	N&a�6:R}�����z}N���ʞ�Z73XP�3=1�\���p���