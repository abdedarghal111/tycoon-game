local Propiedad = {}
Propiedad.__index = Propiedad
Propiedad.gui = script.propiedad
Propiedad.guiParent = script.Parent.Parent

function Propiedad.new()
	local self  = {}
	
	self._gui = Propiedad.gui:Clone()
	self._value = self._gui.value
	self._text = self._gui.text
	
	self.onTextChanged = nil
	
	self._gui.Parent = Propiedad.guiParent
	
	self._value.FocusLost:Connect(self.onTextChanged)
	
	return setmetatable(self,Propiedad)
end



return Propiedad