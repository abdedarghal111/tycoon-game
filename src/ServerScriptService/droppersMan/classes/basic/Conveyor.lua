--TODO: hacer
local Interactable = require(script.Parent.Parent.primitive.Interactable)

local runServ = game:GetService("RunService")

local Convenyor = {}
Convenyor.__index = Convenyor

function Convenyor:start()
	if self.moveEvent then
		if not self.moveEvent.Connected then
			--TODO: compretar esto not self.moveEvent = self
		end
	end
end


function Convenyor.new()
	local self = {
		moveEvent = nil
	}

	return setmetatable(self,Convenyor)
end

return Convenyor


--[[
while task.wait() do
	script.Parent.Velocity = script.Parent.CFrame.LookVector * -20
end
]]