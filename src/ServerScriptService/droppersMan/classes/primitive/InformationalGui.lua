local InformationalGui = {}
InformationalGui.__index = InformationalGui
InformationalGui.type = "InformationalGui"
InformationalGui.MODEL = script.Parent.models.InformationalGui

function InformationalGui:write(text)
    self.TEXT.Text = text
end

function InformationalGui:erase()
    self.Text = ""
end


function InformationalGui.new(instance)
    local self = {}
    self.MODEL = InformationalGui.MODEL:Clone()
    self.TEXT = self.MODEL.text
    self.ASOCIATEDTO = instance
    self.type = InformationalGui.type

    self.Model.Parent = instance

    return setmetatable(self,InformationalGui)
end

return InformationalGui