local Dropper = require(script.Parent.Parent.basic.Dropper)
local CustomizableDrop = require(script.Parent.CustomizableDrop)
local Animation = require(script.Parent.Parent.primitive.Animation)
local GFX = require(script.Parent.Parent.primitive.GFX)

local AnimatedDropper = {}
AnimatedDropper.__index = AnimatedDropper

function Dropper:drop()
    self.ANIMATION:play("aboutToDrop")
    local drop = CustomizableDrop.new(self)
    self.ANIMATION:play("dropped")
    drop:anchorIn(self.WHERETOANCHOR)
    self.ANIMATION:play("dropAnchored")
    drop:unanchor()
    self.ANIMATION:play("dropUnanchored")
end

function AnimatedDropper.new(model,player)
    local self = Dropper.new(model,player)

    self.ANIMATION = Animation.new(self.MODEL.animacion)

    return setmetatable(self,AnimatedDropper)
end

setmetatable(AnimatedDropper,Dropper)
return AnimatedDropper