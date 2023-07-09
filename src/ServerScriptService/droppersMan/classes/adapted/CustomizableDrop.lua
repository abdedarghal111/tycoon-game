local Drop = require(script.Parent.Parent.basic.Drop)

local CustomizableDrop = {}
CustomizableDrop.__index = CustomizableDrop

function CustomizableDrop:setState(state)
    if self.state then
        for i,v in pairs(self.DECORATION["fase "..self.state]:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 1
            end
        end
    end
    for i,v in pairs(self.DECORATION["fase "..state]:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 0
        end
    end
    self.state = state
end

function CustomizableDrop.new(dropper)
    local self = Drop.new(dropper)

    self.state = nil
    self.DECORATION = self.MODEL.decoracion

    return setmetatable(self,CustomizableDrop)
end

setmetatable(CustomizableDrop,Drop)
return CustomizableDrop