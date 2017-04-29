local this = {}

TQSubmitCrateAction = this

this.requested = false
this.accepted = false
this.timer = 0

function this.OnStart(manager)
  this.requested = false
  this.accepted = false
  this.timer = 0
  
  this.quest = manager.quest
end

function this.OnUpdate(manager, timePassed) 
  this.timer = this.timer + timePassed

  if not this.requested and this.timer > 1 then
    this.RequestTurnin()
    this.requested = true
  end
  
  if this.requested and not this.accepted and this.timer > 2 then
    this.TargetTurnin()
    this.accepted = true
  end
  
  if this.requested and this.accepted  and this.timer > 4 then
    local ct = manager.quest.GetContainerId()
    if ctId == nil then
      manager.AdvanceQuest()
    end
  end
  
  if this.timer > 6 then
    -- reset and try again
    this.OnStart(manager)
  end
end

function this.RequestTurnin()
  local id = this.quest.GetNearestTradeMinister()
  
  RequestContextMenu(id)
  WindowData.ContextMenu.returnCode = 352
  BroadcastEvent(SystemData.Events.CONTEXT_MENU_SELECTED)
end

function this.TargetTurnin()
  HandleSingleLeftClkTarget(this.quest.GetContainerId())
end
