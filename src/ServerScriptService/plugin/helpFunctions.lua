local ChangeHistoryService = game:GetService("ChangeHistoryService")

local helpFunctions = {}

function helpFunctions:recordChange(nameOfChange)
    return ChangeHistoryService:TryBeginRecording(nameOfChange,nameOfChange)
end

function helpFunctions:stopRecordingChange(previusRecord)
    ChangeHistoryService:FinishRecording(previusRecord,Enum.FinishRecordingOperation.Commit)
end

function helpFunctions:getInstancePath(instance)
    local parent = instance.Parent
    local str = parent.Name.."/"..instance.Name
    while not parent == workspace do
        local model = parent
        parent = model.Parent
        str = parent.Name.."/"..model.Name
    end

    return str
end

function helpFunctions:isAButton(model)
    if model and model:FindFirstChild("type") and (model.type.Value == "AnimatedButton" or model.type == "Button") then
        return true
    else
        return false
    end
end


return helpFunctions