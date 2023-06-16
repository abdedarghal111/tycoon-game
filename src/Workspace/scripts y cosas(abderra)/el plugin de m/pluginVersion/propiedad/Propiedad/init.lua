local IntValue = require(script.IntValue)
local NumberValue = require(script.NumberVaule)
local StringValue = require(script.StringValue)
local ObjectValue = require(script.ObjectValue)

local Propiedad = {}
Propiedad.__index = Propiedad

local events = script.Parent.Parent.events
Propiedad.gui = script.propiedad

function Propiedad:destroy()
	self.panel:Destroy()
end

function Propiedad:is(instance)
	if self.propiedad == instance then
		return true
	end
end

function Propiedad:getValue(Value)
	return self.instance.Value
end

function Propiedad:setValue(Value)
	self.instance.Value = Value
end

function Propiedad:getText()
	return self.valorMostrado.Text
end

function Propiedad:setText(value)
	self.valorMostrado.Text = value
end

function Propiedad:getName()
	return self.instance.Name
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

	self.panel.Parent = events.getPropiedades:Invoke()
	self.textoMostrado.Text = tostring("test(",instance.ClassName,")")
	self.valorMostrado.PlaceholderText = "insert value"
	self.valorMostrado.Text = "test"
	
	self.textoMostrado.Text = instance.Name.."("..instance.ClassName:sub(1,-6)..")"
	
	
	if instance.ClassName == "IntValue" then
		IntValue.aplyClassOn(self,instance)
	elseif instance.ClassName == "NumberValue" then
		NumberValue.aplyClassOn(self,instance)
	elseif instance.ClassName == "StringValue" then
		StringValue.aplyClassOn(self,instance)
	elseif instance.ClassName == "ObjectValue" then
		ObjectValue.aplyClassOn(self,instance)
	else
		setmetatable(self,Propiedad)
	end
	
	if self.onTextChanged then
		self.valorMostrado.FocusLost:Connect(self.onTextChanged)
	else
		self.valorMostrado.FocusLost:Connect(function()
			print("text changed")
		end)
	end
	
	return self
end


setmetatable(IntValue,Propiedad)
setmetatable(StringValue,Propiedad)
setmetatable(NumberValue,Propiedad)
setmetatable(ObjectValue,Propiedad)
return Propiedad