
local filesystem = require("fs")

local constants = require("./constants")

local module = {}

local methods = {}
methods.__index = methods


function methods:loadCommandProcessors()
  for file, filetype in filesystem.scandirSync("./command/modules") do
    if filetype == "file" then
      local full_filename  = file
      local file_extension = full_filename:match('%.[^.]+$')
      local has_extension  = file_extension ~= nil
      local isLuaFile = has_extension and file_extension == ".lua"

      if isLuaFile then
        local module_name = full_filename:match('^(.-)%.[^.]+$')
        --print("moduleName:"..module_name)
        local commandProcessor = require("./command/modules/".. module_name)
        local processorType = commandProcessor[constants.KEY_PROCESSOR_TYPE]
        local processorFunction = commandProcessor[constants.KEY_PROCESSOR_FUNCTION]

        if processorType == constants.ProcessorTypes.CREATED_MESSAGE_PROCESSOR then
          table.insert(self._createdMessageProcessors, processorFunction)
        end
      end
    end
  end
end


function methods:processCreatedMessage(message)
  for i = 1, #self._createdMessageProcessors do
    local process = self._createdMessageProcessors[i]
    process(message)
  end
end


function methods:processUpdatedMessage(message)
  for i = 1, #self._updatedMessageProcessors do
    local process = self._updatedMessageProcessors[i]
    process(message)
  end
end


function module.new()
  local obj = setmetatable({}, methods)

  obj._createdMessageProcessors = {}
  obj._updatedMessageProcessors = {}

  obj:loadCommandProcessors()
  return obj
end


return module
