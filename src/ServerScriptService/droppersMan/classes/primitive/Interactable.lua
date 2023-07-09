local Interactable = {}

Interactable.objects = {}
Interactable.__index = Interactable
Interactable.type = "Interactable"

function Interactable.giveId(object)
	local posicion = #Interactable.objects + 1
	Interactable.objects[posicion] = object
	return posicion
end

function Interactable:updateObjectInTable()
	Interactable.objects[self.ID] = self
end

function Interactable:setPlayer(plr)
	self.owner = plr
	plr:addStructure(self)
end

function Interactable:onRemovingPlayer()end
function Interactable:removePlayer()
	self.owner = nil
	self:onRemovingPlayer()
	self:hide()
end

function Interactable.getObject(model)
	local id = model:GetAttribute("ID")
	local type = model:GetAttribute("type")
	if id and type == Interactable.type then
		return Interactable.objects[id]
	else
		warn("Not a interactable")
	end
end


function Interactable:isA(type)
	if type == Interactable.type then
		return true
	end
end


function Interactable:show()
	for i,v in pairs(self.DECORATION:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = 0
			v.CanCollide = false
			v.CanQuery = false
			v.CanTouch = false
		end
	end
	for i,v in pairs(self.COLIDERS:GetDescendants()) do
		v.CanCollide = true
		v.CanQuery = false
		v.CanTouch = false
	end
end

function Interactable:hide()
	for i,v in pairs(self.DECORATION:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
			v.CanCollide = false
			v.CanQuery = false
			v.CanTouch = false
		end
	end
	for i,v in pairs(self.COLIDERS:GetDescendants()) do
		v.CanCollide = false
		v.CanQuery = false
		v.CanTouch = false
	end
end

function Interactable:buy()
	warn("Make a buy function for class: "..self.TYPE)
end

function Interactable:setOwner(player)
	--TODO:modificar mas adelante
	warn("Tienes que modificar la funcion setOwner para cada clase")
	self.owner = player
end

function Interactable:getObjId(model)
	return Interactable.objects[model.GetAttribute("ID")]
end

function Interactable:printProperties()
	for i,v in pairs(Interactable.getObject(self.MODEL)) do
		if type(v) == "function" then continue end
		print(i,v)
	end
end


function Interactable.new(model,player)
	local self = {}

	self.ID = Interactable.giveId(self)
	self.MODEL = model
	self.COLIDERS = model:FindFirstChild("colisiones")
	self.DECORATION = model:FindFirstChild("decoracion")
	self.owner = nil
	self.type = Interactable.type

	model:SetAttribute("ID",self.ID)
	model:SetAttribute("type",Interactable.type)
	
	return setmetatable(self,Interactable)
end

return Interactable