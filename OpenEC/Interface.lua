
function Interface.CreatePlayWindowSet()

  DebugService.PrintToChat("OpenEC version 0.1")

  -- Register standard update loops
  UpdateLoopService:AddLoop(UpdateLoopService.LOOP_ALWAYS, Class.create(UpdateLoop, {
    interval = 25
  }))
  UpdateLoopService:AddLoop(UpdateLoopService.LOOP_250MS, Class.create(UpdateLoop, {
    interval = 250
  }))
  UpdateLoopService:AddLoop(UpdateLoopService.LOOP_1000MS, Class.create(UpdateLoop, {
    interval = 1000
  }))
  UpdateLoopService:AddLoop(UpdateLoopService.LOOP_3000MS, Class.create(UpdateLoop, {
    interval = 3000
  }))
end

function Interface.Update(timePassed)
  UpdateLoopService:OnUpdate (timePassed)
end

function Interface.Shutdown()

end