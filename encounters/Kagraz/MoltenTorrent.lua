local MoltenTorrent = WhoDunIt.Mechanic:new(WhoDunIt.KAGRAZ_ENCOUNTER_ID,
    "Molten Torrent",
    "Avoid walking through the fiery link that connects the wolves.",
    WhoDunIt.Mechanic.PRIORITY_CRITICAL)

local SPELL_AURA_ID = 154932
local SPELL_ID = 154938

local activeTorrentData

--local active
function MoltenTorrent:processEventData(eventData)
    local eventName = eventData[2]
    if eventName == "SPELL_AURA_REMOVED" then
        local spellId = tonumber(eventData[12])
        if spellId == SPELL_AURA_ID then
            local timestamp = eventData[1]
            local guid = eventData[8]
            local name = eventData[9]
            local unit = WhoDunIt.Unit:generate(guid, name)

            -- Create a new torrent data item. We will add the hits to this as the come in.
            activeTorrentData = {timestamp = timestamp, hits = {}}
            self:logFail({ unit }, activeTorrentData)
        end
    elseif eventName == "SPELL_DAMAGE" or eventName == "SPELL_MISSED" then
        local spellId = tonumber(eventData[12])
        if spellId == SPELL_ID then
            local guid = eventData[8]
            local name = eventData[9]
            local unit = WhoDunIt.Unit:generate(guid, name)
            table.insert(activeTorrentData.hits, { unit = unit })
        end
    end
end

function MoltenTorrent:render(failGroup)
    for key, fail in pairs(failGroup:getFails()) do
        print(fail.unitList[1].name .. " - " .. #fail.data.hits)
    end;
end