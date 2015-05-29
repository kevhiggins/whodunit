package.path = package.path .. ";../?.lua"

require('inspect')
require('lib/ParseCSVLine')
require("lib/CombatLogConverter")
require("WhoDunIt")
require("EventManager")
require("encounters/Encounter")
require("encounters/Mechanic")
require("encounters/Kagraz/Kagraz")
require("encounters/Kagraz/EnchantedArmament")
require("encounters/Thogar/Thogar")

local file = io.open("flame-bender-log.txt", "r")

io.input(file)

local line = io.read()

object = {}

while (line ~= nil) do
    local eventData = CombatLogConverter:convertEventData(line)
    EventManager:processEventData(eventData)
    --    print(event)

    -- Parse the data into the correct data series based on the incoming event.


    --    os.exit()
    --    WhoDunIt:processCombatLog(object)
    line = io.read()
end