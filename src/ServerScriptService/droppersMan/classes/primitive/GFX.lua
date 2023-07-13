local GFX = {}
GFX.__index = GFX

function GFX:play(GFXname)
    local GFXfunc = self.GFX[GFXname]
    if GFXfunc then
        GFXfunc()
    end
end

function GFX.new(model)
    local self = {}
    
    self.GFX = model:FindFirstChild("GFX") and require(model.GFX) or {}

    return setmetatable(self,GFX)
end

return GFX