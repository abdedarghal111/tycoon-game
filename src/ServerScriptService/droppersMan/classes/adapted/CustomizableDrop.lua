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
    else
        for i,v in pairs(self.DECORATION:GetChildren()) do
            if v.Name == "fase "..state then continue end
            for i,v in pairs(v:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Transparency = 1
                end
            end
        end
    end
    for i,v in pairs(self.DECORATION["fase "..state]:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 0
        end
    end
    --print("from state "..tostring(self.state).." to "..state)
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