local Interactable = require(script.Parent.Interactable)

local Tycoon = {}
Tycoon.__index = Tycoon

function Tycoon:addObject(object)
    table.insert(self.objects,object)
end

function Tycoon:addTableOfObjects(tableOfObjects)
    for i,object in pairs(tableOfObjects) do
        self:addObject(object)
    end
end

function Tycoon:setTableOfObjects(tableOfObjects)
    self.objects = tableOfObjects
end

--reescribir funcion para crear tycoon
function Tycoon:init(owner)
    for i,object in pairs(self.objects) do
        object:hide()
        object:setOwner(owner)
    end
    self.owner = owner
    self:onInit()
end

function Tycoon:onInit()
    error("overwrite this")
end


function Tycoon:close()
    self.owner = nil
    for i,object in pairs(self.objects) do
        object:hide()
    end
    self:onClose()
end

function Tycoon:onClose()
    error("overwrite this")
end


function Tycoon:getPlayer()
    return self.owner:get()
end


function Tycoon.new()
    local self = {}

    self.owner = nil
    self.objects = {}

    return setmetatable(self,Tycoon)
end

return Tycoon