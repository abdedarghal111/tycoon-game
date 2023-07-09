local ServerScriptService = game:GetService("ServerScriptService")
local Interactable = require(script.Parent.Parent.primitive.Interactable)
local InformationalGui = require(ServerScriptService.droppersMan.classes.primitive.InformationalGui)
local TemporalObjects = require(script.Parent.Parent.primitive.TemporalObjects)

local Seller = {}
Seller.__index = Seller
Seller.type = "Seller"
Seller.super = Interactable

function Seller:startWorking()
	if not self.touchEvent then
		self.touchEvent = self.COLIDER.Touched:Connect(function(hit)
			if hit:GetAttribute("type") == TemporalObjects.type then
				self:onTemporalObjectTouch(TemporalObjects.getObject(hit))
			end
		end)
	end
end

function Seller:stopWorking()
	if self.touchEvent then
		self.touchEvent:Disconnect()
		self.touchEvent = nil
	end
end

function Seller:onTemporalObjectTouch(drop)
	if not drop then return end
    self.owner:giveMoney(drop.value)
	drop:destroy()
end

function Seller:onRemovingPlayer()
	self:stopWorking()
end

function Seller:buy()
	self:show()
	self:startWorking()
end


function Seller.new(model,player)
	local self = Interactable.new(model,player)
	
	self.COLIDER = model.colider
	self.touchEvent = nil
	self.type = Seller.type

	self.INFORMATIONALGUI = InformationalGui.new(self.MODEL)

	self.INFORMATIONALGUI:write("Seller")
	
	setmetatable(self,Seller)
	return self
end

setmetatable(Seller,Interactable)
return Seller