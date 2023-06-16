local Button = require(script.Button)
local Dropper = require(script.Dropper)
local Multiplier = require(script.Multiplier)
local money = script.money
local starterButton = workspace.buyButton
game.Players.PlayerAdded:Wait()
local plr = game.Players:WaitForChild("abdedarghal111")

local buttons = {}
local products = {}

local recursiveLoading
function recursiveLoading(buttonModel)
	if buttonModel then
		local product,type = nil,buttonModel.producto.Value.type.Value
		local arg1,arg2 = buttonModel.producto.Value,plr
		--
		if type == "dropper" then
			product = Dropper.new(arg1,arg2)
		elseif type == "multiplier" then
			product = Multiplier.new(arg1,arg2)
		end
		
		local button = Button.new(
			buttonModel,
			nil,
			money,
			product,
			recursiveLoading(buttonModel.siguienteBoton.Value)
		)
		table.insert(buttons,button)
		return button
	end
end


local first = recursiveLoading(starterButton)
first:activate()