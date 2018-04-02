UOService = Class.extend(UOObject, {
  
  GetName = function (self)
    if self.Name ~= nil then
      return self.Name
    else
      return "unnamed-service"
    end
  end
})