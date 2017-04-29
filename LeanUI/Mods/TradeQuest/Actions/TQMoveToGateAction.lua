local this = {}

TQMoveToGateAction = this

this.manager = manager

function this.OnStart(manager)
  this.manager = manager
  
  TradeQuestWindow.Update()
  this.MoveToTarget()
end

function this.MoveToTarget()
  Move.Path({
    {x = 3701, y = 2238, random = 3},
    {x = 3687, y = 2238, random = 2},
    {x = 3679, y = 2230},
    {x = 3679, y = 2156, random =  2},
    {x = 3594, y = 2157},
    {x = 3576, y = 2135},
    {x = 3563, y = 2139, tolerance = 1},
  }, this.TargetReached)
end

function this.TargetReached()
  this.manager.AdvanceQuest()
end