local ClientService = {
  
  Quit = function (self)
    BroadcastEvent (SystemData.Events.EXIT_GAME)
  end,
  
  Logout = function (self)
    BroadcastEvent (SystemData.Events.LOG_OUT)
  end
  
}

OpenCore:RegisterServiceClass("Client.ClientService", "Client", ClientService)
