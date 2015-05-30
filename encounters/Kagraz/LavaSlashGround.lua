local LavaSlashGround = WhoDunIt.Mechanic:new(
    WhoDunIt.KAGRAZ_ENCOUNTER_ID,
    "Lava Slash Ground",
    "Don't stand in the lines of fire on the ground.",
    WhoDunIt.Mechanic.PRIORITY_MEDIUM
)

LavaSlashGround.spellId = 155314
-- 155318

-- It should just be SPELL_DAMAGE and SPELL_MISS events. We will see though.
-- Process the event data, and mark fails as they come up.
function LavaSlashGround:processEventData(eventData)
    local eventName = eventData[2]
    if eventName == "SPELL_PERIODIC_DAMAGE" or eventName == "SPELL_PERIODIC_MISSED" then
        local spellId = tonumber(eventData[12])
        if spellId == self.spellId then
            local guid = eventData[8]
            local name = eventData[9]

            local unit = WhoDunIt.Unit:generate(guid, name)
            self:logFail({unit}, nil)
        end
    end
end
