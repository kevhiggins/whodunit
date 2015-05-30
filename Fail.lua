local Fail = {
    mechanic = nil,
    unitList = nil,
    data = nil
}

function Fail:new(mechanic, unitList, data)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.mechanic = mechanic
    o.unitList = unitList
    o.data = data

    return o
end

WhoDunIt.Fail = Fail


