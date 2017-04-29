local this = {}

LeanWindowOverview = this

this.wnd = "LeanWindowOverview"

function this.Initialize ()
  LabelSetText(this.wnd .. "Title", L"Window Overview")
  
  this.Update()
end

function this.Update () 
  local windows = LeanWindowManager.GetWindows()
  local i = 0
  for name, data in pairs(windows) do
      local rowName = this.wnd .. "" .. name
      local parent = this.wnd .. "ScrollChild"
      
      if DoesWindowNameExist (rowName) then
        DestroyWindow (rowName)
      end
      CreateWindowFromTemplate (rowName, this.wnd .. "Template", parent)
      WindowSetShowing(rowName, true)
      local x,y = WindowGetDimensions (rowName)
      WindowAddAnchor(rowName, "topleft", parent, "topleft", 0, i * y)
      LabelSetText (rowName .. "Name", StringToWString(name))
      i = i + 1
  end
end

function this.OnItemClicked ()
  local rowName = SystemData.ActiveWindow.name
  local window = string.sub(rowName, string.len(this.wnd) + 1);
  
  LeanWindowManager.ToggleWindow (window)
end