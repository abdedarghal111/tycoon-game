local runServ = game:GetService("RunService")

local TimedRequests = {}
TimedRequests.__index = TimedRequests
TimedRequests.type = "TimeRequest"
TimedRequests.requests = {}

function TimedRequests:update()
	if tick() - self.tick > self.OBJECT.cooldown then
		self.tick = tick()
		self.OBJECT[self.FUNCTION](self.FUNCTIONARGS)
	end
end

function TimedRequests:add()
	if not table.find(TimedRequests.requests,self) then
		table.insert(TimedRequests.requests,self)
	end
end

function TimedRequests:remove()
	if table.find(TimedRequests.requests,self) then
		table.remove(TimedRequests,self)
	end
end


function TimedRequests.new(object,_function,...)
	local self = {}
	
	--TODO:Testear la clase primitiva esta para ver si funciona
	self.OBJECT = object
	self.FUNCTION = _function
	self.FUNCTIONARGS = ...
	self.type = TimedRequests.type
	self.tick = tick()
	
	setmetatable(self,TimedRequests)
	return self
end

runServ.Heartbeat:Connect(function()
	for _,request in pairs(TimedRequests.requests) do
		request:update()
	end
end)

return TimedRequests