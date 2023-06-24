local Interactable = {}

Interactable.objects = {}
Interactable.__index = Interactable

function Interactable.giveId(object)
	local posicion = #Interactable.objects + 1
	Interactable.objects[posicion] = object
	return posicion
end

function Interactable:show()
	for i,v in pairs(self.DECORATION:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = 0
			v.CanCollide = true
			v.CanQuery = false
			v.CanTouch = true
		end
	end
end

function Interactable:hide()
	for i,v in pairs(self.DECORATION:GetDescendants()) do
		if v:IsA("Basepart") then
			v.Transparency = 0
			v.CanCollide = false
			v.CanQuery = false
			v.CanTouch = false
		end
	end
end

function Interactable:buy()
	warn("Make a buy function for class: "..self.TYPE)
end

function Interactable:setOwner(player)
	--TODO:modificar mas adelante
	warn("Tienes que modificar la funcion setOwner para cada clase")
	self.OWNER = player
end

function Interactable:getObjId(model)
	return Interactable.objects[model.GetAttribute("ID")]
end

function Interactable.new(model,player)
	local self = {}

	self.ID = Interactable.giveId(self)
	self.MODEL = model
	self.COLIDERS = model:FindFirstChild("colisiones") or nil
	self.DECORATION = model.FindFirstChild("decoracion") or nil
	self.owner = player or nil

	model:SetAttribute("ID",self.ID)

	
	return setmetatable(self,Interactable)
end

return Interactable