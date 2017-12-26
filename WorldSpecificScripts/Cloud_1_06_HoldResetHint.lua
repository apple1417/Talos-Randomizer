SIGSTRM12GIS             x��(                  Signkey.EditorSignature��hEʓm1|"*rV�:�3omWt!�"���a�rL���(f8ð�a��Ң�}�"t��@�K�>�W�@�����s���X0�Sf�i�v9�^ˊ��(�r��S!�)���oS��*;����v�t�FpE�C��� �=�MC)k#����b��n�������c�<�j�,\e2u���Ƶ��?�rZ/��0�R{$�4Vi���ŏ�!�Z��vR����!5�f�-m:�y[+'Ϊʦ��﻿--Wait(CustomEvent("Randomizer_Finished"))
Wait(Delay(0.1))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local sigilNum = talosProgress:GetCodeValue("303_SPM_000_PM_010")
local Bichromatic = worldGlobals.allTetros[worldGlobals.tetros[sigilNum]]


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
)  
�=#�ᄆ���%��o%Y����mjњ�5�S�������� .C�]~m:�9#��)N�gh	�d�M�U�Z)(�ζi�LMt��ûe�F��\�@����iQ��4c��h��� �$U���D�����q�=Tw�FЫ�Xo�@���0��s:v��&*����׸�kV��ޢ@?�y�'�5����u�l���5Ub��P˙{��A��̎y�ͿX)�bGٿ�<�ݠs�����7�Je\&˞L�