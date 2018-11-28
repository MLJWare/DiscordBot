
local constants = require("../constants")

local function processMessage(msgObj)
  local msg = msgObj.content
  local channel = msgObj.channel
  local server_owner = msgObj.guild.owner.name

  if string.lower(msg) == "!king" then
    channel:send(("%s is king!"):format(server_owner))
  end
end

return {
  [constants.KEY_PROCESSOR_TYPE] = constants.ProcessorTypes.CREATED_MESSAGE_PROCESSOR,
  [constants.KEY_PROCESSOR_FUNCTION] = processMessage
}