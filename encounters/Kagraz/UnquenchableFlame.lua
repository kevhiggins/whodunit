local UnquenchableFlame = WhoDunIt.Mechanic:new(
    WhoDunIt.KAGRAZ_ENCOUNTER_ID,
    "Unquenchable Flame",
    "Avoid spinning swords that float in the air and deal damage in an area of effect.",
    WhoDunIt.Mechanic.PRIORITY_MEDIUM
)

UnquenchableFlame.spellId = 156713

-- It should just be SPELL_DAMAGE and SPELL_MISS events. We will see though.
-- Process the event data, and mark fails as they come up.
function UnquenchableFlame:processEventData(eventData)
    local eventName = eventData[2]
    if eventName == "SPELL_DAMAGE" or eventName == "SPELL_MISS" then
        local spellId = tonumber(eventData[12])
        if spellId == self.spellId then
            local guid = eventData[8]
            local name = eventData[9]

            local unit = WhoDunIt.Unit:generate(guid, name)
            self:logFail({unit}, nil)
        end
    end
end