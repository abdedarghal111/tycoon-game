local messagesManager = {
	
}
local messages = {}
messages[0] = "Code prints."
messages[1] = "Part has no model parent."
messages[2] = "You aren't selecting nothing."
messages[3] = "/1 selected." --/1 = part.Name
messages[4] = "/1 unselected." --/1 = part.Name

function messagesManager.printMessage(messageNum)
	print(messages[messageNum])
end

function messagesManager.warnMessage(messageNum)
	warn(messages[messageNum])
end

function messagesManager.printMessageGsub(messageNum,...)
	local message = messages[messageNum]
	for index,string in pairs({...}) do
		message = message:gsub("/"..index,string)
	end
	print(message)
end


return messagesManager