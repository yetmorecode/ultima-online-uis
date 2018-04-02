DateTimeService = Class.define({
  GetDateString = function () 
    return Interface.Clock.YYYY .. "-" .. Interface.Clock.MM .. "-" .. Interface.Clock.DD
  end,
  
  GetTimeString = function () 
    return Interface.Clock.h .. "-" .. Interface.Clock.m .. "-" .. Interface.Clock.s
  end
})