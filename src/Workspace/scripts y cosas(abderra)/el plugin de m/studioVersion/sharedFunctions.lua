local shf = {}
local mesMan = require(script.Parent.messageManager)

function shf.getModelFromSelectedInstance(startingInstance)
	local instance = startingInstance
	while instance.ClassName ~= "Model" do
		instance = instance.Parent
		if instance == game.Workspace then
			mesMan.warnMessageGsub(1,startingInstance.Name)
			return nil
		end
	end
	
	return instance
end

function shf.getModelFromSelectedInstanceNoComments(startingInstance)
	local instance = startingInstance
	while instance.ClassName ~= "Model" do
		instance = instance.Parent
		if instance == game.Workspace then
			return nil
		end
	end

	return instance
end


return shf
