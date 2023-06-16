local StringValue = {}
StringValue.__index = StringValue

local events = script.Parent.Parent.Parent:WaitForChild("events")
local messageManager = require(script.Parent.Parent.Parent.messageManager)

function StringValue.aplyClassOn(propiedad,instance)

	propiedad.onTextChanged = function()
		local output = propiedad:getText()
		if output ~= "" then
			propiedad:setValue(output)
			messageManager.printMessageGsub(6,output,propiedad:getName())
		else
			propiedad:setText(propiedad:getValue())
			messageManager.warnMessageGsub(8,output,propiedad:getName())
		end
	end
	
	propiedad.valorMostrado.Text = tostring(instance.Value)
	
	
	setmetatable(propiedad,StringValue)
	
	return propiedad
end



return StringValue