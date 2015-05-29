-- CombatLogConverter converts combat log rows into table structures matching the in game COMBAT_LOG_EVENT version.
CombatLogConverter = {
    advancedLogEntryCount = 13
}

function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function string.ends(String, End)
    return End == '' or string.sub(String, -string.len(End)) == End
end

function CombatLogConverter:convertEventData(line)
    -- Extract the timestamp and combat data
    local pattern = "(%d+)/(%d+) (%d+):(%d+):(%d+).(%d+)%s+(.*)"
    local month, day, hour, minute, second, millisecond, lineData = line:match(pattern)

    -- TODO Parsing the CSV data is slow.
    local data = ParseCSVLine(lineData)

    local eventName = data[1]

    -- TODO If this gets more complicated, the year should be stored and parsed out of the file name.
    local timestamp = os.time({ year = 2015, month = month, day = day, hour = hour, min = minute, sec = second })
    timestamp = timestamp .. "." .. millisecond

    local eventData = { timestamp }

    if eventName == "ENCOUNTER_START" or eventName == "ENCOUNTER_END" then

        for i = 1, #data do
            table.insert(eventData, data[i])
        end
    else
        -- Timestamp, Event Name, Hide Caster
        table.insert(eventData, eventName)
        table.insert(eventData, false)

        local isSpell = eventName:starts("SPELL_") or eventName:starts("RANGE_")
        local isSwing = eventName:starts("SWING_")
        local isEnvironmental = eventName:starts("ENVIRONMENTAL_")

        -- TODO find out if those columns with zeroes in them are what gets populated with advanced logging.

        -- Parse these events below - SWING, RANGE, SPELL, SPELL_PERIODIC, SPELL_BUILDING, ENVIRONMENTAL
        if isSpell or isSwing or isEnvironmental then
            -- Parse out the generic event fields
            for i = 2, 9, 1 do
                table.insert(eventData, data[i])
            end

            if isSpell then
                self:parseSpellData(eventData, data)
            elseif isSwing then
                self:parseSwingData(data)
            elseif isEnvironmental then
                self:parseEnvironmental(data)
            else
                error("It should not be possible to reach this statement.")
            end
        end
    end

    return eventData
end

-- The last couple
function CombatLogConverter:parseSpellData(eventData, data)

    local startIndex = 10
    local eventName = data[1]

    -- Advanced _DAMAGE _HEAL _ENERGIZE _DRAIN _LEACH _CAST_SUCCESS
    -- Not Sure _INTERRUPT _DISPEL _DISPEL_FAILED _STOLEN _EXTRA_ATTACKS _AURA_BROKEN _INSTAKILL _DURABILITY_DAMAGE _DURABILITY_DAMAGE_ALL _DISSIPATES
    -- Not Advanced _MISSED _AURA_APPLIED _AURA_REMOVED _CAST_START _AURA_REFRESH _AURA_APPLIED_DOSE _AURA_REMOVED_DOSE _AURA_BROKEN_SPELL _CAST_FAILED _CREATE _SUMMON doesn't have advanced logging data
    local advancedLogEventSuffixes = { "_DAMAGE", "_HEAL", "_ENERGIZE", "_DRAIN", "_LEACH", "_CAST_SUCCESS" }

    local isAdvancedEvent = false

    for key, suffix in pairs(advancedLogEventSuffixes) do
        if eventName:ends(suffix) then
            isAdvancedEvent = true
            break
        end
    end

    -- If the event has advanced logging, then get the spell data, skip the advanced entries, and then populate the remaining data
    if isAdvancedEvent == true then
        -- Spell ID, Spell Name, Spell School
        for i = startIndex, 12 do
            table.insert(eventData, data[i])
        end

        self:parseAfterAdvancedData(13, eventData, data)
    else
        -- Otherwise, pull all of the remaining data into the eventData
        for i = startIndex, #data do
            table.insert(eventData, data[i])
        end
    end
end

function CombatLogConverter:parseSwingData(data)
    -- TODO SWING_MISSED
    --    print("IS_SWING")
end

function CombatLogConverter:parseEnvironmental(data)
    --    print("IS_ENVIRONMENTAL")
end

function CombatLogConverter:parseAfterAdvancedData(startIndex, eventData, data)
    local nextIndex = startIndex + self.advancedLogEntryCount

    -- Everything after the advanced logging entries
    for i = nextIndex, #data do
        table.insert(eventData, data[i])
    end
end