local HelpFunctions = {}


HelpFunctions.classes = {}
for i,instance in pairs(script.Parent.Parent.droppersMan.classes:GetDescendants()) do
    if instance:IsA("ModuleScript") then
        --print(instance.Name)
        HelpFunctions.classes[instance.Name] = require(instance)
    end
end
function HelpFunctions:getClass(class)
    if HelpFunctions.classes[class] then
        return HelpFunctions.classes[class]
    end
end

local Interactable = HelpFunctions:getClass("Interactable")
function HelpFunctions:isAValidObjectModel(instance)
    if instance:IsA("Model") and instance:FindFirstChild("type") then
        return true
    end
end

function HelpFunctions:isInteractable(model)
    local id = model:GetAttribute("ID")
	local type = model:GetAttribute("type")
	if id and type == Interactable.type then
		return Interactable.getObject(model)
	else
		return nil
	end
end

function HelpFunctions:createObject(model)
    local class = self:getClass(model.type.Value)
	local object = class.new(model)
    return object
end

function HelpFunctions:getObject(model)
    return Interactable.getObject(model)
end


return HelpFunctions