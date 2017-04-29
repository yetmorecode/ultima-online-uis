Class = {
  extend = function (base, proto)
    proto = proto or {}
    setmetatable (proto, base)
    base.__index = base
    return proto
  end,
  
  define = function (o)
    o = o or {}
    if (o.construct ~= nil) then
      o:construct()
    end
    return o
  end,
  
  create = function (clazz, o) 
    o = o or {}
    setmetatable (o, clazz)
    clazz.__index = clazz
    if (o.construct ~= nil) then
      o:construct()
    end
    return o
  end
}