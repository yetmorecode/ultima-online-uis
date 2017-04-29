
local this = {}

HotbarWidget = this

this.Name = "Hotbar Widget"
this.Description = "A widget providing hotbar slots in the sidebar"

this.wnd = "HotbarWidget"
this.template = this.wnd.."Template"

this.id1 = nil
this.id2 = nil

local modFolder = "./UserInterface/"..SystemData.Settings.Interface.customUiName.."/Mods/SidebarWidgets/Widgets/"..this.wnd
LoadResources(modFolder, this.wnd..".xml", this.wnd..".xml")

function this.OnAdded(sidebar)

  this.sidebar = sidebar
  
  this.id1 = Interface.LoadNumber("HotbarWidget.Id1", nil)
  this.id2 = Interface.LoadNumber("HotbarWidget.Id2", nil)
  
  this.InitHotbar("HotbarWidget.Id1", this.id1)
  this.InitHotbar("HotbarWidget.Id2", this.id2)  
end

function this.InitHotbar(name, id)

  if id == nil then
    id = HotbarSystem.GetNextCustomHotbarId()
  end 
  
  if not this.HotbarExists(id) then
    Debug.PrintToChat("Hotbar "..id.." not existing -> created")
    HotbarRegisterNew(id)
    SystemData.Hotbar[id].Locked = false
  
    for slot = 1, Hotbar.NUM_BUTTONS do  
      HotbarClearItem(id, slot)
    end
  end
  
  Interface.SaveNumber(name, id)
end

function this.HotbarExists(id)
  for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
    if hotbarId == id then
      return true
    end
  end
  
  return false
end

function this.OnCreateWindow(sidebar, width, parent)

  CreateWindowFromTemplateShow(this.wnd, this.template, parent, true)
  
  local hotbarId = this.id1
  for slot = 1, Hotbar.NUM_BUTTONS do
     local element = "HotbarWidgetRow1".."Button"..slot
     local key = SystemData.Hotbar[hotbarId].BindingDisplayStrings[slot]
     
     HotbarSystem.UpdateBinding(element, key)
     HotbarSystem.ClearActionIcon(element, hotbarId, slot, 0)
     HotbarSystem.RegisterAction(element, hotbarId, slot, 0)
  end 
  
  hotbarId = this.id2
  for slot = 1, Hotbar.NUM_BUTTONS do
     local element = "HotbarWidgetRow2".."Button"..slot
     local key = SystemData.Hotbar[hotbarId].BindingDisplayStrings[slot]
     
     HotbarSystem.UpdateBinding(element, key)
     HotbarSystem.ClearActionIcon(element, hotbarId, slot, 0)
     
     --if HotbarHasItem(hotbarId, slot) then
     HotbarSystem.RegisterAction(element, hotbarId, slot, 0)
     --end
  end
  
end

function this.ClearAll()
  local hotbarId = this.id1
  for slot = 1, Hotbar.NUM_BUTTONS do
     local element = "HotbarWidgetRow1".."Button"..slot
     local key = SystemData.Hotbar[hotbarId].BindingDisplayStrings[slot]
     
     HotbarSystem.UpdateBinding(element, key)
     HotbarSystem.ClearActionIcon(element, hotbarId, slot, 0)
  end 
  
  hotbarId = this.id2
  for slot = 1, Hotbar.NUM_BUTTONS do
     local element = "HotbarWidgetRow2".."Button"..slot
     local key = SystemData.Hotbar[hotbarId].BindingDisplayStrings[slot]
     
     HotbarSystem.UpdateBinding(element, key)
     HotbarSystem.ClearActionIcon(element, hotbarId, slot, 0)
  end
end

function this.OnResize(width, height) 
  WindowSetDimensions("HotbarWidgetRow1", width, 100)
  WindowSetDimensions("HotbarWidgetRow2", width, 100)
end

function this.GetParentWindowName()
  if string.find(SystemData.ActiveWindow.name, "HotbarWidgetRow1") then
    return "HotbarWidgetRow1"
  else
    return "HotbarWidgetRow2"
  end
end

--
-- Dropping an action to an hotbar slot (drag and drop)
--
function this.ItemLButtonUp()

  local wnd = this.GetParentWindowName()
  local hotbarId
  if wnd == "HotbarWidgetRow1" then
    hotbarId = this.id1
  else
    hotbarId = this.id2
  end
  local slot = WindowGetId(SystemData.ActiveWindow.name)
  local element = wnd.."Button"..slot
  
  if( SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_NONE ) then    
      local dropSuccess = DragSlotDropAction(hotbarId,slot,0)
      
      if( dropSuccess ) then     
          HotbarSystem.ClearActionIcon(element, hotbarId, slot, 0)
          HotbarSystem.RegisterAction(element, hotbarId, slot, 0)
          
          --local actionType = UserActionGetType(hotbarId,slot,0)  
          --local hasItem = HotbarHasItem(hotbarId, slot)
          
          --local slotWindow = "Hotbar"..hotbarId.."Button"..slot
          --ActionEditWindow.OpenEditWindow(actionType,slotWindow,hotbarId,slot)      
    end
  elseif( slot == Hotbar.CurrentUseSlot and hotbarId == Hotbar.CurrentUseHotbar ) then
    if HotbarHasItem(hotbarId, slot) then
        HotbarExecuteItem(hotbarId, slot)
    end
  end
end

--
-- clicking and using an slot
--
function this.ItemLButtonDown()
    
  local wnd = this.GetParentWindowName()
  local hotbarId
  if wnd == "HotbarWidgetRow1" then
    hotbarId = this.id1
  else
    hotbarId = this.id2
  end
  local slot = WindowGetId(SystemData.ActiveWindow.name)
  local element = wnd.."Button"..slot
  local itemIndex = slot
    
  if WindowData.Cursor ~= nil and WindowData.Cursor.target == true and hotbarId ~= 0 then    
    if UserActionGetType( hotbarId, slot, 0 ) == SystemData.UserAction.TYPE_USE_ITEM then
      local objID = UserActionGetId(hotbarId, slot, 0)
      if objID
      and objID ~= 0 
      --and (not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ))
      then
        HandleSingleLeftClkTarget(objID)
        Hotbar.CurrentUseHotbar = nil
        Hotbar.CurrentUseSlot = nil
      end
    elseif UserActionGetType( hotbarId, slot, 0 ) == SystemData.UserAction.TYPE_USE_OBJECTTYPE then
      local specID = UserActionGetId(hotbarId, slot, 0)
      if specID and specID ~= 0 then
        local objID = UserActionGetNextObjectId(specID)
        if objID 
        and objID ~= 0 
        and (not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ))
        then
          HandleSingleLeftClkTarget(objID)
          Hotbar.CurrentUseHotbar = nil
          Hotbar.CurrentUseSlot = nil
        end
      end
    else
      if HotbarHasItem(hotbarId, itemIndex)
      --and (not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" ))
      then
        Hotbar.CurrentUseHotbar = hotbarId
        Hotbar.CurrentUseSlot = slot
      end
    end
  else
    if HotbarHasItem(hotbarId, itemIndex) then
      if not SystemData.Hotbar[hotbarId].Locked then
        DragSlotSetExistingActionMouseClickData(hotbarId,slot,0)
      end

      --if (not WindowGetShowing("Hotbar"..hotbarId.."Button"..slot.."Disabled" )) then
        Hotbar.CurrentUseHotbar = hotbarId
        Hotbar.CurrentUseSlot = slot
      --end
    end
  end
end

--
-- context menu 
--
function this.ItemRButtonUp()
  
  local wnd = this.GetParentWindowName()
  local hotbarId
  if wnd == "HotbarWidgetRow1" then
    hotbarId = this.id1
  else
    hotbarId = this.id2
  end
  local slot = WindowGetId(SystemData.ActiveWindow.name)
  local slotWindow = wnd.."Button"..slot
   
  local param = {Slot=slot,HotbarId=hotbarId}
  
  ContextMenu.CreateLuaContextMenuItem(HotbarSystem.TID_ASSIGN_HOTKEY, 0, HotbarSystem.ContextReturnCodes.ASSIGN_KEY, param)
  
  if HotbarHasItem(hotbarId, slot) == true then
    HotbarSystem.CreateUserActionContextMenuOptions(hotbarId, slot, 0, slotWindow)
  end
  
  ContextMenu.ActivateLuaContextMenu(Hotbar.ContextMenuCallback)
end

--
-- tooltip on hover
--
function this.ItemMouseOver()
  local wnd = this.GetParentWindowName()
  local hotbarId
  if wnd == "HotbarWidgetRow1" then
    hotbarId = this.id1
  else
    hotbarId = this.id2
  end
  local slot = WindowGetId(SystemData.ActiveWindow.name)
  local itemIndex = slot
  
  local actionType = SystemData.UserAction.TYPE_NONE
  -- default id to the slot so it shows the item properties when there is only a binding
  local itemId = slot
  
  local bindingText = L""
  if SystemData.Hotbar[hotbarId] ~= nil and SystemData.Hotbar[hotbarId].Bindings[slot] ~= nil then
    bindingText = SystemData.Hotbar[hotbarId].Bindings[slot]
    if bindingText ~= L"" then
      bindingText = GetStringFromTid(Hotbar.TID_BINDING)..L" "..bindingText -- "Binding:"..L" "..<KEY>
    end
  end
  
  if( HotbarHasItem(hotbarId,itemIndex) == true ) then
      actionType = UserActionGetType(hotbarId,itemIndex,0)
    local actionId = UserActionGetId(hotbarId,itemIndex,0)
    if( actionId ~= 0 ) then
      itemId = actionId
    end
    
    -- if its a macro reference, we need to dereference it
    if( actionType == SystemData.UserAction.TYPE_MACRO_REFERENCE ) then
      local macroId = UserActionGetId(hotbarId,itemIndex,0)
      local macroIndex = MacroSystemGetMacroIndexById(macroId)
      actionType = SystemData.UserAction.TYPE_MACRO
      hotbarId = SystemData.MacroSystem.STATIC_MACRO_ID -- - 1000 -- ???
      itemIndex = macroIndex
    end
  end

  if( actionType == SystemData.UserAction.TYPE_SKILL ) then
    bindingText = SkillsWindow.FormatSkillValue(WindowData.SkillDynamicData[itemId].RealSkillValue)..L"%\n"..bindingText -- Tack on the formatted skill level.
    
    -- NOTE: Need to fix this. Id 0 is also a null check, so no tooltip for Alchemy
    itemId = itemId + 1
  end 
  
  if(actionType == SystemData.UserAction.TYPE_PLAYER_STATS) then
    bindingText = L""   
  end 
        
  local targetText = L""
  if ( ( UserActionHasTargetType(hotbarId,itemIndex,0) ) and ( SystemData.Settings.GameOptions.legacyTargeting == false ) ) then
    local targetType = UserActionGetTargetType(hotbarId,itemIndex,0)
    targetText = GetStringFromTid(Hotbar.TID_TARGET) -- "Target:"
    if targetType == 1 then -- Current
      targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_CURRENT)
    elseif targetType == 2 then -- Cursor
      targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_CURSOR)
    elseif targetType == 3 then -- Self
      targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_SELF)
    elseif targetType == 4 then -- Object Id
      targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_OBJECT_ID)
    else
      targetText = L"" -- Bad case; forget about it.
    end
  end
  
  local detailType = ItemProperties.DETAIL_SHORT
  if(SystemData.Settings.Interface.showTooltips) then
    detailType = ItemProperties.DETAIL_LONG
  end
  
  local itemData = { windowName = "Hotbar"..hotbarId,
            itemId = itemId,
            itemType = WindowData.ItemProperties.TYPE_ACTION,
            actionType = actionType,
            detail = detailType,
            itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
            binding = bindingText, -- As defined above
            myTarget = targetText, }

  ItemProperties.SetActiveItem(itemData)
  
end
