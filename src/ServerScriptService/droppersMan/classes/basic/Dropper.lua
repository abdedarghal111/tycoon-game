local Drop = require(script.Parent.Drop)
local Interactable = require(script.Parent.Parent.primitive.Interactable)
local TimedRequests = require(script.Parent.Parent.primitive.TimedRequests)
local InformationalGui = require(script.Parent.Parent.primitive.InformationalGui)

local Dropper = {}
Dropper.__index = Dropper
Dropper.type = "Dropper"
Dropper.MODEL = script.Parent.Parent.models.Dropper

function Dropper:drop()
	Drop.new(self)
end

function Dropper:startWorking()
	self.DROPREQUEST:add()
end

function Dropper:stopWorking()
	self.DROPREQUEST:remove()
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
	self.INFORMATIONALGUI = InformationalGui.new(self.MODEL)
	
	self.INFORMATIONALGUI:write("Money per drop: "..self.value)
	
	setmetatable(self,Dropper)
	return self
end


return Dropper