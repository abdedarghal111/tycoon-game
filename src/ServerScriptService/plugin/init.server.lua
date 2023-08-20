local Selection = game:GetService("Selection")

--local mouse:Mouse = plugin:GetMouse()
local helpFunctions = require(script.helpFunctions)
local groupOfButtons = require(script.class.groupOfButtons)
local InstancesManager = require(script.class.PluginInstance)

local toolbar = plugin:CreateToolbar("Plugin de testeo")
local botonCrearGerarquia = toolbar:CreateButton("Crear Gerarquía",[[
	Selecciona el boton inicial del tycoon y luego presiona este boton para mostrar la gerarquía.
]], "rbxassetid://14471480612")
local botonBorrarGerarquia = toolbar:CreateButton("Borrar gerarquía",[[
	Para borrar la gerarquía creada.
]], "rbxassetid://14471506681")
local BotonCrearEnlace = toolbar:CreateButton("Crear enlace",[[
	Selecciona un boton y los productos a comprar sucesivamente con la gerarquía creada para crear enlaces.
]],"rbxassetid://14505177724")

botonCrearGerarquia.ClickableWhenViewportHidden = true
botonBorrarGerarquia.ClickableWhenViewportHidden = true
BotonCrearEnlace.ClickableWhenViewportHidden = true
--local selectedObjects = Selection:Get()
--ChangeHistoryService:SetWaypoint("Added new empty script")

local function closeEvents(...)
	for i,v:RBXScriptConnection in pairs({...}) do
		if v.Connected then
			v:Disconnect()
		end
	end
end

botonCrearGerarquia.Click:Connect(function()
	groupOfButtons:create(Selection)
end)

botonBorrarGerarquia.Click:Connect(function()
	InstancesManager:cleanInstances()
end)

BotonCrearEnlace.Click:Connect(function()
	groupOfButtons:createLink(Selection)
end)

plugin.Unloading:Connect(function()
	InstancesManager:destroyInstances()
end)