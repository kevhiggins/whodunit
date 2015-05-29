Encounter = {
    id = nil,
    name = nil,
    mechanics = {}
}

function Encounter:new(id, name)
    o = {}
    setmetatable(o, self)
    self.__index = self
    o.id = id
    o.name = name
    return o
end

function Encounter:getId()
    return self.id
end

function Encounter:getName()
    return self.name
end

function Encounter:processEventData(eventData)
    for key, mechanic in pairs(self.mechanics) do
        mechanic:processEventData(eventData)
    end
end

function Encounter:registerMechanic(mechanic)
    table.insert(self.mechanics, mechanic)
end