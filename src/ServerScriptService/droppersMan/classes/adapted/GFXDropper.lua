local Dropper = require(script.Parent.Parent.basic.Dropper)
local CustomizableDrop = require(script.Parent.CustomizableDrop)
local Animation = require(script.Parent.Parent.primitive.Animation)
local GFX = require(script.Parent.Parent.primitive.GFX)

local GFXDropper = {}
GFXDropper.__index = GFXDropper

function Dropper:drop()
    self.GFX:play("aboutToDrop")
    local drop = CustomizableDrop.new(self)
    drop:setState(1)
    self.GFX:play("dropped")
    drop:anchorIn(self.WHERETOANCHOR)
    self.GFX:play("dropAnchored")
    drop:unanchor()
    self.GFX:play("dropUnanchored")
end

function GFXDropper.new(model,player)
    local self = Dropper.new(model,player)

    self.GFX = GFX.new(self.MODEL)
    self.WHERETOANCHOR = self.MODEL.generador.CFrame
    --print(self.WHERETOANCHOR)

    return setmetatable(self,GFXDropper)
end

setmetatable(GFXDropper,Dropper)
return GFXDropper