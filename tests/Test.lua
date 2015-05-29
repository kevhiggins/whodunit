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
require("encounters/Encounter")
require("encounters/Mechanic")
require("encounters/Kagraz/Kagraz")
require("encounters/Kagraz/UnquenchableFlame")
require("encounters/Thogar/Thogar")

local file = io.open("flame-bender-log.txt", "r")

io.input(file)

local line = io.read()

object = {}

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