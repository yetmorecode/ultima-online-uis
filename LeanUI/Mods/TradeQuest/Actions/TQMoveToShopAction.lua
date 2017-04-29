local this = {}

TQMoveToShopAction = this

this.manager = manager

function this.OnStart(manager)
  this.manager = manager
  
  TradeQuestWindow.Update()
  this.MoveToShop()
end

function this.MoveToShop()
  Move.Path({
    {x = 3676, y = 2246},
    {x = 3684, y = 2238},
    {x = 3701, y = 2238},
    {x = 3709, y = 2246, random = 2}
  }, this.TargetReached)
end

function this.TargetReached()
  this.manager.AdvanceQuest()
end