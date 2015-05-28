FailManager = {}

function FailManager:new(name)
    o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function FailManager:logFail(mechanic, guidList, data)
end