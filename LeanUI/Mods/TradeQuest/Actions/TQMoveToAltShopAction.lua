local this = {}

TQMoveToAltShopAction = this

this.manager = nil

function this.OnStart(manager)
  this.manager = manager
  this.MoveToTarget()
end

function this.MoveToTarget(destination)
  
  local destination = TradeQuest.GetDestination()
  
  Debug.PrintToOverhead(L"Destination: " .. destination)
  
  local routes = {
    {
      L"Britain", {
        {x = 1350, y = 1985},
        {x = 1355, y = 1797},
        {x = 1366, y = 1783},
        {x = 1366, y = 1752},
        {x = 1397, y = 1752},
        {x = 1415, y = 1737},
        {x = 1433, y = 1737},
        {x = 1446, y = 1723},
        {x = 1446, y = 1703},
        {x = 1451, y = 1697},
        {x = 1461, y = 1697},
        {x = 1463, y = 1693},
        {x = 1466, y = 1689} -- shop
      }
    }, {
      L"Yew", {
        {x = 751, y = 769},
        {x = 751, y = 790},
        {x = 731, y = 810},
        {x = 733, y = 817},
        {x = 580, y = 967},
        {x = 580, y = 1001},
        {x = 517, y = 1001} -- shop
      }
    }, {
      L"Minoc", {
        {x = 2681, y = 670},
        {x = 2681, y = 648},
        {x = 2625, y = 640},
        {x = 2627, y = 643},
        {x = 2573, y = 580},
        {x = 2549, y = 580},
        {x = 2537, y = 561} -- shop
        --{x = 2548, y = 568},
        --{x = 2537, y = 543},
        --{x = 2528, y = 532},
        --{x = 2526, y = 425},
        --{x = 2501, y = 402}
      }
    }, {
      L"Vesper", {
        {x = 2813, y = 689},
        {x = 2819, y = 695},
        {x = 2819, y = 703},
        {x = 2869, y = 703},
        {x = 2869, y = 743},
        {x = 2883, y = 757},
        {x = 2883, y = 789},
        {x = 2906, y = 810},
        {x = 2916, y = 810},
        {x = 2916, y = 846},
        {x = 2902, y = 854},
        {x = 2880, y = 854},
        {x = 2855, y = 881},
        {x = 2848, y = 882} -- shop
      }
    }, {
      L"Trinsic", {
        {x = 1836, y = 2942},
        {x = 1857, y = 2942},
        {x = 1857, y = 2953},
        {x = 1869, y = 2965},
        {x = 1931, y = 2965},
        {x = 1967, y = 2930},
        {x = 2003, y = 2930},
        {x = 2002, y = 2856},
        {x = 1987, y = 2846} -- shop
      }
    }, {
      L"Jhelom", {
        {x = 1461, y = 3811},
        {x = 1433, y = 3811},
        {x = 1419, y = 3797},
        {x = 1396, y = 3797},
        {x = 1387, y = 3788},
        {x = 1363, y = 3788} --shop
      }
    }, {
      L"Moonglow", {
        {x = 4465, y = 1216},
        {x = 4442, y = 1191},
        {x = 4442, y = 1172},
        {x = 4460, y = 1156},
        {x = 4460, y = 1105},
        {x = 4454, y = 1099},
        {x = 4444, y = 1099},
        {x = 4444, y = 1070},
        {x = 4446, y = 1068},
        {x = 4448, y = 1065} -- shop
      }
    }, {
      L"Skara Brae", {
        {x = 638, y = 2118},
        {x = 643, y = 2169},
        {x = 659, y = 2175},
        {x = 656, y = 2186} -- shop
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