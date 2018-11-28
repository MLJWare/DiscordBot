
local Constants = require("../Constants")

local function ProcessMessage(msgObj)
  local msg = msgObj.content
  local channel = msgObj.channel
  local server_owner = msgObj.guild.owner.name

  if string.lower(msg) == "!king" then
    channel:send(("%s is king!"):format(server_owner))
  end
end

return {
  [Constants.KEY_PROCESSOR_TYPE] = Constants.ProcessorTypes.CREATED_MESSAGE_PROCESSOR,
  [Constants.KEY_PROCESSOR_FUNCTION] = ProcessMessage
}