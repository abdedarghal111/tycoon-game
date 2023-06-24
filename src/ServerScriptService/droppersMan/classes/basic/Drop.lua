local cubeFolder = script.cubeFolder.Value
local TemporalObjects = require(script.Parent.Parent.primitive.TemporalObjects)
local InformationalGui = require(script.Parent.Parent.primitive.InformationalGui)

local Drop = {}
Drop.__index = Drop
Drop.MODEL = script.Parent.models.Drop

function Drop:isMultipliedBy(multiplicator)
	if table.find(self.multipliers,multiplicator) then
		return true
	else
		return false
	end
end

function Drop:multiply(multiplicator,multiply)
	table.insert(self.multipliers,multiplicator)
	self.value *= multiply
	self.INFORMATIONALGUI:write("Value: "..self.value)
end



function Drop.new(dropperObj)
	local self = TemporalObjects.new(Drop.MODEL:Clone(),dropperObj.OWNER)
	
	self.CREATOR = dropperObj
	self.INFORMATIONALGUI = InformationalGui.new(self.MODEL)
	self.value = self.CREATOR.value
	self.multipliers = {}

	--partPosition
	--TODO:definir folder para las piezas
	self.MODEL.CFrame = dropperObj.SPAWN.CFrame
	self.MODEL.Parent = workspace
	self.MODEL:SetNetworkOwnership(self.OWNER)
	self.INFORMATIONALGUI:write("Value: "..self.value)
	
	return setmetatable(self,Drop)
end

setmetatable(Drop,TemporalObjects)

return Drop