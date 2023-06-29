local hf = require(script.Parent.Parent.library.helpFunctions)

game.Players.PlayerAdded:Wait()
local plr = game.Players:WaitForChild("abdedarghal111")

local leaderstats = Instance.new("Folder")
leaderstats.Name = "leaderstats"
leaderstats.Parent = plr

local money = Instance.new("IntValue")
money.Name = "Money"
money.Value = 100
money.Parent = leaderstats

local testingPlace = workspace.testing.test

for i,v in pairs(testingPlace:GetDescendants()) do
	if v:IsA("Model") and v:FindFirstChild("type") then
		hf:getClass(v.type.Value).new(v,plr)
	end
end

local button = hf:getClass("Button").getObject(testingPlace.Button)

button:activate()
--for i,v in pairs(button) do 
---	print(i,"=",v)
--end

--print(getmetatable(button))