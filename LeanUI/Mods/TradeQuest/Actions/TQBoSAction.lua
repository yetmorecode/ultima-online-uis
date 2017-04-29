local this = {}

TQBoSAction = this

this.cleanBackpack = true
this.usedBag = false
this.timer = 0

function this.OnStart(manager)
  this.cleanBackpack = true
  this.usedBag = false
  this.timer = 0
  
  this.quest = manager.quest
end

function this.OnUpdate(manager, timePassed) 
  this.timer = this.timer + timePassed

  local bos = Item.FindInContainerByName(Player.BackpackId, L"A Bag Of Sending")
  -- boards
  local item = Item.FindInContainerByType(Player.BackpackId, 7127)
  -- leather
  if item == nil then
    item = Item.FindInContainerByType(Player.BackpackId, 4225)
  end
  -- granite
  if item == nil then
    item = Item.FindInContainerByType(Player.BackpackId, 6009)
  end
  
  if bos ~= nil and item ~= nil and not this.usedBag and this.timer > 0.5 then
    this.cleanBackpack = false
    
    Debug.PrintToChat("Found item to send to bank " .. item)
    DIKey2()
    
    this.usedBag = true
  else
    this.cleanBackpack = true
    this.usedBag = false
  end
  
  if this.usedBag and this.timer > 1.5 then
    HandleSingleLeftClkTarget(item)
    this.usedBag = false
  end

  if not this.usedBag and this.timer > 3 then
    if this.cleanBackpack then
      manager.AdvanceQuest()
    else
      this.OnStart(manager);
    end
  end
end
