----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

NameColor = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

NameColor.Notoriety = { NONE = 1, INNOCENT = 2, FRIEND = 3, CANATTACK = 4, CRIMINAL = 5, ENEMY = 6, MURDERER = 7, INVULNERABLE = 8, HONORED = 9 }
NameColor.NotorietyFilters = { NONE = 1, INNOCENT = 2, FRIEND = 3, CANATTACK = 4, CRIMINAL = 5, ENEMY = 6, MURDERER = 7, INVULNERABLE = 8, HONORED = 9, NEUTRALS = 10, SUMMONS = 11, BOSSES = 12, PLAYERS = 13, PETS = 14, POISONEDONLY = 15, IGNOREMORTALSTRIKED = 16 }
NameColor.NotorietyNames = { "NONE", "INNOCENT", "FRIEND", "CANATTACK", "CRIMINAL", "ENEMY", "MURDERER", "INVULNERABLE", "HONORED" }

NameColor.TextColors = {}
NameColor.TextColors[NameColor.Notoriety.NONE]         = { r = 225, g = 225, b = 225 } --- GREY/SYS
NameColor.TextColors[NameColor.Notoriety.INNOCENT]     = { r = 128, g = 200, b = 255 } --- BLUE
NameColor.TextColors[NameColor.Notoriety.FRIEND]       = { r = 0 ,  g = 180, b = 0   } --- GREEN 
NameColor.TextColors[NameColor.Notoriety.CANATTACK]    = { r = 225, g = 225, b = 225 } --- GREY/SYS
NameColor.TextColors[NameColor.Notoriety.CRIMINAL]     = { r = 225, g = 225, b = 225 } --- GREY/SYS
NameColor.TextColors[NameColor.Notoriety.ENEMY]        = { r = 242, g = 159, b = 77  } --- ORANGE
NameColor.TextColors[NameColor.Notoriety.MURDERER]     = { r = 255, g = 64,  b = 64  } --- RED  
NameColor.TextColors[NameColor.Notoriety.INVULNERABLE] = { r = 255, g = 255, b = 0   } --- YELLOW 
NameColor.TextColors[NameColor.Notoriety.HONORED]	   = { r = 163, g = 73, b = 164   } --- PURPLE 

NameColor.AuraColors = {}
NameColor.AuraColors[NameColor.Notoriety.NONE]         = { r = 225, g = 225, b = 225 } --- GREY/SYS
NameColor.AuraColors[NameColor.Notoriety.INNOCENT]     = { r = 0, g = 130, b = 255 } --- BLUE
NameColor.AuraColors[NameColor.Notoriety.FRIEND]       = { r = 0 ,  g = 255, b = 0   } --- GREEN 
NameColor.AuraColors[NameColor.Notoriety.CANATTACK]    = { r = 70, g = 70, b = 70 } --- GREY/SYS
NameColor.AuraColors[NameColor.Notoriety.CRIMINAL]     = { r = 70, g = 70, b = 70 } --- GREY/SYS
NameColor.AuraColors[NameColor.Notoriety.ENEMY]        = { r = 242, g = 159, b = 77  } --- ORANGE
NameColor.AuraColors[NameColor.Notoriety.MURDERER]     = { r = 255, g = 0,  b = 0  } --- RED  
NameColor.AuraColors[NameColor.Notoriety.INVULNERABLE] = { r = 255, g = 255, b = 0   } --- YELLOW 
NameColor.AuraColors[NameColor.Notoriety.HONORED]	   = { r = 163, g = 73, b = 164   } --- PURPLE 

NameColor.Filter = {}
NameColor.Filter[1] =	GetStringFromTid(1011051) -- None
NameColor.Filter[2] =	GetStringFromTid(1154822) -- Innocent
NameColor.Filter[3] =	GetStringFromTid(1078866) -- Friend
NameColor.Filter[4] =	GetStringFromTid(1154823) -- Attackable
NameColor.Filter[5] =	GetStringFromTid(1153802) -- Criminal
NameColor.Filter[6] =	GetStringFromTid(1095164) -- Enemy
NameColor.Filter[7] =	GetStringFromTid(1154824) -- Murderer
NameColor.Filter[8] =	GetStringFromTid(3000509) -- Invulnerable
NameColor.Filter[9] =	GetStringFromTid(1154825) -- Neutral Animals
NameColor.Filter[10] =	GetStringFromTid(1154826) -- Summons

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function NameColor.UpdateLabelNameColor(windowTextName, visualStateId)

	-- do we have a valid window?
	if not DoesWindowExist(windowTextName) then
		return
	end
	
	-- do we have a valid notoriety?
	if not visualStateId then
	
		-- set the notoriety to none if we don't have it
		visualStateId = NameColor.Notoriety.NONE
	end

	-- get the notoriety color
	local textColor = NameColor.TextColors[visualStateId]

	-- color the text
	LabelSetTextColor(windowTextName, textColor.r, textColor.g, textColor.b)
end

function NameColor.UpdateEditBoxNameColor(windowTextName, visualStateId)
	
	-- do we have a valid window?
	if not DoesWindowExist(windowTextName) then
		return
	end

	-- do we have a valid notoriety?
	if not visualStateId then

		-- set the notoriety to none if we don't have it
		visualStateId = NameColor.Notoriety.NONE
	end

	-- get the notoriety color
	local textColor = NameColor.TextColors[visualStateId]

	-- color the text
	TextEditBoxSetTextColor(windowTextName, textColor.r, textColor.g, textColor.b)
end

function NameColor.UpdateImageNameColor(windowName, visualStateId)

	-- do we have a valid window?
	if not DoesWindowExist(windowName) then
		return
	end

	-- do we have a valid notoriety?
	if not visualStateId then

		-- set the notoriety to none if we don't have it
		visualStateId = NameColor.Notoriety.NONE
	end

	-- get the notoriety color
	local textColor = NameColor.TextColors[visualStateId]

	-- color the window
	WindowSetTintColor(windowName, textColor.r, textColor.g, textColor.b)
end