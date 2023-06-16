local mesMan = require(script.Parent.messageManager)
local Propiedades = require(script.Parent.propiedad.Propiedades)
local shf = require(script.Parent.sharedFunctions)

local Editor = {}
Editor.__index = Editor

function Editor:select(partClicked)
	if not partClicked then mesMan.printMessage(2) return end
	
	local selected = shf.getModelFromSelectedInstance(partClicked)
	
	if selected and selected == self.selected then
		self.selected = nil
		self.highLight.Adornee = nil
		mesMan.printMessageGsub(4,selected.Name)
		self.propiedades:removeAllProprieties()
	elseif selected then
		self.propiedades:removeAllProprieties()
		self.highLight.Adornee = selected
		self.selected = selected
		mesMan.printMessageGsub(3,selected.Name)
		for i,value in pairs(selected:GetChildren()) do
			if value:IsA("ValueBase") then
				self.propiedades:addPropriety(value)
			end
		end
	else --ninguno seleccionado
		if self.selected then
			self.propiedades:removeAllProprieties()
			mesMan.printMessageGsub(4,self.selected.Name)
			self.highLight.Adornee = nil
			self.selected = nil
		end
		mesMan.warnMessageGsub(1,partClicked.Name)
		--[[
		self.highLight.Adornee = selected
		self.selected = selected
		mesMan.printMessageGsub(3,selected.Name)
		for i,value in pairs(selected:GetChildren()) do
			if value:IsA("ValueBase") then
				self.propiedades:addPropriety(value)
			end
		end--]]
	end
end

function Editor:close()
	if not self.propiedades:isEmpty() then
		self.propiedades:removeAllProprieties()
	end
	
	self.highLight.Adornee = nil
	self:deactivateSelection()
end

function Editor:activateSelection()
	if self.mouseEvent and self.mouseEvent.Connected then return end
	self.mouseEvent = self.mouse.Button1Down:Connect(function()
		self:select(self.mouse.Target)
	end)
end

function Editor:deactivateSelection()
	if self.mouseEvent and self.mouseEvent.Connected then
		self.mouseEvent:Disconnect()
	end
end

function Editor.new(highLight,mouse)
	
	local self = {
		highLight = highLight,
		mouse = mouse,
		selected = nil,
		propiedades = Propiedades.new(),
		mouseEvent = nil
	}
	
	return setmetatable(self,Editor)
	
end

return Editor