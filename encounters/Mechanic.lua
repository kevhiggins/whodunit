local Mechanic = {
    id = nil,
    instanceCount = 0,
    encounter = nil,
    name = nil,
    description = nil,
    priority = nil,
    PRIORITY_CRITICAL = 1,
    PRIORITY_HIGH = 2,
    PRIORITY_MEDIUM = 3,
    PRIORITY_LOW = 4
}

function Mechanic:new(encounterId, name, description, priority)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.name = name
    o.description = description
    o.priority = priority

    o.encounter = WhoDunIt.eventManager:registerMechanic(encounterId, o)

    self.instanceCount = self.instanceCount + 1
    o.id = self.instanceCount

    return o
end

function Mechanic:getId()
    return self.id
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

-- The priority used for determining how important it is to not fail this mechanic.
function Mechanic:getPriority()
    return self.priority
end

-- Process the event data, and mark fails as they come up.
function Mechanic:processEventData(eventData)
    error("This method needs to be implemented")
end

function Mechanic:logFail(guidList, data)
    local fail = WhoDunIt.Fail:new(self, guidList, data)
    WhoDunIt.failManager:logFail(fail)
end

WhoDunIt.Mechanic = Mechanic