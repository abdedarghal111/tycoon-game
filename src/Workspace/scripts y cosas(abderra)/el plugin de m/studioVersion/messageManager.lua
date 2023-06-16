local messagesManager = {
	
}
local messages = {}
messages[0] = "Code prints."
messages[1] = "/1 has no model parent."
messages[2] = "You aren't selecting nothing."
messages[3] = "/1 selected."
messages[4] = "/1 unselected."
messages[5] = [["/1" is not a number.]]
messages[6] = [["/1" aplied to /2.]]
messages[7] = [["/1" have to go without decimals.]]
messages[8] = [[The string "/1" in /2 propriety is empty(Unapplied).]]
messages[9] = "Nothing selected."

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

function messagesManager.warnMessageGsub(messageNum,...)
	local message = messages[messageNum]
	for index,string in pairs({...}) do
		message = message:gsub("/"..index,string)
	end
	warn(message)
end


return messagesManager