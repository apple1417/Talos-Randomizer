SIGSTRM12GIS             �o.9                  Signkey.EditorSignature4C�S�$���p8��V���-՞�8|�y�N�-��� +2�ԣ���u?����*�X���Fx��Q9�����l��l�Ow��f�,�ח�E�L��t�k!u�A�$ᶫ���X�,�qX��X�\Wx�-LR�:�*�[궏�Odv�U�Ç�\4-4���V,Q��r|�
�?e��~4Ks*g�>�=�R��V�.+z��os��?�����JU�\"��e�A�S��9��[�`�2'R���ѐ�J����Cu��﻿--Wait(CustomEvent("Randomizer_Finished"))
Wait(Delay(0.1))
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local Sigils = {}
for k, v in pairs({"201_SPM_000_PM_013", "204_SPM_000_PM_004",
                   "202e_SPM_000_PM_004", "207_SPM_000_PM_005",
                   "244_SPM_000_PM_008"}) do
  local sigilNum = talosProgress:GetCodeValue(v)
  Sigils[k] = worldGlobals.allTetros[worldGlobals.tetros[sigilNum]]
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
)jE ;l+����Nmm�d�8z~��e�����.�/��P��� �z^�_�Fj�v���vt�OZkX�?����#�$�H4��X�B�q:X�C��#W�z�$�y0��X�QB*Y^�\�����ΙW!9��JAZ*��}ǌ&�"CG> %']��D��6� ˔T��L>q#������W��j�μ�����x߆�j����x����j���b�4��|��M26Cq1I��I6)GIc}�3N�����(�ſ��4��