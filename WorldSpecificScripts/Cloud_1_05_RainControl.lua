SIGSTRM12GIS             H4�-                  Signkey.EditorSignature<Q�:t�v�1�*��_��n�~WET��2�#�!���r���U��k�vRL�at�r�$|���:�붆l�0҃�.���ǣr�nPQ�ߞa$I4��D�����2E���a6Ld2��`<�6�v�3Xj�t�lF:8�'J���Г�8ۓ��N:�RD�*�%7Z]�bj�0�ͥU�B�mw���CBA㽺ؠ>�P)d7��bЪL��=��8�h���)4;�s���H�ؒ��{�^^H�.���紌��ٙk���﻿Wait(CustomEvent("Randomizer_Finished"))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local Sigils = {}
for k, v in pairs({"201_SPM_000_PM_013", "204_SPM_000_PM_004",
                   "202e_SPM_000_PM_004", "207_SPM_000_PM_005",
                   "244_SPM_000_PM_008"}) do
  local sigilNum = talosProgress:GetCodeValue(v)
  Sigils[k] = worldGlobals.allTetros[sigilNum]
end

BackgroundRotator:PlayAnimLoop("Default")
local iNextThunder = 1
local bLastRaining = false
local bRaining = true
local fNextLightning = 100000

local function Lighting()
  if iNextThunder==1 then
    SoundThunder1:PlayOnce()
    Wait(Delay(1))
    iNextThunder = 2
  else
    SoundThunder2:PlayOnce()
    Wait(Delay(2.1))
    iNextThunder = 1
  end
  LightningAnimator:StartAnimation("TurningOn")
  ParticlesLighnting:Start()
  Wait(Delay(0.15))
  ParticlesLighnting:Stop()
end

local progress = nexGetTalosProgress(worldGlobals.worldInfo)
local strPickedInstances = progress:GetInventoryTetrominoes() .. progress:GetUsedupTetrominoes()

local ctPicked = 0
for i=1,#Sigils do
  -- sigil : CGenericItemEntity
  local sigil = Sigils[i]
  local strName = sigil:GetName()
  if string.match(strPickedInstances, strName..";") then
    ctPicked = ctPicked+1
  end
end

-- see how many sigils are there in the level
local fRnd = 1
if ctPicked%2==0 then
  -- immediately start rain
  RainAnimator:StartAnimation("On")
  bRaining = true
  fNextLightning = 15
  worldInfo:SetMusic("Ambient", resRainyAmbient)
else
  -- immediately start sun
  RainAnimator:StartAnimation("Off")
  worldInfo:SetMusic("Ambient", resSunnyAmbient)
  bRaining = false
end
bLastRaining = bRaining
    
RunHandled(
  function()
    WaitForever()
  end,
  OnEvery(Delay(1)), function()
    -- if we should start sunny weather
    if bLastRaining and not bRaining then
      RainAnimator:StartAnimation("TurningOff")
      worldInfo:SetMusic("Ambient", resSunnyAmbient)
      -- schedule next lighting
      fNextLightning = 100000
    end
    -- if we should start rainy weather
    if bRaining and not bLastRaining then
      RainAnimator:StartAnimation("TurningOn")
      worldInfo:SetMusic("Ambient", resRainyAmbient)
      fNextLightning = 15
    end

    -- if it is raining    
    if bRaining then
      fNextLightning = fNextLightning-1
      if fNextLightning<0 then
        -- schedule new one
        fNextLightning = 10+mthRndF()*20
        -- show lightning
        Lighting()
      end
    end
      
    bLastRaining = bRaining
  end,
  OnEvery(Any(Event(Sigils[1].Picked), Event(Sigils[2].Picked),
              Event(Sigils[3].Picked), Event(Sigils[4].Picked),
              Event(Sigils[5].Picked))), function()
    local fRndDelay = 5+mthRndF()*10
    Wait(Delay(fRndDelay))
    -- toggle desired state
    if bRaining then
      bRaining = false
    else
      bRaining = true
    end
  end
)������ ��hQT����{�ŗχФ�/¨H�Yo,>b��V2�p.e>j4��KY?��n���+��VP�h��ʉ^���t��v�h���������G�-=�ED,U���� �S���G	4,ɿ�Es�z��G�����#�m�l]���k�]r�����;�)iEd�Dl=S$�Ҧ��\���IWv@ 7��߄�P�%�m'�o�{�!�8atD��R"��h��vyt�ò6�e��f{�M��aJ�