local Animation = {}
Animation.__index = Animation

function Animation:play(anim:string)
    local animation:AnimationTrack = self.ANIMATIONS[anim]
    local GFXfunc = self.GFX[anim]
    if not animation.IsPlaying then
        animation:Play()
        if GFXfunc then
            GFXfunc()
        end
    end
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
    self.GFX = model:FindFirstChild("GFX") and require(model.GFX) or {}
    self.ANIMATIONS = {}
    for i,v in pairs(model.Animaciones:GetChildren()) do
        self.ANIMATIONS[v.Name] = self.ANIMATOR:LoadAnimation(v)
    end

    return setmetatable(self,Animation)
end

return Animation