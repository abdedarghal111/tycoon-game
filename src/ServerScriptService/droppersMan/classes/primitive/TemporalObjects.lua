local TemporalObjects = {}
TemporalObjects.__index = TemporalObjects

function TemporalObjects.new()
    local self = {}

    return setmetatable(self,TemporalObjects)
end

return TemporalObjects