local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local Editor = require(script:WaitForChild("Editor"))

local mouse:Mouse = plugin:GetMouse()
local editor = Editor.new(script.Highlight,mouse)
Editor.object = editor

local toolbar = plugin:CreateToolbar("My tycoon editor")
local toolbarButton = toolbar:CreateButton("Panel", "Open panel", "rbxassetid://7059346373")
toolbarButton.ClickableWhenViewportHidden = true
local toolbarWidgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float, -- Widget will be initialized in floating panel
	true, -- Widget will be initially enabled
	false, -- Don't override the previous enabled state
	100, -- Default width of the floating window
	250, -- Default height of the floating window
	50, -- Minimum width of the floating window (optional)
	175 -- Minimum height of the floating window (optional)
)
local toolbarWidget = plugin:CreateDockWidgetPluginGui("Panel",toolbarWidgetInfo)
toolbarWidget.Title = "Panel"

local frame = script.Frame
local ui = {
	frame = frame,
	opciones = frame.mainScreen,
	modoSeleccion = frame.mainScreen.b1,
	analizarParte = frame.mainScreen.b2,
	B3 = frame.mainScreen,
	propiedades = frame.propiedades
}
frame.Parent = toolbarWidget
script.Highlight.Parent = toolbarWidget



local enabled,disabled = not toolbarWidget.Enabled,toolbarWidget.Enabled

--local selectedObjects = Selection:Get()
--ChangeHistoryService:SetWaypoint("Added new empty script")

local function closeEvents(...)
	for i,v:RBXScriptConnection in pairs({...}) do
		if v.Connected then
			v:Disconnect()
		end
	end
end

local function closePlugin()
	if toolbarWidget.Enabled then toolbarWidget.Enabled = not toolbarWidget.Enabled end
	toolbarButton:SetActive(false)
	plugin:Deactivate()
	editor:close()
	error("CLOSED")
end

local mouseEvent
local function openPlugin()
	if not toolbarWidget.Enabled then toolbarWidget.Enabled = not toolbarWidget.Enabled end
	toolbarButton:SetActive(true)
	plugin:Activate(true)
	if not mouse then
		mouse = plugin:GetMouse()
	end
	editor:activateSelection()
	--[[
	if mouseEvent and not mouseEvent.Connected then
		mouseEvent = mouse.Button1Down:Connect(function()
			editor:select(mouse.Target)
		end)
	end
	]]
end

toolbarButton.Click:Connect(function()
	toolbarWidget.Enabled = not toolbarWidget.Enabled
	if toolbarWidget.Enabled then
		openPlugin()
	else
		closePlugin()
	end
end)

toolbarWidget:BindToClose(closePlugin)

ui.analizarParte.Activated:Connect(function()
	ui.opciones.Visible = false
	ui.opciones.Active = false
	ui.propiedades.Active = true
	ui.propiedades.Visible = true
end)

script.events.getPropiedades.OnInvoke = function()
	return ui.propiedades
end

script.events.getMouse.OnInvoke = function()
	return mouse
end