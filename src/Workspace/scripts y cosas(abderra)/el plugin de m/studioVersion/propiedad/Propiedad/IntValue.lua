local IntValue = {}
IntValue.__index = IntValue

local events = script.Parent.Parent.Parent:WaitForChild("events")
local messageManager = require(script.Parent.Parent.Parent.messageManager)

function IntValue.aplyClassOn(propiedad,instance)

	propiedad.onTextChanged = function()
		local output = propiedad:getText()
		local number = tonumber(output)
		if number then
			if number == math.floor(number) then
				propiedad:setValue(number)
				messageManager.printMessageGsub(6,number,propiedad:getName())
			else
				propiedad:setText(propiedad:getValue())
				messageManager.warnMessageGsub(7,output)
			end
		else
			messageManager.warnMessageGsub(5,output)
		end
	end
	
	propiedad.valorMostrado.Text = tostring(instance.Value)
	
	
	setmetatable(propiedad,IntValue)
	
	return propiedad
end



return IntValue