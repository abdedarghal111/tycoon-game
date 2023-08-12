local ServerScriptService = game:GetService("ServerScriptService")
local Interactable = require(script.Parent.Parent.primitive.Interactable)
local InformationalGui = require(ServerScriptService.droppersMan.classes.primitive.InformationalGui)
local TemporalObjects = require(script.Parent.Parent.primitive.TemporalObjects)

local Multiplier = {}
Multiplier.__index = Multiplier
Multiplier.type = "Multiplier"
Multiplier.super = Interactable

function Multiplier:startWorking()
	if not self.touchEvent then
		self.touchEvent = self.COLIDER.Touched:Connect(function(hit)
			if hit:GetAttribute("type") == TemporalObjects.type then
				self:onTemporalObjectTouch(TemporalObjects.getObject(hit))
			end
		end)
	end
end


function Multiplier:onTemporalObjectTouch(drop)
	if not drop then return end
	self:multiply(drop)
end

function Multiplier:multiply(drop)
	if not drop:isMultipliedBy(self) then
		drop:multiply(self,self.multiplier)
		self:onDropDetected(drop) --para las clases futuras(hay varias clases así)
	end
end

function Multiplier:stopWorking()
	if self.touchEvent then
		self.touchEvent:Disconnect()
		self.touchEvent = nil
	end
end

function Multiplier:onRemovingPlayer()
	self:stopWorking()
	self:hide()
end

function Multiplier:buy()
	self:show()
	self:startWorking()
end


function Multiplier.new(model,player)
	local self = Interactable.new(model,player)
	
	self.MODEL = model
	self.COLIDER = model.colider
	self.multiplier = model.multiplicador.Value
	self.touchEvent = nil
	self.type = Multiplier.type

	self.INFORMATIONALGUI = InformationalGui.new(self.MODEL)

	self.INFORMATIONALGUI:write("Multiply: x"..self.multiplier)
	
	setmetatable(self,Multiplier)
	return self
end

setmetatable(Multiplier,Interactable)
return Multiplier