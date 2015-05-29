EventManager = {
    encounters = {},
    activeEncounter = nil
}

function EventManager:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function EventManager:processEventData(eventData)
    -- If no active encounter, check to see if one is starting. If there is an active encounter, check if it has ended.
    -- If the encounter has no ended, process the event data for the active encounter.
    if self.activeEncounter == nil then
        self:isEncounterStart(eventData)
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
        print("END")
        self.activeEncounter = nil
        return true
    end
    return false
end

function EventManager:registerEncounter(encounter)
    self.encounters[encounter:getId()] = encounter
end