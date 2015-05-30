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
require("encounters/Kagraz/Singe")
require("encounters/Thogar/Thogar")

local file = io.open("flame-bender-log.txt", "r")

io.input(file)

local line = io.read()

object = {}

-- TODO Might want to have a configuration for when to start ignoring events.

while (line ~= nil) do
    local eventData = CombatLogConverter:convertEventData(line)
    WhoDunIt.eventManager:processEventData(eventData)
    --    print(event)

    -- Parse the data into the correct data series based on the incoming event.


    --    os.exit()
    --    WhoDunIt:processCombatLog(object)
    line = io.read()
end

WhoDunIt.failManager:display()