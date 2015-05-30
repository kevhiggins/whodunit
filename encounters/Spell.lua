local Spell = {
    id = nil
}
Spell.__index = Spell
setmetatable(Spell, WhoDunIt.Mechanic)

function Spell:new(encounterId, name, description, priority, id)
    local o = WhoDunIt.Mechanic.new(self, encounterId, name, description, priority)
    setmetatable(o, Spell)
    o.id = id
    return o
end

-- Process the event data, and mark fails as they come up.
-- TODO consider merging this logic with SPELL_PERIODIC
function Spell:processEventData(eventData)
    local eventName = eventData[2]
    if eventName == "SPELL_DAMAGE" or eventName == "SPELL_MISSED" then
        local spellId = tonumber(eventData[12])
        if spellId == self.id then
            local guid = eventData[8]
            local name = eventData[9]

            local unit = WhoDunIt.Unit:generate(guid, name)
            self:logFail({unit}, nil)
        end
    end
end

function Spell:render(failGroup)
    local unitFails = {}
    for key, fail in pairs(failGroup:getFails()) do
        for key, unit in pairs(fail.unitList) do
            if unitFails[unit.guid] == nill then
                unitFails[unit.guid] = 1
            else
                unitFails[unit.guid] = unitFails[unit.guid] + 1
            end
        end
    end

    -- Print fail summaries for mechanic
    for guid, failCount in pairs(unitFails) do
        local unit = WhoDunIt.Unit:find(guid)
        print(unit.name .. " - " .. failCount)
    end
end

WhoDunIt.Spell = Spell

