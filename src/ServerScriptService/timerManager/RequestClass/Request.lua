local Request = {}
Request.__index = Request

function Request:update()
	if tick() - self.tick > self.cooldown then
		self.FUNCTION()
		self.tick = tick()
	end
end

function Request:changeCooldown(newCooldown)
	 self.cooldown = newCooldown
end

function Request.new(object,cooldown,function_)
	local request = {}
	
	request.OBJECT = object
	request.FUNCTION = function_
	request.cooldown = cooldown
	request.tick = tick()
	
	setmetatable(request,Request)
	return request
end


return Request