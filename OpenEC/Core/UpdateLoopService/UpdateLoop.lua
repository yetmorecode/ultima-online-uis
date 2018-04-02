UpdateLoop = Class.extend(UOObject, {
  interval = 10000,
  deltaTime = 0,
  callbacks = {},
  
  construct = function (self)
    self.callbacks = {}
  end,
    
  AddCallback = function (self, cb) 
    table.insert (self.callbacks, cb)
  end,
  
  RemoveCallback = function (self, cb)
  
  end,
  
  Execute = function (self, timePassed) 
    if (self.deltaTime + timePassed * 1000 > self.interval) then 
      for k, callback in pairs (self.callbacks) do
        callback (self)
      end
      self.deltaTime = 0
    else
      self.deltaTime = self.deltaTime + timePassed * 1000
    end
  end,
  
  toString = function (self)
    return "UpdateLoop(interval=" .. self.interval .. "ms)"
  end
})