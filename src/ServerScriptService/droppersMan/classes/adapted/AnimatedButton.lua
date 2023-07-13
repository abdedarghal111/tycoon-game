local Button = require(script.Parent.Parent.basic.Button)
local GFX = require(script.Parent.Parent.primitive.GFX)

local AnimatedButton = {}
AnimatedButton.__index = AnimatedButton

function AnimatedButton:purchaseEffect()
	self.GFX:play("OnPurchase")
    self:hide()
end

function AnimatedButton:dennyEffect()
	self.GFX:play("OnDenny")
    self:hide()
end

function AnimatedButton.new(model,player)
    local self = Button.new(model,player)

    self.GFX = GFX.new(self.MODEL)

    return setmetatable(self,AnimatedButton)
end

setmetatable(AnimatedButton,Button)
return AnimatedButton