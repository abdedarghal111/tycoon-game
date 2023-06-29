local HelpFunctions = {}


HelpFunctions.classes = {}
for i,instance in pairs(script.Parent.Parent.droppersMan.classes:GetDescendants()) do
    if instance:IsA("ModuleScript") then
        HelpFunctions.classes[instance.Name] = require(instance)
    end
end
function HelpFunctions:getClass(class)
    if HelpFunctions.classes[class] then
        return HelpFunctions.classes[class]
    end
end

return HelpFunctions