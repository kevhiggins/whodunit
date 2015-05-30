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
    if eventName == "SPELL_DAMAGE" or eventName == "SPELL_MISS" then
        local spellId = tonumber(eventData[12])
        if spellId == self.id then
            local guid = eventData[8]
            local name = eventData[9]

            local unit = WhoDunIt.Unit:generate(guid, name)
            self:logFail({unit}, nil)
        end
    end
end

WhoDunIt.Spell = Spell

