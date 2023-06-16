if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(0.1)

local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local Editor = require(script:WaitForChild("Editor"))

local highlight = Instance.new("Highlight")

local frame = script:WaitForChild("Frame")
local ui = {
	frame = frame,
	opciones = frame.mainScreen,
	modoSeleccion = frame.mainScreen.b1,
	analizarParte = frame.mainScreen.b2,
	B3 = frame.mainScreen,
	propiedades = frame.propiedades
}

Instance.new("ScreenGui").Parent = game.Players.LocalPlayer.PlayerGui
frame.Parent = game.Players.LocalPlayer.PlayerGui.ScreenGui
highlight.Parent = game.Players.LocalPlayer.PlayerGui


local mouse = game.Players.LocalPlayer:GetMouse()
local editor = Editor.new(highlight,mouse)
Editor.object = editor
editor:activateSelection()


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