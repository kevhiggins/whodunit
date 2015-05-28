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

function Encounter:registerMechanic(mechanic)
    table.insert(self.mechanics, mechanic)
end