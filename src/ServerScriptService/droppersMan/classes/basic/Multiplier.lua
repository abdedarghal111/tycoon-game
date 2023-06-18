local Interactable = require(script.Parent.Parent.primitive.Interactable)

local Multiplier = {}
Multiplier.__index = Multiplier

function Multiplier:hide()
	for i,v in pairs(self.DECORATION:GetDescendants()) do
		v.Transparency = 1
		v.CanCollide = false
		v.CanQuery = false
		v.CanTouch = false
	end
end

function Multiplier:show()
	for i,v in pairs(self.DECORATION:GetDescendants()) do
		v.Transparency = 0
		v.CanCollide = true
		v.CanQuery = false
		v.CanTouch = false
	end
end

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
	local multiplier = Interactable.new(player)
	
	multiplier.MODEL = model
	multiplier.DECORATION = model.decoracion
	multiplier.COLIDER = model.colider
	multiplier.multiplier = model.multiplicador.Value
	multiplier.touchEvent = nil
	
	model.colider.board.text.Text = "Multiply: x"..multiplier.multiplier
	
	setmetatable(multiplier,Multiplier)
	return multiplier
end

setmetatable(Multiplier,Interactable)
return Multiplier