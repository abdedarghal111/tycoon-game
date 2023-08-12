local DecorationInfo = {}
DecorationInfo.__index = DecorationInfo

function DecorationInfo:getPartInfo(part)
    local index = table.find(self.partsInfo,part)
    local partInfo = self.partsInfo[index]

    return partInfo,index
end

function DecorationInfo:iterateOverParts()
    --for part,stats in self:iterateOverParts() do
    --funcion,tabla,inicial
    local function iterar(tabla,index)
        local index,instancia = next(tabla,index)
        local partInfo = self.partsInfo[index]

        return index,instancia,partInfo
    end
    
    return iterar,self.parts,nil
end

function DecorationInfo:setInvisibleAllParts()
    for partIndex,part in pairs(self.parts) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            part.CanQuery = false
            part.CanTouch = false
            part.Massless = true
            part.Transparency = 1
        end
    end
end



function DecorationInfo.new(decorationFolder)
    local self = {}

    self.partsInfo = {}

    --local decorationFolder = model:FindFirstChild("Partes de decoracion")
    self.parts = decorationFolder:GetDescendants()
    
    for partIndex,part in pairs(self.parts) do
        if part:IsA("BasePart") then
            self.partsInfo[partIndex] = {
                ["Transparency"] = part.Transparency,
                ["CanCollide"] = part.CanCollide,
                ["CanTouch"] = part.CanTouch,
                ["CanQuery"] = part.CanQuery,
                ["Massless"] = part.Massless
            }
        end
    end

    return setmetatable(self,DecorationInfo)
end

return DecorationInfo