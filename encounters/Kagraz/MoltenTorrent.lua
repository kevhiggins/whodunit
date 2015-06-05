local MoltenTorrent = WhoDunIt.Mechanic:new(WhoDunIt.KAGRAZ_ENCOUNTER_ID,
    "Molten Torrent",
    "Avoid walking through the fiery link that connects the wolves.",
    WhoDunIt.Mechanic.PRIORITY_CRITICAL)

local SPELL_AURA_ID = 154932
local SPELL_ID = 154938
local TORRENT_DEATH_THRESHOLD = 1

local activeTorrentData


--local active
-- TODO make sure being immune still splits damage
function MoltenTorrent:processEventData(eventData)
    local eventName = eventData[2]
    -- TODO Bug SPELL_AURA_REMOVED sometimes happens after the damage
    if eventName == "SPELL_CAST_SUCCESS" then
        -- Track the player who was originally targeted by molten torrent
        local spellId = tonumber(eventData[12])
        if spellId == SPELL_AURA_ID then
            local guid = eventData[8]
            local name = eventData[9]
            local unit = WhoDunIt.Unit:generate(guid, name)

            -- Create a new torrent data item. We will add the hits to this as the come in.
            activeTorrentData = { hits = {}, deaths = {} }
            self:logFail({ unit }, activeTorrentData)
        end
    elseif eventName == "SPELL_DAMAGE" or eventName == "SPELL_MISSED" then
        -- Track all players who were hit by molten torrent
        local spellId = tonumber(eventData[12])
        if spellId == SPELL_ID then
            local timestamp = eventData[1]
            local guid = eventData[8]
            local name = eventData[9]
            local unit = WhoDunIt.Unit:generate(guid, name)
            table.insert(activeTorrentData.hits, { timestamp = timestamp, unit = unit })
        end
    elseif eventName == "UNIT_DIED" then
        -- If a unit that got hit by molten torrent died soon after, then mark the death.
        local timestamp = eventData[1]
        local guid = eventData[8]
        local name = eventData[9]
        local unitWasHit = false

        if activeTorrentData ~= nill then
            local torrentTimestamp
            for key, hit in pairs(activeTorrentData.hits) do
                if hit.unit.guid == guid then
                    unitWasHit = true
                    torrentTimestamp = hit.timestamp
                    break
                end
            end
            if unitWasHit and math.abs(timestamp - torrentTimestamp) < TORRENT_DEATH_THRESHOLD then
                local unit = WhoDunIt.Unit:generate(guid, name)
                table.insert(activeTorrentData.deaths, unit)
            end
        end
    end
end

function MoltenTorrent:render(failGroup)
    local output = ""
    for key, fail in pairs(failGroup:getFails()) do
        local wasFatal = #fail.data.deaths > 0
        local fatalString = ""
        if wasFatal then
            fatalString = "X"
        end

        output = output .. fatalString .. " " .. fail.unitList[1].name .. " - " .. #fail.data.hits .. WhoDunIt.eol
    end
    return output
end