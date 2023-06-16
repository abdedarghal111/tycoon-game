local Propiedad = {}
Propiedad.__index = Propiedad

Propiedad.gui = script.propiedad
Propiedad.guiParent = script.parent

function Propiedad:destroy()
	self.panel:Destroy()
end

function Propiedad:is(instance)
	if self.propiedad == instance then
		return true
	end
end

function Propiedad:setEvent(event)
	self.onTextChanged = self.valorMostrado.FocusLost:Connect(event)
end

function Propiedad.new(instance)
	local self = {}

	self.panel = Propiedad.gui:Clone()
	self.valorMostrado = self.panel.value
	self.textoMostrado = self.panel.text
	self.instance = instance

	self.onTextChanged = function() print("thats void") end

	self.panel.Parent = Propiedad.guiParent
	self.textoMostrado.Text = instance.Name..": "..instance.Value.."("..instance.ClassName..")"
	self.valorMostrado.PlaceholderText = "insert value"

	self.valorMostrado.FocusLost:Connect(self.onTextChanged)

	return setmetatable(self,Propiedad)
end



return Propiedad