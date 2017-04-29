
LoadResources( "./UserInterface/"..SystemData.Settings.Interface.customUiName.."/Mods/LootManager", "LootConfigurationWindow.xml", "LootConfigurationWindow.xml" )

LootConfiguration = { }
LootConfiguration.Properties = {}
LootConfiguration.Properties[1] = { Property = "Jewelry", Operators = {"is"}, Values = {"true","false"} }
LootConfiguration.Properties[2] = { Property = "Cursed", Operators = {"is"}, Values = {"true","false"} }
LootConfiguration.Properties[3] = { Property = "Antique", Operators = {"is"}, Values = {"true","false"} }
LootConfiguration.Properties[4] = { Property = "Prized", Operators = {"is"}, Values = {"true","false"} }
LootConfiguration.Properties[5] = { Property = "Brittle", Operators = {"is"}, Values = {"true","false"} }
LootConfiguration.Properties[6] = { Property = "Eater", Operators = {"is"}, Values = {"true"} }
LootConfiguration.Properties[7] = { Property = "Splintering", Operators = {">=","<=","="}, Values = {"5","10","15","20","25","30" }}
LootConfiguration.Properties[8] = { Property = "SwingSpeedIncrease", Operators = {">=","<=","="}, Values = {"5","10","15","20","25","30","35","40","45","50"}}
LootConfiguration.Properties[9] = { Property = "DamageIncrease", Operators = {">=","<=","="}, Values = {"5","10","15","20","25","30","35","40","45","50" }}
LootConfiguration.Properties[10] = { Property = "TotalResists", Operators = {">=","<=","="}, Values = {"10","20","30","40","50","60","70","80","90","100","110","120","130","140","150"}}
LootConfiguration.Properties[11] = { Property = "Luck", Operators = {">=","<=","="}, Values = {"10","20","30","40","50","60","70","80","90","100","110","120","130","140","150" }}
LootConfiguration.Properties[12] = { Property = "DefenseChanceIncrease", Operators = {">=","<=","="}, Values = {"5","10","15","20","25","30","35","40","45","50" }}
LootConfiguration.Properties[13] = { Property = "HitChanceIncrease", Operators = {">=","<=","="}, Values = {"5","10","15","20","25","30","35","40","45","50" }}
LootConfiguration.Properties[14] = { Property = "Strength", Operators = {">=","<=","="}, Values = {"1","2","3","4","5","6","7","8","9","10" }}
LootConfiguration.Properties[15] = { Property = "Dexterity", Operators = {">=","<=","="}, Values = {"1","2","3","4","5","6","7","8","9","10" }}
LootConfiguration.Properties[16] = { Property = "Intelligence", Operators = {">=","<=","="}, Values = {"1","2","3","4","5","6","7","8","9","10" }}
LootConfiguration.Properties[17] = { Property = "HitPointIncrease", Operators = {">=","<=","="}, Values = {"1","2","3","4","5","6","7","8","9","10" }}
LootConfiguration.Properties[18] = { Property = "StaminaIncrease", Operators = {">=","<=","="}, Values = {"1","2","3","4","5","6","7","8","9","10" }}
LootConfiguration.Properties[19] = { Property = "ManaIncrease", Operators = {">=","<=","="}, Values = {"1","2","3","4","5","6","7","8","9","10" }}
LootConfiguration.Properties[20] = { Property = "HitPointRegeneration", Operators = {">=","<=","="}, Values = {"1","2","3","4","5","6","7","8","9","10" }}
LootConfiguration.Properties[21] = { Property = "StaminaRegeneration", Operators = {">=","<=","="}, Values = {"1","2","3","4","5","6","7","8","9","10" }}
LootConfiguration.Properties[22] = { Property = "ManaRegeneration", Operators = {">=","<=","="}, Values = {"1","2","3","4","5","6","7","8","9","10" }}
LootConfiguration.Properties[23] = { Property = "HitStaminaLeech", Operators = {">=","<=","="}, Values = {"10","20","30","40","50","60","70","80","90","100" }}
LootConfiguration.Properties[24] = { Property = "HitManaLeech", Operators = {">=","<=","="}, Values = {"10","20","30","40","50","60","70","80","90","100" }}
LootConfiguration.Properties[25] = { Property = "HitManaDrain", Operators = {">=","<=","="}, Values = {"10","20","30","40","50","60","70","80","90","100" }}
LootConfiguration.Properties[26] = { Property = "HitFatigue", Operators = {">=","<=","="}, Values = {"510","20","30","40","50","60","70","80","90","100" }}
LootConfiguration.Properties[27] = { Property = "SpellDamageIncrease", Operators = {">=","<=","="}, Values = {"5","10","15","18","20","25","30","35","40","45","50" }}
LootConfiguration.Properties[28] = { Property = "FasterCasting", Operators = {">=","<=","="}, Values = {"1","2","3","4","5" }}
LootConfiguration.Properties[29] = { Property = "FasterCastRecovery", Operators = {">=","<=","="}, Values = {"1","2","3","4","5" }}
LootConfiguration.Properties[30] = { Property = "LowerManaCost", Operators = {">=","<=","="}, Values = {"5","10","15","20" }}
LootConfiguration.Properties[31] = { Property = "LowerReagentCost", Operators = {">=","<=","="}, Values = {"5","10","15","20","25","30","35","40","45","50" }}
LootConfiguration.Properties[32] = { Property = "EnhancePotions", Operators = {">=","<=","="}, Values = {"5","10","15","20","25","30","35","40","45","50" }}
LootConfiguration.Properties[33] = { Property = "CastingFocus", Operators = {">=","<=","="}, Values = {"1","2","3","4","5" }}
LootConfiguration.Properties[34] = { Property = "Intensity", Operators = {">=","<=","="}, Values = {"1 (Minor Magic)","2 (Lesser Magic)","3 (Greater Magic)","4 (Major Magic)","5 (Lesser Artifact)","6 (Greater Artifact)","7 (Major Artifact)","8 (Legendary Artifact)" }}
LootConfiguration.Properties[35] = { Property = "PropertyCount", Operators = {">=","<=","="}, Values = {"1","2","3","4","5","6","7","8","9" }}
LootConfiguration.Properties[36] = { Property = "MaxPropertyCount", Operators = {">=","<=","="}, Values = {"1","2","3","4","5","6","7","8","9" }}
LootConfiguration.Properties[37] = { Property = "Weight", Operators = {">=","<=","="}, Values = {"1","2","3","4","5","10","15","20","25","30","35","40","45","50" }}
LootConfiguration.Properties[38] = { Property = "TreasureMapLevel", Operators = {">=","<=","="}, Values = {"1 (Plainly)","2 (Expertly)","3 (Adeptly)","4 (Cleverly)","5 (Deviously)","6 (Ingeniously)","7 (Diabolically)" }}

LootConfiguration.Rules = {}
LootConfiguration.MuteCorpseLoot = true


-- TODO: uhh. make this local....
LootConfiguration.CurrentColorProperty = ""


----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

local editRuleIndex = 0

function LootConfiguration.Shutdown()
  LootConfiguration.SetDefaultView()
end

-- OnInitialize Handler
function LootConfiguration.Initialize()
  this = "LootConfiguration"
  local id = SystemData.DynamicWindowId
  WindowSetId(this, id)
  WindowUtils.SetActiveDialogTitle(L"Grim's Loot Configuration")

  for i = 1, #LootConfiguration.Properties do
    ComboBoxAddMenuItem(this.."PropertyCombo", towstring(LootConfiguration.Properties[i].Property))
  end

  LabelSetText("LootConfigurationRulesTitle", L"Rules")
  LabelSetText("LootConfigurationItemHueLabel", L"Item Hue")
  LabelSetText("LootConfigurationBorderHueLabel", L"Border Hue")
  LabelSetText("LootConfigurationBackgroundHueLabel", L"Background Hue")
  --LabelSetText("LootConfigurationResultTextLabel", L"Item Text")
  LabelSetText("LootConfigurationConditionsTitle", L"Conditions")
  LabelSetText("LootConfigurationComposeTitle", L"Add Condition")
  LabelSetText("LootConfigurationSettingsTitle", L"Global Settings")
  LabelSetText("LootConfigurationSettingsMuteLabel", L"Mute Corpse Loot")
  LabelSetText("LootConfigurationSaveCondition", L"˚")
  LabelSetText("LootConfigurationCancelSaveCondition", L"ˑ")
  LabelSetText("LootConfigurationPreviewLabel", L"Grid Preview")

  ButtonSetText("LootConfigurationRulesTab", L"Rules")
  ButtonSetText("LootConfigurationSettingsTab", L"Settings")
  
  LootManager.Load()

  LootConfiguration.SetDefaultView()
  LootConfiguration.ShowRules()

end

function LootConfiguration.SetDefaultView()
  WindowSetShowing("LootConfigurationRuleContainer", true)
  WindowSetShowing("LootConfigurationDetailContainer", false)
  WindowSetShowing("LootConfigurationComposeContainer", false)
  WindowSetShowing("LootConfigurationConditionContainer", false)
  WindowSetShowing("LootConfigurationSettingsContainer", false)
  WindowSetShowing("LootConfigurationSettingsContainer", false)
  WindowSetShowing("LootConfigurationRulesTabActive", true)
  WindowSetShowing("LootConfigurationRulesTabInactive", false)
  WindowSetShowing("LootConfigurationSettingsTabActive", false)
  WindowSetShowing("LootConfigurationSettingsTabInactive", true)
  editRuleIndex = 0
end

function LootConfiguration.ShowRules()

  for i = 1, 30 do
    if(DoesWindowExist("Rule".. i)) then
      WindowSetShowing("Rule".. i, false)
    end
  end

  WindowSetShowing("LootConfigurationRuleContainer", true)
  WindowSetShowing("LootConfigurationComposeContainer", false)
  WindowSetShowing("LootConfigurationDetailContainer", false)
  WindowSetShowing("LootConfigurationConditionContainer", false)
  WindowSetShowing("LootConfigurationSettingsContainer", false)
  WindowSetShowing("LootConfigurationRulesTabActive", true)
  WindowSetShowing("LootConfigurationRulesTabInactive", false)
  WindowSetShowing("LootConfigurationSettingsTabActive", false)
  WindowSetShowing("LootConfigurationSettingsTabInactive", true)

  for i = 1, #LootConfiguration.Rules do
    
    local rule = LootConfiguration.Rules[i]
    if(not DoesWindowExist("Rule".. i)) then
      CreateWindowFromTemplate("Rule" .. i, "RuleDisplayTemplate", "RuleScrollWindowScrollChild")
      if( i == 1) then
        WindowAddAnchor("Rule" .. i, "topleft", "RuleScrollWindowScrollChild", "topleft", 0, 0)
      else
        -- Anchor to the last condition of previous rule...
        WindowAddAnchor("Rule" .. i, "bottomleft", "Rule" .. i - 1, "topleft", 0, 0)
      end

      WindowSetId("Rule".. i, i)
      WindowSetId("Rule".. i .. "Edit", i)
      WindowSetId("Rule".. i .. "Decrease", i)
      WindowSetId("Rule".. i .. "Increase", i)
      WindowSetId("Rule".. i .. "Delete", i)
      --WindowSetAlpha("Rule".. i .."Background", .2)
    end
    
    WindowUtils.FitTextToLabel("Rule" .. i .. "Name",i .. L") " .. towstring(rule.Name), false)

    WindowSetShowing("Rule".. i, true)
    --CreateWindowFromTemplate("Rule"..i.."HR", "UO_Default_Horizontal_Rule", "RuleContainer")
    --WindowAddAnchor("Rule".. i.."HR", "bottomleft", "Rule".. i, "topleft", 30, 0)
    --WindowSetDimensions("Rule".. i.."HR", 300, 2)

  end

  ScrollWindowUpdateScrollRect("RuleScrollWindow")

end

function LootConfiguration.EditRule()
  editRuleIndex = WindowGetId(SystemData.ActiveWindow.name)
  LootConfiguration.ShowConditions(editRuleIndex)
end

function LootConfiguration.ShowConditions(ruleIndex)

  WindowSetShowing("LootConfigurationDetailContainer", true)
  WindowSetShowing("LootConfigurationConditionContainer", true)
  WindowSetShowing("LootConfigurationComposeContainer", false)

  for i = 1, 30 do
    if(DoesWindowExist("Condition".. i)) then
      WindowSetShowing("Condition".. i, false)
    end
  end

  local rule = LootConfiguration.Rules[ruleIndex]
  WindowSetId("LootConfigurationItemHue", ruleIndex)
  WindowUtils.FitTextToLabel("LootConfigurationDetailTitle", L"Details - " .. towstring(rule.Name))
  
  LootConfiguration.SetColorPickerValue("LootConfigurationItemHue", rule.ItemHue)
  LootConfiguration.SetColorPickerValue("LootConfigurationBorderHue", rule.BorderHue)
  LootConfiguration.SetColorAlphaValue("LootConfigurationBorderHueAlpha", rule.BorderHueAlpha)
  LootConfiguration.SetColorPickerValue("LootConfigurationBackgroundHue", rule.BackgroundHue)
  LootConfiguration.SetColorAlphaValue("LootConfigurationBackgroundHueAlpha", rule.BackgroundHueAlpha)
  LootConfiguration.UpdateGridPreview()

  for i = 1, #rule.Conditions do
    local condition = rule.Conditions[i]
    if(not DoesWindowExist("Condition".. i)) then
      CreateWindowFromTemplate("Condition" .. i, "ConditionDisplayTemplate", "ConditionScrollWindowScrollChild")
      if( i == 1) then
        WindowAddAnchor("Condition" .. i, "topleft", "ConditionScrollWindowScrollChild", "topleft", 0, 0)
      else
        -- Anchor to the last condition of previous rule...
        WindowAddAnchor("Condition" .. i, "bottomleft", "Condition" .. i - 1, "topleft", 0, 0)
      end
    end

    local conditionDisplay = condition.Property .. " " .. condition.Operator .. " " .. condition.Value
    WindowUtils.FitTextToLabel("Condition" .. i .. "Name", towstring(conditionDisplay))
    WindowSetId("Condition" .. i .. "Delete", i)
    WindowSetShowing("Condition".. i, true)
  end

  ScrollWindowUpdateScrollRect( "ConditionScrollWindow" )

end

function LootConfiguration.ShowSettings()
  WindowSetShowing("LootConfigurationRuleContainer", false)
  WindowSetShowing("LootConfigurationComposeContainer", false)
  WindowSetShowing("LootConfigurationDetailContainer", false)
  WindowSetShowing("LootConfigurationConditionContainer", false)
  WindowSetShowing("LootConfigurationSettingsContainer", true)
  WindowSetShowing("LootConfigurationRulesTabActive", false)
  WindowSetShowing("LootConfigurationRulesTabInactive", true)
  WindowSetShowing("LootConfigurationSettingsTabActive", true)
  WindowSetShowing("LootConfigurationSettingsTabInactive", false)
end

function LootConfiguration.IncreasePriority()

  local ruleIndex = WindowGetId(SystemData.ActiveWindow.name)

  if(ruleIndex == 1) then
    return
  end

  local old = LootConfiguration.Rules[ruleIndex]
  LootConfiguration.Rules[ruleIndex] = LootConfiguration.Rules[ruleIndex - 1]
  LootConfiguration.Rules[ruleIndex - 1] = old

  LootManager.Save()
  LootConfiguration.ShowRules()

end

function LootConfiguration.DecreasePriority()

  local ruleIndex = WindowGetId(SystemData.ActiveWindow.name)

  if(ruleIndex == #LootConfiguration.Rules) then
    return
  end

  local old = LootConfiguration.Rules[ruleIndex]
  LootConfiguration.Rules[ruleIndex] = LootConfiguration.Rules[ruleIndex + 1]
  LootConfiguration.Rules[ruleIndex + 1] = old

  LootManager.Save()
  LootConfiguration.ShowRules()
end

function LootConfiguration.PropertyComboChanged(selectedIndex)

  ComboBoxClearMenuItems("LootConfigurationOperatorCombo")
  ComboBoxClearMenuItems("LootConfigurationValueCombo")

  local prop = LootConfiguration.Properties[selectedIndex]

  --for operator in wstring.gmatch(prop.Operators, L"([^,]+)") do
  --  ComboBoxAddMenuItem("LootConfigurationOperatorCombo", operator)
  --end
  
  --for value in wstring.gmatch(prop.Values, L"([^,]+)") do
  --  ComboBoxAddMenuItem("LootConfigurationValueCombo", value)
  --end

  for i = 1, #prop.Operators do
    ComboBoxAddMenuItem("LootConfigurationOperatorCombo", towstring(prop.Operators[i]))
  end

  for i = 1, #prop.Values do
    ComboBoxAddMenuItem("LootConfigurationValueCombo", towstring(prop.Values[i]))
  end


end

function LootConfiguration.AddRule()
  if(#LootConfiguration.Rules == 30) then
    -- TODO: add message box.
    return
  end

  local rdata = { title=L"Add Rule", subtitle=L"Enter a name for the rule you are creating.", callfunction=LootConfiguration.AddRuleComplete, id=nil}
  RenameWindow.Create(rdata)
end

function LootConfiguration.AddRuleComplete(param, text)
  LootManager.AddRule(param, text)
  LootManager.Save()
  
  LootConfiguration.ShowRules()
  -- Since insert appends to the end, we can assume the index is the last entry...
  editRuleIndex = #LootConfiguration.Rules
  LootConfiguration.ShowConditions(editRuleIndex)
end

function LootConfiguration.EditRuleName()
  local rdata = { title=L"Change Rule Name", subtitle=L"Enter a new name for the rule.", callfunction=LootConfiguration.EditRuleNameComplete, id=editRuleIndex}
  RenameWindow.Create(rdata)
end

function LootConfiguration.EditRuleNameComplete(param, text)
  LootConfiguration.Rules[param].Name = tostring(text)
  LootManager.Save()
  LootConfiguration.ShowRules()
  LootConfiguration.ShowConditions(editRuleIndex)
end

function LootConfiguration.DeleteRule()
  local ruleIndex = WindowGetId(SystemData.ActiveWindow.name)
  local rule = LootConfiguration.Rules[ruleIndex]
  local okayButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() table.remove(LootConfiguration.Rules, ruleIndex) LootConfiguration.Save() LootConfiguration.ShowRules() end }
  local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL }
  local DeleteConfirmWindow = 
  {
    windowName = "DeleteRule", 
    title = L"Delete Rule", 
    body = L"Are you sure you want to delete rule '".. towstring(rule.Name) ..L"'?", 
    buttons = { okayButton, cancelButton }
  }
      
  UO_StandardDialog.CreateDialog( DeleteConfirmWindow )
end




function LootConfiguration.AddCondition()
  WindowSetShowing("LootConfigurationConditionContainer", false)
  WindowSetShowing("LootConfigurationComposeContainer", true)
end

function LootConfiguration.SaveCondition()

  -- BUG: ComboBoxGetSelectedText does not return the right value if the selected index is outside the default visible scroll area. WTF?
  --local property = ComboBoxGetSelectedText("LootConfigurationPropertyCombo")
  --local operator = ComboBoxGetSelectedText("LootConfigurationOperatorCombo")
  --local value = ComboBoxGetSelectedText("LootConfigurationValueCombo")

  local prop = LootConfiguration.Properties[ComboBoxGetSelectedMenuItem("LootConfigurationPropertyCombo")]
  local property = prop.Property
  local operator = prop.Operators[ComboBoxGetSelectedMenuItem("LootConfigurationOperatorCombo")]
  local value = prop.Values[ComboBoxGetSelectedMenuItem("LootConfigurationValueCombo")]

  table.insert(LootConfiguration.Rules[editRuleIndex].Conditions, { Property = tostring(property), Operator = tostring(operator), Value = tostring(value) })

  LootConfiguration.Save()
  LootConfiguration.ShowRules()
  LootConfiguration.ShowConditions(editRuleIndex)
end

function LootConfiguration.CancelSaveCondition()
  LootConfiguration.ShowRules()
  LootConfiguration.ShowConditions(editRuleIndex)
end

function LootConfiguration.DeleteCondition()
  local deleteConditionIndex = WindowGetId(SystemData.ActiveWindow.name)
  table.remove(LootConfiguration.Rules[editRuleIndex].Conditions, deleteConditionIndex)
  LootConfiguration.Save()
  LootConfiguration.ShowConditions(editRuleIndex)
end


function LootConfiguration.Show()
  WindowSetShowing("LootConfiguration", true);
end


function LootConfiguration.PickItemHue()

  LootConfiguration.CurrentColorProperty = string.gsub(SystemData.ActiveWindow.name, "LootConfiguration", "") 

  local defaultColors = {
    0, --HUE_NONE 
    34, --HUE_RED
    53, --HUE_YELLOW
    63, --HUE_GREEN
    89, --HUE_BLUE
    119, --HUE_PURPLE
    144, --HUE_ORANGE
    368, --HUE_GREEN_2
    946, --HUE_GREY
    1153
    }
  local hueTable = {}
  for idx, hue in pairs(defaultColors) do
    for i=0,8 do
      hueTable[(idx-1)*10+i+1] = hue+i
    end
  end
  local Brightness = 1
  CreateWindowFromTemplate( "ColorPicker", "ColorPickerWindowTemplate", "Root" )
  WindowSetLayer( "ColorPicker", Window.Layers.SECONDARY  )
  ColorPickerWindow.SetNumColorsPerRow(9)
  ColorPickerWindow.SetSwatchSize(16)
  ColorPickerWindow.SetWindowPadding(4,4)
  ColorPickerWindow.SetFrameEnabled(true)
  ColorPickerWindow.SetCloseButtonEnabled(true)
  ColorPickerWindow.SetColorTable(hueTable,"ColorPicker")
  ColorPickerWindow.DrawColorTable("ColorPicker")
  ColorPickerWindow.SetAfterColorSelectionFunction(LootConfiguration.HuePicked)
  local w, h = WindowGetDimensions("ColorPicker")
  WindowAddAnchor( "ColorPicker", "topleft", "LootConfiguration"..LootConfiguration.CurrentColorProperty, "topleft", 0, -h)
  ColorPickerWindow.SetFrameEnabled(false)
  WindowSetShowing( "ColorPicker", true )
  --ColorPickerWindow.SelectColor("ColorPicker", 1)
end

function LootConfiguration.HuePicked()
  local hueId= ColorPickerWindow.colorSelected["ColorPicker"]
  LootConfiguration.SetColorPickerValue("LootConfiguration"..LootConfiguration.CurrentColorProperty, hueId)
  LootConfiguration.Rules[editRuleIndex][LootConfiguration.CurrentColorProperty] = hueId
  LootConfiguration.Save()
  LootConfiguration.UpdateGridPreview()
  DestroyWindow("ColorPicker")
end

function LootConfiguration.SetColorPickerValue(window, hueId)
  hueId = tonumber(hueId)
  local hueR,hueG,hueB,hueA = HueRGBAValue(hueId)
  WindowSetTintColor(window, hueR, hueG, hueB)
end

function LootConfiguration.AlphaPicked(curPos)
  local alphaProperty = string.gsub(SystemData.ActiveWindow.name, "LootConfiguration", "") 
  local alpha = string.format("%.1f", curPos)
  if(alpha ~= LootConfiguration.Rules[editRuleIndex][alphaProperty]) then
    LootConfiguration.Rules[editRuleIndex][alphaProperty] = alpha
    LootConfiguration.Save()
    LootConfiguration.UpdateGridPreview()
  end
end

function LootConfiguration.SetColorAlphaValue(window, pos)
  pos = tonumber(pos)
  SliderBarSetCurrentPosition(window, pos)
end

function LootConfiguration.MuteCheckToggle()

  LootConfiguration.MuteCorpseLoot = not LootConfiguration.MuteCorpseLoot
  Interface.SaveBoolean("LootConfigurationMuteCorpseLoot", LootConfiguration.MuteCorpseLoot)

  if(LootConfiguration.MuteCorpseLoot) then
    LabelSetText("LootConfigurationSettingsMuteCheck", L"˖")
  else
    LabelSetText("LootConfigurationSettingsMuteCheck", L"˕")
  end

end

function LootConfiguration.UpdateGridPreview()
  local rule = LootConfiguration.Rules[editRuleIndex]
  --Debug.Print(rule)

  if(rule.BorderHue) then
    local hueR,hueG,hueB,hueA = HueRGBAValue(tonumber(rule.BorderHue))
    WindowSetTintColor("LootConfigurationPreviewIconBorder", hueR, hueG, hueB)
    if(rule.BorderHueAlpha) then
      WindowSetAlpha("LootConfigurationPreviewIconBorder", tonumber(rule.BorderHueAlpha))
    end
  end

  if(rule.BackgroundHue) then
    local hueR,hueG,hueB,hueA = HueRGBAValue(tonumber(rule.BackgroundHue))
    WindowSetTintColor("LootConfigurationPreviewBackground", hueR, hueG, hueB)
    if(rule.BackgroundHueAlpha) then
      WindowSetAlpha("LootConfigurationPreviewBackground", tonumber(rule.BackgroundHueAlpha))
    end
  end

  local item = {}
  item.hueId = tonumber(rule.ItemHue) --372
  item.iconName = "00005141_LegacyTileArt"
  item.iconId = 5141
  item.objectType = 5141
  item.iconScale = 1
  item.newHeight = 44
  item.newWidth = 44
  EquipmentData.UpdateItemIcon("LootConfigurationPreviewIcon", item)

end

-- TOOLTIPS ==============================================================

--function LootConfiguration.AddRuleTooltip()
--  Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, L"Create New Rule")
--  Tooltips.Finalize()
--  Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
--end

