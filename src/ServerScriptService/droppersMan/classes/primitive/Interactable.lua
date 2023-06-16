local Interactable = {
	player = nil,
	id = {}
}

Interactable.__index = Interactable



function Interactable.new()
	local self = {}
	
	
	
	return setmetatable(self,Interactable)
end

return Interactable