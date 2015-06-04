package.path = package.path .. ";../?.lua"

WhoDunIt = {}

require('lib/Inspect')
require('lib/ParseCSVLine')
require("lib/CombatLogConverter")
require("WhoDunIt")
require("EventManager")
require("FailManager")
require("FailGroup")
require("Fail")
require("Unit")
require("encounters/Encounter")
require("encounters/Mechanic")
require("encounters/Spell")
require("encounters/PeriodicSpell")
require("encounters/Kagraz/Kagraz")
require("encounters/Kagraz/UnquenchableFlame")
require("encounters/Kagraz/LavaSlashGround")
require("encounters/Kagraz/MoltenTorrent")
require("encounters/Kagraz/Singe")
require("encounters/Thogar/Thogar")

local test = WhoDunIt.eventManager.startEncounter

local file = io.open("flame-bender-log.txt", "r")
local outFile = io.open('flamebender.lua', 'w')

io.input(file)

local line = io.read()

object = {}

outFile:write('testData = {\n')

while (line ~= nil) do
    local eventData = CombatLogConverter:convertEventData(line)
    local eventName = eventData[2]

    if eventName == "ENCOUNTER_START" then
    elseif eventName == "ENCOUNTER_END" then
    else
        outFile:write(inspect(eventData) .. ",\n")
    end
    line = io.read()
end
outFile:write('}')

WhoDunIt.failManager:display()