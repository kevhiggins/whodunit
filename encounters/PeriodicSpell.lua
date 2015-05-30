local PeriodicSpell = {}
PeriodicSpell.__index = PeriodicSpell
setmetatable(PeriodicSpell, WhoDunIt.Spell)

function PeriodicSpell:new(encounterId, name, description, priority, id)
    local o = WhoDunIt.Spell.new(self, encounterId, name, description, priority, id)
    setmetatable(o, PeriodicSpell)
    return o
end

function PeriodicSpell:processEventData(eventData)
    local eventName = eventData[2]
    if eventName == "SPELL_PERIODIC_DAMAGE" or eventName == "SPELL_PERIODIC_MISSED" then
        local spellId = tonumber(eventData[12])
        if spellId == self.id then
            local guid = eventData[8]
            local name = eventData[9]

            local unit = WhoDunIt.Unit:generate(guid, name)
            self:logFail({unit}, nil)
        end
    end
end

WhoDunIt.PeriodicSpell = PeriodicSpell