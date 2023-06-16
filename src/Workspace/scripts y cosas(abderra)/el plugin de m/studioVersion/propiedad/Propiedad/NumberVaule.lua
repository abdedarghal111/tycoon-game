local NumberValue = {}
NumberValue.__index = NumberValue

local events = script.Parent.Parent.Parent:WaitForChild("events")
local messageManager = require(script.Parent.Parent.Parent.messageManager)

function NumberValue.aplyClassOn(propiedad,instance)

	propiedad.onTextChanged = function()
		local output = propiedad:getText()
		local number = tonumber(output)
		if number then
			propiedad:setValue(number)
			messageManager.printMessageGsub(6,number,propiedad:getName())
		else
			propiedad:setText(propiedad:getValue())
			messageManager.warnMessageGsub(5,output)
		end
	end

	propiedad.valorMostrado.Text = tostring(instance.Value)


	setmetatable(propiedad,NumberValue)

	return propiedad
end



return NumberValue