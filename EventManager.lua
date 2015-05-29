local EventManager = {
    encounters = {},
    activeEncounter = nil,
    attemptId = 0
}

function EventManager:processEventData(eventData)
    -- If no active encounter, check to see if one is starting. If there is an active encounter, check if it has ended.
    -- If the encounter has no ended, process the event data for the active encounter.
    if self.activeEncounter == nil then
        if self:isEncounterStart(eventData) == true then
            self.attemptId = self.attemptId + 1
        end
    else
        if self:isEncounterEnd(eventData) == false then
            self.activeEncounter:processEventData(eventData)
        end
    end
end

function EventManager:isEncounterStart(eventData)
    local eventName = eventData[2]
    if eventName == "ENCOUNTER_START" then
        local encounterId = tonumber(eventData[3])
        local encounter = self.encounters[encounterId]

        if (encounter ~= nil) then
            self.activeEncounter = encounter
            return true
        end
    end
    return false
end

function EventManager:isEncounterEnd(eventData)
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