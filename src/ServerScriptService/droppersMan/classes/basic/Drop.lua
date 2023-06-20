local cubeFolder = script.cubeFolder.Value


local Drop = {}
Drop.__index = Drop

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
	self.BASEPART.board.text.Text = self.value
end



function Drop.new(coinBasePart,dropperObj,player)
	local self = {}
	
	self.multipliers = {}
	self.BASEPART = coinBasePart:Clone()
	self.CREATOR = dropperObj
	self.OWNER = player
	self.value = coinBasePart.Parent.valor.Value
	
	--partCreation
	local part = self.BASEPART
	local value = coinBasePart.Parent.valor:Clone()
	part.CanTouch = true
	part.CanCollide = true
	part.CanQuery = true
	part.Transparency = 0
	part.Anchored = false
	part.board.text.Text = value.Value
	value.Parent = self.BASEPART
	
	part.Parent = cubeFolder
	--partCreation
	require(part.getCube):setObject(self)
	setmetatable(self,Drop)
	return self
end

return Drop