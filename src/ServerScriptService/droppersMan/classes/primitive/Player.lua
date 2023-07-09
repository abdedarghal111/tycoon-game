local Player = {}
Player.__index = Player

function Player.newMoneyValue(self,player)
    if not player:FindFirstChild("leaderstats") then
        local leaderstats = Instance.new("Folder")
        leaderstats.Parent = player
        leaderstats.Name = "leaderstats"
    end
    self.MONEYVALUE = Instance.new("NumberValue")
    self.MONEYVALUE.Name = "Money"
    self.MONEYVALUE.Parent = player.leaderstats
end


function Player:getMoney()
    return self.money
end

function Player:setMoney(money)
    self.money = money
    self.MONEYVALUE.Value = money
end

function Player:giveMoney(money)
    self.money += money
    self.MONEYVALUE.Value += money
end

function Player:removeMoney(money)
    self.money -= money
    self.MONEYVALUE.Value -= money
end


function Player:get()
    return self.PLAYER
end

function Player:getName()
    return self.PLAYER.Name
end


--[[
function Player:onAdded()
    
end

function Player:onRemoved()
    
end
]]

function Player:addStructure(structure)
    table.insert(self.OWNEDSTRUCTURES,structure)
end


function Player.new(player)
    local self = {}

    self.PLAYER = player
    self.money = 1000
    Player.newMoneyValue(self,player)
    self.OWNEDSTRUCTURES = {}
    self.MONEYVALUE.Value = self.money

    return setmetatable(self,Player)
end

return Player