local GroupOfButtons = {}
GroupOfButtons.__index = GroupOfButtons

local Button = require(script.Parent.Button)
local hf = require(script.Parent.Parent.helpFunctions)
local Instance = require(script.Parent.PluginInstance)

function createHierarchy(self,button)
    if self:isCreated() then self:clean() end
    self.headButton = Button.new(button)
    self.tableOfButtons = {}
    self.headButton:getAllConnectedModels(self.tableOfButtons)
end

function GroupOfButtons:create(selection: Selection)
    if #selection:Get() > 1 then warn("More than 1 instance selected.") return end
    local selected = selection:Get()[1]
    if not hf:isAButton(selected) then
        warn([[
            The instance you selected is not a button.
        ]])
    else
        createHierarchy(self,selected)
    end
end

function GroupOfButtons:recreate()
    local button = self.headButton:getModel()
    createHierarchy(self,button)
end

function GroupOfButtons:createLink(selection : Selection)

    if not self:isCreated() then
        return warn([[
            Create a hierarchy first.
        ]])
    end

    local selected = selection:Get()
    local button = selected[1]
    table.remove(selected,1)

    if not hf:isAButton(button) then
        return warn([[
            First selected model is not a button.
        ]])
    end

    for index,model in pairs(selected) do

        if not hf:isAInteractable(model) then
            return warn([[
                Selected model("]]..hf:getInstancePath(model)..[[") is not an interactable.
            ]])
        end

        for i,interactableInUse in pairs(self.tableOfButtons) do
            if model == interactableInUse then
                warn([[
                    There is a linked model(is not going to include in this operation).
                ]])
                table.remove(selected,index)
                break
            end
        end
       local change = hf:recordChange("Added links")

       for i,interactable in pairs(selected) do
            hf:createLinkButtonProduct(button,interactable)
       end

       hf:stopRecordingChange(change)

       self:recreate()

    end

    --inicio operaciones


end


function GroupOfButtons:isCreated()
    return self.headButton and true or false
end

function GroupOfButtons:clean()
    --self.headButton:destroy()
    Instance:cleanInstances()
    self.headButton = nil
end

function GroupOfButtons.new()
    local self = {
        headButton = nil,
        products = {}
    }

    return setmetatable(self,GroupOfButtons)
end

return GroupOfButtons.new()