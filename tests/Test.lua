package.path = ";../?.lua" .. package.path

require('inspect')
require('lib/ParseCSVLine')
require("WhoDunIt")

local file = io.open("flame-bender-log.txt", "r")

io.input(file)

local line = io.read()

object = {}

while (line ~= nil) do

    -- local date, time, data = string.gmatch(line, "%S+");

    tokens = {}
    for i in string.gmatch(line, "%S+") do
        tokens[#tokens + 1] = i
    end

    local date, time, data = unpack(tokens)
    local datetime = date .." " .. time

    local pattern = "(%d+)/(%d+) (%d+):(%d+):(%d+).(%d+)"
    local month, day, hour, minute, second, millisecond = datetime:match(pattern)

    -- If this gets more complicated, the year should be stored and parsed out of the file name.
    timestamp = os.time({year=2015, month=month, day=day, hour=hour, min=minute, sec=second})

    local result = ParseCSVLine(data)

    local event = result[1]

    -- Parse the data into the correct data series based on the incoming event.


    os.exit()
    WhoDunIt:processCombatLog(object)
    line = io.read()
end