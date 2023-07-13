local Players = game:GetService("Players")
local Player = {}
Player.__index = Player
Player.players = {}

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

function Player.getPlayerByInstance(player)
    if Player.players[player.Name] then
        return Player.players[player.Name]
    else
        return nil
    end
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


function Player:onRemoving()
    --TODO:Cuando el player salga
end

function Player:addStructure(structure)
    table.insert(self.OWNEDSTRUCTURES,structure)
end


function Player.new(player)
    local self = Player.getPlayerByInstance(player)
    if self then return self end

    self = {}

    self.PLAYER = player
    self.money = 0
    Player.newMoneyValue(self,player)
    self.OWNEDSTRUCTURES = {}
    self.MONEYVALUE.Value = self.money

    return setmetatable(self,Player)
end

Players.PlayerAdded:Connect(function(player)
    Player.new(player)
end)

Players.PlayerRemoving:Connect(function(player)
    --TODO:hacerlo mas adelante
    --Player.getPlayerByInstance(player):onRemoving()
end
)

return Player