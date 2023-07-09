local Multiplier = require(script.Parent.Parent.basic.Multiplier)

local StarterMultiplierFase2 = {}
StarterMultiplierFase2.__index = StarterMultiplierFase2

function StarterMultiplierFase2:onDropDetected(drop)
    drop:setState(3)
end

function StarterMultiplierFase2.new(model,player)
    local self = Multiplier.new(model,player)

    return setmetatable(self,StarterMultiplierFase2)
end

setmetatable(StarterMultiplierFase2,Multiplier)
return StarterMultiplierFase2