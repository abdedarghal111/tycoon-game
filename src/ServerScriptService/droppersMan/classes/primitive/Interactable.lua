local Interactable = {
	OWNER = "player",
	id = {}
}

Interactable.__index = Interactable



function Interactable.new(player)
	local self = {
		OWNER = player
	}
	
	return setmetatable(self,Interactable)
end

return Interactable