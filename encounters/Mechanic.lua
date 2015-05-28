Mechanic = {
    encounter = nil,
    name = nil,
    description = nil
}

function Mechanic:new(encounter, name, description)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.encounter = encounter
    o.name = name
    o.description = description

    encounter:registerMechanic(o)

    return o
end

function Mechanic:getEncounter()
    return self.encounter
end

function Mechanic:getName()
    return self.name
end

function Mechanic:getDescription()
    return self.description
end

-- Process the event data, and mark fails as they come up.
function Mechanic:processEventData(eventData)
    error("This method needs to be implemented")
end

