
local constants = require("../constants")

local SCHEDULE_COMMANDS = {"!schedule", "!streams"}

local function isScheduleCommand(rawMessage)
  for i = 1, #SCHEDULE_COMMANDS do
    local scheduleCommand = SCHEDULE_COMMANDS[i]
    local msg = string.lower(rawMessage)
    if msg == scheduleCommand then
      return true
    end
  end
  return false
end

local function processMessage(msgObj)
  local rawMessage = msgObj.content
  local channel = msgObj.channel
  local scheduleInfo = [[Most Tuesdays and Thursdays usually from around 8:15 to 16:15 CEST (UTC+2).]]

  if isScheduleCommand(rawMessage) then
    channel:send(("SCHEDULE: %s"):format(scheduleInfo))
  end
end

return {
  [constants.KEY_PROCESSOR_TYPE] = constants.ProcessorTypes.CREATED_MESSAGE_PROCESSOR,
  [constants.KEY_PROCESSOR_FUNCTION] = processMessage
}