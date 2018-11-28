


local moduleCommandProcessor = require("./command/Processor")
local CommandProcessor = moduleCommandProcessor.new()


local module = {}

function module:client_ready(clientObj)

end


function module:client_messageCreate(messageObj)
  CommandProcessor:processCreatedMessage(messageObj)
end


function module:client_messageUpdated(messageObj)
  CommandProcessor:processUpdatedMessage(messageObj)
end


return module