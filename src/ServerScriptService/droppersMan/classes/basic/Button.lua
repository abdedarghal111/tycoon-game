local players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local Interactable = require(script.Parent.Parent.primitive.Interactable)
local InformationalGui = require(script.Parent.Parent.primitive.InformationalGui)
local hf = require(game.ServerScriptService.library.helpFunctions)

local Button = {}
Button.__index = Button
Button.MODEL = script.Parent.models.Button

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

function Button:onTouch()
		if self:buyProduct() then
			for i,v in pairs(self.PRODUCTS) do
				self:buy()
			end
		else
			task.wait(1)
			self:activate()
		end
end

function Button:activate()
	if not self.touchEvent then
		self.touchEvent = self.COLIDER.Touched:Connect(function(hit)
			if hit and players:GetPlayerFromCharacter(hit.Parent) == self.OWNER then
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

function Button.new(model,player)
	local self = Interactable.new(model,player)

	--TODO: modificar esto porque esta mal definido
	
	self.PRODUCTS = model.productosAComprar
	self.NEXTBUTTONS = model.botonesSiguientes
	self.COLIDER = model.colider
	self.VALUE = model:FindFirstChild("coste") and model.coste.Value or Button.MODEL.coste.Value
	--TODO: CAMBIAR EL INPUT DE DINERO
	self.MONEY = script.money.Value
	
	self.isBought = false
	self.touchEvent = nil

	self.INFORMATIONALGUI = InformationalGui.new(self.MODEL)
	
	InformationalGui.write("Cost: "..self.value)
	
	setmetatable(self,Button)
	return self
end

setmetatable(Button,Interactable)
return Button
