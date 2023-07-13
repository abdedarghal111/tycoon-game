local Animation = {}
Animation.__index = Animation

local GFX = require(script.Parent.GFX)

function Animation:play(animName:string)
    local animation : AnimationTrack = self.ANIMATIONS[animName]
    
    if animation and not animation.IsPlaying then
        animation:Play()
    end
    self.GFX:play(animName)
end

function Animation:showModel()
    for i,v in pairs(self.MODEL:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = 0
		end
	end
end

function Animation:hideModel()
    for i,v in pairs(self.MODEL:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
		end
	end
end

function Animation.new(model)
    local self = {}

    self.MODEL = model
    self.ANIMATIONCONTROLLER = model.AnimationController
    self.ANIMATOR = model.AnimationController.Animator
    self.HUMANOIDROOTPART = model.HumanoidRootPart
    self.GFX = GFX.new(model.GFX)
    self.ANIMATIONS = {}
    for i,v in pairs(model.Animaciones:GetChildren()) do
        self.ANIMATIONS[v.Name] = self.ANIMATOR:LoadAnimation(v)
    end

    return setmetatable(self,Animation)
end

return Animation