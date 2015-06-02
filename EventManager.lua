local EventManager = {
    encounters = {},
    activeEncounter = nil,
    attemptId = 0
}

function EventManager:processCombatLog(...)
    if self.activeEncounter ~= nil then
        -- TODO consider renaming to processCombatLog
        self.activeEncounter:processEventData({...})
    end
end

-- TODO alter how code indexes the activeEncounter
-- TODO setup end encounter like start encounter
-- Todo setup the test script to call start encounter when the event is found in the log
-- {encounterId, encounterName, difficultyID, raidSize}
function EventManager:startEncounter(encounterID, encounterName, difficultyID, raidSize)
--    print("ENCOUNTER_START")
--    print(encounterID)
--    print(encounterName)
--    print(difficultyID)
--    print(raidSize)

    encounterID = tonumber(encounterID)
    local encounter = self.encounters[encounterID]

    if (encounter ~= nil) then
        self.activeEncounter = encounter
    end
end

function EventManager:endEncounter(encounterID, encounterName, difficultyId, raidSize, endStatus)
--    print("ENCOUNTER_END")
--    print(encounterID)
--    print(encounterName)
--    print(difficultyID)
--    print(raidSize)
--    print(endStatus)

    encounterID = tonumber(encounterID)

    if (self.activeEncounter ~= nil and self.activeEncounter.id == encounterID) then
        self.activeEncounter = nil
    end
end

function EventManager:registerEncounter(encounter)
    self.encounters[encounter:getId()] = encounter
end

-- Registers the mechanic with the encounter corresponding to encounterId. Returns the encounter the mechanic was registered to.
function EventManager:registerMechanic(encounterId, mechanic)
    local encounter = self.encounters[encounterId]
    if encounter == nil then
        error("Could not register mechanic " .. mechanic:getName() .. " for encounter ID " .. encounterId)
    end
    encounter:registerMechanic(mechanic)
    return encounter
end

function EventManager:getAttemptId()
    return self.attemptId
end

WhoDunIt.eventManager = EventManager