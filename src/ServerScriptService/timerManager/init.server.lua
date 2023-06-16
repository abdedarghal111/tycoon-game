local runServ = game:GetService("RunService")

local Request = require(script.Request)

local requests = {}


runServ.Heartbeat:Connect(function()
	for _,request in pairs(requests) do
		request:update()
	end
end)

script.addFunction.OnInvoke = function(object,cooldown,function_)
	local request = Request.new(object,cooldown,function_)
	table.insert(requests,request)
	
	return request
end

script.removeFunction.Event:Connect(function(request)
	table.remove(requests,request)
end)