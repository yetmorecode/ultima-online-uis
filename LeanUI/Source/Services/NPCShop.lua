local this = {}

NPCShop = this

NPCShop.TAILOR = "Tailor"
NPCShop.BLACKSMITH = "Blacksmith"

function this.FindShopTypeByObject(id)
  local data =  Item.GetObjectInfo(id)
  
  Debug.D(data)
  
  return NPCShop.Tailor;
end