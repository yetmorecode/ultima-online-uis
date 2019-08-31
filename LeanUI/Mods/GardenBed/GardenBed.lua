GardenBed = {
  MAX_PLANTS = 8,
  MAX_SEEDS = 8
}

local this = GardenBed

function this.Initialize()
  this.GARDEN_BED_GUMP = 29842
  this.GARDEN_BED_HARVEST_GUMP = 22222

  this.active = false
  this.timePassed = 0
  this.seedToPickup = this.MAX_SEEDS
  this.plantsToPickup = this.MAX_PLANTS
  this.hasHarvestOpen = false
  this.closeGump = false
end

function this.SetAutoHarvest(harvest)
  this.active = harvest == true
end

function this.SetDecorativePlants(decorative)
  this.setToDecorative = decorative == true
end

function this.Update(timePassed)
  if not this.active then
    return
  end
  this.timePassed = this.timePassed + timePassed
  if this.timePassed > 1 then
    this.timePassed = 0
    this.Pickup()
  end
end

function this.Pickup()
  -- has open plant gump?
  if GumpData.Gumps[this.GARDEN_BED_GUMP] ~= nil then
    if this.closeGump then
      GGManager.destroyWindow(GumpData.Gumps[this.GARDEN_BED_GUMP].windowName)
      this.closeGump = false
    else
      -- open harvest gump
      GumpsParsing.PressButton(this.GARDEN_BED_GUMP, 1)
      this.seedToPickup = this.MAX_SEEDS
      this.plantsToPickup = this.MAX_PLANTS
    end
    return
  end
  
  -- has open harvest gump?
  if GumpData.Gumps[this.GARDEN_BED_HARVEST_GUMP] ~= nil then
    if this.seedToPickup > 0 then
      this.seedToPickup = this.seedToPickup - 1
      GumpsParsing.PressButton(this.GARDEN_BED_HARVEST_GUMP, 6)
    elseif this.plantsToPickup > 0 then
      this.plantsToPickup = this.plantsToPickup - 1
      GumpsParsing.PressButton(this.GARDEN_BED_HARVEST_GUMP, 7)
    else
      GumpsParsing.PressButton(this.GARDEN_BED_HARVEST_GUMP, 1)
      this.closeGump = true
    end
  end
end