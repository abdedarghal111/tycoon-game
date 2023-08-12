local Animation = {}
Animation.__index = Animation

local GFX = require(script.Parent.GFX)
local DecorationInfo = require(script.Parent.DecorationInfo)

function Animation:play(animName:string)
    local animation : AnimationTrack = self.ANIMATIONS[animName]
    
    if animation and not animation.IsPlaying then
        animation:Play()
    end
    self.GFX:play(animName,animation)
end

function Animation:showModel()
    for index,part,properties in self.DECORATIONINFO:iterateOverParts() do
        if not properties then continue end
        for property,value in pairs(properties) do
            part[property] = value
        end
    end
end

function Animation:hideModel()
    self.DECORATIONINFO:setInvisibleAllParts()
end

function Animation.new(model)
    local self = {}

    self.MODEL = model
    self.DECORATIONINFO = DecorationInfo.new(model)
    self.ANIMATIONCONTROLLER = model.AnimationController
    self.ANIMATOR = model.AnimationController.Animator
    self.HUMANOIDROOTPART = model.HumanoidRootPart
    self.GFX = GFX.new(model)
    self.ANIMATIONS = {}
    for i,v in pairs(model.Animaciones:GetChildren()) do
        self.ANIMATIONS[v.Name] = self.ANIMATOR:LoadAnimation(v)
    end

    return setmetatable(self,Animation)
end

return Animation