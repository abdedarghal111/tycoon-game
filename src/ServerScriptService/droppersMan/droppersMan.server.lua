local hf = require(script.Parent.Parent.library.helpFunctions)

game.Players.PlayerAdded:Wait()
local plr = game.Players:WaitForChild("abdedarghal111")

local testingPlace = workspace.testing

local playerObj = hf:getClass("Player").new(plr)

for i,v in pairs(workspace:GetDescendants()) do
	if v:IsA("Model") and v:FindFirstChild("type") then
		local class = hf:getClass(v.type.Value)
		object = class.new(v,plr)
		object:removePlayer()
		object:setPlayer(playerObj)
	end
end

--basic drops
local button = hf:getClass("Button").getObject(testingPlace["complete models"]["basic droppers"].Button)
button:show()
button:activate()
--fin basic drops

local button2 = hf:getClass("Button").getObject(testingPlace.test2.Button)

button2:show()
button2:activate()