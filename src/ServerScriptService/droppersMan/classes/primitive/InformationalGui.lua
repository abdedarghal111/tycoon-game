local InformationalGui = {}
InformationalGui.__index = InformationalGui
InformationalGui.type = "InformationalGui"
InformationalGui.MODEL = script.Parent.models.InformationalGui

function InformationalGui:write(text)
    self.MODEL.text.Text = text
end

function InformationalGui:erase()
    self.MODEL.text.Text = ""
end

function InformationalGui:hide()
    self.MODEL.Enabled = false
end

function InformationalGui:show()
    self.MODEL.Enabled = true
end



function InformationalGui.new(instance)
    local self = {}
    self.MODEL = InformationalGui.MODEL:Clone()
    self.ASOCIATEDTO = instance
    self.type = InformationalGui.type
    self.MODEL.Parent = instance

    return setmetatable(self,InformationalGui)
end

return InformationalGui