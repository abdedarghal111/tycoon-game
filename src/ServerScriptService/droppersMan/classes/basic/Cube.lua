local cubeFolder = script.cubeFolder.Value


local Cube = {}
Cube.__index = Cube

function Cube:isMultipliedBy(multiplicator)
	if table.find(self.multipliers,multiplicator) then
		return true
	else
		return false
	end
end

function Cube:multiply(multiplicator,multiply)
	table.insert(self.multipliers,multiplicator)
	self.value *= multiply
	self.BASEPART.board.text.Text = self.value
end



function Cube.new(coinBasePart,dropperObj,player)
	local cube = {}
	
	cube.multipliers = {}
	cube.BASEPART = coinBasePart:Clone()
	cube.CREATOR = dropperObj
	cube.OWNER = player
	cube.value = coinBasePart.Parent.valor.Value
	
	--partCreation
	local part = cube.BASEPART
	local value = coinBasePart.Parent.valor:Clone()
	part.CanTouch = true
	part.CanCollide = true
	part.CanQuery = true
	part.Transparency = 0
	part.Anchored = false
	part.board.text.Text = value.Value
	value.Parent = cube.BASEPART
	
	part.Parent = cubeFolder
	--partCreation
	require(part.getCube):setObject(cube)
	setmetatable(cube,Cube)
	return cube
end

return Cube