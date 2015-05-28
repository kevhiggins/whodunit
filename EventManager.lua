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
    local eventName = eventData[2]

    -- Check to see if an encounter is starting. If so, set it as the active encounter
    if self.activeEncounter == nil then
        -- If no encounter is active, then see if one is starting
        if eventName == "ENCOUNTER_START" then
            local encounterId = eventData[3]
            local encounter = self.encounters[encounterId]
            if (encounter ~= nil) then
                self.activeEncounter = encounter
            end
            -- That's it. You can be done.
        end
    else
        -- If the active encounter is over, then set it to nil
        if eventName == "ENCOUNTER_END" and self.activeEncounter:getId() == eventData[3] then
            self.activeEncounter = nil
        else
            -- Using the activeEncounter, test the log data for fails
        end
    end
end

function EventManager:registerEncounter(encounter)
    self.encounters[encounter:getId()] = encounter
end

-- writeFail
-- FailDetails (Mechanic specific page)