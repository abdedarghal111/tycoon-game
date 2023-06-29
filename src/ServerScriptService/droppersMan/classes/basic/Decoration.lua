local Interactable = require(script.Parent.Parent.primitive.Interactable)

local Decoration = {}
Decoration.__index = Decoration
Decoration.type = "Decoration"

function Decoration:buy()
	self:show()
end

function Decoration.new(model,player)
    local self = Interactable.new(model,player)

    --TODO: plantearse para qué mas adelante

    return setmetatable(self,Decoration)
end
setmetatable(Decoration,Interactable)
return Decoration