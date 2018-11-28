
local filesystem = require("fs")

local Constants = require("./constants")

local module = {}

local methods = {}
methods.__index = methods


function methods:LoadCommandProcessors()
  for file, filetype in filesystem.scandirSync("./command/commandModules") do
    if filetype == "file" then
      local full_filename  = file
      local file_extension = full_filename:match('%.[^.]+$')
      local has_extension  = file_extension ~= nil
      local isLuaFile = has_extension and file_extension == ".lua"

      if isLuaFile then
        local module_name = full_filename:match('^(.-)%.[^.]+$')
        --print("moduleName:"..module_name)
        local commandProcessor = require("./command/commandModules/".. module_name)
        local processorType = commandProcessor[Constants.KEY_PROCESSOR_TYPE]
        local processorFunction = commandProcessor[Constants.KEY_PROCESSOR_FUNCTION]

        if processorType == Constants.ProcessorTypes.CREATED_MESSAGE_PROCESSOR then
          table.insert(self.CreatedMessageProcessors, processorFunction)
        end
      end
    end
  end
end


function methods:ProcessCreatedMessage(message)
  for i = 1, #self.CreatedMessageProcessors do
    local process = self.CreatedMessageProcessors[i]
    process(message)
  end
end


function methods:ProcessUpdatedMessage(message)
  for i = 1, #self.UpdatedMessageProcessors do
    local process = self.UpdatedMessageProcessors[i]
    process(message)
  end
end


function module.new()
  local obj = setmetatable({}, methods)

  obj.CreatedMessageProcessors = {}
  obj.UpdatedMessageProcessors = {}

  obj:LoadCommandProcessors()
  return obj
end


return module
