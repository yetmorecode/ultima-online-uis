local this = {}

TQMoveToDestinationAction = this

this.manager = manager

function this.OnStart(manager)
  this.manager = manager
  
  TradeQuestWindow.Update()
  this.MoveToTarget()
end

function this.MoveToTarget()
  -- Find destination city
  RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
  
  local id = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
  RegisterWindowData(WindowData.ContainerWindow.Type, id)
    
  local tradeDealProps = nil
  local data = WindowData.ContainerWindow[id]
  for i=1, data.numItems do
    local item = data.ContainedItems[i]
    RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
    
    local prop = ItemProperties.GetObjectProperties(item.objectId, nil, "")
    for propIndex = 1, table.getn(prop) do
      if wstring.find(prop[propIndex], L"TRADE") then
        tradeDealProps = prop
        break
      end
    end
    
    --UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
  end
  
  if tradeDealProps == nil then
    return
  end
  
  local destination = wstring.sub(tradeDealProps[3], 19)
  
  local routes = {
    {
      L"Britain", {
        {x = 1464, y = 1699},
        {x = 1474, y = 1699},
        {x = 1474, y = 1713},
        {x = 1465, y = 1722},
        {x = 1465, y = 1730},
        {x = 1435, y = 1730},
        {x = 1434, y = 1757},
        {x = 1437, y = 1760}
      }
    }, {
      L"Yew", {
        {x = 580, y = 1001},
        {x = 622, y = 1043, tolerance = 1}
      }
    }, {
      L"Minoc", {
        {x = 2537, y = 542},
        {x = 2528, y = 531},
        {x = 2527, y = 426},
        {x = 2501, y = 400}
      }
    }, {
      L"Vesper", {
        {x = 2855, y = 881},
        {x = 2880, y = 854},
        {x = 2902, y = 854},
        {x = 2916, y = 846},
        {x = 2957, y = 848},
        {x = 2957, y = 830},
        {x = 3007, y = 830},
        {x = 3007, y = 834}
      }
    }, {
      L"Trinsic", {
        {x = 2013, y = 2872},
        {x = 2013, y = 2891},
        {x = 2026, y = 2891},
        {x = 2056, y = 2861},
        {x = 2057, y = 2852}
      }
    }, {
      L"Jhelom", {
        {x = 1379, y = 3805},
        {x = 1379, y = 3830},
        {x = 1398, y = 3849},
        {x = 1378, y = 3865},
        {x = 1378, y = 3875}
      }
    }, {
      L"Moonglow", {
        {x = 4432, y = 1051},
        {x = 4418, y = 1051},
        {x = 4418, y = 1038}
      }
    }, {
      L"Skara Brae", {
        {x = 656, y = 2195},
        {x = 640, y = 2211},
        {x = 640, y = 2231},
        {x = 648, y = 2238}
      }
    }
  }
  
  local route = nil
  for i, data in ipairs(routes) do
    if data[1] == destination then
      route = data[2]
    end 
  end
  
  if route ~= nil then
    Move.Path(route, this.TargetReached)
  else
    Debug.PrintToChat(L"No route found")
  end

end

function this.TargetReached()
  this.manager.AdvanceQuest()
end