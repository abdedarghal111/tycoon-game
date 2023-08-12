local PluginInstance = {}
PluginInstance.__index = PluginInstance
PluginInstance.PointersFolder = Instance.new("Folder")


local folder = PluginInstance.PointersFolder
folder.Name = "Plugin Garbage(don't delete)"
folder.Parent = workspace
-- TODO: instancias y gerarquia a mostrar


function PluginInstance.new()
    local self = {}

    return setmetatable(self,PluginInstance)
end

return PluginInstance