local Selector = require(script.Selector)

local ObjectValue = {}
ObjectValue.__index = ObjectValue

local events = script.Parent.Parent.Parent:WaitForChild("events")
local mesMan = require(script.Parent.Parent.Parent.messageManager)

function ObjectValue:destroy()
	self.panel:Destroy()
	self.selector:Destroy()
end

function ObjectValue.aplyClassOn(propiedad,instance)
	
	propiedad.selector = Selector.new(propiedad)

	propiedad.onTextChanged = function()
		--empty
	end
	
	propiedad.valorMostrado.Focused:Connect(function()
		propiedad.valorMostrado:ReleaseFocus()
		propiedad.valorMostrado.Text = "(selecting...)"
		local model = propiedad.selector:select()
		
		if model then
			propiedad:setValue(model)
			propiedad:setText(model.Name)
			propiedad.selector:setSelected(model)
			mesMan.printMessageGsub(6,model.Name,propiedad:getName())
		else
			propiedad:setText(propiedad:getValue() and propiedad:getValue().Name or "nil")
			propiedad.selector:setSelected(propiedad:getValue())
			mesMan.warnMessage(9)
		end
	end)
	
	
	propiedad.valorMostrado.Text = instance.Value ~= nil and instance.Value.Name or "nil"


	setmetatable(propiedad,ObjectValue)

	return propiedad
end



return ObjectValue