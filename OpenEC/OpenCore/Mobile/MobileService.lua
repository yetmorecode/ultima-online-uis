local MobileService = {

  NOTORIETY_NONE = 1, 
  NOTORIETY_INNOCENT = 2,
  NOTORIETY_FRIEND = 3,
  NOTORIETY_CANATTACK = 4,
  NOTORIETY_CRIMINAL = 5, 
  NOTORIETY_ENEMY = 6, 
  NOTORIETY_MURDERER = 7, 
  NOTORIETY_INVULNERABLE = 8,

  Initialize = function (self)
  
  end,
  
  Shutdown = function (self)
  
  end

}
OpenCore:RegisterServiceClass("Mobile.MobileService", "Mobile", MobileService)