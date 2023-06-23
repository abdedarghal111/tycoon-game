local players = game:GetService("Players")

local Interactable = require(script.Parent.Parent.primitive.Interactable)

local Button = {}
Button.__index = Button

function Button:buyProduct()
	if self.value <= self.MONEY.Value and not self.isBought then
		self.MONEY.Value -= self.value
		self:purchaseEffect()
		return true
	else
		self:dennyEffect()
		return false
	end
end

function Button:purchaseEffect()
	--TODO: complete
	warn("complete this")
end

function Button:dennyEffect()
	--TODO: complete
	warn("you should comprete that")
end

function Button:activate()
	if not self.touchEvent then
		self.touchEvent = self.COLIDER.Touched:Connect(function(hit)
			if hit and players:GetPlayerFromCharacter(hit.Parent) == self.OWNER then
				self.touchEvent:Disconnect()
				self.touchEvent = nil
				if self:buyProduct() then
					self.PRODUCTOBJ:buy()
					self.NEXTBUTTONOBJ:activate()
				end
			end
		end)
	end
end

function Button:deactivate()
	if self.touchEvent then
		self.touchEvent:Disconnect()
	end
end

function Button.new(model,player,money,productObject,nextButtonObject)
	local self = Interactable.new(model,player)

	--TODO: modificar esto porque esta mal definido
	
	self.PRODUCTOBJ = productObject
	self.COLIDER = model.colider
	self.MONEY = money
	self.NEXTBUTTONOBJ = nextButtonObject
	self.value = model.coste.Value
	
	self.isBought = false
	self.touchEvent = nil
	
	model.colider.board.text.Text = "Cost: "..self.value
	
	setmetatable(self,Button)
	return self
end

setmetatable(Button,Interactable)
return Button
