local players = game:GetService("Players")

local TemporalObjects = {}
TemporalObjects.__index = TemporalObjects
TemporalObjects.type = "TemporalObject"
TemporalObjects.objects = {} -- ["playerName"] = {"tabla1" = {},"tabla2" = {}}
TemporalObjects.currentActiveTable = 1
TemporalObjects.COOLDOWN = 30
TemporalObjects.tableCount = 0

function TemporalObjects.giveId(object,player)
	local posicion = TemporalObjects.tableCount + 1
	TemporalObjects.objects[player.Name][TemporalObjects.currentActiveTable][posicion] = object

	return posicion
end

function TemporalObjects.getObject(model)
    if not model:GetAttribute("type") == TemporalObjects.type then return end

    local ID = model:GetAttribute("ID")
    local ASOCIATEDTABLE = model:GetAttribute("ASOCIATEDTABLE")
    local OWNER = players[model:GetAttribute("player")]

    return TemporalObjects.objects[OWNER][ASOCIATEDTABLE][ID]
end

function TemporalObjects:isA(type)
    if type == TemporalObjects.type then
        return true
    end
end

function TemporalObjects:destroy()
    self.MODEL:Destroy()
    --TemporalObjects.objects[self.OWNER][self.ASOCIATEDTABLE][self.ID] = nil
end

function TemporalObjects.new(model,player)
    local self = {}

    self.ID = TemporalObjects.giveId(self,player)
    self.ASOCIATEDTABLE = TemporalObjects.currentActiveTable
    self.MODEL = model
    self.OWNER = player or error("didn' gave any player")
    self.type = TemporalObjects.type

    model:SetAttribute("ID",self.ID)
    model:SetAttribute("ASOCIATEDTABLE",self.ASOCIATEDTABLE)
    model:SetAttribute("OWNER",self.OWNER.Name)
    model:SetAttribute("type",TemporalObjects.type)

    return setmetatable(self,TemporalObjects)
end

players.PlayerAdded:Connect(function(player)
    TemporalObjects.objects[player.Name] = {}
end)

players.PlayerRemoving:Connect(function(player)
    for _,object in pairs(TemporalObjects.objects[player.Name]) do
        object:destroy()
    end
    TemporalObjects.objects[player.Name] = nil
end)

local function clearTable(tableNumber)
    for playerIndex,_ in pairs(TemporalObjects.objects) do
        --Pasar por todos los valores de la tabla indicada por todos los jugadores
        local lastValue,lastIndex = next(TemporalObjects[playerIndex][tableNumber], nil)
        while lastValue do
            lastIndex,lastValue = next(TemporalObjects[playerIndex][tableNumber], lastIndex)
            TemporalObjects[playerIndex][tableNumber][lastIndex]:destroy()
        end
        --al finalizar crear una nueva limpia
        TemporalObjects[playerIndex][tableNumber] = {}
    end
end

task.spawn(function()
    while task.wait() do
        TemporalObjects.currentActiveTable = 1
        TemporalObjects.tableCount = 0
        task.wait(TemporalObjects.COOLDOWN)
        clearTable(2)
        TemporalObjects.currentActiveTable = 2
        TemporalObjects.tableCount = 0
        task.wait(TemporalObjects.COOLDOWN)
        clearTable(1)
    end
end)

return TemporalObjects