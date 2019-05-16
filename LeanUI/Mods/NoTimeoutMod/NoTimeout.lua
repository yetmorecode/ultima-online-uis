-- Print a message every XX seconds
local INTERVAL = 30
-- Channels are: /say, /chat, /guild, /alliance, /party, ...
local CHANNEL = L"/say"
-- Actual message to print
local MESSAGE = L"test"

NoTimeout = {
  timePassed = 0,

  Update = function (timePassed) 
    NoTimeout.timePassed = NoTimeout.timePassed + timePassed
    if NoTimeout.timePassed > INTERVAL then
      NoTimeout.timePassed = 0
      --SendChat(CHANNEL, MESSAGE)
    end
  end
}