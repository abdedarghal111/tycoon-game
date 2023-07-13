task.wait(0.1)
local count = tick()

local hf = require(script.Parent.Parent.library.helpFunctions)
local players = game.Players
local Player = hf:getClass("Player")

local tycoon1Objects = {}
for i,model in pairs(workspace.tycoons.tycoon1:GetDescendants()) do
	if hf:isAValidObjectModel(model) then
		table.insert(tycoon1Objects,hf:createObject(model))
	end
end
local Tycoon = hf:getClass("Tycoon")
local tycoon1 = Tycoon.new()
tycoon1:setTableOfObjects(tycoon1Objects)

count = tick() - count
print("Game loaded("..count ..")")

local place = workspace.tycoons.tycoon1
local inicio = place.inicio
local startTouch = place["inicial part"]

function tycoon1:onInit()
	local manualDropper = hf:getObject(inicio.manualDropper)
	local seller = hf:getObject(inicio.seller)
	local startButton = hf:getObject(place.buttons.floor)

	seller:buy()
	manualDropper:buy()
	startButton:buy()

	inicio.clickable.ClickDetector.MouseClick:Connect(function(clicker)
		if clicker == tycoon1:getPlayer() then
			manualDropper:drop()
		end
	end)
end

local ev; ev = startTouch.Touched:Connect(function(hit)
	local player = players:GetPlayerFromCharacter(hit.Parent)
	if player then
		player = Player.new(player)
		ev:Disconnect()
		startTouch.SurfaceGui.TextLabel.Text = player:getName()
		tycoon1:init(player)
		print("tycoon started("..player:getName()..")")
	end
end)