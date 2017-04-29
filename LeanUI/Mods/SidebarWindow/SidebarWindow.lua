local this = {}

SidebarWindow = this

this.Expanded = false
this.MouseIn = false
this.wnd = "SidebarWindow"

this.width = 350
this.minOffset = -1 * this.width + 5
this.currentWidth = this.width
this.height = 1280
this.step = 20

this.widgets = {}
this.widgetStyle = {
  MarginBottom = 10
}

function this.Initialize() 
  CreateWindow(this.wnd, true)  
  WindowSetDimensions(this.wnd, this.currentWidth, this.height)
  WindowSetOffsetFromParent(this.wnd, this.minOffset, 0)
end

function this.Shutdown() 
  DestroyWindow(this.wnd)
end

function this.Update(timePassed) 
  this.UpdateWindow(this.wnd, timePassed)
  
  for i, widget in pairs(this.widgets) do
    this.UpdateWindow(widget.wnd, timePassed)
    
    if widget.OnUpdate ~= nil then
      widget.OnUpdate(this, timePassed)
    end
  end
end

function this.UpdateWindow(window, timePassed)
  local mx = SystemData.MousePosition.x
  local x,y = WindowGetOffsetFromParent(this.wnd)
  mx = mx / InterfaceCore.scale
  
  if mx < x + this.width then
    this.MouseIn = true
  else
    this.MouseIn = false
  end

  if not this.Expanded and this.MouseIn and x < -5 then
    x = x + this.step
    
    if x > -5 then
      x = -5
    end
  end
  
  if not this.MouseIn and x > this.minOffset then
    x = x - this.step
    if x <= this.minOffset then
      x = this.minOffset
    end
  end
  
  WindowSetOffsetFromParent(this.wnd, x, 0)
end

function this.AddWidget(widget, position)
  if widget == nil then
    Debug.PrintToDebugConsole(StringToWString(this.wnd) .. L": invalid widget = nil passed to AddWidget()")
    return
  end
  table.insert(this.widgets, position, widget)
  
  if widget.OnAdded ~= nil then
    widget.OnAdded(this)
  end
  if widget.OnCreateWindow ~= nil then
    widget.OnCreateWindow(this, this.width, this.wnd)
  end
    
  local x,y = WindowGetDimensions(widget.wnd)
  x = this.currentWidth
    
  WindowSetDimensions(widget.wnd, x, y)
  if widget.OnResize ~= nil then
    widget.OnResize(x, y)
  end
  
  this.Relayout()
end

function this.Relayout()
  local y = 0
  for i, widget in pairs(this.widgets) do
    this.UpdateWindow(widget.wnd, timePassed)
    
    WindowClearAnchors(widget.wnd)  
    WindowAddAnchor(widget.wnd, "topleft", this.wnd, "topleft", 0, y)
    
    local wx, wy = WindowGetDimensions(widget.wnd)
    y = y + wy + this.widgetStyle.MarginBottom;
  end
end

function this.ExpandWidget(widget)
  
end

function this.CollapseWidget(widget)
  
end