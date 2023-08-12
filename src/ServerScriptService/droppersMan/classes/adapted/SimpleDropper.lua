local Dropper = require(script.Parent.Parent.basic.Dropper)
local Drop = require(script.Parent.Parent.basic.Drop)
local GFX = require(script.Parent.Parent.primitive.GFX)

local SimpleDropper = {}
SimpleDropper.__index = SimpleDropper

function SimpleDropper:drop()
	local drop = Drop.new(self)
    self.GFX:play("onDrop")
end

function SimpleDropper.new(model,player)
    local self = Dropper.new(model,player)

    self.GFX = GFX.new(self.MODEL)

    return setmetatable(self,SimpleDropper)
end

setmetatable(SimpleDropper,Dropper)
return SimpleDropper