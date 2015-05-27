local WhoDunItBase = {}

function WhoDunItBase:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

print "GRRz"

function WhoDunItBase:processCombatLog(self, event, ...)
    print(line)
end

WhoDunIt = WhoDunItBase:new()