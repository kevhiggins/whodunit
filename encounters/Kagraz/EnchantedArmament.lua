local EnchantedArmament = Mechanic:new(Kagraz,
    "Enchanted Armament",
    "Avoid spinning swords that float in the air and deal damage in an area of effect by casting Unquenchable Flame.")

EnchantedArmament.spellId = 156713

-- It should just be SPELL_DAMAGE and SPELL_MISS events. We will see though.
-- Process the event data, and mark fails as they come up.
function EnchantedArmament:processEventData(eventData)
    local eventName = eventData[2]
    if eventName == "SPELL_DAMAGE" or eventName == "SPELL_MISS" then
        local spellId = tonumber(eventData[12])
        if spellId == self.spellId then
            local target = eventData[9]
            print("HIT - " .. target)
        end
    end
end