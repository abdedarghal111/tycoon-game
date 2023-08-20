local PluginInstance = {}
PluginInstance.__index = PluginInstance

local garbage = workspace:FindFirstChild("Plugin Garbage(don't delete)")
if not garbage then
    garbage = Instance.new("Folder")
    garbage.Name = "Plugin Garbage(don't delete)"
    garbage.Parent = workspace
end

local pointers = garbage:FindFirstChild("pointers")
if not pointers then
    pointers = Instance.new("Folder")
    pointers.Name = "pointers"
    pointers.Parent = garbage
end

PluginInstance.garbageFolder = garbage
PluginInstance.pointersFolder = pointers

function PluginInstance:destroyInstances()
    print("destroying Instances")
    for i,pointer in pairs(PluginInstance.pointersFolder:GetChildren()) do
        pointer.Value:Destroy()
        pointer:Destroy()
    end
    for i,instance in pairs(PluginInstance.garbageFolder:GetChildren()) do
        instance:Destroy()
    end
    PluginInstance.garbageFolder:Destroy()
end

function PluginInstance:cleanInstances()
    for i,pointer in pairs(PluginInstance.pointersFolder:GetChildren()) do
        pointer.Value:Destroy()
        pointer:Destroy()
    end
end


function PluginInstance:setProperty(property,value)
    self.instance[property] = value
end

function PluginInstance:getProperty(property)
    return self.instance[property]
end

function PluginInstance:get()
    return self.instance
end


function PluginInstance.new(type,parent,properties)
    if typeof(parent) == "table" then parent = parent:get() end
    local self = {}
    self.pointer = Instance.new("ObjectValue")
    self.instance = Instance.new(type)

    local instance = self.instance
    instance.Parent = parent or PluginInstance.garbageFolder
    if properties then for property,value in pairs(properties) do
        if typeof(value) == "table" then value = value:get() end
        instance[property] = value
    end end
    

    local pointer = self.pointer
    pointer.Parent = PluginInstance.pointersFolder
    pointer.Value = instance

    return setmetatable(self,PluginInstance)
end

return PluginInstance