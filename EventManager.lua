local EventManager = {
    encounters = {},
    activeEncounter = nil,
    attemptId = 0
}

function EventManager:processEventData(eventData)
    -- If no active encounter, check to see if one is starting. If there is an active encounter, check if it has ended.
    -- If the encounter has no ended, process the event data for the active encounter.

    if self.activeEncounter ~= nil then
        self.activeEncounter:processEventData(eventData)
    end
--
--    if self.activeEncounter == nil then
--        if self:isEncounterStart(eventData) == true then
--            self.attemptId = self.attemptId + 1
--        end
--    else
--        if self:isEncounterEnd(eventData) == false then
--            self.activeEncounter:processEventData(eventData)
--        end
--    end
end

-- TODO alter how code indexes the activeEncounter
-- TODO setup end encounter like start encounter
-- Todo setup the test script to call start encounter when the event is found in the log
-- {encounterId, encounterName, difficultyID, raidSize}
function EventManager:startEncounter(eventName, ...)
    print(inspect(self))
    print(eventName)
    os.exit()
    local encounterId = ...
    encounterId = tonumber(encounterId)
    local encounter = self.encounters[encounterId]

    if (encounter ~= nil) then
        self.activeEncounter = encounter
        return true
    end
    return false
end

function EventManager:endEncounter(eventData)
    local eventName = eventData[2]
    if eventName == "ENCOUNTER_END" and self.activeEncounter:getId() == tonumber(eventData[3]) then
        self.activeEncounter = nil
        return true
    end
    return false
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