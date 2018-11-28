


local moduleCommandProcessor = require("./command/CommandProcessor")
local CommandProcessor = moduleCommandProcessor.new()


local module = {}

function module:client_ready(clientObj)

end


function module:client_messageCreate(messageObj)
  CommandProcessor:ProcessCreatedMessage(messageObj)
end


function module:client_messageUpdated(messageObj)
  CommandProcessor:ProcessUpdatedMessage(messageObj)
end


return module