local tweenServ = game:GetService("TweenService")

local Interactable = require(script.Parent.Parent.primitive.Interactable)
local DecorationInfo = require(script.Parent.Parent.primitive.DecorationInfo)

local Decoration = {}
Decoration.__index = Decoration
Decoration.type = "Decoration"

function Decoration:buy()
	self:show()
end

function Decoration:show()
    for index,part,properties in self.DECORATIONINFO:iterateOverParts() do
        if not properties then continue end
        for property,value in pairs(properties) do
            if type(value) == "number" then
                local info = TweenInfo.new(1)
                local tween = tweenServ:Create(part,info,{[property] = value})
                tween:Play()
            else
                part[property] = value
            end
        end
    end
end

function Decoration:hide()
    self.DECORATIONINFO:setInvisibleAllParts()
end

function Decoration:test()
    for index,part,properties in self.DECORATIONINFO:iterateOverParts() do
        print(index,part.Name,properties)
    end
end



function Decoration.new(model,player)
    local self = Interactable.new(model,player)

    self.DECORATIONINFO = DecorationInfo.new(model:FindFirstChild("Partes de decoracion"))

    return setmetatable(self,Decoration)
end
setmetatable(Decoration,Interactable)
return Decoration