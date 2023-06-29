local players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local Interactable = require(script.Parent.Parent.primitive.Interactable)
local InformationalGui = require(script.Parent.Parent.primitive.InformationalGui)

local Button = {}
Button.__index = Button
Button.type = "Button"
Button.MODEL = script.Parent.models.Button

function Button:buyProduct()
	if self.VALUE <= self.MONEY.Value and not self.isBought then
		self.MONEY.Value -= self.VALUE
		self.isBought = true
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

function Button:onTouch()
		if self:buyProduct() then
			self:buyProducts()
			self:hide()
		else
			task.wait(1)
			self:activate()
		end
end

function Button:buyProducts()
	for i,v in pairs(self.PRODUCTS:GetChildren()) do

		local model = v.Value

		if model:GetAttribute("type") == Interactable.type then
			local object = Interactable.getObject(model)
			if object then
				object:buy()
			else
				warn("is not a object(func: button:onTouch)")
				continue
			end
		else
			warn("Is not a interactable(func: button:onTouch)")
		end

	end
	
end


function Button:activate()
	if not self.touchEvent then
		self.touchEvent = self.COLIDER.Touched:Connect(function(hit)
			if hit and players:GetPlayerFromCharacter(hit.Parent) == self.owner then
				self:deactivate()
				self:onTouch()
			end
		end)
	end
end

function Button:deactivate()
	if self.touchEvent then
		self.touchEvent:Disconnect()
	end
end

function Button:buy()
	self:show()
	self:activate()
end

function Button.new(model,player)
	local self = Interactable.new(model,player)
	
	self.PRODUCTS = model.productosAComprar
	self.COLIDER = model.colider
	self.VALUE = model:FindFirstChild("coste") and model.coste.Value or Button.MODEL.coste.Value
	--TODO: CAMBIAR EL INPUT DE DINERO
	self.MONEY = players["abdedarghal111"].leaderstats.Money
	
	self.isBought = false
	self.touchEvent = nil

	self.INFORMATIONALGUI = InformationalGui.new(self.MODEL)
	
	InformationalGui:write("Cost: "..self.VALUE)
	
	return setmetatable(self,Button)
end

setmetatable(Button,Interactable)
return Button
