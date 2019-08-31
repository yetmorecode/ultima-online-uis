----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

EquipmentData = {}

EquipmentData.EQPOS_DRAG = 0
EquipmentData.EQPOS_RIGHTHAND = 1 -- wielding
EquipmentData.EQPOS_LEFTHAND = 2 
EquipmentData.EQPOS_FEET = 3 -- wearing
EquipmentData.EQPOS_LEGS = 4
EquipmentData.EQPOS_TORSO = 5 -- shirt
EquipmentData.EQPOS_HEAD = 6
EquipmentData.EQPOS_HANDS = 7
EquipmentData.EQPOS_FINGER1 = 8
EquipmentData.EQPOS_TALISMAN = 9
EquipmentData.EQPOS_NECK = 10
EquipmentData.EQPOS_HAIR = 11 
EquipmentData.EQPOS_WAIST = 12
EquipmentData.EQPOS_CHEST = 13 -- breastplate
EquipmentData.EQPOS_LWRIST = 14 
EquipmentData.EQPOS_RWRIST = 15
EquipmentData.EQPOS_FACIALHAIR = 16
EquipmentData.EQPOS_ABOVECHEST = 17
EquipmentData.EQPOS_EARS = 18
EquipmentData.EQPOS_ARMS = 19
EquipmentData.EQPOS_CAPE = 20
EquipmentData.EQPOS_BACKPACK = 21
EquipmentData.EQPOS_DRESS = 22
EquipmentData.EQPOS_SKIRT = 23
EquipmentData.EQPOS_FEETLEGS = 24
EquipmentData.EQPOS_RIDING = 25
EquipmentData.EQPOS_MAX = 26 
EquipmentData.EQPOS_SELLS = 26 
EquipmentData.EQPOS_INVENT = 27 
EquipmentData.EQPOS_BUYS = 28 
EquipmentData.EQPOS_BANK = 29 
EquipmentData.EQPOS_SHOP_MAX = 30            

EquipmentData.WEAPONABILITY_PRIMARY = 1
EquipmentData.WEAPONABILITY_SECONDARY = 2

EquipmentData.WEAPONABILITY_ABILITYOFFSET = 1000

EquipmentData.RegisteredAbilityIcons = {}
EquipmentData.CurrentWeaponAbilities = {}

EquipmentData.ActiveAbility = nil

function EquipmentData.Initialize()
	--Debug.Print("EquipmentData.Initialize")

	Interface.GetPlayerEquipmentData(EquipmentData.EQPOS_RIGHTHAND)
	Interface.GetPlayerEquipmentData(EquipmentData.EQPOS_LEFTHAND)
	Interface.GetPlayerEquipmentData(EquipmentData.EQPOS_RIDING)
	
	-- Initialize weapon abilities
	EquipmentData.UpdateWeaponAbilities(true)

end

function EquipmentData.Shutdown()
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_RIGHTHAND)
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_LEFTHAND)	
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_RIDING)
end

function EquipmentData.UpdateAbilityIcon(iconWindow, moveId)
	iconId = moveId + EquipmentData.WEAPONABILITY_ABILITYOFFSET

	local texture, x, y = GetIconData( iconId )
	WindowSetDimensions(iconWindow.."SquareIcon", 50, 50)
	DynamicImageSetTexture( iconWindow.."SquareIcon", texture, x, y )	   
	DynamicImageSetTextureScale(iconWindow.."SquareIcon", 0.78 )
	
	if (moveId ~= 0) then
		WindowSetShowing(iconWindow.."Disabled",false)
		ButtonSetDisabledFlag(iconWindow,false)
	else
		WindowSetShowing(iconWindow.."Disabled",true)
		ButtonSetDisabledFlag(iconWindow,true)
	end
end

function EquipmentData.RegisterWeaponAbilitySlot(iconWindow,type)
	EquipmentData.RegisteredAbilityIcons[iconWindow] = type	
	
	if (iconWindow ~= nil) then
		if (EquipmentData.CurrentWeaponAbilities[type] ~= nil) then
			EquipmentData.UpdateAbilityIcon(iconWindow,EquipmentData.CurrentWeaponAbilities[type])
		end
	end
end

function EquipmentData.UnregisterWeaponAbilitySlot(iconWindow)
	EquipmentData.RegisteredAbilityIcons[iconWindow] = nil	
end

function EquipmentData.UpdateWeaponAbilities(initialize)
	if (WindowData.UpdateInstanceId == EquipmentData.EQPOS_RIGHTHAND or
		WindowData.UpdateInstanceId == EquipmentData.EQPOS_LEFTHAND or
		initialize == true) then		

		EquipmentData.CurrentWeaponAbilities[EquipmentData.WEAPONABILITY_PRIMARY] = 
			GetWeaponAbilityId(EquipmentData.WEAPONABILITY_PRIMARY);
		EquipmentData.CurrentWeaponAbilities[EquipmentData.WEAPONABILITY_SECONDARY] = 
			GetWeaponAbilityId(EquipmentData.WEAPONABILITY_SECONDARY);			
		
		for iconWindow, type in pairs(EquipmentData.RegisteredAbilityIcons) do
			if (iconWindow ~= nil) then
				EquipmentData.UpdateAbilityIcon(iconWindow,EquipmentData.CurrentWeaponAbilities[type])
			end
		end

		CharacterAbilities.UpdateWeaponAbilities()
	end
end

function EquipmentData.ActivateAbility()
	local abilityId = GameData.Abilities.ActiveAbility
	local type = GameData.Abilities.ActiveAbilityType
	EquipmentData.ActiveAbility = abilityId
	--Debug.Print("Activate Ability: abilityId="..tostring(abilityId).." type="..tostring(type))

	if (type == SystemData.UserAction.TYPE_WEAPON_ABILITY) then
		local abilityIndex = 0
		if (abilityId == EquipmentData.CurrentWeaponAbilities[EquipmentData.WEAPONABILITY_PRIMARY]) then
			abilityIndex = EquipmentData.WEAPONABILITY_PRIMARY
		elseif (abilityId == EquipmentData.CurrentWeaponAbilities[EquipmentData.WEAPONABILITY_SECONDARY]) then
			abilityIndex = EquipmentData.WEAPONABILITY_SECONDARY
		end
		
		for iconWindow, index in pairs(EquipmentData.RegisteredAbilityIcons) do
			if (iconWindow ~= nil and index == abilityIndex) then
				if Interface.LastSpecialMoveTime > 0 then
					WindowSetTintColor(iconWindow.."SquareIcon",255,0,0)
				else
					WindowSetTintColor(iconWindow.."SquareIcon",0,255,0)
					
				end
			end
		end
	end
end

function EquipmentData.ResetAbility()
	EquipmentData.ActiveAbility = nil
	for iconWindow, index in pairs(EquipmentData.RegisteredAbilityIcons) do
		if (iconWindow ~= nil) then
			WindowSetTintColor(iconWindow.."SquareIcon",255,255,255)
		end
	end
end

function EquipmentData.UpdateItemIcon(elementIcon, item)
	
	-- do we have the item ID instead of the table?
	if type(item) == "number" then
		
		-- item id
		local id = item

		-- getting the item info
		item = Interface.GetObjectInfoData(id)

		-- verify the data is correct
		if not Interface.VerifyObjectName(id, item) then
			return
		end
	end

    if (elementIcon ~= nil and item ~= nil and item.newWidth ~= nil and item.newHeight ~= nil) then
		--Debug.Print("Setting Icon")
        WindowSetDimensions(elementIcon, item.newWidth, item.newHeight)		
        DynamicImageSetTextureDimensions(elementIcon, item.newWidth, item.newHeight)		
        DynamicImageSetTexture(elementIcon, item.iconName, 0, 0 )
    		
	    DynamicImageSetCustomShader(elementIcon, "UOSpriteUIShader", {item.hueId, item.objectType})
        DynamicImageSetTextureScale(elementIcon, item.iconScale)
        WindowSetTintColor(elementIcon,item.hue.r,item.hue.g,item.hue.b)
        WindowSetAlpha(elementIcon,item.hue.a/255)		
    end
end

function EquipmentData.UpdateItemIconWithHue(elementIcon, item, hue)
    if (elementIcon ~= nil and item ~= nil and item.newWidth ~= nil and item.newHeight ~= nil) then
		--Debug.Print("Setting Icon")
        WindowSetDimensions(elementIcon, item.newWidth, item.newHeight)		
        DynamicImageSetTextureDimensions(elementIcon, item.newWidth, item.newHeight)		
        DynamicImageSetTexture(elementIcon, item.iconName, 0, 0 )
        
	    DynamicImageSetCustomShader(elementIcon, "UOSpriteUIShader", {hue, item.objectType})
        DynamicImageSetTextureScale(elementIcon, item.iconScale)
        WindowSetTintColor(elementIcon,item.hue.r,item.hue.g,item.hue.b)
        WindowSetAlpha(elementIcon,item.hue.a/255)		
    end
end


function EquipmentData.DrawObjectIconAtWindowDimensions(objectType, hueId, elementIcon)
	local w, h = WindowGetDimensions(elementIcon)
	EquipmentData.DrawObjectIcon(objectType, hueId, elementIcon, w, h)
end

function EquipmentData.DrawObjectIcon(objectType, hueId, elementIcon, w, h, scl)
	if not w then
		w = 80
	end
	if not h then
		h = 80
	end
	local name, x, y, scale, newWidth, newHeight = RequestTileArt(objectType, w, h)

	if not w or not h then
		 WindowSetDimensions(elementIcon, newWidth * scale, newHeight * scale)	
	end

	if scl then
		scale = scl
	end
	WindowSetDimensions(elementIcon, newWidth*scale, newHeight*scale)	
	DynamicImageSetTextureDimensions(elementIcon, newWidth*scale, newHeight*scale)
	DynamicImageSetTexture(elementIcon, name, x, y )
	
	DynamicImageSetCustomShader(elementIcon, "UOSpriteUIShader", {hueId, objectType})
	
	DynamicImageSetTextureScale(elementIcon, scale)
	local hueR,hueG,hueB,hueA = HueRGBAValue(hueId)
	WindowSetTintColor(elementIcon, hueR,hueG,hueB )
	WindowSetAlpha(elementIcon,hueA/255)	
end

function EquipmentData.GetWeaponAbilityId(index)
	if (index == EquipmentData.WEAPONABILITY_PRIMARY or index == EquipmentData.WEAPONABILITY_SECONDARY) then
		if (EquipmentData.CurrentWeaponAbilities[index] == nil) then
			return 1
		end
		
		return EquipmentData.CurrentWeaponAbilities[index]
	end
	
	return 1
end