local this = {}

GumpExplorerWindow = this

this.wnd = "GumpExplorerWindow"
this.currentGumps = {}

function this.Initialize()
  ButtonSetText(this.wnd .. "UpdateButton", L"Update")
  LabelSetText(this.wnd .. "GumpData", L"none")
  
  this.Update()
end

function this.Update () 
  
  local gumps = GumpData.Gumps
  local i = 0
  for id, data in pairs(this.currentGumps) do
      local rowName = this.wnd .. "_" .. id
      if DoesWindowNameExist (rowName) then
        DestroyWindow (rowName)
      end
  end
  this.currentGumps = {}
  
  for id, data in pairs(gumps) do
      local rowName = this.wnd .. "_" .. id
      local parent = this.wnd .. "ScrollChild"
     
      this.currentGumps[id] = data
      CreateWindowFromTemplate (rowName, this.wnd .. "EntryTemplate", parent)
      WindowSetShowing(rowName, true)
      local x,y = WindowGetDimensions (rowName)
      WindowAddAnchor(rowName, "topleft", parent, "topleft", 0, i * y)
      LabelSetText (rowName .. "Name", L"Gump " .. id)
      i = i + 1
  end
end

function this.OnGumpClicked ()
  local rowName = SystemData.ActiveWindow.name
  local gump = tonumber(string.sub(rowName, string.len(this.wnd) + 2));
  
  local gumpData = GumpData.Gumps[gump]
  local out = "GumpData.Gumps[" .. gump .. "] = {\n"
  local i = 0
  for id, data in pairs(gumpData) do
    out = out .. "  " .. id .. "\n"
  end
  for id, data in pairs(gumpData.Labels) do
    out = out .. "  Labels[" .. id .. "] = {\n"
    out = out .. "    id = " .. data.id .. ", tid = " .. data.tid .. ",\n"
    for j, parm in pairs(gumpData.Labels[id].tidParms) do
      out = out .. "    tidParm[" .. j .. "] = " .. WStringToString(parm) .. "\n"
    end
    out = out .. "    str = " .. WStringToString(GetStringFromTid(data.tid)) .. "\n"
    out = out .. "  }\n"
  end
  out = out .. "}\n"
  
  LabelSetText(this.wnd .. "GumpData", StringToWString(out))
  --local textW, textH = WindowGetDimensions(this.wnd.."GumpData")
  --local parent = WindowGetParent(this.wnd.."GumpData")
  --local parentW, parentH = WindowGetDimensions(parent)
  --WindowSetDimensions(parent, textW, textH)
  
end



function this.OnUpdate ()
  this.Update()
end

function this.Shutdown()

end