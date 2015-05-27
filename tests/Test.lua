package.path = package.path .. ";../?.lua"

require('inspect')
require('lib/ParseCSVLine')
require("WhoDunIt")

local file = io.open("flame-bender-log.txt", "r")

io.input(file)

local line = io.read()

object = {}

function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

-- TODO pull this code into a wow LOG Parser class/lib
function parseEventData(data)

    local eventName = data[1]
    local eventData = {}

    local isSpell = eventName:starts("SPELL_") or eventName:starts("RANGE_")
    local isSwing = eventName:starts("SWING_")
    local isEnvironmental = eventName:starts("ENVIRONMENTAL_")

    -- TODO parse ENCOUNTER_START/ENCOUNTER_END events
    -- TODO find out if those columns with zeroes in them are what gets populated with advanced logging.

    -- Parse these events below - SWING, RANGE, SPELL, SPELL_PERIODIC, SPELL_BUILDING, ENVIRONMENTAL
    if isSpell or isSwing or isEnvironmental then
        -- Parse out the generic event fields
        for i = 1, 9, 1 do
            eventData[i] = data[i]
        end

        if isSpell then
            parseSpellData(data)
        elseif isSwing then
            parseSwingData(data)
        elseif isEnvironmental then
            parseEnvironmental(data)
        else
            error("It should not be possible to reach this statement.")
        end
    end
    os.exit()
end

function parseSpellData(data)
    print("IS_SPELL")
end

function parseSwingData(data)
    print("IS_SWING")
end

function parseEnvironmental(data)
    print("IS_ENVIRONMENTAL")
end


while (line ~= nil) do
    -- Extract the timestamp and combat data
    local pattern = "(%d+)/(%d+) (%d+):(%d+):(%d+).(%d+)%s+(.*)"
    local month, day, hour, minute, second, millisecond, data = line:match(pattern)

    local result = ParseCSVLine(data)
    --local event = result[1]

    parseEventData(result)



    -- TODO If this gets more complicated, the year should be stored and parsed out of the file name.
    timestamp = os.time({ year = 2015, month = month, day = day, hour = hour, min = minute, sec = second })

    --    print(event)

    -- Parse the data into the correct data series based on the incoming event.


    --    os.exit()
    --    WhoDunIt:processCombatLog(object)
    line = io.read()
end