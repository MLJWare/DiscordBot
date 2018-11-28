
local discordia = require('discordia')
local client = discordia.Client()

local BotMain = require("./BotMain")


client:on('ready', function()
  BotMain:client_ready(client)
end)


client:on('messageCreate', function(message)
  BotMain:client_messageCreate(message)
end)


client:on('messageUpdate', function(message)
  BotMain:client_messageUpdated(message)
end)


client:run(require("./Server-token"))

return BotMain