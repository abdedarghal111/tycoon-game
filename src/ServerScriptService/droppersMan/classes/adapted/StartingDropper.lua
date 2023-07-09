local Dropper = require(script.Parent.Parent.basic.Dropper)
local CustomizableDrop = require(script.Parent.CustomizableDrop)

local StartingDropper = {}
StartingDropper.__index = StartingDropper

function Dropper:drop()
	local drop = CustomizableDrop.new(self)
    drop:setState(1)
end

function StartingDropper.new(model,player)
    local self = Dropper.new(model,player)

    return setmetatable(self,StartingDropper)
end

setmetatable(StartingDropper,Dropper)
return StartingDropper