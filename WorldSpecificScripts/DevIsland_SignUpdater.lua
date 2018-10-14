SIGSTRM12GIS             }�F�                  Signkey.EditorSignature(��3�95�Q����D��H�l�pl����������l�l@�w�qaB�R�̷���P�0[���`� �,ީ�a_��U��z��a:ǎ��eO=��-
b��~�|���`��Α�=(���o�C� �Y?�Y�hh��o�Ǝ6�k̡��}t���1�tr6��u%�����Գx�(&���w4{��FT	�Ш*A���?��F�q�b�DM�Q�<�@'v�����vT��~�u��;3hj﻿--[[
  For the three spots without a sign - C Messenger, F0 Star, F3 Star
  These sigils don't actually exist in the world so we need to do a
   bunch of stuff differently
]]--

Wait(CustomEvent("Randomizer_Finished"))
-- talosProgress : CTalosProgress
local talosProgress = nexGetTalosProgress(worldGlobals.worldInfo)
local showAll = talosProgress:IsVarSet("Randomizer_ShowAll")
local print = worldGlobals.print

local icons = {
  ["I"]="▄▄",
  ["J"]="▐▄",
  ["L"]="▄▌",
  ["O"]="█",
  ["S"]="▗▛",
  ["T"]="▗▙",
  ["Z"]="▜▖",
  ["*"]="★"
}

local text = {
  ["*"] = textStar,
  ["D"] = textDoor,
  ["E"] = textSecret,
  ["M"] = textMechanical,
  ["N"] = textNexus,
  ["Default"] = textDefault
}

local textPtr = {
  ["*"] = {},
  ["D"] = {},
  ["E"] = {},
  ["M"] = {},
  ["N"] = {},
  ["Default"] = {}
}

--[[
  Setup all text pointers, and make sure all texts have the
   correct default message
]]--
for k,v in pairs(text) do
  for i=1,#text[k] do
    textPtr[k][i] = text[k][i]:GetTextConfig()
    if k == "Default" then
      text[k][i]:SetText(textPtr[k][i], "?", true)
    else
      text[k][i]:ClearText(textPtr[k][i])
    end
  end
end

local sigilNames = {
   "**1",  "**2",  "**3",  "**4",  "**5",  "**6",  "**7",  "**8",  "**9", "**10",
  "**11", "**12", "**13", "**14", "**15", "**16", "**17", "**18", "**19", "**20",
  "**21", "**22", "**23", "**24", "**25", "**26", "**27", "**28", "**29", "**30",
  "DI1", "DI2",
  "DJ1", "DJ2", "DJ3", "DJ4", "DJ5",
  "DL1", "DL2", "DL3",
  "DT1", "DT2", "DT3", "DT4",
  "DZ1", "DZ2", "DZ3", "DZ4",
  "EL1", "EL2", "EL3", "EL4",
  "EO1",
  "ES1", "ES2", "ES3", "ES4",
  "MI1",
  "MJ1",
  "ML1", "ML2", "ML3", "ML4",
  "MO1",
  "MS1", "MS2",
  "MT1", "MT2", "MT3", "MT4", "MT5", "MT6", "MT7", "MT8", "MT9", "MT10",
  "MZ1", "MZ2", "MZ3", "MZ4",
  "NI1", "NI2", "NI3", "NI4", "NI5", "NI6",
  "NJ1", "NJ2", "NJ3", "NJ4",
  "NL1", "NL2", "NL3", "NL4", "NL5", "NL6", "NL7", "NL8", "NL9", "NL10",
  "NO1", "NO2", "NO3", "NO4", "NO5", "NO6", "NO7",
  "NS1", "NS2", "NS3", "NS4",
  "NT1", "NT2", "NT3", "NT4", "NT5", "NT6", "NT7", "NT8", "NT9", "NT10", "NT11", "NT12",
  "NZ1", "NZ2", "NZ3", "NZ4", "NZ5", "NZ6"
}
local markers = {
  "Islands_01_SRT_SPM_000_PM_003",
  "Secret_28_SRT_SPM_000_PM_004",
  "LeapOfFaith_PM_010"
}
local collected = talosProgress:GetInventoryTetrominoes()..talosProgress:GetUsedupTetrominoes()

-- Sort the sigil list to prevent memorising spawn order
local sigils = {}
local stars = {}
for i=1, #markers do
  local sigilNum = talosProgress:GetCodeValue(markers[i])
  if sigilNum <= 30 then
    table.insert(stars, sigilNum)
  else
    table.insert(sigils, sigilNum)
  end
end
table.sort(sigils)
--[[
  The elements of each sign are indexed weirdly so I need to
   resort the list to work with it
]]--
local allSigils = {}
local half = mthCeilF(#sigils/2)
for i=1, #sigils do
  if i > half then
    allSigils[2*(i-half)] = sigils[i]
  else
    allSigils[2*i-1] = sigils[i]
  end
end
for i=1, #stars do table.insert(allSigils, stars[i]) end

--[[
  Function to fill each sign
  If this is called multiple times it will replace sigils with
   themselves, effectivly doing nothing
  Leaving this because I might eventually add the dev island spots to
   mobius mode, and I'll need it then
]]--
local function updateText()
  for i=1, #allSigils do
    local sigil = sigilNames[allSigils[i]]
    local colour = string.sub(sigil, 1, 1)
    local type = string.sub(sigil, 2, 2)
    local _, count = string.gsub(collected, sigil, "")
    if count >= 1 then
      if count > 1 then
        print("How did you collect " .. sigil .. " more than once???")
      end
      text[colour][i]:SetText(textPtr[colour][i], icons[type], true)
      text["Default"][i]:SetText(textPtr["Default"][i], "✘", true)
    -- If a sigil is not picked and showAll is false it'll remain '?'
    elseif showAll then
      text[colour][i]:SetText(textPtr[colour][i], icons[type], true)
      text["Default"][i]:ClearText(textPtr["Default"][i])
    end
  end
end

updateText()

if talosProgress:GetCodeValue("Randomizer_Loop") ~= 0 then
  local F0 = talosProgress:GetCodeValue("Randomizer_LoopF0")
  local F3 = talosProgress:GetCodeValue("Randomizer_LoopF3")
  local worldNames = {
    "A1", "A2", "A3", "A4", "A5", "A6", "A7", "A*",
    "B1", "B2", "B3", "B4", "B5", "B6", "B7", "B*",
    "C1", "C2", "C3", "C4", "C5", "C6", "C7", "C*", "CM"
  }
  F0Text:SetText(F0Text:GetTextConfig(), worldNames[mthFloorF((F0 + 1)/2)], true)
  F3Text:SetText(F3Text:GetTextConfig(), worldNames[mthFloorF((F3 + 1)/2)], true)
else
  WorldSign:Disappear()
end

-- Need to make sure the sign updates incase you don't reset
RunHandled(
  function()
    WaitForever()
  end,
  OnEvery(CustomEvent("TetrominoAwarded")),
  function()
    updateText()
  end
)w��nj�?��F/&�E��h�!O~ 5�f�H=�K2:����2F�Q �"Zv��cϕ<��1�k
��L��{
�*�9�"�	��١��.*2�����1n:��>^�M#si�*����	��i��g��u�}KbO���I���m�.wk&�h���DѬ#�*���3b�����.g��& ki�'�L ��la�7��I}�������ޚvx���s����v�;HY�}�瞃�-?���͘{&Xs�SA