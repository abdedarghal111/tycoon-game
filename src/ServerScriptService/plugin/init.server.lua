local Selection = game:GetService("Selection")

--local mouse:Mouse = plugin:GetMouse()
local helpFunctions = require(script.helpFunctions)
local groupOfButtons = require(script.class.groupOfButtons)

local toolbar = plugin:CreateToolbar("Plugin de testeo")
local botonCrearGerarquia = toolbar:CreateButton("Crear Gerarquía",[[
	Selecciona el boton inicial del tycoon y luego presiona este boton para mostrar la gerarquía.
]], "rbxassetid://7059346373")
botonCrearGerarquia.ClickableWhenViewportHidden = true

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

plugin.Unloading:Connect(function()
	print("apagao")
end)