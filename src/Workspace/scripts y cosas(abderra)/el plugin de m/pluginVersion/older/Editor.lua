local mesMan = require(script.Parent.messageManager)
local Propiedades = require(script.Parent.propiedad.Propiedades)

local Editor = {}
Editor.__index = Editor

function Editor:select(inst)
	if not inst then mesMan.printMessage(2) return end
	while inst.ClassName ~= "Model" do
		inst = inst.Parent
		if inst == game.Workspace then return mesMan.printMessage(1) end
	end
	
	if inst == self.selected then
		self.selected = nil
		self.highLight.Adornee = nil
		mesMan.printMessageGsub(4,inst.Name)
		if not self.propiedades:isEmpty() then
			self.propiedades:removeAllProprieties()
		end
	else
		self.highLight.Adornee = inst
		self.selected = inst
		mesMan.printMessageGsub(3,inst.Name)
		for i,value in pairs(inst:GetChildren()) do
			if value:IsA("ValueBase") then
				self.propiedades:addPropriety(value)
			end
		end
	end
end

function Editor:close()
	if not self.propiedades:isEmpty() then
		self.propiedades:removeAllProprieties()
	end
	
	self.highLight.Adornee = nil
end

function Editor.new(highLight)
	
	local self = {
		highLight = highLight,
		selected = nil,
		propiedades = Propiedades.new()
	}
	
	return setmetatable(self,Editor)
	
end

return Editor