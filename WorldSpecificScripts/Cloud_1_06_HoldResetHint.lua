SIGSTRM12GIS             �_N�                  Signkey.EditorSignature��_u�&  ��[���jw����~�:
�V�/F^U��M\c;G�4x�[�⇁��rO0]���H@�J���f�B!7�p�1���~�mN���/v
x�-�m�PR�&)�}���Z{�i-�.����z�]���#@CqY�^���L~f�|+�����y��'��{]�k��&���Ւ��
�ȟ�E o0��
?��R��i|Nì�OH/�]W6kz�fP=ǊEG��aS (=W!�A�	�T�f�邊﻿Wait(CustomEvent("Randomizer_Finished"))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local sigilNum = talosProgress:GetCodeValue("303_SPM_000_PM_010")
local Bichromatic = worldGlobals.allTetros[sigilNum]


local bDoorOpen=0 -- 0 door is closed, 1 door is open
local iConnectorsInsideArea=0 -- how many connectors are inside possible stuck area
local bEnoughConnectors=false -- are there enough connectors inside stuck zone to finish puzzle

RunHandled(WaitForever,
  OnEvery(Event(plasmaDoor_BlueReceiver.Opened)), 
  function()
    bDoorOpen=1
    SignalEvent("Door opened")
  end,
  -- decide if showing a reset msg is needed
  OnEvery(Event(plasmaDoor_BlueReceiver.Closed)), 
  function() 
    -- player : CPlayerPuppetEntity
    bDoorOpen=0
    detector_PlayerStuck:Recharge()
    local player=Wait(Event(detector_PlayerStuck.Activated)):GetActivator()
    Wait(Any(Delay(5), CustomEvent("Door Opened")))
    if bDoorOpen==0 then
      local vPlayer = player:GetPlacement():GetVect()
      if detector_PlayerStuck:IsPointInArea(vPlayer, player:GetNavigationRadius()) then
        if not bEnoughConnectors then
          if player then 
            player:ShowTutorialMessage("TTRS:Hint.HoldToReset=Hold {plcmdHome} to reset", 30.0, 0.5)
          end
        else
          Wait(Event(bichromatic.Picked))  
          if player then 
            Wait(Delay(2))
            player:ShowTutorialMessage("TTRS:Hint.HoldToReset=Hold {plcmdHome} to reset", 30.0, 0.5)
          end          
        end  
      end
    end
  end,
  -- count how many connectors are in area when door closes
  OnEvery(Event(plasmaDoor_BlueReceiver.Closed)), 
  function()
    iConnectorsInsideArea=0
    local vConnector1 = connector1:GetActualPlacement():GetVect()
    local vConnector2 = connector2:GetActualPlacement():GetVect()
    local vConnector3 = connector3:GetActualPlacement():GetVect()
    if detector_PlayerStuck:IsPointInArea(vConnector1, 0.5) then
      iConnectorsInsideArea=iConnectorsInsideArea+1
    end    
    if detector_PlayerStuck:IsPointInArea(vConnector2, 0.5) then
      iConnectorsInsideArea=iConnectorsInsideArea+1
    end    
    if detector_PlayerStuck:IsPointInArea(vConnector3, 0.5) then
      iConnectorsInsideArea=iConnectorsInsideArea+1
    end         
    if iConnectorsInsideArea>1 then
      bEnoughConnectors=true -- there are enough connectors in area to solve puzzle
    else  
      bEnoughConnectors=false -- there are not enough connectors in area to solve puzzle
    end
  end
)I���ʕ�� ��._�)&�����^��=�%�=�L4%*{�4��jL6p�:��h�����-�{W�k/��A~�ĹT��fכ>3�8� =NM!�!.H��R��!��%��2��(���L�MC��5�ÆQz�Έ\�)%I��^]j�'��A�nt?9/�l� @oC��뵆���i�ۣ������7s�?�U����5��F�s�GI#�&DҺ
?b;��UAo�������� \�MBɚ������H��