

local constants = require("../constants")

local HELP_COMMANDS = {"!commands", "!help"}


local function isHelpCommand(rawMessage)
  for i = 1, #HELP_COMMANDS do
    local helpCommand = HELP_COMMANDS[i]
    local msg = string.lower(rawMessage)
    if msg == helpCommand then
      return true
    end
  end
  return false
end


local function processMessage(msgObj)
  local rawMessage = msgObj.content
  local channel = msgObj.channel
  local server_owner = msgObj.guild.owner.name

  if isHelpCommand(rawMessage) then
    channel:send(([[
      !schedulen\
      !king
    ]]):format(server_owner))
  end
end


return {
  [constants.KEY_PROCESSOR_TYPE] = constants.ProcessorTypes.CREATED_MESSAGE_PROCESSOR,
  [constants.KEY_PROCESSOR_FUNCTION] = processMessage
}