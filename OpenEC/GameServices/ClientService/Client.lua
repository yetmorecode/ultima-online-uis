Client = Class.define({
  
  Quit = function ()
    BroadcastEvent (SystemData.Events.EXIT_GAME)
  end,
  
  Logout = function ()
    BroadcastEvent (SystemData.Events.LOG_OUT)
  end
  
})