local FailGroup = {
    mechanic = nil,
    fails = {}
}

function FailGroup:new(mechanic)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.mechanic = mechanic

    return o
end

function FailGroup:getMechanic()
    return self.mechanic
end

function FailGroup:addFail(fail)
    table.insert(self.fails, fail)
end

function FailGroup:getFails()
    return self.fails
end

WhoDunIt.FailGroup = FailGroup


