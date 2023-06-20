local runServ = game:GetService("RunService")

local Request = require(script.Request)

local requests = {}


runServ.Heartbeat:Connect(function()
	for _,request in pairs(requests) do
		request:update()
	end
end)

local addFunction = script:FindFirstChild("addFunction") or Instance.new("BindableFunction",script)
addFunction.Name = "addFunction"
local removeFunction = script:FindFirstChild("removeFunction") or Instance.new("BindableEvent",script)
removeFunction.Name = "removeFunction"

addFunction.OnInvoke = function(object,cooldown,function_)
	local request = Request.new(object,cooldown,function_)
	table.insert(requests,request)
	
	return request
end

removeFunction.Event:Connect(function(request)
	table.remove(requests,request)
end)