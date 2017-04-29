local this = {}

Quest = this

this.active = false
this.paused = false

this.index = 1
this.quest = nil
this.actions = nil
this.action = nil

this.actionCooldown = 1
this.actionCooldownTimer = 0

this.time = 0

function this.Initialize(quest)
  this.quest = quest
  
  this.actions = quest.GetActions()
  this.index = 1
  this.action = this.actions[this.index]
end

function this.Update(timePassed)

  this.time =  this.time + timePassed

  if this.actionCooldownTimer > 0 then
    Debug.PrintToChat("cooldown " .. this.actionCooldownTimer)
    this.actionCooldownTimer = this.actionCooldownTimer - timePassed
    return
  end
  
  if not this.active then
    return
  end
  
  if this.paused then
    return
  end
  
  if this.quest ~= nil then
    if this.quest.OnUpdate ~= nil then
      this.quest.OnUpdate(this, timePassed)
    end
  end
  
  if this.action ~= nil then
    if this.action.OnUpdate ~= nil then
      this.action.OnUpdate(this, timePassed)
    end
  end
  
end

function this.AdvanceQuest()
  Debug.PrintToChat("advancing quest!")
  this.index = this.index + 1
  
  if this.index > table.getn(this.actions) then
    this.Stop()
    this.action = nil
    this.Start()
  else
    --this.actionCooldownTimer = this.actionCooldown
    this.action = this.actions[this.index]
    
    if this.action.OnStart ~= nil then
      this.action.OnStart(this)
    end
  end
end

function this.Start()
  Debug.PrintToChat("Starting quest")
  this.active = true
  this.time = 0
  this.index = 1
  this.action = this.actions[this.index]
  
  if this.quest ~= nil and this.quest.OnStart ~= nil then
    this.quest.OnStart(this)
  end
  
  if this.action ~= nil and this.action.OnStart ~= nil then
    this.action.OnStart(this)
  end
end

function this.Pause()
  this.paused = true
end

function this.Resume()
  this.paused = false
end

function this.Stop()
  this.active = false
  Debug.PrintToChat("Stopping quest")  
  
  if this.quest ~= nil and this.quest.OnStop ~= nil then
    this.quest.OnStop(this)
  end
  
  if this.action ~= nil and this.action.OnStop ~= nil then
    this.action.OnStop(this)
  end
end