ShipCannonState = {
    UNLOADED = 0,
    LOADING = 1,
    LOADED = 2
}


ShipCannon = Class.define({
    state = ShipCannonState.UNLOADED,
    
    shouldPrepare = false,
    shouldFire = false,
    
    
    __construct = function (self)
    
    end,
    
    Fire = function (self) 
        if self.state == ShipCannonSatte.UNLOADED then
            self:Prepare()
        end
        
    end,
    
    Prepare = function (self)
        self.shouldPrepare = 1
    end,
    
    GetState = function (self)
        return self.state
    end

})