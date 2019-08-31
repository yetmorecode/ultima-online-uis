----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

EquipmentData = {}

EquipmentData.RegisteredAbilityIcons = {}
EquipmentData.CurrentWeaponAbilities = {}

function EquipmentData.Initialize()
	--Debug.Print("EquipmentData.Initialize")

	RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_RIGHTHAND)
	RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_LEFTHAND)
	--WindowRegisterEventHandler( "Root", WindowData.PlayerEquipmentSlot.Event, "EquipmentData.UpdateWeaponAbilities")
	
	WindowRegisterEventHandler( "Root", SystemData.Events.ABILITY_DISPLAY_ACTIVE, "EquipmentData.ActivateAbility")
	WindowRegisterEventHandler( "Root", SystemData.Events.ABILITY_RESET, "EquipmentData.ResetAbility")
	
	-- Initialize weapon abilities
	EquipmentData.UpdateWeaponAbilities(true)

end

function EquipmentData.Shutdown()
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_RIGHTHAND)
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_LEFTHAND)	
end

function EquipmentData.UpdateAbilityIcon(iconWindow, moveId)
	iconId = moveId + EquipmentData.WEAPONABILITY_ABILITYOFFSET

	local texture, x, y = GetIconData( iconId )
	WindowSetDimensions(iconWindow.."SquareIcon", 50, 50)
	DynamicImageSetTexture( iconWindow.."SquareIcon", texture, x, y )	   
	DynamicImageSetTextureScale(iconWindow.."SquareIcon", 0.78 )
	
	if( moveId ~= 0 ) then
		WindowSetShowing(iconWindow.."Disabled",false)
		ButtonSetDisabledFlag(iconWindow,false)
	else
		WindowSetShowing(iconWindow.."Disabled",true)
		ButtonSetDisabledFlag(iconWindow,true)
	end
end

function EquipmentData.RegisterWeaponAbilitySlot(iconWindow,type)
	EquipmentData.RegisteredAbilityIcons[iconWindow] = type	
	
	if( iconWindow ~= nil ) then
		if( EquipmentData.CurrentWeaponAbilities[type] ~= nil ) then
			EquipmentData.UpdateAbilityIcon(iconWindow,EquipmentData.CurrentWeaponAbilities[type])
		end
	end
end

function EquipmentData.UnregisterWeaponAbilitySlot(iconWindow)
	EquipmentData.RegisteredAbilityIcons[iconWindow] = nil	
end

function EquipmentData.UpdateWeaponAbilities(initialize)
	if( WindowData.UpdateInstanceId == EquipmentData.EQPOS_RIGHTHAND or
		WindowData.UpdateInstanceId == EquipmentData.EQPOS_LEFTHAND or
		initialize == true ) then		

		EquipmentData.CurrentWeaponAbilities[EquipmentData.WEAPONABILITY_PRIMARY] = 
			GetWeaponAbilityId(EquipmentData.WEAPONABILITY_PRIMARY);
		EquipmentData.CurrentWeaponAbilities[EquipmentData.WEAPONABILITY_SECONDARY] = 
			GetWeaponAbilityId(EquipmentData.WEAPONABILITY_SECONDARY);			
		
		for iconWindow, type in pairs(EquipmentData.RegisteredAbilityIcons) do
			if( iconWindow ~= nil ) then
				EquipmentData.UpdateAbilityIcon(iconWindow,EquipmentData.CurrentWeaponAbilities[type])
			end
		end

		CharacterAbilities.UpdateWeaponAbilities()
	end
end

function EquipmentData.ActivateAbility()
	local abilityId = GameData.Abilities.ActiveAbility
	local type = GameData.Abilities.ActiveAbilityType
	
	--Debug.Print("Activate Ability: abilityId="..tostring(abilityId).." type="..tostring(type))
	
	if( type == SystemData.UserAction.TYPE_WEAPON_ABILITY ) then
		local abilityIndex = 0
		if( abilityId == EquipmentData.CurrentWeaponAbilities[EquipmentData.WEAPONABILITY_PRIMARY] ) then
			abilityIndex = EquipmentData.WEAPONABILITY_PRIMARY
		elseif( abilityId == EquipmentData.CurrentWeaponAbilities[EquipmentData.WEAPONABILITY_SECONDARY] ) then
			abilityIndex = EquipmentData.WEAPONABILITY_SECONDARY
		end
		
		for iconWindow, index in pairs(EquipmentData.RegisteredAbilityIcons) do
			if( iconWindow ~= nil and index == abilityIndex ) then
				WindowSetTintColor(iconWindow.."SquareIcon",255,0,0)
			end
		end
	end
end

function EquipmentData.ResetAbility()
	for iconWindow, index in pairs(EquipmentData.RegisteredAbilityIcons) do
		if( iconWindow ~= nil ) then
			WindowSetTintColor(iconWindow.."SquareIcon",255,255,255)
		end
	end
end

function EquipmentData.UpdateItemIcon(elementIcon, item)
    if( elementIcon ~= nil and item ~= nil and item.newWidth ~= nil and item.newHeight ~= nil ) then
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

function EquipmentData.GetWeaponAbilityId(index)
	if (index == EquipmentData.WEAPONABILITY_PRIMARY or index == EquipmentData.WEAPONABILITY_SECONDARY) then
		if (EquipmentData.CurrentWeaponAbilities[index] == nil) then
			return 1
		end
		
		return EquipmentData.CurrentWeaponAbilities[index]
	end
	
	return 1
end