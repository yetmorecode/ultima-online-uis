ShipCannonManager = {};

local this = ShipCannonManager

this.Cannons = {}

function this.Initialize()
    DebugService.PrintToChat("ShipCannonManager 0.1")
end

function this.Update(timePassed)

end

function this.GetCannon(self, id)
    if self.Cannons[id] ~= nil then
        return self.Cannons[id]
    else
        
    end
end 

function PrepCannon(self, id)
    local cannon = self:GetCannon(id)
    cannon:Prepare()
end

function FireCannon(self, id)
    local cannon = self:GetCannon(id)
    cannon:Fire()
end