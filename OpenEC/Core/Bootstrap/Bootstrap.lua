Bootstrap = {};

--
-- Sets up update loops with different intervals
--
-- OpenEC by default support four update loops:
--  LOOP_ALWAYS - runs as often as possible / on each update run
--  LOOP_250MS  - runs only once per 250 milliseconds
--  LOOP_1000MS  - runs only once per second
--  LOOP_3000MS  - runs only once per three seconds
-- 
Bootstrap.InitializeUpdateLoops = function ()
  UpdateLoopService:AddLoop (UpdateLoopService.LOOP_ALWAYS, Class.create (UpdateLoop, {
    interval = 25
  }))
  UpdateLoopService:AddLoop (UpdateLoopService.LOOP_250MS, Class.create (UpdateLoop, {
    interval = 250
  }))
  UpdateLoopService:AddLoop (UpdateLoopService.LOOP_1000MS, Class.create (UpdateLoop, {
    interval = 1000
  }))
  UpdateLoopService:AddLoop (UpdateLoopService.LOOP_3000MS, Class.create (UpdateLoop, {
    interval = 3000
  }))
end