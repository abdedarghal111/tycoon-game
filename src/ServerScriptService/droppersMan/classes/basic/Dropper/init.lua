local addFunctionFunction = script.Parent.Parent.timerManager.addFunction
local removeFunctionEvent = script.Parent.Parent.timerManager.removeFunction

local Cube = require(script.Cube)

local Dropper = {}
Dropper.__index = Dropper

function Dropper:hide()
	for i,v in pairs(self.DECORATION:GetDescendants()) do
		v.Transparency = 1
		v.CanCollide = false
		v.CanQuery = false
		v.CanTouch = false
	end
end

function Dropper:show()
	for i,v in pairs(self.DECORATION:GetDescendants()) do
		v.Transparency = 0
		v.CanCollide = true
		v.CanQuery = false
		v.CanTouch = false
	end
end

function Dropper:drop()
	Cube.new(self.SPAWN,self,self.OWNER)
end

function Dropper:startWorking()
	if not self.cooldownRequest then
		self.cooldownRequest = addFunctionFunction:Invoke(self,self.cooldown,function()
			self:drop()
		end)
	end
end

function Dropper:stopWorking()
	if self.cooldownRequest then
		removeFunctionEvent:Fire()
		self.cooldownRequest = nil
	end
end

function Dropper:buy()
	self:show()
	self:startWorking()
end


function Dropper.new(model,player)
	local dropper = {}
	
	dropper.MODEL = model
	dropper.DECORATION = model.decoracion
	dropper.SPAWN = model.generador
	dropper.OWNER = model.jugador.Value
	dropper.value = model.valor.Value
	dropper.cooldown = model.enfriamiento.Value
	dropper.cooldownRequest = nil
	
	model.generador.board.text.Text = "Value: "..dropper.value
	
	setmetatable(dropper,Dropper)
	return dropper
end


return Dropper