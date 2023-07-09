local Multiplier = require(script.Parent.Parent.basic.Multiplier)
local Animation = require(script.Parent.Parent.primitive.Animation)

local AnimatedMultiplier = {}
AnimatedMultiplier.__index = AnimatedMultiplier

function AnimatedMultiplier:onDropDetected(drop)
    drop:setState(self.STATETOCHANGE)
    self.ANIMATION:play("dropDetected")
end


function AnimatedMultiplier:show()
    Multiplier.show(self)
    self.ANIMATION:showModel()
    Multiplier.hide(self)
end

function AnimatedMultiplier:hide()
    self.ANIMATION:hideModel()
end



function AnimatedMultiplier.new(model,player)
    local self = Multiplier.new(model,player)

    self.ANIMATION = Animation.new(self.MODEL.animacion)
    self.STATETOCHANGE = self.MODEL["fase a cambiar"].Value

    return setmetatable(self,AnimatedMultiplier)
end

setmetatable(AnimatedMultiplier,Multiplier)
return AnimatedMultiplier