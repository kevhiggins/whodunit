local Unit = {
    guid = nil,
    name = nil
}

local activeUnits = {}

function Unit:new(guid, name)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.guid = guid
    o.name = name

    return o
end

function Unit:generate(guid, name)
    if activeUnits[guid] == nil then
        activeUnits[guid] = Unit:new(guid, name)
    end
    return activeUnits[guid]
end

function Unit:find(guid)
    if activeUnits[guid] == nil then
        return nil
    end
    return activeUnits[guid]
end

WhoDunIt.Unit = Unit


