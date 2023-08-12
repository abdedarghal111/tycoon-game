local Button = {}
Button.__index = Button

local hf = require(script.Parent.Parent.helpFunctions)

function Button:destroy()
    error("TODO: complete")
end

function Button.new(button)
    local self = {
        model = nil,
        products = {},
        buttons =  {}
    }

    self.model = button

    for i,objectVal in pairs(button.productosAComprar:GetChildren()) do
        local instancia = objectVal.Value
        if not instancia then --es nil
            local change = hf:recordChange("Deleted instance.")
            warn([[
                a button have a empty product to buy(deleted), press control + z to undo.
            ]])
            objectVal:Destroy()
            hf:stopRecordingChange(change)
        elseif instancia.ClassName ~= "Model" then --no es un modelo
            warn([[
                Instance is not a model.(path:"]]..hf:getInstancePath(objectVal)..[[")
            ]])
        elseif not instancia:FindFirstChild("type") then --no tienen tipo
            warn([[
                Instance is not a Interactable.(path:"]]..hf:getInstancePath(objectVal)..[[")
            ]])
        elseif instancia.type.Value == "AnimatedButton" or instancia.type == "Button" then -- un boton
            table.insert(self.buttons,Button.new(instancia))
        else -- un interactable
            table.insert(self.products,instancia)
        end
    end

    return setmetatable(self,Button)
end

return Button