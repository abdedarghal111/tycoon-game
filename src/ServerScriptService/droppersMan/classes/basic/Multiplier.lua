local ServerScriptService = game:GetService("ServerScriptService")
local Interactable = require(script.Parent.Parent.primitive.Interactable)
local InformationalGui = require(ServerScriptService.droppersMan.classes.primitive.InformationalGui)

local Multiplier = {}
Multiplier.__index = Multiplier

function Multiplier:multiply(part)
	if not part:isMultipliedBy(self) then
		part:multiply(self,self.multiplier)
	end
end

function Multiplier:startWorking()
	if not self.touchEvent then
		self.touchEvent = self.COLIDER.Touched:Connect(function(hit)
			if hit:FindFirstChild("type") and hit.type.Value == "cube" then
				self:multiply(require(hit.getCube):getObject())
			end
		end)
	end
end

function Multiplier:stopWorking()
	if self.touchEvent then
		self.touchEvent:Disconnect()
		self.touchEvent = nil
	end
end

function Multiplier:buy()
	self:show()
	self:startWorking()
end


function Multiplier.new(model,player)
	local self = Interactable.new(player)
	
	self.MODEL = model
	self.DECORATION = model.decoracion
	self.COLIDER = model.colider
	self.multiplier = model.multiplicador.Value
	self.touchEvent = nil

	self.INFORMATIONALGUI = InformationalGui.new(self.MODEL)

	self.INFORMATIONALGUI.write("Multiply: x"..self.multiplier)
	
	setmetatable(self,Multiplier)
	return self
end

setmetatable(Multiplier,Interactable)
return Multiplier