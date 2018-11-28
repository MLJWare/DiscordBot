
local Constants = require("../Constants")

local SCHEDULE_COMMANDS = {"!schedule", "streams"}

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

local function ProcessMessage(msgObj)
  local rawMessage = msgObj.content
  local channel = msgObj.channel
  local scheduleInfo = [[Most Tuesdays and Thursdays usually from around 8:15 to 16:15 CEST (UTC+2).]]

  if isScheduleCommand(rawMessage) then
    channel:send(("SCHEDULE: %s"):format(scheduleInfo))
  end
end

return {
  [Constants.KEY_PROCESSOR_TYPE] = Constants.ProcessorTypes.CREATED_MESSAGE_PROCESSOR,
  [Constants.KEY_PROCESSOR_FUNCTION] = ProcessMessage
}