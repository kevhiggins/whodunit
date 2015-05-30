local Mechanic = {
    id = nil,
    encounter = nil,
    name = nil,
    description = nil,
    priority = nil,
    PRIORITY_CRITICAL = 1,
    PRIORITY_HIGH = 2,
    PRIORITY_MEDIUM = 3,
    PRIORITY_LOW = 4
}
Mechanic.__index = Mechanic
local instanceCount = 0;

function Mechanic:new(encounterId, name, description, priority)
    local o = {}
    setmetatable(o, self)

    o.name = name
    o.description = description
    o.priority = priority

    o.encounter = WhoDunIt.eventManager:registerMechanic(encounterId, o)

    instanceCount = instanceCount + 1
    o.id = instanceCount

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

function Mechanic:logFail(unitList, data)
    local fail = WhoDunIt.Fail:new(self, unitList, data)
    WhoDunIt.failManager:logFail(fail)
end

WhoDunIt.Mechanic = Mechanic