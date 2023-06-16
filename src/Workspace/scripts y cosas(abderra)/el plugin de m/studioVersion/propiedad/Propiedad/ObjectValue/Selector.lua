local Selector = {}
Selector.__index = Selector

local shf = require(script.Parent.Parent.Parent.Parent.sharedFunctions)
local mesMan = require(script.Parent.Parent.Parent.Parent.messageManager)

local mouseInv = script.Parent.Parent.Parent.Parent.events.getMouse
local editorClass = script.Parent.Parent.Parent.Parent.Editor

function Selector:select()
	local model,partClicked,selected
	local mouse = mouseInv:Invoke()
	local editor = require(editorClass).object
	local sugSelectEv = true
	task.spawn(function()
		while sugSelectEv and task.wait() do
			partClicked = mouse.Target
			if partClicked then
				model = shf.getModelFromSelectedInstanceNoComments(partClicked)
			end
			
			self.highLight.Adornee = model
		end
	end)
	
	editor:deactivateSelection()
	mouse.Button1Down:Wait()
	partClicked = mouse.Target
	if partClicked then
		model = shf.getModelFromSelectedInstance(partClicked)
	end
	sugSelectEv = false
	editor:activateSelection()
	
	return model
	--[[
	--TODO: cambiar el sistema
	
	if model and model == self.selected then
		selected = nil
		self.selected = nil
		self.highLight.Adornee = nil
		self.objectGui.Parent = nil
		mesMan.printMessageGsub(4,model.Name)
	elseif model then
		self.selected = model
		self.highLight.Adornee = model
		self.objectGui.Parent = model
		mesMan.printMessageGsub(3,model.Name)
	else --ninguno seleccionado
		if self.selected then
			mesMan.printMessageGsub(4,self.selected.Name)
			self.selected = nil
			self.highLight.Adornee = nil
			self.objectGui.Parent = nil
		end
		mesMan.warnMessageGsub(1,partClicked.Name)
	end
	]]
end

function Selector:setSelected(model)
	self.selected = model
	self.highLight.Adornee = model
	self.objectGui.Parent = model
end

function Selector:Destroy()
	self.highLight:Destroy()
	self.objectGui:Destroy()
end


function Selector.new(propiedad)
	local objectGui = script.BillboardGui:Clone()
	local highLight = objectGui.Highlight
	local textLabel = objectGui.TextLabel
	
	
	local self = {
		highLight = highLight,
		objectGui = objectGui,
		textLabel = textLabel,
		selected = nil
	}
	
	textLabel.Text = propiedad.instance.Name
	self.selected = propiedad.instance.Value
	self.highLight.Adornee = propiedad.instance.Value
	self.objectGui.Parent = propiedad.instance.Value
	highLight.Parent = propiedad.instance
	
	return setmetatable(self,Selector)
end

return Selector