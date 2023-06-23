local addFunctionFunction = script.Parent.Parent.timerManager.addFunction
local removeFunctionEvent = script.Parent.Parent.timerManager.removeFunction


--TODO: modificar esto también
local Cube = require(script.Parent.Cube)

local Interactable = require(script.Parent.Parent.primitive.Interactable)
local TimedRequests = require(script.Parent.Parent.primitive.TimedRequests)

local Dropper = {}
Dropper.__index = Dropper
Dropper.MODEL = script.Parent.Parent.models.Dropper

function Dropper:drop()
	Cube.new(self.SPAWN,self,self.OWNER)
end

function Dropper:startWorking()
	if not self.cooldownRequest then
		self.DROPREQUEST:add()
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

function Dropper:getCooldown()
	return self.cooldown
end



function Dropper.new(model,player)
	local self = Interactable.new(model,player)
	
	self.SPAWN = model.generador
	self.value = model:FindFirstChild("Valor") and model.valor.Value or Dropper.MODEL.valor.Value
	self.cooldown =  model:FindFirstChild("enfriamiento") and model.enfriamiento.Value or Dropper.MODEL.enfriamiento.Value

	self.DROPREQUEST = TimedRequests.new(self,self.drop,self)
	
	if model.generador:FindFirstChild("board") then
		model.generador.board.text.Text = "Value: "..self.value
	end
	
	setmetatable(self,Dropper)
	return self
end


return Dropper