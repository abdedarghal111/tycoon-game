--TODO: hacer
local Interactable = require(script.Parent.Parent.primitive.Interactable)

local runServ = game:GetService("RunService")

local Convenyor = {}
Convenyor.__index = Convenyor
Convenyor.MODEL = script.Parent.models.Convenyor

function Convenyor:start()
	for _,cinta in pairs(self.CONVENYORS:GetDescendants()) do
		cinta.AssemblyLinearVelocity = Vector3.zero
	end
end

function Convenyor:stop()
	for _,cinta in pairs(self.CONVENYORS:GetDescendants()) do
		cinta.AssemblyLinearVelocity = cinta.CFrame.LookVector * self.speed
	end
end



function Convenyor.new(model,player)
	local self = Interactable.new(model,player)

	self.CONVENYORS = model.cintas
	self.speed = model:FindFirstChild("velocidad") and model.velocidad.Value or Convenyor.MODEL.velocidad.Value

	return setmetatable(self,Convenyor)
end

return Convenyor