local Propiedad = require(script.Parent.Propiedad)

local Propiedades = {}
Propiedades.__index = Propiedades

function Propiedades:addPropriety(instance)
	self.propiedades[instance.Name] = Propiedad.new(instance)
end

function Propiedades:removeAllProprieties()
	for name,propiedad in pairs(self.propiedades) do
		propiedad:destroy()
		self.propiedades[name] = nil
	end
end

function Propiedades:removePropriety(instance)
	for name,propiedad in pairs(self.propiedades) do
		if propiedad:is(instance) then
			propiedad:destroy()
			self.propiedades[name] = nil
			--table.remove(self.propiedades,propiedad)
			break
		end
	end
end

function Propiedades:isEmpty()
	if #self.propiedades == 0 then
		return true
	end
	
	return false
end

function Propiedades.new()
	local self = {}
	
	self.propiedades = {}
	
	return setmetatable(self,Propiedades)
end

return Propiedades