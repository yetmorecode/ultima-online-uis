----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------
Cliloc ={}

Cliloc.Cliloc ={}
Cliloc.Cliloc[SystemData.Settings.Language.LANGUAGE_ENU] ={
-- example : [] = L"TEXT",

[1] = L"(of max - min)",
[2] = L"Very Bad Stat",
[3] = L"Bad Stat",
[4] = L"Pet Rating (0 to 5): ~1_RATE~ (~2_PERC~)",
[5] = L"Taming Required",
[6] = L"Control Chances",
[7] = L"Toggle Highlight",
[8] = L"Enable Logging",
[9] = L"Set Background",
[10] = L"Clock Disabled",
[11] = L"Settings",
[12] = L"Disable",
[13] = L"Always Show Frame",
[14] = L"Always Show Background",
[15] = L"Type the parameters",
[16] = L"Default Location",
[17] = L"Select a location first!",
[18] = L"There is no Default Location!!!",
[19] = L"Open the Moongate window first!",
[20] = L"Set Access Level",
[21] = L"Target the item to change the security level...",
[22] = L"Obtainable from: ~1_TYPES~ dye tubs",
[23] = L"Special",
[24] = L"Statuette",
[25] = L"Metallic",
[26] = L"Known Colors List",
[27] = L"Saved Colors",
[28] = L"Target Color",
[29] = L"The targeted color is not obtainable with this dye tub.",
[30] = L"Selected Color Info",
[31] = L"Beard Only Dye",
[32] = L"Target the item type you want to see as example...",
[33] = L"Enter the color name",
[34] = L"Color Name",
[35] = L"Remove Color",
[36] = L"Delete the saved color: ~1_COLOR~?",
[37] = L"Click to select the example item type.",
[38] = L"Bright Hair Dye",
[39] = L"Hair Only Dye",
[40] = L"Bright Hair Only Dye",
[41] = L"Bright Beard Only Dye",

[42] = L"exceptionally crafted by ~1_name~",
[43] = L"DPS:",
[44] = L"Weapon Damage:",
[45] = L"Weapon Speed:",
[46] = L"Special Attacks:",
[47] = L"1-Hand",
[48] = L"2-Hand",
[49] = L"Cap: ~1_CAP~",
[50] = L"Weapon Range:",
[51] = L"Item Color ID: ~1_HUE~",
[52] = L"Item Color ID: ~1_HUE~\n~2_NAME~",
[53] = L"Total Resist:",
[54] = L"Paper",
[55] = L"BOD Rewards:",
[56] = L"Large BOD Rewards:",
[57] = { L"[None]" , L"[Innocent]" , L"[Friend]" , L"[Attackable]" , L"[Criminal]", L"[Enemy]", L"[Murderer]", L"[Invulnerable]", L"[Honored Target]" },
[58] = L"Taming Required: ~1_SKILL~",
[59] = L"Taming Chance: ~1_CHANCE~",

[60] = L"ALL ITEMS:\n- Hit Point Regeneration\n- Hit Point Increase\n- Strength Bonus\n\nARMORS and SHIELDS ONLY:\n- Damage Eaters\n\nWEAPONS ONLY:\n- Hit Life Leech\n\nAvailable on any runic.",
[61] = L"ALL ITEMS:\n- Mana Increase\n- Mana Regeneration\n- Lower Mana Cost\n- Intelligence Bonus\n\nWEAPONS ONLY:\n- Hit Mana Leech\n\nSHIELDS ONLY:\n- Soul Charge\n\nAvailable on any runic.",
[62] = L"ALL ITEMS:\n- Dexterity Bonus\n- Stamina Increase\n- Stamina Regeneration\n\nWEAPONS ONLY:\n- Hit Stamina Leech\n- Swing Speed Increase\n\nAvailable on any runic.",
[63] = L"ALL ITEMS:\n- Mana Increase\n- Mana Regeneration\n- Lower Mana Cost\n- Intelligence Bonus\n\nARMORS ONLY:\n- Casting Focus\n - Lower Reagent Cost\n - Mage Armor\n\nWEAPONS ONLY:\n- Hit Mana Leech\n - Mage Weapon\n\nAvailable on any runic\n\nSHIELDS ONLY:\nSpell Channeling\nFaster Casting.",
[64] = L"ALL ITEMS:\n- Durability\n- Lower Requirements\n- Self Repair\n\nARMORS ONLY:\n- Mage Armor\n\nWEAPONS ONLY:\n- Slayers\n- Spell Channeling\n- Velocity (Bows and Crossbows ONLY)\n- Elemental Damage\n- Chaos Damage\n- Mage Weapon\n\nAvailable on any runic.",
[65] = L"WEAPONS ONLY:\n- Hit Life Leech\n- Hit Stamina Leech\n- Hit Mana Leech\n- Hit Mana Drain\n- Hit Fatigue\n\nAvailable on any runic.",
[66] = L"ALL ITEMS:\n- Hit Point Regeneration\n- Stamina Regeneration\n- Mana Regeneration\n\nARMORS and SHIELDS ONLY:\n- Damage Eaters\n\nSHIELDS ONLY:\n- Soul Charge\n\nAvailable on any runic.",
[67] = L"ALL ITEMS:\n- Resistances\n\nAvailable on any runic.",
[68] = L"ALL ITEMS:\n- Luck\n\nAvailable on tools up to bronze/spined/ash.",
[69] = L"ALL ITEMS:\n- Enhance Potions\n\nWEAPONS ONLY:\n- Balanced (Bows and Crossbows ONLY)\n\nAvailable on tools up to shadow/spined/oak.",
[70] = L"ALL ITEMS:\n- Hit Chance Increase\n\nWEAPONS ONLY:\n- Damage Increase\n- Area Damage\n- Hit Spells\n- Battle Lust\n- Use Best Weapon Skill\n\nSHIELDS ONLY:\n- Damage Increase\n\nAvailable on tools up to shadow/spined/oak (for armors), any tool for weapons.",
[71] = L"ALL ITEMS:\n- Defense Chance Increase\n\nARMORS ONLY:\n- Casting Focus\n\nWEAPONS ONLY:\n- Hit Lower Attack\n\nSHIELDS ONLY:\n- Soul Charge\n- Reactive Paralyze\n\nAvailable on tools up to shadow/spined/oak (for armors), any tool for weapons.",

[90] = L"Imbuing Intensity: ~1_INTENS~",

[91] = L"The amount of damage per second you can deal with melee or ranged attacks.",

[92] = L"Swing Speed",
[93] = L"The current weapon speed.",

[94] = L"Medable Suit",
[95] = L"Your suit is fully medable, and allows active meditation.",

[96] = L"Your suit (or race) allows the you to ignore the effects of darkness from either night or from being underground in a dungeon.",

[97] = L"Hit Life Drain",

[98] = L"Show the category statistics.",
[99] = L"Hide the category statistics.",

[100] = L"Your weapon will cause ~1_DMG_AMT~ to all the creatures affected by ~2_SLAYER~.",
[101] = L"You will receive DOUBLE damage from all the creatures affected by ~1_OPPOSITE~.",
[102] = L"DOUBLE damage",
[103] = L"TRIPLE damage",

[104] = L"Riding",
[105] = L"You are riding.",

[106] = L"Overweight!",
[107] = L"You can hold ~1_VAL~ more stones before being overweight.",
[108] = L"You are overweight, you can't recall and you will lose stamina while moving!",

[109] = L"Skill Delay",

[109] = L"Unable To Run",
[110] = L"Your mount is overweight and unable to run.",

[111] = L"Tainted Mana",
[112] = L"Your mana has been tainted!\nEverytime you use the mana, you recive a damage equal to the mana consumed.",

[113] = L"Mana Divert",
[114] = L"Extra mana will be drawn from you if you cast a spell.",

[115] = L"Muddied",
[116] = L"You have been Muddied!\nYour swing speed has been reduced by -20%",

[117] = L"Falling Walls",
[118] = L"The cave is falling and you are stunned!",

[119] = L"Stunned",
[120] = L"You have been stunned!",

[121] = L"Berserk Rage",
[122] = L"The damage received will be reduced.\nYou can't be healed!",

[123] = L"You have the ability to move amongst monsters without them becoming hostile to you.",

[124] = L"Entangled",
[125] = L"You are entangled in the acid drenched roots!",

[126] = L"Super Slayers: ~1_SLAYERS~",
[127] = L"Slayers: ~1_SLAYERS~",
[128] = L"Opposite Slayers: ~1_SLAYERS~",

[129] = L"CRAFTING ASSISTANT",
[130] = L"Active Skill",
[131] = L"Skill Level:",
[132] = L"Current Tool Uses:",
[133] = L"Materials:",
[134] = L"Warning:",
[135] = L"Oh no! I don't have access to the TOOLS container!",
[136] = L"The TOOLS container MUST be inside your backpack!",
[137] = L"Alter",
[139] = L"Change the crafting settings for the active skill.",
[140] = L"LAST\n",
[141] = L"Show the last items created.",
[142] = L"Search the missing recipes for the active tool.\n\nNOTE: The process with take some time and the gump will blink and become unavailable until the process is complete!",
[143] = L"Make",
[144] = L"Required Materials",
[145] = L"You don't have any tool available for your skills higher than 0.",
[146] = L"You don't have any crafting skill higher than 0.",
[147] = L"All Tools Uses:",
[148] = L"You don't have any more tools for the active skill!",
[149] = L"Craftable amt.: ",
[150] = L"Oh no! I don't have access to the MATERIALS container!",
[151] = L"The MATERIALS container MUST be inside your backpack!",
[152] = L"There are no missing recipes!",
[153] = L"I'm creating the item.\nPlease wait...",
[154] = L"You don't have any ~1_Val~ tools!",
[155] = L"Set Tools Container",
[156] = L"Set Materials Container",
[157] = L"Show Materials",
[158] = L"Show Sub-Materials",
[159] = L"Active Skill Items ONLY",
[160] = L"Show Items With 0% Success",
[161] = L"Enable Search By Skill",
[162] = L"Show All Skills",
[163] = L"Show Skills > 0",
[164] = L"Show Skills With Tool Available",
[165] = L"Mark as QUEST ITEM",
[166] = L"DO NOT mark as QUEST ITEM",
[167] = L"MARK ITEMS",
[168] = L"PROMPT before Marking Item",
[169] = L"DO NOT MARK ITEMS",
[170] = L"Tool Type",
[171] = L"Now you are using the ~1_Tool~ tool.",
[172] = L"Target the container.",
[173] = L"Search Options",
[174] = L"Target The Container To Search In...",
[175] = L"~1_Val~ Items Found!",
[176] = L"If you have used \"Make Number\" or \"Make Max\" and you changed your mind, press this button.",
[177] = L"~1_Val~ Recipes Missing",
[178] = L"I'm checking the missing recipes, please STAND BY until the process is complete...",
[179] = L"Craft the item",
[180] = L"Auto combine the right items to fill this bod.\nThis function will search inside your backpack and sub-containers to find the required items.",
[181] = L"You don't have enough items to fill the bulk order.",
[182] = L"The bulk order has been filled.",
[183] = L"Gather the materials to craft all the items required in this bulk order.",
[184] = L"Quick Loot On All Containers Enabled!",
[185] = L"Quick Loot On All Containers Disabled!",
[186] = L"Toggle Quick Loot On All Containers",
[187] = L"Enable/Disable the quick loot on all containers making you able to put items in your backpack/loot bag by right clicking them.",
[188] = L"Restock Complete!",

[189] = L"Healing Speed",
[190] = L"Seconds required to apply a bandage on yourself and on others. The time amount is based on your dexterity.",

[191] = L"Debug Window",
[192] = L"Credits",

[193] = L"This UI requires EC PlaySound to work. Run ECPlaySound.exe from the game folder or press OK to use the default interface.",

[194] = L"\n(Supported languages: English and Italian)",
[195] = L"Describe the problem and provide as many details as you can on how to replicate it.\nAlso check the <game folder>/logs/errors to find out if there are any errors popping out so that they can be fixed.\n At the end of the procedure, your email program will open to send the report, feel free to attach a screenshot too.\n Thanks!",

[196] = L"Any",
[197] = L"Add Property",
[198] = L"Finders Keepers Item",
[199] = L"Invalid description!",
[200] = L"Specify an item type or at least 1 item property!",
[201] = L"There is already another item with the same description!",
[202] = L"Do you want to delete this item?",
[203] = L"Highlight Color",

[204] = L"Target the ~1_NAME~.",

[205] = L"Enable All",
[206] = L"Disable All",

[207] = L"Interrupt the ship tracking and remove the map markers.",

[208] = L"Enable the item sorting on this container.\nWhen enabled you can't switch the item position inside the container slots.",
[209] = L"Disable the item sorting on this container.",

[210] = L"Set as trash",
[211] = L"A finders keepers item is always shown on top of the sort list, but if you set it as trash the effect will be the opposite and the item will be dropped at the bottom of the list.",

[212] = L"Shore Fish",
[213] = L"Deep Water Fish",
[214] = L"Dungeon Fish",

[215] = L"Book recorder enabled!",
[216] = L"Book recorder disabled!",

[217] = L"You killed: ~1_NAME~",
[218] = L"a creature",

[219] = L"This action can be used only inside a macro.",

[220] = L"Target the the default weapon of the type you want to use.\nThis weapon will be used if the search can't find a better one.\nYou can also target a talisman.",

[221] = L"Target the item to retrieve.",

[222] = L"Total Resist: ~1_VAL~",

[223] = L"Locate",
[224] = L"Magnetize",

[225] = L"Open the plant gump first.",

[226] = L"Veteran Rewards",

[227] = L"Robes",
[228] = L"Jewelry Sets",
[229] = L"Knight Set (Human & Elves ONLY)",
[230] = L"Sorcerer Set (Human & Elves ONLY)",
[231] = L"Scout Set (Human & Elves ONLY)",
[232] = L"Bestial Set",
[233] = L"Fisherman Set",
[234] = L"Virtuoso Set",
[235] = L"Talismans",
[236] = L"Pigments",
[237] = L"Musical Instruments",

[238] = L"Target Name\nIt will copy the name of the targeted object.",

[239] = L"Move toward the front of the boat.",
[240] = L"Updated the boat direction to: ~1_DIR~",
[241] = L"The current boat direction is: ~1_DIR~",
[242] = L"The boat direction is not set.",
[243] = L"The boat direction is detected automatically when you place a boat, but other players may have moved it or you could have moved it with the wheel and the direction may be wrong.\n\nDo you want to change the direction amnually?",
[244] = L"Boat Direction",
[245] = L"Get on a boat first!",
[246] = L"Speed increased!",
[247] = L"Speed reduced!",
[248] = L"You are at maximum speed!",
[249] = L"You are at minimum speed!",

[250] = L"Red",
[251] = L"Green",
[252] = L"Blue",
[253] = L"Yellow",
[254] = L"Aqua",
[255] = L"Pink",
[256] = L"White",

[257] = L"Total Buoys: ~1_VAL~",
[258] = L"Dist.:",
[259] = L"Bobs:",
[260] = L"Last Bob:",

[261] = L"Use the object handle (CTRL + SHIFT) to load all the buoys around, or wait for them to \"bobs\"...",

[262] = L"Piloting",
[263] = L"You are piloting the ship.\nThe boat is currently facing: ~1_DIR~",

[264] = L"You can't use this command while you are piloting the ship!",
[265] = L"There are no reachable SoS in this facet...",

[266] = L"Real Time",

[267] = L"This is the default spell used when you double click a rune.\nClick here to change it.",

[268] = L"Show Charges Instead of Quantity",
[269] = L"Show Quantity Instead of Charges",

[270] = L"The Satyr Trick:",

[271] = L"Masteries",

[272] = L"You will receive DOUBLE damage from all kind of Tigers.",
[273] = L"You will receive DOUBLE damage from all kind of NON-tribal creatures in Eodon.",
[274] = L"You will receive DOUBLE damage from every creature outside Eodon.",
[275] = L"Your weapon will cause DOUBLE damage to all the creatures in Eodon.",

[276] = L"Vulnerability",
[277] = L"Lock Chat Line Under The Game Window",

[278] = L"Toggle Classic Gump (extra info)",
[279] = L"Power Hour\nYour pet is under the effects of enhanced training progress for the next hour!\nTime Left:   ~1_time~",

[280] = L"Mouse Over",

[281] = L"Creating Macro...",
[282] = L"I'm creating a hidden macro in order to set an hotkey for the spell.<BR>PLEASE KEEP MOVING YOUR MOUSE.",
[283] = L"Hotkey Cast Target",

[284] = L"I'm creating a hidden macro in order to set an hotkey for the skill.<BR>PLEASE KEEP MOVING YOUR MOUSE.",

[285] = L"You can only have one of this in your hotbars.",

[286] = L"Describe the problem and provide as many details as you can on how to replicate it.",

[287] = L"This action will PERMANENTLY mark this pet as \"not a mount\".\nDo you want to proceed?",
[288] = L"Mark this pet as \"NOT A MOUNT\"",
[289] = L"Mounts List",
[290] = L"Mount/Dismount",
[291] = L"Action that handle mount and dismount.\nRight-click to assign an hotkey.",
[292] = L"Gargoyles can't use mounts, but you can still change the hotkey for flying at the bottom of this window...",
[293] = L"You can now move the whole group of hotbars with ALT + DRAG and you can collapse all with ALT + CLICK on the \"Hide Hotbar\" button.",
[294] = L"Set All Skills To 0",

[295] = L"Welcome to Test Center!\n\nIn this shard you\'ll be able to test (almost) every feature of the game. All the special commands available are inside the \"TC Tools\" shield-button that usually is located at the bottom-right corner of the game area.\n\nRemember that NOTHING is permanent here, and the shard can be wiped clean at any moment.\n\nEnjoy your stay, and if you find any bug don\'t forget to report them through the appropriate tool (ESCAPE -> Bug Report), because we can't fix what we don't know is broken. Thanks!",

[296] = L"Turn Up",
[297] = L"Turn Down",

[298] = L"Shut down?",
[299] = L"The client will shut down in ~1_Time~.\nDo you want to shut it down immediately?",

[300] = L"Export Settings",
[301] = L"Import Settings",
[302] = L"Import all the settings from ~1_NAME~",
[303] = L"Keep showing the tips",
[304] = L"Are you sure you want to import all the settings from ~1_NAME~?\n\nNOTE: this will override all the current settings (including Finders Keepers items and Loot Sort).",
[305] = L"Spell: ~1_NAME~",

[306] = L"Import",
[307] = L"Export Macro",
[308] = L"Import Macro",
[309] = L"Importing the macro.<BR>PLEASE KEEP MOVING YOUR MOUSE.",

[310] = L"Delay: ~1_VALUE~s",
[311] = L"Command: ~1_VALUE~",
[312] = L"Resource: ~1_VALUE~",

[313] = L"Owner: ~1_VALUE~",

[314] = L"Overwrite Macro?",
[315] = L"A macro with the same name already exist.\nDo you want to OVERWRITE it?",

[316] = L"Total Pets:",

[317] = L"Vendor Hair Color",
[318] = L"Vendor Beard Color",

[319] = L"Contacts and Online Status",
[320] = L"~1_NAME~ is now ~2_STATUS~.",
[321] = L"Click to leave the current channel",
[322] = L"Click to change your status",
[323] = L"Are you sure you want to remove ~1_NAME~ from your friends?",

[324] = L"Opt In/Out of Search",
[325] = L"\n\nPress ENTER to confirm.\nPress ESCAPE to cancel.",
[326] = L"Bank Gold Available:",
[327] = L"Insurance Cost:",
[328] = L"Data unavailable on siege rules",
[329] = L"Vendor Gold Available:",
[330] = L"Vendor Daily Cost:",
[331] = L"The vendor is paid for ~1_NUM~ days.",
[332] = L"Click to change the amount of gold the vendor is holding.",
[333] = L"Change the amount of gold the vendor is holding.",
[334] = L"Vanity and Equipment",
[335] = L"Beard Dye",
[336] = L"You can't dismiss the vendor while he's holding your gold!",

[337] = L"Toggle Search Engine Window",
[338] = L"Remove Saved Criteria Set",
[339] = L"Save Criteria Set",
[340] = L"<NEW CRITERIA SET>",
[341] = L"Enter the criteria set name (20 chars MAX)",
[342] = L"Save Changes to Criteria Set",
[343] = L"Criteria set saved!",
[344] = L"Criteria set CHANGES saved!",
[345] = L"Do you really want to remove this criteria set?",
[346] = L"Criteria set DELETED!",

[347] = L"WARNING:\nAlways check inside all containers before accepting a trade, and make sure the gold/platinum amount offered is what you are expecting!",

[348] = L"~1_NOTHING~",
[349] = L"~1_NOTHING~",
[350] = L"~1_NOTHING~",
[351] = L"~1_NOTHING~",
[352] = L"~1_NOTHING~",
[353] = L"~1_NOTHING~",
[354] = L"~1_NOTHING~",
[355] = L"~1_NOTHING~",
[356] = L"~1_NOTHING~",
[357] = L"~1_NOTHING~",
[358] = L"~1_NOTHING~",
[359] = L"~1_NOTHING~",
[360] = L"~1_NOTHING~",
[361] = L"~1_NOTHING~",
[362] = L"~1_NOTHING~",
[363] = L"~1_NOTHING~",
[364] = L"~1_NOTHING~",
[365] = L"~1_NOTHING~",
[366] = L"~1_NOTHING~",
[367] = L"~1_NOTHING~",
[368] = L"~1_NOTHING~",
[369] = L"~1_NOTHING~",
[370] = L"~1_NOTHING~",
[371] = L"~1_NOTHING~",
[372] = L"~1_NOTHING~",

[373] = L"You cannot deposit any item at this time, re-open the bank box in order to do it.",

[374] = L"Absorb Skill",
[375] = L"You don't have enough points to spare to absorb the skill, so one or more of the following skills (that YOU set to \"DOWN\" from the skill window), will lose points:\n~1_SKILLS~",
[376] = L"You don't have enough points to spare to absorb the skill, set one or more skills to \"DOWN\" from the skill window.",
[377] = L"ABSORB",
[378] = L"Press this button to DELETE PERMANENTLY the skill stored in this soulstone.\nThe soulstone will be empty afterwards.",
[379] = L"Press this button to ABSORB the skill stored in this soulstone.\nThe soulstone will be empty afterwards.",
[380] = L"Do you REALLY want to DELETE the skill inside the soulstone (~1_SKILL~)?\n\nThis action is FINAL there is no going back...",
[381] = L"Delete Skill",
[382] = L"You need to use a ~1_POWERSCROL~ ~2_SKILLNAME~ power scroll before you can absorb this skill.",
[383] = L"Are you sure you want to ABSORB this skill (~1_SKILL~) and lose points in other skills in the process?\n\nThis action is FINAL there is no going back...",
[384] = L"Store Skill",
[385] = L"Are you sure you want to STORE this skill (~1_SKILL~)?\n\nYou will be able to absorb it back at any time with this or any other character of this account (as long as they have used the proper power scroll first).",

[386] = L"Buy",
[387] = L"Click to buy from this shopkeeper",
[388] = L"Sell",
[389] = L"Click to sell to this shopkeeper",

[390] = L"Type \"~1_PASSCODE~\" to unlock the \"~2_BUTTONNAME~\" button.",

[391] = L"DOUBLE-CLICK to get a quest and start a new adventure!",
[392] = L"Use to stable your pet.",
[393] = L"Commands the pet to stop what it's currently doing.",
[394] = L"Commands the pet to stay at their current location.",
[395] = L"Commands the pet to follow you.",
[396] = L"Commands the pet to guard you.",
[397] = L"Commands the pet to attack the target specified.",
[398] = L"Change your pet name, it's FREE!",
[399] = L"The veterinary skill will allow you to heal animals with bandages in much the same way that the healing skill works on people. If you're skilled enough you can also cure poisons and bring animals back to life!",

[400] = L"Click to dispel that pesky summon!",
[401] = L"Click to kick this summon where it came from!",
[402] = L"The healing skill will allow you to heal people with bandages. If you're skilled enough you can also cure poisons and bring people back to life!",
[403] = L"Click to resurrect this person.",
[404] = L"This is the leader of your party.",
[405] = L"Pin Healthbar.",
[406] = L"Click to pin the healthbar.\nOnce pinned it will move on the pinned list.",
[407] = L"Un-Pin Healthbar.",
[408] = L"Click to un-pin the healthbar.\nOnce un-pinned it will be moved on the proper list (it can also get closed if there is no proper list).",
[409] = L"Command: Attack",
[410] = L"Order your pets to attack this enemy.",
[411] = L"Honor the target and activate perfection.",
[412] = L"This spell will deal a great amount of damage to the target (NOT PLAYERS). When it can be used depends on your arcane circle level.",
[413] = L"Pinned",
[414] = L"The mobile body ID is: ~1_ID~",
[415] = L"Mobile color ID: ~1_HUE~\n~2_NAME~",
[416] = L"Mobile color ID: ~1_HUE~",
[417] = L"Dockspot Settings",
[418] = L"~1_NAME~ Settings",

[419] = L"Auto-Close Dockspot",
[420] = L"When enabled, the dockspot will automatically open/close when there are bars to show.",

[421] = L"Close Left",
[422] = L"When enabled, the dockspot will close on the left side, if disabled it will close on the right side.\nThe healthbars will spawn in the direction of the bar.",

[423] = L"Sort Type",
[424] = L"Choose how to sort the bars: Appearance (sorted in the order the mobiles appears), Distance (sorted from the nearest to you), Health (sorted from the most injured to the most injured).",

[425] = L"Layout",
[426] = L"Choose how the healthbars should be shown.\nWhile the settings window for the dockspot is open, you will be able to see a grid as a preview of the layout.",

[427] = L"Leave Disabled Bars",
[428] = L"When enabled, if a mobile goes outside the visible area, instead of removing the bar it will remains in the list but disabled.",

[429] = L"Create Filters Set",
[430] = L"DELETE Filters Set",
[431] = L"Slide the bar to change the amount of mobiles of this type you want in the dockspot.",
[432] = L"Bosses",
[433] = L"Quest Givers",
[434] = L"Stable Masters",
[435] = L"Bankers",
[436] = L"Shopkeepers",
[437] = L"BoD Dealers",
[438] = L"Player Vendors",
[439] = L"Other People's Pets",
[440] = L"Players",
[441] = L"Toggle this type of mobile from the list.\nNOTE: the mobiles are not flagged correctly 100% of the times due to some client issues...",
[442] = L"Enter a UNIQUE filter name (10 chars MAX)",
[443] = L"Do you really want to remove this filters set?",
[444] = L"Toggle Search Box",
[445] = L"Enable Right-Click to Close Pinned Healthbars",
[446] = L"Enable Status Spells Buttons",
[447] = L"Toggle customizable spells buttons on the status.",
[448] = L"Friends | Foes",
[449] = L"Enable this option to see friends mobiles in the right column and foes in the left one (inverted if you have the close right option).\nNOTE: foes are: Attackables, Criminals, Enemies and Murders, the rest are considered friends.",

[450] = L"Pet Type:",
[451] = L"Valorite Blue",
[452] = L"Ice White",
[453] = L"Red",
[454] = L"Blaze",
[455] = L"Pet Color:",
[456] = L"Echo Blue",
[457] = L"~1_COLORNAME~ (~2_RARITY~)",
[458] = L"~1_COLORNAME~",

[459] = L"Maximum possible STRENGTH this creature can naturally have (without training).",
[460] = L"Maximum possible HIT POINTS this creature can naturally have (without training).",
[461] = L"Maximum possible DEXTERITY this creature can naturally have (without training).",
[462] = L"Maximum possible STAMINA this creature can naturally have (without training).",
[463] = L"Maximum possible INTELLIGENCE this creature can naturally have (without training).",
[464] = L"Maximum possible MANA this creature can naturally have (without training).",
[465] = L"Maximum possible PHYSICAL RESISTANCE this creature can naturally have (without training).",
[466] = L"Maximum possible FIRE RESISTANCE this creature can naturally have (without training).",
[467] = L"Maximum possible COLD RESISTANCE this creature can naturally have (without training).",
[468] = L"Maximum possible POISON RESISTANCE this creature can naturally have (without training).",
[469] = L"Maximum possible ENERGY RESISTANCE this creature can naturally have (without training).",
[470] = L"Sum of all the current resistances.\nCAP: 365",
[471] = L"Maximum possible TOTAL RESISTANCES this creature can naturally have (without training).",
[472] = L"Difference between the current resistances and the maximum possible.",
[473] = L"Fruits and Vegetables ... and Shoes!",
[474] = L"Maximum possible skill this creature can naturally have (without training).",
[475] = L"Immune",
[476] = L"Cannot Be Tamed",
[477] = L"Dexterity.\nThe more the pet has, the faster will walk!",
[478] = L"Click to find a better type to match the creature.",
[479] = L"Save Animal Data To File",

[480] = L"Resistances: ~1_VALUE~ / ~2_CAP~",
[481] = L"Hit Points: ~1_VALUE~ / ~2_CAP~",
[482] = L"Stats: ~1_VALUE~ / ~2_CAP~",
[483] = L"Skills: ~1_VALUE~ / ~2_CAP~",

[484] = L"Body ID: ~1_VALUE~",
[485] = L"Hue ID: ~1_VALUE~",
[486] = L"Total Resistances: ~1_VALUE~ / ~2_CAP~",

[487] = L"Strength, Dexterity & Intelligence: ~1_VALUE~ / ~2_CAP~",
[488] = L"Hit Point, Stamina & Mana: ~1_VALUE~ / ~2_CAP~",
[489] = L"Resists: ~1_VALUE~ / ~2_CAP~",
[490] = L"Hit Point Regeneration: ~1_VALUE~ / ~2_CAP~",
[491] = L"Stamina Regeneration: ~1_VALUE~ / ~2_CAP~",
[492] = L"Mana Regeneration: ~1_VALUE~ / ~2_CAP~",

[493] = L"Training Weight Caps",
[494] = L"Training Stats Caps",

[495] = L"Strength + Intelligence: ~1_VALUE~ / ~2_CAP~",
[496] = L"Dexterity: ~1_VALUE~ / ~2_CAP~",
[497] = L"Hit Points: ~1_VALUE~ / ~2_CAP~",
[498] = L"Stamina: ~1_VALUE~ / ~2_CAP~",
[499] = L"Mana: ~1_VALUE~ / ~2_CAP~",
[500] = L"Physical Resist: ~1_VALUE~ / ~2_CAP~",
[501] = L"Fire Resist: ~1_VALUE~ / ~2_CAP~",
[502] = L"Cold Resist: ~1_VALUE~ / ~2_CAP~",
[503] = L"Poison Resist: ~1_VALUE~ / ~2_CAP~",
[504] = L"Energy Resist: ~1_VALUE~ / ~2_CAP~",
[505] = L"All Resist: ~1_VALUE~ / ~2_CAP~",

[506] = L"Cancel Training",
[507] = L"Are you sure?\nCanceling the process will remove all remaining points.",
[508] = L"Trains the creature in the power of Healing.",
[509] = L"Trains the creature the ability to go into a rage, that will allow it to inflict a small amount of damage over time to its enemy.",
[510] = L"Increase the creature skill cap.",

[511] = L"Light Blue",
[512] = L"Strong Cyan",
[513] = L"Tangle",
[514] = L"Cyan",
[515] = L"Strong Yellow",
[516] = L"Olive Green",
[517] = L"Strong Purple",
[518] = L"Strong Green",

[519] = L"Right Click to switch skill",

[520] = L"Import the finders keepers items list from ~1_NAME~",

[521] = L"~1_SPELL~ Target\n(Range: ~2_RANGE~)",
[522] = L"Target a musical instrument!",
[523] = L">>> LOCKED <<<",
[524] = L">>> SCANNING... <<<",
[525] = L">>> OUT OF RANGE <<<",
[526] = L">>> INVALID TARGET <<<",
[527] = L"NO DATA",

[528] = L"Friends Sort Type",

[529] = L"70 FPS",
[530] = L"80 FPS",
[531] = L"90 FPS",
[532] = L"100 FPS",
[533] = L"110 FPS",
[534] = L"120 FPS",
[535] = L"130 FPS",
[536] = L"140 FPS",
[537] = L"150 FPS",
[538] = L"160 FPS",
[539] = L"170 FPS",
[540] = L"180 FPS",
[541] = L"190 FPS",
[542] = L"200 FPS",

[543] = L"Total Intensity: ~1_CURR~/~2_Max~ (~3_Perc~)",
[544] = L"Stats Intensity: ~1_CURR~/~2_Max~ (~3_Perc~)",
[545] = L"Resistances Intensity: ~1_CURR~/~2_Max~ (~3_Perc~)",
[546] = L"Skills Intensity: ~1_CURR~/~2_Max~ (~3_Perc~)",

[547] = L"There are no injured pets!",
[548] = L"There are no injured party members!",
[549] = L"There are no injured mobiles!",
[550] = L"Honor Target",
[551] = L"Poisoned Only",
[552] = L"Ignore Mortal Striked",

[553] = L"Eodon",

[554] = L"Waypoints Filter",
[555] = L"Cursor Location",
[556] = L"Points of Interest",
[557] = L"Player and Party Names",
[558] = L"Activate the Atlas Overlay\nOnce activated the 2 maps will overlay each other so you can find the (and mark with a waypoint) the treasure location easily.",
[559] = L"Drag the world map until it matches the transparent treasure map overlay. When you find the perfect match, press the X to create the waypoint for the treasure location.",
[560] = L"Click to create the waypoint in your map!",
[561] = L"Locate Waypoint",
[562] = L"Icon:",
[563] = L"X/Y",
[564] = L"Latitude/Longitude",
[565] = L"N",
[566] = L"S",
[567] = L"W",
[568] = L"E",
[569] = L"Invalid Waypoint Name!",
[570] = L"Invalid Coordinates!",
[571] = L"No waypoints found!",
[572] = L"Total Waypoints: ~1_TOT~",
[573] = L"You have arrived to your destination!",
[574] = L"The target is in: ~1_MAP~\nNearest Moongate: ~2_DISTANCE~",
[575] = L"LEFT-CLICK to locate the waypoint\nRIGHT-CLICK to turn off the compass",
[576] = L"LEFT-CLICK to cycle through the tracking targets\nRIGHT-CLICK to turn off the compass",

[577] = L"Click to select a group of actions",
[578] = L"Default Target",
[579] = L"Items List Updated!",

[580] = L"There are no reachable Treasures in this facet...",
[581] = L"The target is already being ignored",
[582] = L"Are you sure you want to release ALL the pets under your control?\n\nThe process is IRREVERSIBLE and certain creatures can even disappear and be lost forever.",
[583] = L"The container is empty!",
[584] = L"Loading shurikens...",
[585] = L"Ninja belt fully loaded!",
[586] = L"Not enough shurikens to completely load the ninja belt!",
[587] = L"You don't have a ninja belt with you!",
[588] = L"It's been too long since the last items list update! Use the object handles (CTRL + SHIFT) to update the list and try again.",
[589] = L"There are no corpses in range.",
[590] = L"Unlooted Corpses Only",
[591] = L"Only Corpses in Loot Range",
[592] = L"Only Reanimable Corpses",
[593] = L"Undress complete!",
[594] = L"Restock complete!",
[595] = L"Organize complete!",
[596] = L"Vacuum complete!",
[597] = L"Requires a current target",
[598] = L"You need to drag an object to use this action!",
[599] = L"There is no boss to target!",
[600] = L"There is no target stored!",
[601] = L"You have no pets in sight!",
[602] = L"You are not mounted!",
[603] = L"You have no spellbook of this type in your backpack!",
[604] = L"You need to move in order to fix the boat direction!",
[605] = L"You have no weapons compatible with the selected type with you...",

[606] = L"Requires a recipe.",
[607] = L"Requires Stygian Abyss.",
[608] = L"Requires High Seas.",
[609] = L"Requires Rustic Booster Pack.",
[610] = L"Requires Gothic Booster Pack.",
[611] = L"Requires Time of Legends.",
[612] = L"The item retains the material color.",
[613] = L"Missing Item Data",
[614] = L"Rebuild the tool data for the DB.\n\nNOTE: the more items there are in the tool, the longer it will take.\n\nRemember to logout and update the CraftingInfo.lua file at the end of the process!",

[615] = L"(~1_SKILL~)",
[616] = L"Vice vs Virtue Reward",
[617] = L"Peerless Boss",
[618] = L"Tinkering BoD",
[619] = L"Skinning",
[620] = L"Void Creature",
[621] = L"Fire Rabbit",
[622] = L"Paragon Artifact",
[623] = L"Alchemy Shop",
[624] = L"Kotl City Hidden Chest",
[625] = L"Kotl City Artifact Trader",
[626] = L"Clipped Plants",
[627] = L"Quicksilver Elemental",
[628] = L"Use Thread/Yarn on a Loom",
[629] = L"Ore Elementals",
[630] = L"Britain Library",
[631] = L"Tailor Shop",
[632] = L"Use Cotton on Spinning Wheel",
[633] = L"Use Scissor on bone parts",
[634] = L"Cavern of the Discarded",
[635] = L"Treasures of Tokuno (Event)",
[636] = L"Mage Shop",
[637] = L"Beekeper Shop",
[638] = L"Halloween Event 2015",
[639] = L"Wheat Fields",
[640] = L"Barkeep Shop",
[641] = L"Cook Shop",
[642] = L"Halloween Event 2019",
[643] = L"Farmer Shop",
[644] = L"Sea Market Barkeep Shop",
[645] = L"Fey (Abyss)",
[646] = L"Baker Shop",
[647] = L"Butcher Shop",
[648] = L"Sugar Cane",
[649] = L"Innkeeper Shop",
[650] = L"Eat Bowl of Peas to get it",
[651] = L"Vanilla Plant",
[652] = L"Vicious Macaw",
[653] = L"Use Wool on Spinning Wheel",
[654] = L"Unfrozen Mummy",
[655] = L"Click to go to the crafting details of this material...",

[656] = L"If the mounts list shows mount that are not mounts or your mount cannot be found, press this button to reset the data.",
[657] = L"Open the crafting details of an item first!",
[658] = L"Set the item to craft first!",
[659] = L"Item to craft: ~1_ITEM~",
[660] = L"You need to use a ~1_SKILL~ tool!",
[661] = L"No item set!",
[662] = L"( ~1_charges~ USES LEFT )",


--[[ 1000 TO 2499 RESERVED FOR SETTINGS: 
	
	1000 - 1499 DESCRIPTIONS
	1500 - 1999 NAMES
	2000 - 2499 OTHER LABELS
--]]
[1000] = L"Enable UO Cartographer/Mapper",
[1001] = L"Enable Items Icons",
[1002] = L"Enable Full Slot Durability Check",
[1003] = L"Select The Texture",
[1004] = L"Hotbar's Border Texture",
[1005] = L"Enable Clock",
[1006] = L"Enable The New Animal Lore Gump" ,
[1007] = L"Enable User Friendly Moongate Gump" ,
[1008] = L"Enable Advanced Crafting" ,
[1009] = L"Enable New Item Properties Layout" ,
[1010] = L"Enable Cast Bar" ,
[1011] = L"Scavenge All",
[1012] = L"Direct Button Text Color",
[1013] = L"Control + Button Text Color",
[1014] = L"Alt + Button Text Color",
[1015] = L"Shift + Button Text Color",
[1016] = L"Control + Alt + Button Text Color",
[1017] = L"Alt + Shift + Button Text Color",
[1018] = L"Control + Shift + Button Text Color",
[1019] = L"Control + Alt + Shift + Button Text Color",
[1020] = L"Countdown Text Color",
[1021] = L"Current Target Border Color",
[1022] = L"Target Self Border Color",
[1023] = L"Target Cursor Border Color",
[1024] = L"Target Stored Border Color",
[1025] = L"Default Border Color",
[1026] = L"Default Player Vendor View",
[1027] = L"Disable Spells Buttons While Casting",
[1028] = L"EC PlaySound - Effects",
[1029] = L"EC PlaySound - Music",
[1030] = L"EC PlaySound - HeartBeat",
[1031] = L"HeartBeat Volume",
[1032] = L"Normal Forge" ,
[1033] = L"Ter Mur Forge" ,
[1034] = L"Queen Forge" ,
[1035] = L"Human/Elf" ,
[1036] = L"Gargoyle" ,
[1037] = L"Default Item Name Text Color",
[1038] = L"Default Properties Text Color",
[1039] = L"Default Engrave Text Color",
[1040] = L"Default Artifact Name Color",
[1041] = L"Default Set Name Color",
[1042] = L"Default Magic Residue Item Color" ,
[1043] = L"Default Ench. Essence Item Color" ,
[1044] = L"Default Relic Fragment Item Color" ,
[1045] = L"Default Lost Items Color" ,
[1046] = L"Book Log" ,
[1047] = L"Auto-Close Veteran Rewards Gump",
[1048] = L"Properties Scale",
[1049] = L"Enable Container Type Icon",
[1050] = L"Enable Paperdoll Background",
[1051] = L"Show Names And Healthbars On The Map",
[1052] = L"Show Properties Cap",
[1053] = L"Enable Auto-Toggle War Mode",
[1054] = L"Enable Vice VS Virtue Alert",
[1055] = L"Enable Item Properties Intensity Color",
[1056] = L"Item Properties Intensity Color",
[1057] = L"Enable Smart Boat Commands",
[1058] = L"Enable Current Target Context Actions",
[1059] = L"Refresh Rate",
[1060] = L"Auto Accept Self Honoring",
[1061] = L"Windowed Fullscreen (Restart Required)",
[1062] = L"Disable Gate Warnings",
[1063] = L"Save Scroll Position",
[1064] = L"Switch Current Target on Mouse Over",
[1065] = L"Target Mouse Over Border Color",
[1066] = L"Toggle Object Handles",
[1067] = L"Scale Window\n(if scale mode is enabled)",
[1068] = L"Alter Window Transparency\n(if alpha mode is enabled)",
[1069] = L"Quick Loot",
[1070] = L"Unstack 1",
[1071] = L"Unstack Half",
[1072] = L"Create Blockbar/Quickstat",
[1073] = L"Move Hotbar Item",
[1074] = L"Move Hotbar\n(same as dragging the handle)",
[1075] = L"Move Hotbars as Group",
[1076] = L"Shrink/Enlarge Hotbars Group",
[1097] = L"Messages Log Buffer",
[1099] = L"Enable Overhead Healthbars",
[1100] = L"Show Friend Status Changes",
[1101] = L"Enable Boss Bar",
[1102] = L"Disable Healthbars Buttons",
[1103] = L"Bad Stat Range (yellow)",
[1104] = L"VERY Bad Stat Range (red)",
[1105] = L"Loot Max Weight",
[1106] = L"Auto-Pin Honored Target",
[1107] = L"Use Khyro's Pet Rating System",
[1109] = L"Enable Pin-Point Lines",
[1110] = L"Dig at YOUR Location",
[1111] = L"Auto-Target Gold for Bag of Sending",

[1500] = L"Enable this to link the game to UO Cartographer/Mapper.<BR><BR>NOTE: When enabled the disk usage will be very high!!!",
[1501] = L"Enable this to see the items icons instead of the slot icon on the paperdoll.",
[1502] = L"Enable this to see the durability status of an item on the paperdoll in the whole slot. If disabled you will see the durabilty status just on the slots border.",
[1503] = L"Pick your favourite texture from the list, and it will be used for the paperdoll and hotbars.",
[1504] = L"Pick your favourite texture to use as default for the hotbar's borders.",
[1505] = L"Shows a real digital clock.",
[1506] = L"Toggle the new Animal Lore gump that shows all the info in a single page.",
[1507] = L"Toggle the new Moongate gump and all the related actions.",
[1508] = L"If enabled you will be able to use the new user friendly crafting system and all the related functions.",
[1509] = L"Enable the new USER-FRIENDLY item properties layout.\nDisable this if you like to struggle while reading the items properties.",
[1510] = L"Enable the cast bar that will shows how long the spell casting will take everytime you cast a spell.",
[1511] = L"If enabled the scavenger agent will try to pick up EVERYTHING in range instead of picking up only the items specified inside the Agents Settings.<br>With this option you will be able to filter items through the object handle text filter.",
[1512] = L"Allows you to change the color of the button name for a single button (a macro that do not requires CTRL, ALT or SHIFT).",
[1513] = L"Allows you to change the color of the button name for the Control + Button.",
[1514] = L"Allows you to change the color of the button name for the Alt + Button.",
[1515] = L"Allows you to change the color of the button name for the Shift + Button.",
[1516] = L"Allows you to change the color of the button name for the Control + Alt + Button.",
[1517] = L"Allows you to change the color of the button name for the Alt + Shift + Button.",
[1518] = L"Allows you to change the color of the button name for the Control + Shift + Button.",
[1519] = L"Allows you to change the color of the button name for the Control + Alt + Shift + Button.",
[1520] = L"Allows you to change the color of the countdown text over the hotbar buttons.",
[1521] = L"Allows you to change the color of the hotbar border for the buttons that requires a target current.",
[1522] = L"Allows you to change the color of the hotbar border for the buttons that requires a target self.",
[1523] = L"Allows you to change the color of the hotbar border for the buttons that requires a target cursor.",
[1524] = L"Allows you to change the color of the hotbar border for the buttons that requires a target stored.",
[1525] = L"Allows you to change the color of the default hotbar border.",
[1526] = L"Default view used when you browse a player vendor.",
[1527] = L"When enabled, the spells buttons on your hotbar will be disabled when you are casting and recoverying from another spell.",
[1528] = L"Enable additional sound effects from EC PlaySound.\nThis also allows you to use your custom sounds.",
[1529] = L"Enable the new music for the game.\nYou can customize the music by swapping the files inside the Music folder of the game.",
[1530] = L"This replaces the default game heartbeat played when your life is low.",
[1531] = L"The volume of the heartbeat.",
[1532] = L"Calculate the unravel materials based on a normal soulforge bonus.",
[1533] = L"Calculate the unravel materials based on the Ter Mur soulforge bonus.",
[1534] = L"Calculate the unravel materials based on the Queen soulforge bonus.",
[1535] = L"Calculate the unravel materials based on humans/elves bonus.",
[1536] = L"Calculate the unravel materials based on gargoyles bonus.",
[1537] = L"Click the square to change the default items name text color...",
[1538] = L"Click the square to change the default items properties text color...",
[1539] = L"Click the square to change the default engrave text color...",
[1540] = L"Click the square to change the default items artifact name color...",
[1541] = L"Click the square to change the default items set name color...",
[1542] = L"Click the square to change the default Magic Residue Item Color" ,
[1543] = L"Click the square to change the default Enchanted Essence Item Color" ,
[1544] = L"Click the square to change the default Relic Fragment Item Color" ,
[1545] = L"Click the square to change the default Lost Items Color" ,
[1546] = L"If enabled, every book you open will be saved into the \"Logs\" folder of the game.\n\nNOTE: You will be unable to close the book until the saving process is complete." ,
[1547] = L"If enabled the veteran rewards gump will be closed automatically on login.",
[1548] = L"The scale used for the new item properties.",
[1549] = L"If enabled, when the legacy grid mode is disabled, you will see an icon on the top-left corner of the container window that represents the container type.",
[1550] = L"If enabled, the background of your paperdoll will change based on the place you are.",
[1551] = L"When active, the map will shows the name and the healthbars for you and your party members.",
[1552] = L"Show the cap of each property.",
[1553] = L"The Auto-Toggle war mode, puts you in peace when hit by blood oath, and recovers the war mode after invisibility/hiding.",
[1554] = L"If enabled, you'll receive a center screen text everytime a Vice VS Virtue battle begins.",
[1555] = L"If enabled, the item properties will be colored based on the intensity.",
[1556] = L"The item properties intensity color used in different shade based on the intensity.",
[1557] = L"When enabled, the boat speech commands will be adjustd with the boat direction.\n\nUse the action \"Fix Ship Direction\" to adjust the ship orientation (in case is wrong).",
[1558] = L"When enabled, the current target will show the context menu actions as buttons underneath it.",
[1559] = L"The frequency rate for the healthbar status refresh.\n\nNOTE: if it's too fast the client could lag or even get disconnected!!!",
[1560] = L"If enabled, when you honor yourself, it will automatically press \"OK\".",
[1561] = L"The client will stay windowed mode, but it will also fill the whole screen like if it was fullscreen.",
[1562] = L"Disable the warning gump generated when you try to use a gate.",
[1563] = L"Disable the auto-saving scroll position for your containers. Use this option if the client don't save/load the scroll correctly.",
[1564] = L"If enabled, allows you to target any creature (or yourself) by moving the mouse over it.\nBy doing so the cast of a spell or the use of a skill on current target became a cast on mouse over.\n\nNOTE: If when you cast a spell (or use a skill) you have no current target a cursor target appear and automatically cast it over the first creature you point it at (without clicking).",
[1565] = L"Allows you to change the color of the hotbar border for the buttons that requires a target on mouse over.",
[1566] = L"Control + Shift",
[1567] = L"Mouse Wheel",
[1568] = L"Mouse Wheel",
[1569] = L"Right Click",
[1570] = L"Control + Right Click",
[1571] = L"Alt + Right Click",
[1572] = L"Control + Drag",
[1573] = L"Shift + Drag",
[1574] = L"Control + Drag",
[1575] = L"Alt + Drag",
[1576] = L"Alt + Click\n(on hide/show button)",
[1577] = L"Show/Hide the overhead or the mobiles list healthbars for this type of mobile.",
[1578] = L"Change the scan rate of the mobiles on screen.\nNOTE: the faster you make it the worst will be the game performance.",
[1579] = L"Change the distance between the bars in the mobiles list.",
[1580] = L"Make the names clickable (like clicking the mobile itself).",
[1581] = L"Change the chat transparency.",
[1582] = L"If enabled, the chat will auto-hide after a short amount of time.",
[1583] = L"Specify how much time it will take for the chat to hide.",
[1584] = L"Reveal the chat when the mouse cursor is over the are where is hidden.\nIf disabled, the chat will re-appear only when a new message arrives.",
[1585] = L"If enabled, the text will fade with the rest of the chat window.",
[1586] = L"If enabled, you will see the time in front of every message.",
[1587] = L"Prevents the chat window from being moved.",
[1588] = L"Lock the chat line at the bottom of the game window.",
[1589] = L"Lock the chat line UNDER the game window.",
[1590] = L"Minimum amount of damage to deal before it starts to show in the chat window (set to 0 to disable the feature).",
[1591] = L"Enable/disable the \"You See ...\" message in the chat log when a mobile with this notoriety approaches.",
[1592] = L"Show/hide the spell's word of power in the chat log when you (or someone else) cast a spell.",
[1593] = L"Show/hide the spell's messages in the chat log (like \"You are already casting a spell\").",
[1594] = L"Show/hide the perfection messages in the chat log.",
[1595] = L"If enabled, this option will block duplicate messages with the same text from the same sender.",
[1596] = L"Show/hide the channel name tag (like \[Party\], \[Guild\], etc..).",
[1597] = L"This is the number of messages saved between sessions. The double of this amount is visible in the chat log while playing.\n\nNOTE: increasing the number of messages stored will decrease the game performance.",
[1598] = L"Amount of healthbars for this type of mobiles.\nNOTE: no matter how you set this limit, there can't be more than 20 active healthbars at time (total of all the mobile types).",
[1599] = L"Enable the overhead healthbars. This healthbars are lighter than the default one and they can co-exist (only the default bar or the overhead healthbar can exist at the same time).",
[1600] = L"If enabled, allows you to receive messages that informs you when a friend come online or goes offline.",
[1601] = L"If enabled, the known bosses will have a boss bar on top of the game area for easy targeting.",
[1602] = L"If enabled, the healthbars won't expand anymore and you won't be able to access the special buttons.",
[1603] = L"Percent difference between the minimum and maximum WILD value that a pet can have in a stat to consider BAD.\nThe stat will be considered BAD if it's equal or less to this percent but greater than the VERY BAD value.",
[1604] = L"Percent difference between the minimum and maximum WILD value that a pet can have in a stat to consider VERY BAD.\nThe stat will be considered VERY BAD if it's equal or less to this percent.",
[1605] = L"If enabled, the healthbars won't expand anymore, but you'll have a set of 5 small buttons on the bottom of each bar for the main actions.",
[1606] = L"Any item with a weight higher that the one you specify here will NOT be looted by the auto-loot and it will always show at the bottom of the list inside a container with the loot sort active.",
[1607] = L"If enabled, the honored target will get his bar pinned automatically.",
[1608] = L"Use Khyro's pet rating system instead of the old one. Khyro's system uses the intensity to rate the pet instead of a plain stat comparison and it will provide a more realistic results (especially for trained pets).",
[1609] = L"When enabled, you'll see 2 lines intersecting in the treasure location instead of the X, making it easier to find the location.",
[1610] = L"When enabled, after pressing the map name inside the treasure map window, you'll start to dig at your character location instead of getting the target cursor to dig somewhere else.",
[1611] = L"When enabled, after using the Bag of Sending, the biggest pile of gold you have in your backpack will be automatically targetted.",

[2000] = L"Mini Texture Packs",
[2001] = L"Diablo 2",
[2002] = L"Hotbars Colors - Hotkeys",
[2003] = L"Loot Sort Order",
[2004] = L"Finders Keepers",
[2005] = L"Add Item",
[2006] = L"EC PlaySound",
[2007] = L"Item Properties",
[2008] = L"Imbuing Settings",
[2009] = L"Colors Settings",
[2010] = L"Cascade Settings",
[2011] = L"Random Cascade",
[2012] = L"Item Properties Intensity Color",
[2013] = L"Overhead",
[2014] = L"Gumps Settings",
[2015] = L"Global Keys (NOT CUSTOMIZABLE)",
[2016] = L"Container Keys (NOT CUSTOMIZABLE)",
[2017] = L"Hotbars Keys (NOT CUSTOMIZABLE)",
[2018] = L"Character Sheet/Abilities and Spellbooks Keys (NOT CUSTOMIZABLE)",
[2019] = L"Hotbars Colors - Targets and Cooldowns",
[2020] = L"Mobiles List Options",
[2021] = L"\t\t\t\t\t\t\tIgnored Players\t\t\t\t\t\t\t\t\t\t\t\t\tIgnored Chat Players",
[2022] = L"Filters (Overhead Healthbars ONLY)",
[2023] = L"Party Healthbar",
[2024] = L"Small Healthbars Buttons",
[2025] = L"Export List",
[2026] = L"Import List",
[2027] = L"Treasure Maps",

--[[ 3000 TO 4000 RESERVED FOR ACTIONS: 
	
	3000 - 3499 DESCRIPTIONS
	3500 - 3999 NAMES
	4000 - 4500 CATEGORY NAMES
--]]

[3000] = L"Send a chat message.",
[3001] = L"Send a message to the guild.",
[3002] = L"Send a message to the alliance.",
[3003] = L"Send a message to the party.",
[3004] = L"Show a speech text over your character and in the journal. This text is visible only by you.",
[3005] = L"Activate a custom buff with cooldown.\n\nYou will have to enter the parameters Buff Name|Cooldown.\nes. Craft Time|10.0\n\nNOTE: always use the DOT as decimal separator for seconds.",
[3006] = L"Go to the default Moongate location.\nNOTE: the user friendly moongate gump MUST be active.",
[3007] = L"Open the most filled ~1_TYPE~ spellbook.",
[3008] = L"Use this action when you want to change the security of a container/item inside your home. This action automatically select the pre-defined rights on the targetted item.\nTo change the rights use the context menu on this action.",
[3009] = L"Allows you to see the properties tooltip over this square instead of the mouse location.\n\nAn active use of this action will turn on/off the properties tooltip.",
[3010] = L"Use this to switch between the map and the tactical map.",
[3011] = L"Shows a special map with the server lines in it.",
[3012] = L"Use this action to select your snooping victim.\n\nUse a macro with \"Snoop Target\" followed by \"Use Targeted Object\" to start snooping and this action to switch target.",
[3013] = L"Use this action inside a macro followed by \"Use Targeted Object\" to snoop your target. Use the action \"Set Snoop Target\" to change your victim.",
[3014] = L"!!!TO BE USED ONLY INSIDE A MACRO!!!\n\nPut this before an empty equip action to set the best weapon for the current target (inside the equip).",
[3015] = L"Use this action to open the art viewer window.",
[3016] = L"Use this action to retrieve an object locked down in your home.",
[3017] = L"Gather all the seeds from the plant. Open the plant gump before using this action.",
[3018] = L"Gather all the resources from the plant. Open the plant gump before using this action.",
[3019] = L"Increase the boat speed.",
[3020] = L"Decrease the boat speed.",
[3021] = L"Manually set the ship direction (to be used in case the ship commands are messed up).",
[3022] = L"Show/Hide the Buoy Tool that allows you to manage all the buoys that you have around.",
[3023] = L"Target the nearest buoy from the Buoy's Tool list.",
[3024] = L"!!!TO BE USED ONLY INSIDE A MACRO!!!\n\nPut this before an empty equip action to equip the last item of the selected slot.",
[3025] = L"Magnetize the compass to the nearest SoS, so you will be easily find it without searching the map manually.\nNOTE: it will search only for the SoS in the facet where is triggered.",
[3026] = L"Press the \"Reimbue Last\" button in the Imbuing Menu.\n\nNote: You muse open the imbuing menu first.",
[3027] = L"Set a filter for the mobiles dockspot.\nRight click to set the filter.\nIf you remove the selected filter, it will automatically select the default one until you change it.",
[3028] = L"Set the current target as the active boss, and show the boss bar for it.\nNOTE: invulnerable NPCs cannot be set as boss.",
[3029] = L"Target the active boss.",
[3030] = L"Use this when standing on the pentagram in the Papua mage shop to reach Moonglow.",
[3031] = L"Used near a barkeep or a town crier, will give a scenario hint.",
[3032] = L"Open the most filled Magery spellbook.",
[3033] = L"Open the most filled Necromancy spellbook.",
[3034] = L"Open the most filled Chivalry spellbook.",
[3035] = L"Open the most filled Bushido spellbook.",
[3036] = L"Open the most filled Ninjitsu spellbook.",
[3037] = L"Open the most filled Spellweaving spellbook.",
[3038] = L"Open the most filled Mysticism spellbook.",
[3039] = L"Used in a stable, will report how many stable slots are occupied.",
[3040] = L"Right click this action when is in the hotbar or a macro to customize the filters for the mobile to target.",
[3041] = L"Use this when standing on the pentagram in the Papua mage shop to reach Moonglow.",
[3042] = L"Used near a barkeep or a town crier, will give a scenario hint.",
[3043] = L"Unravel all items inside a container",
[3044] = L"Magnetize the compass to the nearest Treasure Map waypoint, so you will be easily find it without searching the map manually.\nNOTE: it will search only for the Treasure Map in the facet where is triggered.",
[3045] = L"Target the first item inside the pre-selected container.\n\nNOTE: The first item is always the first item placed inside the container and NOT the first on the grid.",
[3046] = L"Target a chosen type of item (with a specific hue) inside your backpack (or any sub-container).",
[3047] = L"Use this action to directly target the DEFAULT PET ~1_NUM~.\n\nThe pet needs to be stored previously by using Store Default Pet ~1_NUM~",
[3048] = L"Use this action to directly target the DEFAULT OBJECT ~1_NUM~.\n\nThe object needs to be stored previously by using Store Default Object ~1_NUM~",
[3049] = L"Use this action AFTER using the object handles (CTRL + SHIFT) to target the nearest corpse.\n\nYou can customize the action with the following filters:\n - Unlooted Corpses Only\n - Only Corpses in Loot Range\n - Only Reanimable Corpses (for necromancy).\n\nYou also need to set your object handle filters to Dynamic Objects or Corpses in order to get the correct item list.",
[3050] = L"Use this action to close the crafting gump.",
[3051] = L"Use this action when the crafting gump is open, to craft a specific item.\nTo set the item, open the crafting gump on the details of the item you want to craft and edit this action.",

[3500] = L"Chat",
[3501] = L"Guild",
[3502] = L"Alliance",
[3503] = L"Party",
[3504] = L"Note To Self",
[3505] = L"Custom Buff ~1_NUM~",
[3506] = L"Default Moongate Location",
[3507] = L"Full ~1_TYPE~ spellbook",
[3508] = L"Set Security",
[3509] = L"Properties Showing Point",
[3510] = L"Toggle Tactical Map",
[3511] = L"Show Server Lines",
[3512] = L"Set Snoop Target",
[3513] = L"Snoop Target",
[3514] = L"Set Best Weapon/Spellbook",
[3515] = L"Art Viewer Window",
[3516] = L"Retrieve Item",
[3517] = L"Gather Seeds",
[3518] = L"Gather Resources",
[3519] = L"Speed UP",
[3520] = L"Speed DOWN",
[3521] = L"Fix Ship Direction",
[3522] = L"Buoy Tool",
[3523] = L"Target Nearest Buoy",
[3524] = L"Equip Last",
[3525] = L"Nearest SoS",
[3526] = L"Reimbue Last",
[3527] = L"Set Mobile Bars Filter",
[3528] = L"Set Boss Bar",
[3529] = L"Target Boss",
[3530] = L"Undress Agent",
[3531] = L"Switch Object Handle",
[3532] = L"Claim Pet",
[3533] = L"Recsu",
[3534] = L"Recdu",
[3535] = L"News",
[3536] = L"Unravel Container",
[3537] = L"Nearest Treasure Map",
[3538] = L"Target Nearest Corpse",
[3539] = L"Close Crafting Gump",
[3540] = L"Craft Item",

[4000] = L"Custom Buffs",
[4001] = L"Stop Tracking";
[4002] = L"Equip Fishing Pole",


-- from 5000 to 6000 reserved for materials info.
[5141] = L"Obtainable by cutting body parts (without flesh) with a scissor.",
[5142] = L"Obtainable by cutting a great barracuda with a knife.",
[5143] = L"Obtainable from apple trees or purchased NPC Innkeeper and Farmer. It can also be created with the Create Food spell.",
[5144] = L"It can be purchased from NPC Tavernkeepers in the Sea Market.",
[5145] = L"Obtainable by cutting a yellowtail barracuda with a knife.",
[5146] = L"Obtainable by mining niter deposits.",
[5147] = L"You can gather broken crystals at the Prism of Light or by gathering Ancient Pottery Fragments from the creatures in Ter-Mur. The broken cristals are the following: Crystalline Fragments, Broken Crystals, Shattered Crystals, Scattered Crystals, Crushed Crystals, Jagged Crystals and Crystal Pieces.",
[5148] = L"Obtainable by cutting a giant koi with a knife.",
[5149] = L"Obtainable by cutting a fire fish with a knife.",
[5150] = L"Obtainable by cutting a reaper fish with a knife.",
[5151] = L"Obtainable by cutting a crystal fish with a knife.",
[5152] = L"Obtainable by cutting a bull fish with a knife.",
[5153] = L"Obtainable by cutting a summer dragonfish with a knife.",
[5154] = L"Obtainable by cutting a fairy salmon with a knife.",
[5155] = L"Obtainable by unraveling rare and powerful items.",
[5156] = L"You can gather the wheat from the farmlands around the world.",
[5157] = L"Obtainable by cutting a holy mackerel with a knife.",
[5158] = L"Obtainable by cutting a unicorn fish with a knife.",
[5159] = L"Obtainable by cutting a stone crab with a knife.",
[5160] = L"Obtainable by cutting a blue lobster with a knife.",
[5161] = L"Obtainable by killing Medusa.",
[5162] = L"Obtainable by cutting a spider crab with a knife.",
[5163] = L"Obtainable by using the balls of yarn into a loom or purchased from NPC Tailor and Weaver.",
[5164] = L"It can be purchased from NPC Mage, Necromancer, Alchemist or Herbalist. Sometimes it can be found on the ground.\nPlanting a Green Thorn into the dirt could spawn this reagent.",
[5165] = L"Obtainable by cutting a Bolt of Cloth with a scissor or by making the Cut-Up Cloth. It can also be purchased from NPC Tailor and Weaver.",
[5166] = L"Obtainable by killing a Red Death in Bedlam.",
[5167] = L"Obtainable by cutting a decorative plant with the Clippers.\nNOTE: the Clippers must be set to cut reeds!",
[5168] = L"Obtainable as loot on certain monsters or inside a treasure chest. The Sea Monsters may have one as loot. All maps used must be decoded and completed by the same person. Feluccan maps cannot be used with those obtained elsewhere.",
[5169] = L"A rare drop of the Fire Rabbits. The Fire Rabbits can be found on the top of Mount Sho in Isamu-Jima.",
[5170] = L"Obtainable by plucking birs and harpies. It can also be purchased from NPC Bowyer.",
[5171] = L"It can be purchased from NPC Innkeeper or Tavernkeeper. You can also use an Endless Decanter of Water, obtainable by throwing Pitchers of Water against Water Elementals.",
[5172] = L"Obtainable by using Wheat into a flour mill",
[5173] = L"Obtainable randomly while mining.",
[5174] = L"Obtainable from beehives or purchased from NPC Cook.",
[5175] = L"It can be purchased from NPC Farmer.",
[5176] = L"The currency of all the worlds. If you need some try in Bank...",
[5177] = L"Obtainable by killing Toxic Sliths in Ter-Mur.",
[5178] = L"Obtainable rarely while mining and randomly as loot of the Stygian Abyss Mini-Champions.\nIt can also be obtained by completing certain quests.",
[5179] = L"Obtainable by killing most of the creatures and by skinning them with a knife. It can be purchased from NPC Butcher.",
[5180] = L"Obtainable by killing the following creatures: Betrayer, Blackthorn Juggernaut, Exodus Minion, Exodus Overseer or Golem.",
[5181] = L"Obtainable rarely while fishing and randomly as loot of the Stygian Abyss Mini-Champions.\nIt can also be obtained by completing certain quests.",
[5182] = L"It can be purchased from NPC Cook, Barkeeper, Tavernkeeper and Waiter. It can also be created with the Create Food spell.",
[5183] = L"Obtainable randomly while mining or purchased from NPC Jeweler.",
[5184] = L"Obtainable rarely while lumberjacking and randomly as loot of the Stygian Abyss Mini-Champions.\nIt can also be obtained by completing certain quests.",
[5185] = L"The faction currency of Felucca. It can be obtained by killing faction enemies or by successfully steal an enemy town sigil.",
[5186] = L"Obtainable rarely by killing the Dread Horn.",
[5187] = L"It can be purchased from NPC Mage or Necromancer. Sometimes it can be found as loot on Necromancer creatures (like Liches).",
[5188] = L"Obtainable by killing the Shimmering Effusion.",
[5189] = L"Obtainable as loot on Void creatures in Ter-Mur.",
[5190] = L"Obtainable as loot Earth Elementals and Ant Lions.",
[5191] = L"Obtainable by skinning most of the reptilians creatures.",
[5192] = L"Obtainable by cutting a plain fishes with a knife.",
[5193] = L"It can be purchased from NPC Cook, Barkeeper, Tavernkeeper and Waiter.",
[5194] = L"Obtainable by skinning most of the bird creatures. It can be purchased from NPC Butcher.",
[5195] = L"Obtainable rarely while lumberjacking in Ter-Mur.",
[5196] = L"Obtainable by skinning sheeps. It can be purchased from NPC Butcher.",
[5197] = L"Obtainable randomly while lumberjacking.",
[5198] = L"It can be stolen from the containers inside NPC Blacksmith shops.",
[5199] = L"Obtainable randomly while mining.",
[5200] = L"Obtainable randomly while mining in Ter-Mur or as loot of the Ore Elementals spawned with the Gargoyle Pickaxe.",
[5201] = L"It can be purchased from NPC Tailor.",
[5202] = L"It can be purchased from NPC Tailor or Weaver.",
[5203] = L"Obtainable by killing Krakens or Leviathans.",
[5204] = L"Obtainable by using whool or cotton on a Spinning Wheel. It can also be purchased from NPC Tailor or Weaver.",
[5205] = L"Obtainable by Paragon creatures. It can also be gathered from the Sugar Canes.",
[5206] = L"Obtainable by cutting a decorative plant with the Clippers.\nNOTE: the Clippers must be set to cut plants!",
[5207] = L"It can be purchased from NPC Mage or Necromancer.",
[5208] = L"Obtainable as loot of the creatures in Doom and Void creatures in Ter-Mur.",
[5209] = L"It can be purchased from NPC Beekeper.",
[5210] = L"Obtainable while mining on sand.",
[5211] = L"Obtainable randomly as loot of Peerless monsters.",
[5213] = L"Obtainable from grapevines or purchased NPC Innkeeper and Farmer. It can also be created with the Create Food spell.",
[5214] = L"It can be gathered from Cocoa Tree.",
[5215] = L"It can be purchased NPC Innkeeper.",
[5216] = L"Obtainable by cutting a lava fish with a knife.",
[5217] = L"It can be gathered inside the Solen Hive or as loot of the Solens.",
[5218] = L"Obtainable by killing Chief Paroxysmus.",
[5219] = L"Obtainable by killing the Dread Horn.",
[5220] = L"Obtainable by killing Lady Melisande.",
[5221] = L"Obtainable by killing the Monsterous Interred Grizzle.",
[5222] = L"It can be purchased from NPC Farmer or it can be obtained as loot by killing Yamandon in Tokuno.",
[5223] = L"Obtainable by cutting an autumn dragonfish with a knife.",
[5224] = L"Obtainable by killing Silver Serpents in the Tomb of the Kings in Ter-Mur. It can also be farmed from living Silver Serpents using Empty Venom Vials and a Snake Charmer Flute.",
[5225] = L"Obtainable by killing Savages.",
[5226] = L"Obtainable by purchasing a Bowl of Peas/Carrots/Corn/Lettuce from an NPC Innkeeper, Cook, Waiter, Barkeeper or Tavernkeeper and eating the contents.",
[5227] = L"Obtainable by killing Rotworm and cutting the corpses.",
[5228] = L"It can be purchased from NPC Butcher or it can be created with the Create Food spell.",
[5229] = L"It can be purchased from NPC Innkeeper, Cook, Waiter, Barkeeper or Tavernkeeper.",
[5230] = L"Obtainable from a peach tree or purchased NPC Innkeeper and Farmer. It can also be created with the Create Food spell.",
[5231] = L"Obtainable as special reward by killing Paragon creatures.",
[5232] = L"It can be purchased from NPC Provisioneer, Barkeeper, Tavernkeeper and Waiter.",
[5233] = L"It can be stolen from the Pestilence Champion Spawn in Bedlam.",
[5234] = L"It can be found as loot on Pixies, Fairy Dragons and Wisps in the Abyss.",
[5235] = L"Obtainable by killing the Travesty.",
[5236] = L"Obtainable by skinning Medusa while she's alive.",
[5237] = L"Obtainable by milking cows or purchased from NPC Innkeeper and Farmer.",

-- ITEM DESCRIPTION
[10000] = {
	-- REAGENTS
	-- L"Garlic"
	[wstring.lower(GetStringFromTid(1023972))] = L"Magic Reagent",
	-- L"Black Pearl"
	[wstring.lower(GetStringFromTid(1023962))] = L"Magic Reagent",
	-- L"Blood Moss"
	[wstring.lower(GetStringFromTid(1023963))] = L"Magic Reagent",
	-- L"Mandrake Root"
	[wstring.lower(GetStringFromTid(1023974))] = L"Magic Reagent",
	-- L"Nightshade"
	[wstring.lower(GetStringFromTid(1023976))] = L"Magic Reagent",
	-- L"Spiders' Silk"
	[wstring.lower(GetStringFromTid(1023981))] = L"Magic Reagent",
	-- L"Sulfurous Ash"
	[wstring.lower(GetStringFromTid(1023980))] = L"Magic Reagent",
	-- L"Ginseng"
	[wstring.lower(GetStringFromTid(1023973))] = L"Magic Reagent",
	-- L"Bone"
	[wstring.lower(GetStringFromTid(1023966))] = L"Magic Reagent\nTailoring Material",
	-- L"Daemon Bone"
	[wstring.lower(GetStringFromTid(1023968))] = L"Magic Reagent\nDoom Quest Item",
	-- L"Dragon's Blood"
	[wstring.lower(GetStringFromTid(1023970))] = L"Magic Reagent",
	-- L"Fertile Dirt"
	[wstring.lower(GetStringFromTid(1023969))] = L"Magic Reagent\nMay randomly lead to accelerated plant growth (20 per bowl)",
	-- L"Pig Iron"
	[wstring.lower(GetStringFromTid(1023978))] = L"Necrotic Reagent",
	-- L"Batwing"
	[wstring.lower(GetStringFromTid(1023960))] = L"Necrotic Reagent",
	-- L"Daemon Blood"
	[wstring.lower(GetStringFromTid(1023965))] = L"Necrotic Reagent",
	-- L"Nox Crystal"
	[wstring.lower(GetStringFromTid(1023982))] = L"Necrotic Reagent",
	-- L"Grave Dust"
	[wstring.lower(GetStringFromTid(1023983))] = L"Necrotic Reagent",

	-- IMBUING REAGENTS
	-- L"Abyssal Cloth"
	[wstring.lower(GetStringFromTid(1113350))] = L"Imbuing Ingredient\nRequired for: Mage Armor property.\nObtained from: Cavern of the Discarded creatures (Abyss) or crafted by tailoring skill.",
	-- L"Arcanic Rune Stone"
	[wstring.lower(GetStringFromTid(1113352))] = L"Imbuing Ingredient\nRequired for: Mage Weapon property.\nObtained from: Cavern of the Discarded creatures (Abyss) or crafted by tinkering skill.",
	-- L"Bottle Of Ichor"
	[wstring.lower(GetStringFromTid(1113361))] =  L"Imbuing Ingredient\nRequired for: Night Sight property.\nObtained from: Wolf Spider and Sentinel Spider (Underworld), Trapdoor Spiders (overland Ter Mur) or crafted by alchemy skill.",
	-- L"Boura Pelt"
	[wstring.lower(GetStringFromTid(1113355))] =  L"Imbuing Ingredient\nRequired for: Cold Resist, Energy Resist, Fire Resist, Physical Resist, and Poison Resist properties.\nObtained from: Boura (overland Ter Mur).",
	-- L"Chaga Mushroom"
	[wstring.lower(GetStringFromTid(1113356))] =  L"Imbuing Ingredient\nRequired for: Luck property.\nObtained from: Tomb of Kings and tunnels leading to Abyssal Infernal and Primeval Lich champ spawn areas (Abyss).",
	-- L"Crushed Glass"
	[wstring.lower(GetStringFromTid(1113351))] =  L"Imbuing Ingredient\nRequired for: Enhance Potions property.\nObtained from: Cavern of the Discarded creatures (Abyss) or crafted by blacksmith skill.",
	-- L"Crystal Shards"
	[wstring.lower(GetStringFromTid(1113347))] =  L"Imbuing Ingredient\nRequired for: Damage Increase and Spell Damage Increase properties.\nObtained from: Cavern of the Discarded creatures (Abyss) or can also drop in backpack while lumberjacking in Ter Mur.",
	-- L"Crystalline Blackrock"
	[wstring.lower(GetStringFromTid(1113344))] =  L"Imbuing Ingredient\nRequired for: Skill bonus property.\nObtained from: Cavern of the Discarded creatures (Abyss) or crafted by can also drop in backpack while mining in Ter Mur. You can also find these as loot on the corpses of ore elementals.",
	-- L"Daemon Claw"
	[wstring.lower(GetStringFromTid(1113330))] =  L"Imbuing Ingredient\nRequired for: Demon slayer property.\nObtained from: any Fire Daemon in the Abyss or found in overland Ter Mur (west corner).",
	-- L"Delicate Scales"
	[wstring.lower(GetStringFromTid(1113349))] =  L"Imbuing Ingredient\nRequired for: Use Best Weapon Skill property.\nObtained from: Cavern of the Discarded creatures (Abyss) or can also drop in backpack while fishing in any facet.",
	-- L"Elven Fletching"
	[wstring.lower(GetStringFromTid(1113346))] =  L"Imbuing Ingredient\nRequired for: Lower Requirements property.\nObtained from: Cavern of the Discarded creatures (Abyss) or crafted by fletching skill.",
	-- L"Essence Of Achievement"
	[wstring.lower(GetStringFromTid(1113325))]  = L"Imbuing Ingredient\nRequired for: Faster Casting property.\nObtained from: Creatures in the Abyssal Lair Entrance mini-champ spawn in the Abyss.",
	-- L"Essence Of Balance"
	[wstring.lower(GetStringFromTid(1113324))]  = L"Imbuing Ingredient\nRequired for: Balanced property on bows.\nObtained from: Cavern of the Discarded creatures (Abyss) or void creatures (overland Ter Mur).",
	-- L"Essence Of Control"
	[wstring.lower(GetStringFromTid(1113340))]  = L"Imbuing Ingredient\nRequired for: Swing Speed Increase property.\nObtained from: Creatures in the Enslaved Goblins mini-champ spawn in the Abyss.",
	-- L"Essence Of Diligence"
	[wstring.lower(GetStringFromTid(1113338))]  = L"Imbuing Ingredient\nRequired for: Faster Cast Recovery property.\nObtained from: Creatures in the Stygian Dragon Lair Entrance mini-champ spawn in the Abyss.",
	-- L"Essence Of Direction"
	[wstring.lower(GetStringFromTid(1113328))]  = L"Imbuing Ingredient\nRequired for: Velocity property on bows.\nObtained from: Creatures in the Lands of the Lich mini-champ spawn in the Abyss.",
	-- L"Essence Of Feeling"
	[wstring.lower(GetStringFromTid(1113339))]  = L"Imbuing Ingredient\nRequired for: Hit Magic Arrow property.\nObtained from: Creatures in the Secret Garden mini-champ spawn in the Abyss.",
	-- L"Essence Of Order"
	[wstring.lower(GetStringFromTid(1113342))]  = L"Imbuing Ingredient\nRequired for: Lower Mana Cost property.\nObtained from: Creatures in the Fire Temple Ruins mini-champ spawn in the Abyss.",
	-- L"Essence Of Passion"
	[wstring.lower(GetStringFromTid(1113326))]  = L"Imbuing Ingredient\nRequired for: Hit Lightning property.\nObtained from: Creatures in the Lava Caldera mini-champ area in the Abyss.",
	-- L"Essence Of Persistence"
	[wstring.lower(GetStringFromTid(1113343))]  = L"Imbuing Ingredient\nRequired for: It has no known use at this time.\nObtained from: Skeletal Dragon mini-champ spawn in the Abyss.",
	-- L"Essence Of Precision"
	[wstring.lower(GetStringFromTid(1113327))]  = L"Imbuing Ingredient\nRequired for: Hit Chance Increase property.\nObtained from: Creatures in the Crimson Veins mini-champ spawn in the Abyss.",
	-- L"Essence Of Singularity"
	[wstring.lower(GetStringFromTid(1113341))]  = L"Imbuing Ingredient\nRequired for: Defense Chance Increase property.\nObtained from: Creatures in the Passage of Tears mini-champ spawn in the Abyss.",
	-- L"Faery Dust"
	[wstring.lower(GetStringFromTid(1113358))]  = L"Imbuing Ingredient\nRequired for: Lower Reagent Cost property.\nObtained from: Fairy Dragon, Pixies, Wisps and Dark Wisps (Abyss).",
	-- L"Goblin Blood"
	[wstring.lower(GetStringFromTid(1113335))]  = L"Imbuing Ingredient\nRequired for: Repond slayer property.\nObtained from: all kind of Goblins in Underworld and Abyss.",
	-- L"Lava Serpent Crust"
	[wstring.lower(GetStringFromTid(1113336))]  = L"Imbuing Ingredient\nRequired for: Reptile slayer property.\nObtained from: Lava Elementals (Abyss and west corner of overland Ter Mur).",
	-- L"Luminescent Fungi"
	[wstring.lower(GetStringFromTid(1073475))]  = L"Imbuing Ingredient\nRequired for: Hit Point Increase, Mana Increase, and Stamina Increase properties.\nObtained from: can drop in backpack while lumberjacking in Ter Mur.",
	-- L"Parasitic Plant"
	[wstring.lower(GetStringFromTid(1073474))]  = L"Imbuing Ingredient\nRequired for: Hit Harm, Hit Lower Attack and Hit Lower Defense properties.\nObtained from: can drop in backpack while lumberjacking in Ter Mur.",
	-- L"Powdered Iron"
	[wstring.lower(GetStringFromTid(1113353))]  = L"Imbuing Ingredient\nRequired for: Durability property on shields.\nObtained from: Cavern of the Discarded creatures (Abyss) or crafted by blacksmith skill.",
	-- L"Raptor Teeth"
	[wstring.lower(GetStringFromTid(1113360))]  = L"Imbuing Ingredient\nRequired for: Hit Cold Area, Hit Energy Area, Hit Fire Area, Hit Physical Area, and Hit Poison Area properties.\nObtained from: Raptors (overland Ter Mur).",
	-- L"Reflective Wolf Eye"
	[wstring.lower(GetStringFromTid(1113362))]  = L"Imbuing Ingredient\nRequired for: Reflect Physical Damage property.\nObtained from: Clan Scratch Savage Wolf (Abyss).",
	-- L"Seed Of Renewal"
	[wstring.lower(GetStringFromTid(1113345))]  = L"Imbuing Ingredient\nRequired for: Hit Point Regeneration, Mana Regeneration and Stamina Regeneration properties.\nObtained from: Cavern of the Discarded creatures (Abyss) or randomly as a gathered resource when collecting seeds from plants.",
	-- L"Silver Snake Skin"
	[wstring.lower(GetStringFromTid(1113357))]  = L"Imbuing Ingredient\nRequired for: Spell Channeling property.\nObtained from: Silver Serpents in the Tomb of Kings.",
	-- L"Slith Tongue"
	[wstring.lower(GetStringFromTid(1113359))]  = L"Imbuing Ingredient\nRequired for: Hit Dispel property.\nObtained from: Slith (overland Ter Mur).",
	-- L"Spider Carapace"
	[wstring.lower(GetStringFromTid(1113329))]  = L"Imbuing Ingredient\nRequired for: Arachnid Slayer property.\nObtained from: Navrey Night-Eyes (Underworld) and Trapdoor Spiders (overland Ter Mur).",
	-- L"Undying Flesh"
	[wstring.lower(GetStringFromTid(1113337))]  = L"Imbuing Ingredient\nRequired for: Undead Slayer property.\nObtained from: Undead Guardians and Nipporailem (Tomb of Kings); Undead Guardians in Medusa's Lair (Abyss).",
	-- L"Vial Of Vitriol"
	[wstring.lower(GetStringFromTid(1113331))]  = L"Imbuing Ingredient\nRequired for: Elemental Slayer property.\nObtained from: Acid Slugs (Underworld), Acid Slugs (Passage of Tears mini-champ spawn in the Abyss) or crafted by alchemy skill.",
	-- L"Void Orb"
	[wstring.lower(GetStringFromTid(1113354))]  = L"Imbuing Ingredient\nRequired for: Hit Life Leech, Hit Mana Leech and Hit Stamina Leech properties.\nObtained from: Void creatures (overland Ter Mur) or crafted by tinkering skill.",

	-- L"Fire Ruby"
	[wstring.lower(GetStringFromTid(1026254))] = L"Used as ingredient  to craft certain items.\nUsed by imbuing for Hit Fireball and Strength Bonus properties.",
	-- L"Turquoise"
	[wstring.lower(GetStringFromTid(1026250))] = L"Used as ingredient  to craft certain items.\nUsed by imbuing for Intelligence Bonus property.",
	-- L"White Pearl"
	[wstring.lower(GetStringFromTid(1026253))] = L"Used as ingredient  to craft certain items.\nUsed by imbuing for lesser slayers property.",
	-- L"Blue Diamond"
	[wstring.lower(GetStringFromTid(1026255))] = L"Used as ingredientto craft certain items.",
	-- L"Ecru Citrine"
	[wstring.lower(GetStringFromTid(1026252))] = L"Used as ingredient to craft certain items.",
	-- L"Perfect Emerald"
	[wstring.lower(GetStringFromTid(1026251))] = L"Used as ingredient to craft certain items.",
	-- L"Dark Sapphire"
	[wstring.lower(GetStringFromTid(1026249))] = L"Used as ingredient to craft certain items.",
	-- L"Brilliant Amber"
	[wstring.lower(GetStringFromTid(1026256))] = L"Used as ingredient to craft certain items.",

	-- PEERLESS KEYS
	-- L"Irk's Brain"
	[wstring.lower(GetStringFromTid(1074335))] = L"Dread Horn peerless key.",
	-- L"Gnaw's Fang"
	[wstring.lower(GetStringFromTid(1074332))] = L"Dread Horn peerless key.",
	-- L"Lissith's Silk"
	[wstring.lower(GetStringFromTid(1074333))] = L"Dread Horn peerless key.",
	-- L"Sabrix's Eye"
	[wstring.lower(GetStringFromTid(1074336))] = L"Dread Horn peerless key.",
	-- L"Blighted Cotton"
	[wstring.lower(GetStringFromTid(1074331))] = L"Dread Horn peerless key.",
	-- L"Thorny Briar"
	[wstring.lower(GetStringFromTid(1074334))] = L"Dread Horn peerless key.",

	-- L"Partially Digested Torso"
	[wstring.lower(GetStringFromTid(1074326))] = L"Chief Paroxysmus peerless key.",
	-- L"Gelatanous Skull"
	[wstring.lower(GetStringFromTid(1074328))] = L"Chief Paroxysmus peerless key.",
	-- L"Coagulated Legs"
	[wstring.lower(GetStringFromTid(1074327))] = L"Chief Paroxysmus peerless key.",
	-- L"Putrifier Spleen"
	[wstring.lower(GetStringFromTid(1074329))] = L"Chief Paroxysmus peerless key.",

	-- L"Disintegrating Thesis Note"
	[wstring.lower(GetStringFromTid(1074440))] = L"Monstrous Interred Grizzle peerless key.",

	-- L"Scattered Crystals"
	[wstring.lower(GetStringFromTid(1074264))] = L"Shimmering Effusion peerless key.\nUsed by alchemists to make crystal dust.",
	-- L"Shattered Crystal"
	[wstring.lower(GetStringFromTid(1074266))] = L"Shimmering Effusion peerless key.\nUsed by alchemists to make crystal dust.",
	-- L"Crushed Crystals"
	[wstring.lower(GetStringFromTid(1074262))] = L"Shimmering Effusion peerless key.\nUsed by alchemists to make crystal dust.",
	-- L"Jagged Crystal"
	[wstring.lower(GetStringFromTid(1074265))] = L"Shimmering Effusion peerless key.\nUsed by alchemists to make crystal dust.",
	-- L"Crystal Pieces"
	[wstring.lower(GetStringFromTid(1074263))] = L"Shimmering Effusion peerless key.\nUsed by alchemists to make crystal dust.",
	-- L"Broken Crystals"
	[wstring.lower(GetStringFromTid(1074261))] = L"Shimmering Effusion peerless key.\nUsed by alchemists to make crystal dust.",

	-- L"Draconic Orb (Lesser)"
	[wstring.lower(GetStringFromTid(1113515))] = L"Stygian Dragon peerless key.",

	-- L"A Rare Serpent Egg"
	[wstring.lower(GetStringFromTid(1112575))] = L"Medusa peerless key.",

	-- L"Tiger Claw Key"
	[wstring.lower(GetStringFromTid(1074342))] = L"Travesty peerless key.",
	-- L"Serpent Fang Key"
	[wstring.lower(GetStringFromTid(1074341))] = L"Travesty peerless key.",
	-- L"Dragon Flame Key"
	[wstring.lower(GetStringFromTid(1074343))] = L"Travesty peerless key.",


	-- L"Robe of Rite"
	[wstring.lower(GetStringFromTid(1153510))] = L"Exodus peerless key.",
	-- L"Exodus Summoning Rite"
	[wstring.lower(GetStringFromTid(1153498))] = L"Exodus peerless key.",
	-- L"Exodus Summoning Altar"
	[wstring.lower(GetStringFromTid(1153502))] = L"Exodus peerless key.",
	-- L"Exodus Sacrificial dagger"
	[wstring.lower(GetStringFromTid(1153500))] = L"Exodus peerless key.",

	-- QUEST ITEMS
	-- L"Acid Sac"
	[wstring.lower(GetStringFromTid(1111654))] = L"Used to destroy magical vines.",
	-- L"Ancient Pottery Fragments" 
	[wstring.lower(GetStringFromTid(1112990))] = L"Used in Axem's 'A Broken Vase' quest or to make crystal dust with alchemy.",
	-- L"Tattered Remnants of an Ancient Scroll"
	[wstring.lower(GetStringFromTid(1112991))] = L"Used in Axem's 'Putting the Pieces Together' quest.",
	-- L"Untranslated Ancient Tome"
	[wstring.lower(GetStringFromTid(1112992))] = L"Used in Axem's 'Ye Olde Gargish' quest.",
	-- L"Boura Skin"
	[wstring.lower(GetStringFromTid(1112900))] = L"Used in Thepem's 'Tasty Treats' quest and Zosilem's 'Dabbling on The Dark Side' quest.",
	-- L"Congealed Slug Acid"
	[wstring.lower(GetStringFromTid(1112901))] = L"Used in Thepem's 'All That Glitters' quest.",
	-- L"Seared Fire Ant Goo"
	[wstring.lower(GetStringFromTid(1112902))] = L"Used in Thepem's 'Pink is the New Black' quest.",
	-- L"Fairy Dragon Wing"
	[wstring.lower(GetStringFromTid(1112899))] = L"Used in Zosilem's 'Dabbling on the Dark Side' quest.",
	-- L"Infused Glass Stave"
	[wstring.lower(GetStringFromTid(1112909))] = L"Used in Zosilem's Tier 3 'Pure Valorite' quest.",
	-- L"Leather Wolf Skin"
	[wstring.lower(GetStringFromTid(1112906))] = L"Used in Zosilem's Tier 2 'Armor Up' quest.",
	-- L"Treefellow Wood"
	[wstring.lower(GetStringFromTid(1112908))] = L"Used in Zosilem's Tier 3 'The Forbidden Fruit' quest.",
	-- L"Undamaged Iron Beetle Scale"
	[wstring.lower(GetStringFromTid(1112905))] = L"Used in Thepem's 'Metal Head' and Zosilem's 'Armor Up' quests.",
	-- L"Undamaged Undead Gargoyle Horns"
	[wstring.lower(GetStringFromTid(1112903))] = L"Used in Zosilem's 'The Brainy Alchemist' quest.",
	-- L"Undead Gargoyle Medallions"
	[wstring.lower(GetStringFromTid(1112907))] = L"Used in Zosilem's 'Green with Envy' quest.",
	-- L"Zoogi Fungus"
	[wstring.lower(GetStringFromTid(1029911))] = L"Used in solen's quests to obtain the Translocation Powder.",

	-- MATERIALS
	-- L"Medusa Blood"
	[wstring.lower(GetStringFromTid(1031702))] = L"Used by alchemists to make Elixer of Rebirth.",
	-- L"Shimmering Crystals"
	[wstring.lower(GetStringFromTid(1075095))] = L"Used by alchemists to make Crystal Granules.",
	-- L"Silver Serpent Venom"
	[wstring.lower(GetStringFromTid(1112173))] = L"Used by alchemists and cooks to make Color Fixative.",
	-- L"Toxic Venom Sac"
	[wstring.lower(GetStringFromTid(1112291))] = L"Used by alchemists to make softened reeds from plant clippings.",
	-- L"Void Essence"
	[wstring.lower(GetStringFromTid(1112327))] = L"Used by tinkers to make Clockwork Scorpions, Leather Wolves, and Vollems. Also used by alchemists to craft soulstone fragments.",
	-- L"Crystalline Fragments"
	[wstring.lower(GetStringFromTid(1073054))] = L"Used by alchemists to make crystal dust.",
	-- L"Translocation Powder"
	[wstring.lower(GetStringFromTid(1029912))] = L"Used to recharge Bag of Sending, Bracelet of Binding and Crystal Ball of pet summoning.",

	-- Spined Leather
	[wstring.lower(GetStringFromTid(1049354))] = L"BONUS:\n- Physical Resist +9\n- Luck +40\n\nTailoring Required: 65",
	-- Horned Leather
	[wstring.lower(GetStringFromTid(1049355))] = L"BONUS:\n- Physical Resist +2\n- Fire Resist +4\n- Cold Resist +3\n- Poison Resist +3\n- Energy Resist +3\n\nTailoring Required: 80",
	-- Barbed Leather
	[wstring.lower(GetStringFromTid(1049356))] = L"BONUS:\n- Physical Resist +3\n- Fire Resist +2\n- Cold Resist +3\n- Poison Resist +3\n- Energy Resist +5\n\nTailoring Required: 99",

	-- Dull Copper
	[wstring.lower(GetStringFromTid(1053108))] = L"ARMOR BONUS:\n- Physical Resist +10\n- Durability +50\n- Lower Requirements 20%\n\nWEAPON BONUS:\n- Lower Requirements 50%\n- Durability +100\n\nBlacksmith/Tinkering Required: 65",
	-- Shadow Iron
	[wstring.lower(GetStringFromTid(1053107))] = L"ARMOR BONUS:\n- Physical Resist +3\n- Fire Resist +2\n- Energy Resist +7\n- Durability +100\n\nWEAPON BONUS:\n- Cold Damage 20%\n- Durability +50\n\nBlacksmith/Tinkering Required: 70",
	-- Copper
	[wstring.lower(GetStringFromTid(1053106))] = L"ARMOR BONUS:\n- Physical Resist +2\n- Fire Resist +2\n- Poison Resist +7\n- Energy Resist +2\n\nWEAPON BONUS:\n- Poison Damage 10%\n- Energy Damage 20%\n\nBlacksmith/Tinkering Required: 75",
	-- Bronze
	[wstring.lower(GetStringFromTid(1053105))] = L"ARMOR BONUS:\n- Physical Resist +3\n- Cold Resist +7\n- Poison Resist +2\n- Energy Resist +2\n\nWEAPON BONUS:\n- Fire Damage 40%\n\nBlacksmith/Tinkering Required: 80",
	-- Golden
	[wstring.lower(GetStringFromTid(1053104))] = L"ARMOR BONUS:\n- Physical Resist +2\n- Fire Resist +2\n- Cold Resist +3\n- Energy Resist +3\n- Luck +40\n\nWEAPON BONUS:\n- Luck +40\n- Lower Requirements 50%\n\nBlacksmith/Tinkering Required: 85",
	-- Agapite
	[wstring.lower(GetStringFromTid(1053103))] = L"ARMOR BONUS:\n- Physical Resist +2\n- Fire Resist +7\n- Cold Resist +2\n- Poison Resist +2\n- Energy Resist +2\n\nWEAPON BONUS:\n- Cold Damage 30%\n- Energy Damage 30%\n\nBlacksmith/Tinkering Required: 90",
	-- Verite
	[wstring.lower(GetStringFromTid(1053102))] = L"ARMOR BONUS:\n- Physical Resist +4\n- Fire Resist +4\n- Cold Resist +3\n- Poison Resist +4\n- Energy Resist +1\n\nWEAPON BONUS:\n- Poison Damage 40%\n- Energy Damage 20%\n\nBlacksmith/Tinkering Required: 95",
	-- Valorite
	[wstring.lower(GetStringFromTid(1053101))] = L"ARMOR BONUS:\n- Physical Resist +5\n- Cold Resist +4\n- Poison Resist +4\n- Energy Resist +4\n- Durability +50\n\nWEAPON BONUS:\n- Fire Damage 10%\n- Cold Damage 20%\n- Poison Damage 10%\n- Energy Damage 20%\n\nBlacksmith/Tinkering Required: 99",

	-- Red Scales
	[wstring.lower(GetStringFromTid(1053129))] = L"BONUS:\n- Physical Resist +1\n- Fire Resist +11\n- Cold Resist -3\n- Poison Resist +1\n- Energy Resist +1",
	-- Yellow Scales
	[wstring.lower(GetStringFromTid(1053130))] = L"BONUS:\n- Physical Resist -3\n- Fire Resist +1\n- Cold Resist +1\n- Poison Resist +1\n- Energy Resist +1",
	-- Black Scales
	[wstring.lower(GetStringFromTid(1053131))] = L"BONUS:\n- Physical Resist +11\n- Fire Resist +1\n- Cold Resist +1\n- Poison Resist +1\n- Energy Resist -3",
	-- Green Scales
	[wstring.lower(GetStringFromTid(1053132))] = L"BONUS:\n- Physical Resist +1\n- Fire Resist -3\n- Cold Resist +1\n- Poison Resist +11\n- Energy Resist +1",
	-- White Scales
	[wstring.lower(GetStringFromTid(1053133))] = L"BONUS:\n- Physical Resist -3\n- Fire Resist +1\n- Cold Resist +11\n- Poison Resist +1\n- Energy Resist +1",
	-- Blue Scales
	[wstring.lower(GetStringFromTid(1053134))] = L"BONUS:\n- Physical Resist +1\n- Fire Resist +1\n- Cold Resist +1\n- Energy Resist +11",
	-- Sea Serpent Scales
	[wstring.lower(GetStringFromTid(1053113))] = L"BONUS:\n- Physical Resist +1\n- Fire Resist +1\n- Cold Resist +1\n- Energy Resist +11",

	-- Oak
	[wstring.lower(GetStringFromTid(1072533))] = L"ARMOR BONUS:\n- Physical Resist +3\n- Fire Resist +3\n- Poison Resist +2\n- Energy Resist +3\n- Luck +40\n\nSHIELD BONUS:\n- Physical Resist +1\n- Fire Resist +1\n- Cold Resist +1\n- Poison Resist +1\n- Energy Resist +1\n\nWEAPON BONUS:\n- Damage Increase 5%\n- Luck +40\n\nCarpentry/Fletching Required: 65",
	-- Ash
	[wstring.lower(GetStringFromTid(1072534))] = L"ARMOR BONUS:\n- Physical Resist +4\n- Fire Resist +2\n- Cold Resist +4\n- Poison Resist +1\n- Energy Resist +6\n- Lower Requirements 20%\n\nSHIELD BONUS:\n- Energy Resist +3\n- Lower Requirements 20%\n\nWEAPON BONUS:\n- Swing Speed Increase 10%\n- Lower Requirements 20%\n\nCarpentry/Fletching Required: 80",
	-- Yew
	[wstring.lower(GetStringFromTid(1072535))] = L"ARMOR BONUS:\n- Physical Resist +6\n- Fire Resist +3\n- Cold Resist +3\n- Energy Resist +3\n- Hit Point Regeneration 1\n\nSHIELD BONUS:\n- Physical Resist +3\n- Hit Point Regeneration 1\n\nWEAPON BONUS:\n- Hit Chance Increase 5%\n- Damage Increase 10%\n\nCarpentry/Fletching Required: 95",
	-- Heartwood
	[wstring.lower(GetStringFromTid(1072538))] = L"ARMOR BONUS:\n- Physical Resist +3\n- Fire Resist +8\n- Cold Resist +1\n- Poison Resist +3\n- Energy Resist +3\n- Hit Point Regeneration 2\n\nSHIELD BONUS:\n- Fire Resist +3\n- Hit Point Regeneration 2\n- Luck +40\n\nWEAPON BONUS:\n- Hit Point Regeneration 2\n- Hit Life Leech 16% (DO NOT STACK WITH IMBUED VALUES!!!)\n\nCarpentry/Fletching Required: 100",
	-- Bloodwood
	[wstring.lower(GetStringFromTid(1072536))] = L"ARMOR BONUS:\n- Physical Resist +2\n- Fire Resist +3\n- Cold Resist +2\n- Poison Resist +7\n- Energy Resist +2\n(RANDOM EFFECT)\n- Luck +40\n- Durability +50%\n- Lower Requirements 20%\n- Damage Increase 10%\n- Hit Chance Increase 5%\n- Mage Armor\n- Lower Weight 50%\n\nSHIELD BONUS:\n(RANDOM EFFECT)\n- Dexterity Bonus 2\n- Strength Bonus 2\n- Physical Resist +5\n- Cold Resist + 3\n- Reflect Physical Damage 5%\n- Self Repair 2\n- Spell Channeling\n\nWEAPON BONUS:\n(RANDOM EFFECT)\n- Luck +10\n- Luck +40\n- Durability +50%\n- Lower Requirements 20%\n- Swing Speed Increase 10%\n- Hit Chance Increase 5%\n- Hit Life Leech (random value)\n- Lower Weight 75%\n\nCarpentry/Fletching Required: 100",
	-- Frostwood
	[wstring.lower(GetStringFromTid(1072539))] = L"ARMOR BONUS:\n- Physical Resist +2\n- Fire Resist +1\n- Cold Resist +8\n- Poison Resist +3\n- Energy Resist +4\n\nSHIELD BONUS:\n- Cold Resist +3\n- Spell Channeling\n- Faster Casting -1\n\nWEAPON BONUS:\n- Damage Increase 12%\n- Cold Damage 40%\n\nCarpentry/Fletching Required: 100",

	-- USELESS
	-- L"Horn Of Abyssal Inferno"
	[wstring.lower(GetStringFromTid(1031703))] = L"Decorative.",
	-- L"Kepetch Wax"
	[wstring.lower(GetStringFromTid(1112412))] = L"Decorative.",
	-- L"Lodestone"
	[wstring.lower(GetStringFromTid(1113348))] = L"Decorative.",
	-- L"Primeval Lich Dust"
	[wstring.lower(GetStringFromTid(1031701))] = L"Decorative.",
	-- L"Stygian Dragon Head"
	[wstring.lower(GetStringFromTid(1031700))] = L"Decorative.",
	-- L"Vile Tentacles"
	[wstring.lower(GetStringFromTid(1113333))] = L"Decorative.",
	-- L"Void Core"
	[wstring.lower(GetStringFromTid(1031700))] = L"Decorative.",
	-- Claw of Slasher of Veils
	[wstring.lower(GetStringFromTid(1031704))] = L"Decorative.",

	-- MISC TOOLS
	-- L"Clippers"
	[wstring.lower(GetStringFromTid(1112117))] = L"Clippers are used in Staining and Basket Weaving to create Plant Clippings and Dry Reeds.",
	-- L"Scissors"
	[wstring.lower(GetStringFromTid(1011191))] = L"Use on hide to make leather.\nUse on clotings to make cut of cloth.\nUse on cut of cloth to make bandages.\nUse on leather items to make leather.\nUse on bone parts (except skulls) to make bones.\nDo not run with the scissors target in hand...",
	-- ancient hammer +10
	[wstring.lower(GetStringFromTid(1049028))] = L"Once equipped, your blacksmith skill will be raised by 10. The bonus is not limited by your skill cap.",
	-- ancient hammer +15
	[wstring.lower(GetStringFromTid(1049029))] = L"Once equipped, your blacksmith skill will be raised by 15. The bonus is not limited by your skill cap.",
	-- ancient hammer +30
	[wstring.lower(GetStringFromTid(1049030))] = L"Once equipped, your blacksmith skill will be raised by 30. The bonus is not limited by your skill cap.",
	-- ancient hammer +60
	[wstring.lower(GetStringFromTid(1049031))] = L"Once equipped, your blacksmith skill will be raised by 60. The bonus is not limited by your skill cap.",

	-- RUNICS
	-- L"Dull Copper Runic Hammer"
	[wstring.lower(GetStringFromTid(1049020))] = L"Blacksmith runic tool.\nMin Intensity: 40%\nMax Intensity: 100%\nMin Properties: 1\nMax Properties: 2\nMax Charges: 50",
	-- L"Shadow Runic Hammer"
	[wstring.lower(GetStringFromTid(1049021))] = L"Blacksmith runic tool.\nMin Intensity: 45%\nMax Intensity: 100%\nMin Properties: 2\nMax Properties: 2\nMax Charges: 45",
	-- L"Copper Runic Hammer"
	[wstring.lower(GetStringFromTid(1049022))] = L"Blacksmith runic tool.\nMin Intensity: 50%\nMax Intensity: 100%\nMin Properties: 2\nMax Properties: 3\nMax Charges: 40",
	-- L"Bronze Runic Hammer"
	[wstring.lower(GetStringFromTid(1049023))] = L"Blacksmith runic tool.\nMin Intensity: 55%\nMax Intensity: 100%\nMin Properties: 3\nMax Properties: 3\nMax Charges: 35",
	-- L"Golden Runic Hammer"
	[wstring.lower(GetStringFromTid(1049024))] = L"Blacksmith runic tool.\nMin Intensity: 60%\nMax Intensity: 100%\nMin Properties: 3\nMax Properties: 4\nMax Charges: 30",
	-- L"Agapite Runic Hammer"
	[wstring.lower(GetStringFromTid(1049025))] = L"Blacksmith runic tool.\nMin Intensity: 65%\nMax Intensity: 100%\nMin Properties: 4\nMax Properties: 4\nMax Charges: 25",
	-- L"Verite Runic Hammer"
	[wstring.lower(GetStringFromTid(1049026))] = L"Blacksmith runic tool.\nMin Intensity: 70%\nMax Intensity: 100%\nMin Properties: 4\nMax Properties: 5\nMax Charges: 20",
	-- L"Valorite Runic Hammer"
	[wstring.lower(GetStringFromTid(1049027))] = L"Blacksmith runic tool.\nMin Intensity: 85%\nMax Intensity: 100%\nMin Properties: 5\nMax Properties: 5\nMax Charges: 15",

	-- L"Spined Runic Sewing Kit"
	[wstring.lower(wstring.gsub(GetStringFromTid(1061119), L"~1_LEATHER_TYPE~" , GetStringFromTid(1061118)))] = L"Tailoring runic tool.\nMin Intensity: 40%\nMax Intensity: 100%\nMin Properties: 1\nMax Properties: 3\nMax Charges: 45",
	-- L"Horned Runic Sewing Kit"
	[wstring.lower(wstring.gsub(GetStringFromTid(1061119), L"~1_LEATHER_TYPE~" , GetStringFromTid(1061117)))] = L"Tailoring runic tool.\nMin Intensity: 45%\nMax Intensity: 100%\nMin Properties: 3\nMax Properties: 4\nMax Charges: 30",
	-- L"Barbed Runic Sewing Kit"
	[wstring.lower(wstring.gsub(GetStringFromTid(1061119), L"~1_LEATHER_TYPE~" , GetStringFromTid(1061116)))] = L"Tailoring runic tool.\nMin Intensity: 50%\nMax Intensity: 100%\nMin Properties: 4\nMax Properties: 5\nMax Charges: 15",

	-- L"Oak Runic Fletcher's Tools"
	[wstring.lower(GetStringFromTid(1072628))] = L"Bowcraft runic tool.\nMin Intensity: 1%\nMax Intensity: 50%\nMin Properties: 1\nMax Properties: 2\nMax Charges: 45",
	-- L"Ash Runic Fletcher's Tools"
	[wstring.lower(GetStringFromTid(1072629))] = L"Bowcraft runic tool.\nMin Intensity: 35%\nMax Intensity: 75%\nMin Properties: 2\nMax Properties: 3\nMax Charges: 35",
	-- L"Yew Runic Fletcher's Tools"
	[wstring.lower(GetStringFromTid(1072630))] = L"Bowcraft runic tool.\nMin Intensity: 40%\nMax Intensity: 90%\nMin Properties: 3\nMax Properties: 3\nMax Charges: 25",
	-- L"Heartwood Runic Fletcher's Tools"
	[wstring.lower(GetStringFromTid(1072631))] = L"Bowcraft runic tool.\nMin Intensity: 50%\nMax Intensity: 100%\nMin Properties: 4\nMax Properties: 4\nMax Charges: 15",

	-- L"Oak Runic Dovetail Saw"
	[wstring.lower(GetStringFromTid(1072634))] = L"Carpentry runic tool.\nMin Intensity: 1%\nMax Intensity: 50%\nMin Properties: 1\nMax Properties: 2\nMax Charges: 45",
	-- L"Ash Runic Dovetail Saw"
	[wstring.lower(GetStringFromTid(1072635))] = L"Carpentry runic tool.\nMin Intensity: 35%\nMax Intensity: 75%\nMin Properties: 2\nMax Properties: 3\nMax Charges: 35",
	-- L"Yew Runic Dovetail Saw"
	[wstring.lower(GetStringFromTid(1072636))] = L"Carpentry runic tool.\nMin Intensity: 40%\nMax Intensity: 90%\nMin Properties: 3\nMax Properties: 3\nMax Charges: 25",
	-- L"Heartwood Runic Dovetail Saw"
	[wstring.lower(GetStringFromTid(1072637))] = L"Carpentry runic tool.\nMin Intensity: 50%\nMax Intensity: 100%\nMin Properties: 4\nMax Properties: 4\nMax Charges: 15",

	-- L"Dull Copper Runic Mallet and Chisel"
	[wstring.lower(GetStringFromTid(1111796))] = L"Masonry runic tool.\nMin Intensity: 40%\nMax Intensity: 100%\nMin Properties: 1\nMax Properties: 2\nMax Charges: 10",
	-- L"Shadow Runic Mallet and Chisel"
	[wstring.lower(GetStringFromTid(1111797))] = L"Masonry runic tool.\nMin Intensity: 45%\nMax Intensity: 100%\nMin Properties: 2\nMax Properties: 2\nMax Charges: 10",
	-- L"Copper Runic Mallet and Chisel"
	[wstring.lower(GetStringFromTid(1111798))] = L"Masonry runic tool.\nMin Intensity: 50%\nMax Intensity: 100%\nMin Properties: 2\nMax Properties: 3\nMax Charges: 10",
	-- L"Bronze Runic Mallet and Chisel"
	[wstring.lower(GetStringFromTid(1111799))] = L"Masonry runic tool.\nMin Intensity: 55%\nMax Intensity: 100%\nMin Properties: 3\nMax Properties: 3\nMax Charges: 10",
	-- L"Golden Runic Mallet and Chisel"
	[wstring.lower(GetStringFromTid(1111800))] = L"Masonry runic tool.\nMin Intensity: 60%\nMax Intensity: 100%\nMin Properties: 3\nMax Properties: 4\nMax Charges: 10",
	-- L"Agapite Runic Mallet and Chisel"
	[wstring.lower(GetStringFromTid(1111801))] = L"Masonry runic tool.\nMin Intensity: 65%\nMax Intensity: 100%\nMin Properties: 4\nMax Properties: 4\nMax Charges: 10",
	-- L"Verite Runic Mallet and Chisel"
	[wstring.lower(GetStringFromTid(1111802))] = L"Masonry runic tool.\nMin Intensity: 70%\nMax Intensity: 100%\nMin Properties: 4\nMax Properties: 5\nMax Charges: 10",
	-- L"Valorite Runic Mallet and Chisel"
	[wstring.lower(GetStringFromTid(1111803))] = L"Masonry runic tool.\nMin Intensity: 85%\nMax Intensity: 100%\nMin Properties: 5\nMax Properties: 5\nMax Charges: 10",

	-- CARPENTRY TOOLS
	-- L"Jointing Plane"
	[wstring.lower(GetStringFromTid(1011166))] = L"Carpentry tool.",
	-- L"Moulding Planes"
	[wstring.lower(GetStringFromTid(1011165))] = L"Carpentry tool.",
	-- L"Smoothing Plane"
	[wstring.lower(GetStringFromTid(1011167))] = L"Carpentry tool.",
	-- L"Scorp"
	[wstring.lower(GetStringFromTid(1011195))] = L"Carpentry tool.",
	-- L"Draw Knife"
	[wstring.lower(GetStringFromTid(1011192))] = L"Carpentry tool.",
	-- L"Saw"
	[wstring.lower(GetStringFromTid(1011197))] = L"Carpentry tool.",
	-- L"Dovetail Saw"
	[wstring.lower(GetStringFromTid(1011196))] = L"Carpentry tool.",
	-- L"Froe"
	[wstring.lower(GetStringFromTid(1011193))] = L"Carpentry tool.",
	-- L"Hammer"
	[wstring.lower(GetStringFromTid(1011198))] = L"Carpentry tool.",
	-- L"Inshave"
	[wstring.lower(GetStringFromTid(1011194))] = L"Carpentry tool.",
	-- L"Nails"
	[wstring.lower(GetStringFromTid(1024142))] = L"Carpentry tool.",


	-- ODDITIES
	-- L"A Small Piece Of Blackrock"
	[wstring.lower(GetStringFromTid(1150016))] = L"Blackrock Stew ingredient.\nKeep on your backpack to being able to damage the Dark Wisps while their barrier is active.",
	-- L"Clockwork Assembly"
	[wstring.lower(GetStringFromTid(1073426))] = L"Tool for create Golems.\nRequires: 1 Power Crystal, 50 Iron Ingots, 50 Bronze Ingots, 5 Gears.",
	-- L"Power Crystal"
	[wstring.lower(GetStringFromTid(1112811))] = L"Mechanical pet component.",
	[L"Compassion Sage"] = L"Use it to gain in Compassion.\nYou can use only 1 per day.",
	-- L"Arcane Gem"
	[wstring.lower(GetStringFromTid(1114115))] = L"Item used to create and charge Arcane Clothing.",
	-- L"Lucky Coin"
	[wstring.lower(GetStringFromTid(1113366))] = L"Throw this coin in the fountain of fortune (inside the Underworld dungeon), and you'll being rewarded.",
	-- L"Bag Of Sending"
	[wstring.lower(GetStringFromTid(1150423))] = L"Used to send an item directly in your bank box.",
	-- L"Bracelet of Binding"
	[wstring.lower(wstring.gsub(GetStringFromTid(1054000), L" : ~1_val~ ~2_val~", L""))] = L"Once linked to another one, will teleport you near the person who is wearing it.",

	-- MAGIC ITEMS
	-- Great barracuda
	[wstring.lower(GetStringFromTid(1116214))] = L"Increases Hit Chance Increase by 8 for 300 seconds.",
	--yellowtail barracuda
	[wstring.lower(GetStringFromTid(1116215))] = L"Increases Hit Point Regeneration by 3 for 300 seconds.",
	--giant koi
	[wstring.lower(GetStringFromTid(1116216))] = L"Increases Defence Chance Increase by 8 for 300 seconds.",
	--fire fish
	[wstring.lower(GetStringFromTid(1116217))] = L"Soaks Fire Damage by 5 for 300 seconds.",
	--reaper fish
	[wstring.lower(GetStringFromTid(1116218))] = L"Soaks Poison Damage by 5 for 300 seconds.",
	--crystal fish
	[wstring.lower(GetStringFromTid(1116219))] = L"Soaks Energy Damage by 5 for 300 seconds.",
	--bull fish
	[wstring.lower(GetStringFromTid(1116220))] = L"Increases Melee Damage by 5 for 300 seconds.",
	--summer fish
	[wstring.lower(GetStringFromTid(1116221))] = L"Increases Spell Damage by 5 for 300 seconds.",
	--fairy fish
	[wstring.lower(GetStringFromTid(1116222))] = L"Increases Casting Focus by 2 for 300 seconds.",
	--lava fish
	[wstring.lower(GetStringFromTid(1116223))] = L"Increases Soul Charge ability by 5 for 300 seconds.",
	--autumn fish
	[wstring.lower(GetStringFromTid(1116224))] = L"Increases Meditation skill by 10 for 300 seconds.",
	--holy fish
	[wstring.lower(GetStringFromTid(1116225))] = L"Increases Mana Regeneration by 3 for 300 seconds.",
	--unicorn fish
	[wstring.lower(GetStringFromTid(1116226))] = L"Increases Stamina Regeneration by 3 for 300 seconds.",
	--stone crab
	[wstring.lower(GetStringFromTid(1116227))] = L"Soaks Physical Damage by 5 for 300 seconds.",
	--blue lobster
	[wstring.lower(GetStringFromTid(1116228))] = L"Soaks Cold Damage by 5 for 300 seconds.",
	--spider crab
	[wstring.lower(GetStringFromTid(1116229))] = L"Icreases Focus skill by 10 for 300 seconds.",

	--enchanted apple
	[wstring.lower(GetStringFromTid(1072952))] = L"Enchanted apples remove curses from your character when consumed; similar to the Paladin's Remove Curse spell. Can be used once every 15 seconds.",
	--grapes of wrath
	[wstring.lower(GetStringFromTid(1072953))] = L"Damage Increase +35% and Spell Damage Increase +15% for 20 seconds. Can be used once every 120 seconds.",
	--Fruit Bowl
	[wstring.lower(GetStringFromTid(1072950))] = L"Increase all stats by 8 for 90 seconds. Can be used until you're hungry.",

	-- prized fish
	[wstring.lower(GetStringFromTid(1041073))] = L"Raises your intelligence by 8 - 12% for 150 seconds.",
	-- wondrous fish
	[wstring.lower(GetStringFromTid(1041074))] = L"Raises your dexterity by 8 - 12% for 150 seconds.",
	-- truly rare fish
	[wstring.lower(GetStringFromTid(1041075))] = L"Raises your strength by 8 - 12% for 150 seconds.",
	-- highly peculiar fish
	[wstring.lower(GetStringFromTid(1041076))] = L"Restores your stamina by 10.",

	-- CREATURES
	[L"a cow"] = L"Please, do not harass the cow...",

	},

}


Cliloc.Cliloc[SystemData.Settings.Language.LANGUAGE_JPN] ={
-- example : [] = L"TEXT",
}


Cliloc.Cliloc[SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL] ={
-- example : [] = L"TEXT",
}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function GetCliloc(number, language)
	if not language then
		language = SystemData.Settings.Language.type
	end
	if (Cliloc.Cliloc[language]) then
		if (Cliloc.Cliloc[language][number]) then
			return Cliloc.Cliloc[language][number]
		else
			return Cliloc.Cliloc[SystemData.Settings.Language.LANGUAGE_ENU][number]
		end
	else
		return Cliloc.Cliloc[SystemData.Settings.Language.LANGUAGE_ENU][number]
	end
end

function GetDescription(text, language)
	if not language then
		language = SystemData.Settings.Language.type
	end
	text = wstring.lower(towstring(text))
	if (Cliloc.Cliloc[language]) then
		if (Cliloc.Cliloc[language][10000]) then
			return Cliloc.Cliloc[language][10000][text]
		else
			return Cliloc.Cliloc[SystemData.Settings.Language.LANGUAGE_ENU][10000][text]
		end
	else
		return Cliloc.Cliloc[SystemData.Settings.Language.LANGUAGE_ENU][10000][text]
	end
end