local Fail = {
    mechanic = nil,
    guidList = nil,
    data = nil
}

function Fail:new(mechanic, guidList, data)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.mechanic = mechanic
    o.guidList = guidList
    o.data = data

    return o
end

WhoDunIt.Fail = Fail


