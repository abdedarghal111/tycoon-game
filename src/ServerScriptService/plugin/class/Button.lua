local Button = {}
Button.__index = Button

local hf = require(script.Parent.Parent.helpFunctions)
local Instance = require(script.Parent.PluginInstance)

--function Button:destroy()
--    error("TODO: complete")
--end

function createHighlight(model1,model2,fillColor)
    local parentPosition = model1.WorldPivot.Position
    local childPosition = model2.WorldPivot.Position
    local vectorDireccion = childPosition - parentPosition
    local posicionObjetivo = vectorDireccion/2 + parentPosition
    local linkPart = Instance.new("Part",nil,{
        ["Anchored"] = true,
        ["Size"] = Vector3.new(0.25,0.25,vectorDireccion.Magnitude),
        ["Transparency"] = 0,
        --["Position"] = posicionObjetivo,
        --["Orientation"] = Vector3.new(CFrame.lookAt(posicionObjetivo,parentPosition):ToEulerAnglesXYZ())
        ["CFrame"] = CFrame.new(posicionObjetivo,parentPosition)
    })
    local highLight = Instance.new("Highlight",linkPart,{
        ["Adornee"] = linkPart,
        ["FillColor"] = fillColor,
        ["FillTransparency"] = 0,
        ["OutlineTransparency"] = 1
    })
end

function Button:getAllConnectedModels(recursiveTable)

    table.insert(recursiveTable,self.model)

    for i,product in pairs(self.products) do
        table.insert(recursiveTable,product)
    end

    for i,button in pairs(self.buttons) do
        button:getAllConnectedModels(recursiveTable)
    end

end

function Button:getModel()
    return self.model
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

            local buttonModel = instancia
            table.insert(self.buttons,Button.new(buttonModel))
            createHighlight(self.model,buttonModel,Color3.fromRGB(0,0,255))

        else -- un interactable

            local interactable = instancia
            table.insert(self.products,interactable)
            createHighlight(self.model,interactable,Color3.fromRGB(255,255,0))

        end
    end

    return setmetatable(self,Button)
end


return Button

--[[
local parentPart = Instance.new("Part",nil,{
        ["Anchored"] = true,
        ["Size"] = Vector3.zero,
        ["Transparency"] = 1,
        ["Position"] = self.model.WorldPivot.Position
    })
    local parentAttachment = Instance.new("Attachment",parentPart:get())



local childPart = Instance.new("Part",nil,{
                ["Anchored"] = true,
                ["Size"] = Vector3.zero,
                ["Transparency"] = 1,
                ["Position"] = buttonModel.WorldPivot.Position
            })
            local childAttachment = Instance.new("Attachment",childPart:get())
            local childBeam = Instance.new("Beam",nil,{
                ["Texture"] = "http://www.roblox.com/asset/?id=9449395070",
                ["TextureMode"] = Enum.TextureMode.Stretch,
                ["LightEmission"] = 1,
                ["Color"] = ColorSequence.new(Color3.fromRGB(0,0,255)),
                ["LightInfluence"] = 0,
                ["TextureSpeed"] = 2,
                ["Transparency"] = NumberSequence.new(0),
                ["Segments"] = 1,
                ["Attachment0"] = parentAttachment:get(),
                ["Attachment1"] = childAttachment:get(),
                ["Width1"] = 5,
                ["TextureLength"] = 5,
                ["Brightness"] = 10,
                ["ZOffset"] = 1
            })


            
local childPart = Instance.new("Part",nil,{
                ["Anchored"] = true,
                ["Size"] = Vector3.zero,
                ["Transparency"] = 1,
                ["Position"] = interactable.WorldPivot.Position
            })
            local childAttachment = Instance.new("Attachment",childPart:get())
            local childBeam = Instance.new("Beam",nil,{
                ["Texture"] = "http://www.roblox.com/asset/?id=9449395070",
                ["TextureMode"] = Enum.TextureMode.Stretch,
                ["LightEmission"] = 1,
                ["Color"] = ColorSequence.new(Color3.fromRGB(255,255,0)),
                ["LightInfluence"] = 0,
                ["TextureSpeed"] = 2,
                ["Transparency"] = NumberSequence.new(0),
                ["Segments"] = 1,
                ["Attachment0"] = parentAttachment:get(),
                ["Attachment1"] = childAttachment:get(),
                ["Width1"] = 5,
                ["TextureLength"] = 5,
                ["Brightness"] = 10,
                ["ZOffset"] = 1
            })
]]