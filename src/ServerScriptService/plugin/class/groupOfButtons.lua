local GroupOfButtons = {}
GroupOfButtons.__index = GroupOfButtons

local Button = require(script.Parent.Button)
local hf = require(script.Parent.Parent.helpFunctions)

function GroupOfButtons:create(selection: Selection)
    if self:isCreated() then self:clean() end
    if #selection:Get() > 1 then warn("More than 1 instance selected.") return end
    local selected = selection:Get()[1]
    if not hf:isAButton(selected) then
        warn([[
            The instance you selected is not a button.
        ]])
    else
        self.headButton = Button.new(selected)
    end
end

function GroupOfButtons:isCreated()
    return self.headButton and true or false
end

function GroupOfButtons:clean()
    self.headButton:destroy()
    self.headButton = nil
end

function GroupOfButtons.new()
    local self = {
        headButton = nil
    }

    return setmetatable(self,GroupOfButtons)
end

return GroupOfButtons.new()