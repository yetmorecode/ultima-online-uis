----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ItemPreview = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------



function ItemPreview.Initialize()
	TextEditBoxSetText("ItemPreviewSearchBox", L"0")
	TextEditBoxSetText("ItemPreviewHueBox", L"0")
	
	LabelSetText("ItemPreviewSearchText", GetStringFromTid(3005050))
	LabelSetText("ItemPreviewHueText", GetStringFromTid(3005049))
	
	ItemPreview.OnLButtonUpSearch()
end

function ItemPreview.Shutdown()

end

function ItemPreview.OnRClick()
	DynamicImageSetTexture( "ItemPreviewIcon", "", 0, 0 )
	WindowSetShowing("ItemPreview", false )
end

function ItemPreview.OnLButtonUpSearch()
	local objectType = tonumber(TextEditBoxGetText("ItemPreviewSearchBox"))
	local hueId = tonumber(TextEditBoxGetText("ItemPreviewHueBox"))
	if not hueId then
		hueId = 0
	end
	if not objectType then
		objectType = 0
	end
	EquipmentData.DrawObjectIcon(objectType, hueId, "ItemPreviewIcon", 300, 300, 1.5)
	
end

function ItemPreview.Plus()
	local objectType = tonumber(TextEditBoxGetText("ItemPreviewSearchBox"))
	if objectType then
		TextEditBoxSetText("ItemPreviewSearchBox", towstring(objectType + 1))
		ItemPreview.OnLButtonUpSearch()
	end
end

function ItemPreview.Minus()
	local objectType = tonumber(TextEditBoxGetText("ItemPreviewSearchBox"))
	if objectType and objectType > 0 then
		TextEditBoxSetText("ItemPreviewSearchBox", towstring(objectType - 1))
		ItemPreview.OnLButtonUpSearch()
	end
end

function ItemPreview.ChangeId(x, y, delta)
	if delta > 0 then
		ItemPreview.Minus()
	elseif delta < 0 then
		ItemPreview.Plus()
	end
end


-------- GRID ------------

ItemPreview.GridStartID = -1

function ItemPreview.InitializeGrid()
	LabelSetText("ItemPreviewGridSearchText", L"Starting " .. GetStringFromTid(3005050))
	TextEditBoxSetText("ItemPreviewGridSearchBox", L"0")
	ItemPreview.Redraw()
end

function ItemPreview.ShutdownGrid()

end

function ItemPreview.OnRClickGrid()
	WindowSetShowing("ItemPreviewGrid", false )
end

function ItemPreview.OnLButtonUpGridNext()
	ItemPreview.GridStartID = ItemPreview.GridStartID + 100
	ItemPreview.Redraw()
end

function ItemPreview.OnLButtonUpGridPrev()
	if ItemPreview.GridStartID  > 0 then
		ItemPreview.GridStartID = ItemPreview.GridStartID - 100
		if ItemPreview.GridStartID < 0 then
			ItemPreview.GridStartID = -1
		end
		ItemPreview.Redraw()
	end
end

function ItemPreview.Redraw()
	local parent = "ItemPreviewGrid"
	local hueId = 0
	local lastlink = ""
	local firstlinelink = ""
	local itemid = ItemPreview.GridStartID
	for i = 1, 10 do
		for j = 1, 10 do
			local slotName = "itemPreviewGrid_" .. i .. "_" .. j
			if not DoesWindowExist(slotName) then
				CreateWindowFromTemplate(slotName, "ItemPreviewImageTemplate", parent)
				
				if i == 1 and j == 1 then
					WindowAddAnchor(slotName, "topleft", parent, "topleft", 20, 90)
				elseif j == 1 then
					WindowAddAnchor(slotName, "topleft", parent, "topleft", 20, 90 * i)
				else
					WindowAddAnchor(slotName, "topleft", parent, "topleft", 20 + (90 * (j - 1)), 90 * i )
				end
			end
			itemid = itemid + 1
			WindowSetDimensions(slotName, 90, 90)
			EquipmentData.DrawObjectIcon(itemid, hueId, slotName, 90, 90)
			WindowSetId(slotName, itemid)
		end
	end
	TextEditBoxSetText("ItemPreviewGridSearchBox", towstring(ItemPreview.GridStartID + 1))
	
end


function ItemPreview.ItemTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  towstring(WindowGetId(SystemData.ActiveWindow.name)))
end

function ItemPreview.ShowSingle()
	local id = towstring(WindowGetId(SystemData.ActiveWindow.name))
	WindowSetShowing("ItemPreview", true)
	TextEditBoxSetText("ItemPreviewSearchBox", id)
	ItemPreview.OnLButtonUpSearch()
end

function ItemPreview.OnLButtonUpSearchGrid()
	ItemPreview.GridStartID = tonumber(TextEditBoxGetText("ItemPreviewGridSearchBox")) - 1
	ItemPreview.Redraw()
end

function ItemPreview.ChangeIdGrid(x, y, delta)
	if delta < 0 then
		ItemPreview.OnLButtonUpGridNext()
	elseif delta > 0 then
		ItemPreview.OnLButtonUpGridPrev()
	end
end