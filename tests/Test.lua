package.path = package.path .. ";../?.lua"

require('inspect')
require('lib/ParseCSVLine')
require("lib/CombatLogConverter")
require("WhoDunIt")


local file = io.open("flame-bender-log.txt", "r")

io.input(file)

local line = io.read()

object = {}

while (line ~= nil) do
    local eventData = CombatLogConverter:convertEventData(line)
    --    print(event)

    -- Parse the data into the correct data series based on the incoming event.


    --    os.exit()
    --    WhoDunIt:processCombatLog(object)
    line = io.read()
end