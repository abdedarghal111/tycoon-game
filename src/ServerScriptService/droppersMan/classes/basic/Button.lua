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

function Button:show()
	for i,v in pairs(self.DECORATION:GetDescendants()) do
		v.Transparency = 0
		v.CanCollide = true
		v.CanQuery = false
		v.CanTouch = true
	end
end

function Button:hide()
	for i,v in pairs(self.DECORATION:GetDescendants()) do
		v.Transparency = 0
		v.CanCollide = false
		v.CanQuery = false
		v.CanTouch = false
	end
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
	local button = Interactable.new(player)
	
	button.MODEL = model
	button.PRODUCTOBJ = productObject
	button.COLIDER = model.colider
	button.MONEY = money
	button.NEXTBUTTONOBJ = nextButtonObject
	button.value = model.coste.Value
	
	button.isBought = false
	button.touchEvent = nil
	
	model.colider.board.text.Text = "Cost: "..button.value
	
	setmetatable(button,Button)
	return button
end

setmetatable(Button,Interactable)
return Button
