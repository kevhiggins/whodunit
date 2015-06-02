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

io.input(file)

local line = io.read()

object = {}

while (line ~= nil) do
    local eventData = CombatLogConverter:convertEventData(line)
    local eventName = eventData[2]

    if eventName == "ENCOUNTER_START" then
        WhoDunIt.eventManager:startEncounter(select(3, unpack(eventData)))
    elseif eventName == "ENCOUNTER_END" then
        WhoDunIt.eventManager:endEncounter(select(3, unpack(eventData)))
    else
        WhoDunIt.eventManager:processCombatLog(unpack(eventData))
    end


    -- Parse the data into the correct data series based on the incoming event.


    --    os.exit()
    --    WhoDunIt:processCombatLog(object)
    line = io.read()
end

WhoDunIt.failManager:display()