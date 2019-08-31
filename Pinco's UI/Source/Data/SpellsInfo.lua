
SpellsInfo = {}

SpellsInfo.DisabledReason = {}
SpellsInfo.DisabledReason.CANT_USE_WHILE_FLYING = 1
SpellsInfo.DisabledReason.ALREADY_IN_EFFECT = 2
SpellsInfo.DisabledReason.PLAYER_DEAD = 3
SpellsInfo.DisabledReason.PLAYER_PARALYZED = 4
SpellsInfo.DisabledReason.LACK_REQUIREMENTS = 5
SpellsInfo.DisabledReason.PLAYER_RECOVERYING = 6
SpellsInfo.DisabledReason.PLAYER_CASTING = 7
SpellsInfo.DisabledReason.LOW_MANA = 8
SpellsInfo.DisabledReason.OUT_OF_RANGE = 9
SpellsInfo.DisabledReason.WRONG_MASTERY = 10
SpellsInfo.DisabledReason.TOO_MANY_FOLLOWERS = 11

SpellsInfo.DisabledReasonTID = 
{
	[SpellsInfo.DisabledReason.CANT_USE_WHILE_FLYING] = 1113415,
	[SpellsInfo.DisabledReason.ALREADY_IN_EFFECT] = 1005417,
	[SpellsInfo.DisabledReason.PLAYER_DEAD] = 1060169,
	[SpellsInfo.DisabledReason.PLAYER_PARALYZED] = 502646,
	[SpellsInfo.DisabledReason.LACK_REQUIREMENTS] = 1049536,
	[SpellsInfo.DisabledReason.PLAYER_RECOVERYING] = 502644,
	[SpellsInfo.DisabledReason.PLAYER_CASTING] = 502165,
	[SpellsInfo.DisabledReason.LOW_MANA] = 1060181,
	[SpellsInfo.DisabledReason.OUT_OF_RANGE] = 500643,
	[SpellsInfo.DisabledReason.WRONG_MASTERY] = 1115664,
	[SpellsInfo.DisabledReason.TOO_MANY_FOLLOWERS] = 1049645,
}

SpellsInfo.MasterySkillTID = 
{
	[15] = 1151945, -- TID_MASTERY_DISCORD		
	[22] = 1151946, -- TID_MASTERY_PROVOCATION	
	[9] = 1151947, -- TID_MASTERY_PEACEMAKING	
	[25] = 1155771, -- TID_MASTERY_MAGERY		
	[55] = 1155772, -- TID_MASTERY_MYSTICISM		
	[49] = 1155773, -- TID_MASTERY_NECRO			
	[54] = 1155774, -- TID_MASTERY_SPELLWEAVING	
	[52] = 1155775, -- TID_MASTERY_BUSHIDO		
	[51] = 1155776, -- TID_MASTERY_CHIVALRY		
	[53] = 1155777, -- TID_MASTERY_NINJITSU		
	[42] = 1155778, -- TID_MASTERY_FENCING		
	[41] = 1155779, -- TID_MASTERY_MACE			
	[40] = 1155780, -- TID_MASTERY_SWORDS		
	[57] = 1155781, -- TID_MASTERY_THROWING		
	[5] = 1155782, -- TID_MASTERY_PARRY			
	[30] = 1155783, -- TID_MASTERY_POISON		
	[43] = 1155784, -- TID_MASTERY_WRESTILING	
	[35] = 1155785, -- TID_MASTERY_ANIMAL_TAMING	
	[31] = 1155786, -- TID_MASTERY_ARCHERY	
}

SpellsInfo.TargetObjectSpells = 
{
	[13] = true, -- magic trap
	[14] = true, -- magic untrap
	[19] = true, -- magic lock
	[23] = true, -- unlock
	[32] = true, -- recall
	[34] = true, -- dispel field
	[45] = true, -- mark
	[52] = true, -- gate travel
	[210] = true, -- sacred journey
}

function SpellsInfo.Initialize()

	SpellsInfo.SpellsData = 
	{
		["Uus Jux"] = { id = 1, name = "Clumsy", color = Interface.Settings.Curse, distance = 10 },
		["In Mani Ylem"] = { id = 2, name = "Create Food", color = Interface.Settings.Neutral, notarget = true },
		["Rel Wis"] = { id = 3, name = "Feeblemind", color = Interface.Settings.Curse, distance = 10 },
		["In Mani"] = { id = 4, name = "Heal", color = Interface.Settings.Heal, distance = 10 },
		["In Por Ylem"] = { id = 5, name = "Magic Arrow", color = Interface.Settings.FIRE, distance = 10 },
		["In Lor"] = { id = 6, name = "Night Sight", color = Interface.Settings.Neutral, distance = 10 },
		["Flam Sanct"] = { id = 7, name = "Reactive Armor", color = Interface.Settings.Neutral, notarget = true },
		["Des Mani"] = { id = 8, name = "Weaken", color = Interface.Settings.Curse, distance = 10 },

		["Ex Uus"] = { id = 9, name = "Agility", color = Interface.Settings.Heal, distance = 10 },
		["Uus Wis"] = { id = 10, name = "Cunning", color = Interface.Settings.Heal, distance = 10 },
		["An Nox"] = { id = 11, name = "Cure", color = Interface.Settings.Heal, distance = 10 },
		["An Mani"] = { id = 12, name = "Harm", color = Interface.Settings.COLD, distance = 10 },
		["In Jux"] = { id = 13, name = "Magic Trap", color = Interface.Settings.Neutral, cursorOnly = true },
		["An Jux"] = { id = 14, name = "Magic Untrap", color = Interface.Settings.Neutral, distance = 10, cursorOnly = true  },
		["Uus Sanct"] = { id = 15, name = "Protection", color = Interface.Settings.Neutral, notarget = true  },
		["Uus Mani"] = { id = 16, name = "Strength", color = Interface.Settings.Heal, distance = 10 },

		["Rel Sanct"] = { id = 17, name = "Bless", color = Interface.Settings.Heal, distance = 10 },
		["Vas Flam"] = { id = 18, name = "Fireball", color = Interface.Settings.FIRE, distance = 10 },
		["An Por"] = { id = 19, name = "Magic Lock", color = Interface.Settings.Neutral, distance = 15 },
		["In Nox"] = { id = 20, name = "Poison", color = Interface.Settings.POISON, distance = 10 },
		["Ort Por Ylem"] = { id = 21, name = "Telekinesis", color = Interface.Settings.Neutral, distance = 15 },
		["Rel Por"] = { id = 22, name = "Teleport", color = Interface.Settings.Neutral, cursorOnly = true },
		["Ex Por"] = { id = 23, name = "Unlock", color = Interface.Settings.Neutral, distance = 15 },
		["In Sanct Ylem"] = { id = 24, name = "Wall of Stone", color = Interface.Settings.Neutral, distance = 22 },

		["Vas An Nox"] = { id = 25, name = "Arch Cure", color = Interface.Settings.Heal },
		["Vas Uus Sanct"] = { id = 26, name = "Arch Protection", color = Interface.Settings.Neutral, distance = 6 },
		["Des Sanct"] = { id = 27, name = "Curse", color = Interface.Settings.Curse, distance = 10 },
		["In Flam Grav"] = { id = 28, name = "Fire Field", color = Interface.Settings.FIRE, distance = 22 },
		["In Vas Mani"] = { id = 29, name = "Greater Heal", color = Interface.Settings.Heal, distance = 10 },
		["Por Ort Grav"] = { id = 30, name = "Lightning", color = Interface.Settings.ENERGY, distance = 10 },
		["Ort Rel"] = { id = 31, name = "Mana Drain", color = Interface.Settings.Curse, distance = 10 },
		["Kal Ort Por"] = { id = 32, name = "Recall", color = Interface.Settings.Neutral, distance = 15, noSelf = true },

		["In Jux Hur Ylem"] = { id = 33, name = "Blade Spirits", color = Interface.Settings.Neutral, cursorOnly = true },
		["An Grav"] = { id = 34, name = "Dispel Field", color = Interface.Settings.Neutral, distance = 13, noSelf = true },
		["Kal In Ex"] = { id = 35, name = "Incognito", color = Interface.Settings.Neutral, notarget = true },
		["In Jux Sanct"] = { id = 36, name = "Magic Reflection", color = Interface.Settings.Neutral, notarget = true },
		["Por Corp Wis"] = { id = 37, name = "Mind Blast", color = Interface.Settings.COLD, distance = 10 },
		["An Ex Por"] = { id = 38, name = "Paralyze", color = Interface.Settings.Paralyze, distance = 10 },
		["In Nox Grav"] = { id = 39, name = "Poison Field", color = Interface.Settings.POISON, distance = 22 },
		["Kal Xen"] = { id = 40, name = "Summon Creature", color = Interface.Settings.Neutral, notarget = true },

		["An Ort"] = { id = 41, name = "Dispel", color = Interface.Settings.Neutral, distance = 10, noSelf = true },
		["Corp Por"] = { id = 42, name = "Energy Bolt", color = Interface.Settings.ENERGY, distance = 10 },
		["Vas Ort Flam"] = { id = 43, name = "Explosion", color = Interface.Settings.FIRE, distance = 10 },
		["An Lor Xen"] = { id = 44, name = "Invisibility", color = Interface.Settings.Neutral, distance = 10 },
		["Kal Por Ylem"] = { id = 45, name = "Mark", color = Interface.Settings.Neutral, noSelf = true },
		["Vas Des Sanct"] = { id = 46, name = "Mass Curse", color = Interface.Settings.Curse },
		["In Ex Grav"] = { id = 47, name = "Paralyze Field", color = Interface.Settings.Paralyze, distance = 22 },
		["Wis Quas"] = { id = 48, name = "Reveal", color = Interface.Settings.Neutral, distance = 22 },

		["Vas Ort Grav"] = { id = 49, name = "Chain Lightning", color = Interface.Settings.ENERGY, distance = 10 },
		["In Sanct Grav"] = { id = 50, name = "Energy Field", color = Interface.Settings.ENERGY, distance = 22 },
		["Kal Vas Flam"] = { id = 51, name = "Flamestrike", color = Interface.Settings.FIRE, distance = 10 },
		["Vas Rel Por"] = { id = 52, name = "Gate Travel", color = Interface.Settings.Neutral, distance = 15, cursorOnly = true },
		["Ort Sanct"] = { id = 53, name = "Mana Vampire", color = Interface.Settings.Curse, distance = 10 },
		["Vas An Ort"] = { id = 54, name = "Mass Dispel", color = Interface.Settings.Neutral, distance = 22 },
		["Flam Kal Des Ylem"] = { id = 55, name = "Meteor Swarm", color = Interface.Settings.FIRE, distance = 10 },
		["Vas Ylem Rel"] = { id = 56, name = "Polymorph", color = Interface.Settings.Neutral, notarget = true },

		["In Vas Por"] = { id = 57, name = "Earthquake", color = Interface.Settings.PHYSICAL, notarget = true },
		["Vas Corp Por"] = { id = 58, name = "Energy Vortex", color = Interface.Settings.Neutral, cursorOnly = true },
		["An Corp"] = { id = 59, name = "Resurrection", color = Interface.Settings.Heal, distance = 1 },
		["Kal Vas Xen Hur"] = { id = 60, name = "Air Elemental", color = Interface.Settings.Neutral, notarget = true },
		["Kal Vas Xen Corp"] = { id = 61, name = "Summon Daemon", color = Interface.Settings.Neutral, notarget = true },
		["Kal Vas Xen Ylem"] = { id = 62, name = "Earth Elemental", color = Interface.Settings.Neutral, notarget = true },
		["Kal Vas Xen Flam"] = { id = 63, name = "Fire Elemental", color = Interface.Settings.Neutral, notarget = true },
		["Kal Vas Xen An Flam"] = { id = 64, name = "Water Elemental", color = Interface.Settings.Neutral, notarget = true  },

		["Uus Corp"] = { id = 101, name = "Animate Dead", color = Interface.Settings.Neutral , distance = 11, cursorOnly = true },
		["In Jux Mani Xen"] = { id = 102, name = "Blood Oath", color = Interface.Settings.Curse, distance = 10 },
		["In Aglo Corp Ylem"] = { id = 103, name = "Corpse Skin", color = Interface.Settings.Curse, distance = 10 },
		["An Sanct Gra Char"] = { id = 104, name = "Curse Weapon", color = Interface.Settings.Neutral, notarget = true },
		["Pas Tym An Sanct"] = { id = 105, name = "Evil Omen", color = Interface.Settings.Curse, distance = 10 },
		["Rel Xen Vas Bal"] = { id = 106, name = "Horrific Beast", color = Interface.Settings.Neutral, notarget = true },
		["Rel Xen Corp Ort"] = { id = 107, name = "Lich Form", color = Interface.Settings.Neutral, notarget = true },
		["Wis An Ben"] = { id = 108, name = "Mind Rot", color = Interface.Settings.Curse, distance = 10 },
		["In Sar"] = { id = 109, name = "Pain Spike", color = Interface.Settings.ENERGY, distance = 10 },
		["In Vas Nox"] = { id = 110, name = "Poison Strike", color = Interface.Settings.POISON, distance = 10 },
		["In Bal Nox"] = { id = 111, name = "Strangle", color = Interface.Settings.POISON, distance = 10 },
		["Kal Xen Bal"] = { id = 112, name = "Summon Familiar", color = Interface.Settings.Neutral, notarget = true },
		["Rel Xen An Sanct"] = { id = 113, name = "Vampiric Embrace", color = Interface.Settings.Neutral, notarget = true },
		["Kal Xen Bal Beh"] = { id = 114, name = "Vengeful Spirit", color = Interface.Settings.Neutral, distance = 10, noSelf = true },
		["Kal Vas An Flam"] = { id = 115, name = "Wither", color = Interface.Settings.COLD, notarget = true },
		["Rel Xen Um"] = { id = 116, name = "Wraith Form", color = Interface.Settings.Neutral, notarget = true },
		["Ort Corp Grav"] = { id = 117, name = "Exorcism", color = Interface.Settings.Neutral, notarget = true },

		["Expor Flamus"] = { id = 201, name = "Cleanse by Fire", color = Interface.Settings.Heal, distance = 18 },
		["Obsu Vulni"] = { id = 202, name = "Close Wounds", color = Interface.Settings.Heal, distance = 2 },
		["Consecrus Arma"] = { id = 203, name = "Consecrate Weapon", color = Interface.Settings.Neutral, notarget = true },
		["Dispiro Malas"] = { id = 204, name = "Dispel Evil", color = Interface.Settings.Neutral, notarget = true },
		["Divinum Furis"] = { id = 205, name = "Divine Fury", color = Interface.Settings.Neutral, notarget = true },
		["Forul Solum"] = { id = 206, name = "Enemy of One", color = Interface.Settings.Neutral, notarget = true },
		["Augus Luminos"] = { id = 207, name = "Holy Light", color = Interface.Settings.Neutral, notarget = true },
		["Dium Prostra"] = { id = 208, name = "Noble Sacrifice", color = Interface.Settings.Heal, notarget = true },
		["Extermo Vomica"] = { id = 209, name = "Remove Curse", color = Interface.Settings.Heal, distance = 18 },
		["Sanctum Viatas"] = { id = 210, name = "Sacred Journey", color = Interface.Settings.Neutral, distance = 15 },

		["Myrshalee"] = { id = 601, name = "Arcane Circle", color = Interface.Settings.Neutral, notarget = true },
		["Olorisstra"] = { id = 602, name = "Gift of Renewal", color = Interface.Settings.Heal },
		["Thalshara"] = { id = 603, name = "Immolating Weapon", color = Interface.Settings.Neutral, notarget = true },
		["Haeldril"] = { id = 604, name = "Attune Weapon", color = Interface.Settings.Neutral, notarget = true },
		["Erelonia"] = { id = 605, name = "Thunderstorm", color = Interface.Settings.Curse, notarget = true },
		["Rauvvrae"] = { id = 606, name = "Nature's Fury", color = Interface.Settings.Neutral, cursorOnly = true },
		["Alalithra"] = { id = 607, name = "Summon Fey", color = Interface.Settings.Neutral, notarget = true },
		["Nylisstra"] = { id = 608, name = "Summon Fiend", color = Interface.Settings.Neutral, notarget = true },
		["Tarisstree"] = { id = 609, name = "Reaper Form", color = Interface.Settings.Neutral, notarget = true },
		["Haelyn"] = { id = 610, name = "Wildfire", color = Interface.Settings.FIRE, distance = 10 },
		["Anathrae"] = { id = 611, name = "Essence of Wind", color = Interface.Settings.Curse, notarget = true },
		["Rathril"] = { id = 612, name = "Dryad Allure", color = Interface.Settings.Neutral, distance = 10 },
		["Orlavdra"] = { id = 613, name = "Ethereal Voyage", color = Interface.Settings.Neutral, notarget = true },
		["Nyraxle"] = { id = 614, name = "Word of Death", color = Interface.Settings.Chaos, distance = 11 },
		["Illorae"] = { id = 615, name = "Gift of Life", color = Interface.Settings.Neutral },
		["Aslavdra"] = { id = 616, name = "Arcane Empowerment", color = Interface.Settings.Neutral, notarget = true },

		["In Corp Ylem"] = { id = 678, name = "Nether Bolt", color = Interface.Settings.Chaos, distance = 10, spellTrigger = true },
		["Kal In Mani"] = { id = 679, name = "Healing Stone", color = Interface.Settings.Neutral, notarget = true, spellTrigger = true },
		["An Ort Sanct"] = { id = 680, name = "Purge Magic", color = Interface.Settings.Neutral, distance = 13, spellTrigger = true },
		["In Ort Ylem"] = { id = 681, name = "Enchant", color = Interface.Settings.Neutral, notarget = true, spellTrigger = true },
		["In Zu"] = { id = 682, name = "Sleep", color = Interface.Settings.Paralyze, distance = 13, spellTrigger = true },
		["Kal Por Xen"] = { id = 683, name = "Eagle Strike", color = Interface.Settings.ENERGY, distance = 13, spellTrigger = true },
		["In Jux Por Ylem"] = { id = 684, name = "Animated Weapon", color = Interface.Settings.Neutral, cursorOnly = true, spellTrigger = true },
		["In Rel Ylem"] = { id = 685, name = "Stone Form", color = Interface.Settings.Neutral, notarget = true, spellTrigger = true },
		["In Vas Ort Ex"] = { id = 686, name = "Spell Trigger", color = Interface.Settings.Neutral, notarget = true },
		["Vas Zu"] = { id = 687, name = "Mass Sleep", color = Interface.Settings.Paralyze, distance = 13, spellTrigger = true },
		["In Vas Mani Hur"] = { id = 688, name = "Cleansing Winds", color = Interface.Settings.Heal, distance = 13, spellTrigger = true },
		["Corp Por Ylem"] = { id = 689, name = "Bombard", color = Interface.Settings.PHYSICAL, distance = 13, spellTrigger = true },
		["Vas Rel Jux Ort"] = { id = 690, name = "Spell Plague", color = Interface.Settings.Curse, distance = 13 },
		["Kal Des Ylem"] = { id = 691, name = "Hail Storm", color = Interface.Settings.COLD, distance = 13 },
		["Grav Hur"] = { id = 692, name = "Nether Cyclone", color = Interface.Settings.Chaos, distance = 13 },
		["Kal Vas Xen Corp Ylem"] = { id = 693, name = "Rising Colossus", color = Interface.Settings.Neutral, cursorOnly = true },

		["Uus Por"] = { id = 701, name = "Inspire", color = Interface.Settings.Heal, notarget = true },
		["An Zu"] = { id = 702, name = "Invigorate", color = Interface.Settings.Heal, notarget = true },
		["Kal Mani Tym"] = { id = 703, name = "Resilience", color = Interface.Settings.Heal, notarget = true },
		["Uus Jux Sanct"] = { id = 704, name = "Preservance", color = Interface.Settings.Heal, notarget = true },
		["In Jux Hur Rel"] = { id = 705, name = "Tribulation", color = Interface.Settings.Curse, distance = 8 },
		["Kal Des Mani Tym"] = { id = 706, name = "Despair", color = Interface.Settings.PHYSICAL, distance = 8 },
	
		["In Grav Corp"] = { id = 707, name = "Death Ray", color = Interface.Settings.Chaos },
		["Uus Ort Grav"] = { id = 708, name = "Ethereal Burst", color = Interface.Settings.Chaos, notarget = true },
		["In Vas Xen Por"] = { id = 709, name = "Nether Blast", color = Interface.Settings.Chaos },
		["Vas Ylem Wis"] = { id = 710, name = "Mystic Weapon", color = Interface.Settings.Neutral, notarget = true },
		["In Corp Xen Por"] = { id = 711, name = "Command Undead", color = Interface.Settings.Neutral },
		["Uus Corp Grav"] = { id = 712, name = "Conduit", color = Interface.Settings.Neutral, cursorOnly = true },
		["Faerkulggen"] = { id = 713, name = "Mana Shield", color = Interface.Settings.Neutral, notarget = true },
		["Lartarisstree"] = { id = 714, name = "Summon Reaper", color = Interface.Settings.Neutral, notarget = true },
		["Anticipate Hit"] = { id = 716, notarget = true },
		["Warcry"] = { id = 717, notarget = true },
		["Rejuvenate"] = { id = 719 },
		["Holy Fist"] = { id = 720 },
		["Shadow"] = { id = 721, notarget = true },
		["White Tiger Form"] = { id = 722, notarget = true },
		["Flaming Shot"] = { id = 723 },
		["Flaming Shot"] = { id = 724, notarget = true },
		["Thrust"] = { id = 725, notarget = true },
		["Pierce"] = { id = 726, notarget = true },
		["Stagger"] = { id = 727, notarget = true },
		["Toughness"] = { id = 728, notarget = true },
		["Onslaught"] = { id = 729, notarget = true },
		["Focused Eye"] = { id = 730, notarget = true },
		["Elemental Fury"] = { id = 731, notarget = true },
		["Called Shot"] = { id = 732, notarget = true },
		["Shield Bash"] = { id = 734, notarget = true },
		["Bodyguard"] = { id = 735 },
		["Highten Senses"] = { id = 736, notarget = true },
		["Tolerance"] = { id = 737, notarget = true },
		["Injected Strike"] = { id = 738 },
		["Rampage"] = { id = 740, notarget = true },
		["Fists of Fury"] = { id = 741, notarget = true },
		["Whispering"] = { id = 743, notarget = true },
		["Combat Training"] = { id = 744 },

		["Honorable Execution"] = { id = 401, notarget = true },
		["Confidence"] = { id = 402, notarget = true },
		["Evasion"] = { id = 403, notarget = true },
		["Counter Attack"] = { id = 404, notarget = true },
		["Lightning Strike"] = { id = 405, notarget = true },
		["Momentum Strike"] = { id = 406, notarget = true },

		["Focus Attack"] = { id = 501, notarget = true },
		["Death Strike"] = { id = 502, notarget = true },
		["Animal Form"] = { id = 503, notarget = true },
		["Ki Attack"] = { id = 504, notarget = true },
		["Surprise Attack"] = { id = 505, notarget = true },
		["Backstab"] = { id = 506, notarget = true },
		["Shadowjump"] = { id = 507, cursorOnly = true },
		["Mirror Image"] = { id = 508, notarget = true },

		["Anh Mi Sah Ko"] = { id = -1, name = "Spirit Speak", color = Interface.Settings.Heal },
	}
end

SpellsInfo.EnchantContextOptions = 
{
	[0] = 1080133, -- Select Enchant (used as description)
	[1] = 1079702, -- Hit Dispel
	[2] = 1079703, -- Hit Fireball
	[3] = 1079704, -- Hit Harm
	[4] = 1079705, -- Hit Lightning
	[5] = 1079706, -- Hit Magic Arrow
}

SpellsInfo.SummonFamiliarContextOptions = 
{
	[0] = 1078861, -- Select (used as description)
	[1] = 1060146, -- Horde Minion
	[2] = 1060142, -- Shadow Wisp
	[3] = 1060143, -- Dark Wolf
	[4] = 1060145, -- Death Adder
	[5] = 1060144, -- Vampire Bat
}

SpellsInfo.AnimalFormContextOptions = 
{
	[0]	 = 1078861, -- Select (used as description)
	[1]	 = 1028485, -- Rabbit
	[2]	 = 1028483, -- Rat
	[3]	 = 1075971, -- squirrel
	[4]	 = 1018280, -- Dog
	[5]	 = 1018264, -- Cat
	[6]	 = 1075972, -- ferret
	[7]	 = 1028496, -- Bullfrog
	[8]	 = 1018114, -- Giant Serpent
	[9]	 = 1031670, -- cu sidhe
	[10] = 1028438, -- Llama
	[11] = 1018273, -- Ostard
	[12] = 1030083, -- Bake-Kitsune
	[13] = 1028482, -- Wolf
	[14] = 1075202, -- reptalon
	[15] = 1029632, -- Kirin
	[16] = 1018214, -- Unicorn 
}		

SpellsInfo.PolymorphContextOptions = 
{
	[0]	 = 1078861, -- Select (used as description)
	[1]	 = 1015236, -- Chicken
	[2]	 = 1015237, -- Dog
	[3]	 = 1015238, -- Wolf
	[4]	 = 1015239, -- Panther
	[5]	 = 1015240, -- Gorilla
	[6]	 = 1015241, -- Black Bear
	[7]	 = 1015242, -- Grizzly Bear
	[8]	 = 1015243, -- Polar Bear
	[9]	 = 1015244, -- Human Male
	[10] = 1015254,  -- Human Female
	[11] = 1015246,  -- Slime
	[12] = 1015247,  -- Orc
	[13] = 1015248,  -- Lizard Man
	[14] = 1015249,  -- Gargoyle
	[15] = 1015250,  -- Ogre
	[16] = 1015251,  -- Troll
	[17] = 1015252,  -- Ettin
	[18] = 1015253,  -- Daemon
}

SpellsInfo.CombatTrainingContextOptions = 
{
	[0]	 = 1078861, -- Select (used as description)
	[1]	 = 1156109, -- Empowerment
	[2]	 = 1157544, -- As One
	[3]	 = 1112194, -- Berserk
	[4]	 = 1156108, -- Consume Damage
}


SpellsInfo.PassiveSpells = 
{
	[715] = true; -- Enchanted Summoning
	[716] = true; -- Anticipate Hit
	[718] = true; -- Intuition
	[733] = true; -- Saving Throw
	[742] = true; -- Knockout
	[745] = true; -- Boarding
}

SpellsInfo.ScrollsToSpellID = 
{
	-- MAGERY
	[7982] = 1, -- Clumsy
	[7983] = 2, -- Create Food
	[7984] = 3, -- Feeblemind
	[7985] = 4, -- Heal
	[7986] = 5, -- Magic Arrow
	[7987] = 6, -- Night Sight
	[7981] = 7, -- Reactive Armor
	[7988] = 8, -- Weaken

	[7989] = 9, -- Agility
	[7990] = 10, -- Cunning
	[7991] = 11, -- Cure
	[7992] = 12, -- Harm
	[7993] = 13, -- Magic Trap
	[7994] = 14, -- Magic Untrap
	[7995] = 15, -- Protection
	[7996] = 16, -- Strength

	[7997] = 17, -- Bless
	[7998] = 18, -- Fireball
	[7999] = 19, -- Magic Lock
	[8000] = 20, -- Poison
	[8001] = 21, -- Telekinesis
	[8002] = 22, -- Teleport
	[8003] = 23, -- Unlock
	[8004] = 24, -- Wall of Stone

	[8005] = 25, -- Arch Cure
	[8006] = 26, -- Arch Protection
	[8007] = 27, -- Curse
	[8008] = 28, -- Fire Field
	[8009] = 29, -- Greater Heal
	[8010] = 30, -- Lightning
	[8011] = 31, -- Mana Drain
	[8012] = 32, -- Recall

	[8013] = 33, -- Blade Spirit
	[8014] = 34, -- Dispel Field
	[8015] = 35, -- Incognito
	[8016] = 36, -- Magic Reflection
	[8017] = 37, -- Mind Blast
	[8018] = 38, -- Paralyze
	[8019] = 39, -- Poison Field
	[8020] = 40, -- Summon Creature

	[8021] = 41, -- Dispel
	[8022] = 42, -- Energy Bolt
	[8023] = 43, -- Explosion
	[8024] = 44, -- Invisibility
	[8025] = 45, -- Mark
	[8026] = 46, -- Mass Curse
	[8027] = 47, -- Paralyze Field
	[8028] = 48, -- Reveal

	[8029] = 49, -- Chain Lightning
	[8030] = 50, -- Energy Field
	[8031] = 51, -- Flamestrike
	[8032] = 52, -- Gate Travel
	[8033] = 53, -- Mana Vampire
	[8034] = 54, -- Mass Dispel
	[8035] = 55, -- Meteor Swarm
	[8036] = 56, -- Polymorph
	
	[8037] = 57, -- Earthquake
	[8038] = 58, -- Energy Vortex
	[8039] = 59, -- Ressurrection
	[8040] = 60, -- Summon Air Elemental
	[8041] = 61, -- Summon Daemon
	[8042] = 62, -- Summon Earth Elemental
	[8043] = 63, -- Summon Fire Elemental
	[8044] = 64, -- Summon Water Elemental

	-- NECROMANCY
	[8800] = 101, -- Animate Dead
	[8801] = 102, -- Blood Oath
	[8802] = 103, -- Corpse Skin
	[8803] = 104, -- Curse Weapon
	[8804] = 105, -- Evil Omen
	[8805] = 106, -- Horrific Beast
	[8806] = 107, -- Lich Form
	[8807] = 108, -- Mind Rot
	[8808] = 109, -- Pain Spike
	[8809] = 110, -- Poison Strike
	[8810] = 111, -- Strangle
	[8811] = 112, -- Summon Familiar
	[8812] = 113, -- Vampiric Embrace
	[8813] = 114, -- Vengeful Spirit
	[8814] = 115, -- Wither
	[8815] = 116, -- Wraith Form
	[8816] = 117, -- Exorcism

	-- SPELLWEAVING
	[11601] = 601, -- Arcane Circle
	[11602] = 602, -- Gift of Renewal
	[11603] = 603, -- Immolating Weapon
	[11604] = 604, -- Attune Weapon
	[11605] = 605, -- Thunderstorm
	[11606] = 606, -- Nature's Fury
	[11607] = 607, -- Summon Fey
	[11608] = 608, -- Summon Fiend
	[11609] = 609, -- Reaper Form
	[11610] = 610, -- Wildfire
	[11611] = 611, -- Essence of Wind
	[11612] = 612, -- Dryad Allure
	[11613] = 613, -- Ethereal Voyage
	[11614] = 614, -- Word of Death
	[11615] = 615, -- Gift of Life
	[11616] = 616, -- Arcane Empowerment

	-- MYSTICISM
	[11678] = 678, -- Nether Bolt
	[11679] = 679, -- Healing Stone
	[11680] = 680, -- Purge Magic
	[11681] = 681, -- Enchant
	[11682] = 682, -- Sleep
	[11683] = 683, -- Eagle Strike
	[11684] = 684, -- Animated Weapo
	[11685] = 685, -- Stone Form
	[11686] = 686, -- Spell Trigger
	[11687] = 687, -- Mass Sleep
	[11688] = 688, -- Cleansing Winds
	[11689] = 689, -- Bombard
	[11690] = 690, -- Spell Plague
	[11691] = 691, -- Hail Storm
	[11692] = 692, -- Nether Cyclone
	[11693] = 693, -- Rising Colossus
}

function SpellsInfo.IsPassive(spellId)
	return SpellsInfo.PassiveSpells[spellId]
end

function SpellsInfo.GetMinSkill(spellId) 
	
	-- recall and gate travel can be used at 0 skill on ship runes
	if spellId == 32 or spellId == 52 then
		return 0
	end

	if (spellId >= 1 and spellId <= 8) then -- Magery 1
		return -20
	elseif (spellId >= 9 and spellId <= 16) then-- Magery 2
		return -5
	elseif (spellId >= 17 and spellId <= 24) then-- Magery 3
		return 9
	elseif (spellId >= 25 and spellId <= 32) then-- Magery 4
		return 23
	elseif (spellId >= 33 and spellId <= 40) then-- Magery 5
		return 38
	elseif (spellId >= 41 and spellId <= 48) then-- Magery 6
		return 52
	elseif (spellId >= 49 and spellId <= 56) then-- Magery 7
		return 66
	elseif (spellId >= 57 and spellId <= 64) then-- Magery 8
		return 80
	elseif (spellId == 101) then -- Animate Dead
		return 40
	elseif (spellId == 102) then -- Blood Oath
		return 20
	elseif (spellId == 103) then -- Corpse Skin
		return 20
	elseif (spellId == 104) then -- Curse Weapon
		return 0
	elseif (spellId == 105) then -- Evil Omen
		return 20
	elseif (spellId == 106) then -- Horrific Beast
		return 40
	elseif (spellId == 107) then -- Lich Form
		return 70
	elseif (spellId == 108) then -- Mind Rot
		return 30
	elseif (spellId == 109) then -- Pain Spike
		return 20
	elseif (spellId == 110) then -- Poison Strike
		return 50
	elseif (spellId == 111) then -- Strangle
		return 65
	elseif (spellId == 112) then -- Summon Familiar
		return 30
	elseif (spellId == 113) then -- Vampiric Embrace
		return 99
	elseif (spellId == 114) then -- Vengeful Spirit
		return 80
	elseif (spellId == 115) then -- Wither
		return 60
	elseif (spellId == 116) then -- Wraith Form
		return 20
	elseif (spellId == 117) then -- Exorcism
		return 80
	elseif (spellId > 700) then -- masteries
		return 90
	end
end

function SpellsInfo.GetMaxSkill(minSkill, spellId) 
	if (spellId == 401 or spellId == 405 or spellId == 406) then
		return minSkill
	end
	if (spellId >= 1 and spellId <= 8) then -- Magery 1
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 9 and spellId <= 16) then-- Magery 2
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 17 and spellId <= 24) then-- Magery 3
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 25 and spellId <= 32) then-- Magery 4
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 33 and spellId <= 40) then-- Magery 5
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 41 and spellId <= 48) then-- Magery 6
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 49 and spellId <= 56) then-- Magery 7
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 57 and spellId <= 64) then-- Magery 8
		return SpellsInfo.GetMinSkill(spellId) + 40
	elseif (spellId >= 101 and spellId <= 200) then -- Necromancy
		return minSkill + 40
	elseif (spellId >= 201 and spellId <= 300) then -- Chivalry
		return minSkill + 50
	elseif (spellId >= 401 and spellId <= 500) then -- Bushido
		return minSkill + 35
	elseif (spellId >= 501 and spellId <= 600) then	-- Ninjitsu
		return minSkill + 40
	elseif (spellId >= 601 and spellId <= 677) then -- Spellweaving
		return minSkill + 40
	elseif (spellId >= 678 and spellId <= 700) then -- Mysticism
		return minSkill + 37.5
	else
		return minSkill + 40
	end
end

function SpellsInfo.GetVariation(spellId) 
	if (spellId >= 1 and spellId <= 64) then-- Magery 
		return 40
	elseif (spellId >= 101 and spellId <= 200) then -- Necromancy
		return 40
	elseif (spellId >= 201 and spellId <= 300) then -- Chivalry
		return 50
	elseif (spellId >= 401 and spellId <= 500) then -- Bushido
		return 35
	elseif (spellId >= 501 and spellId <= 600) then	-- Ninjitsu
		return 40
	elseif (spellId >= 601 and spellId <= 677) then -- Spellweaving
		return 40
	elseif (spellId >= 678 and spellId <= 700) then -- Mysticism
		return  37.5
	else
		return  40
	end
end

function SpellsInfo.GetHighestSkillID(skillsIDs, withBonus) 

	-- initialize the skills array
	local skills = {}

	for i = 1, #skillsIDs do 
		table.insert(skills, {value = GetSkillValue(skillsIDs[i], withBonus), id = skillsIDs[i]})
	end

	-- searching for the highest skill

	-- we assume the first one is the highest skill
	local largestIdx = 1

	-- scan all skills
	for i = 2, #skills do
		
		-- getting the value of the current
		local current = skills[i]

		-- getting the value of the highest
		local largest = skills[largestIdx]

		-- is the current higher than higher we got? if yes we replace it
		if current.value > largest.value then
			largestIdx = i
		end
	end

	return skills[largestIdx].id
end

function SpellsInfo.GetSkillID(spellId) 
	
	-- is this a valid spell ID?
	if not IsValidID(spellId) then
		return
	end

	if (spellId >= 1 and spellId <= 64) or spellId == 707  or spellId == 708 then-- Magery 
		return SkillsWindow.SkillsID.MAGERY

	elseif (spellId >= 101 and spellId <= 200) or spellId == 711  or spellId == 712 then -- Necromancy
		return SkillsWindow.SkillsID.NECROMANCY

	elseif (spellId >= 201 and spellId <= 300) or spellId == 719  or spellId == 720 then -- Chivalry
		return SkillsWindow.SkillsID.CHIVALRY

	elseif (spellId >= 401 and spellId <= 500) or spellId == 716  or spellId == 717 then -- Bushido
		return SkillsWindow.SkillsID.BUSHIDO

	elseif (spellId >= 501 and spellId <= 600) or spellId == 721  or spellId == 722 then	-- Ninjitsu
		return SkillsWindow.SkillsID.NINJITSU

	elseif (spellId >= 601 and spellId <= 677) or spellId == 713  or spellId == 714  then -- Spellweaving
		return SkillsWindow.SkillsID.SPELLWEAVING

	elseif (spellId >= 678 and spellId <= 700) or spellId == 709  or spellId == 710 then -- Mysticism
		return SkillsWindow.SkillsID.MYSTICISM

	-- masteries
	elseif spellId == 733 then -- Warrior's Gift

		-- this spell works only if one of the masteries are active
		if Spellbook.ActiveMastery == 1155780 then -- swords
			return SkillsWindow.SkillsID.SWORDSMANSHIP

		elseif Spellbook.ActiveMastery == 1155779 then -- mace
			return SkillsWindow.SkillsID.MACE_FIGHTING

		elseif Spellbook.ActiveMastery == 1155778 then -- fencing
			return SkillsWindow.SkillsID.FENCING

		elseif Spellbook.ActiveMastery == 1155786 then -- archery
			return SkillsWindow.SkillsID.ARCHERY

		elseif Spellbook.ActiveMastery == 1155781 then -- throwing
			return SkillsWindow.SkillsID.THROWING

		else  -- return the highest skill
			return SpellsInfo.GetHighestSkillID({ SkillsWindow.SkillsID.SWORDSMANSHIP, SkillsWindow.SkillsID.MACE_FIGHTING, SkillsWindow.SkillsID.FENCING, SkillsWindow.SkillsID.ARCHERY, SkillsWindow.SkillsID.THROWING }, false) -- weapon skill (swords, mace, fencing, archery, throwing)
		end

	elseif spellId == 723 then -- Flaming Shot
		return SkillsWindow.SkillsID.ARCHERY -- archery

	elseif spellId == 724 then -- Playing the Odds
		return SkillsWindow.SkillsID.ARCHERY -- archery

	elseif spellId == 725 then -- Thrust
		return SkillsWindow.SkillsID.FENCING -- fencing

	elseif spellId == 726 then -- Pierce
		return SkillsWindow.SkillsID.FENCING -- fencing

	elseif spellId == 727 then -- Stagger
		return SkillsWindow.SkillsID.MACE_FIGHTING -- mace fighting

	elseif spellId == 728 then -- Toughness
		return SkillsWindow.SkillsID.MACE_FIGHTING -- mace fighting

	elseif spellId == 729 then -- Onslaught
		return SkillsWindow.SkillsID.SWORDSMANSHIP -- swordsmanship

	elseif spellId == 730 then -- Focused Eye
		return SkillsWindow.SkillsID.SWORDSMANSHIP -- swordsmanship

	elseif spellId == 731 then -- Elemental Fury
		return SkillsWindow.SkillsID.THROWING -- throwing

	elseif spellId == 732 then -- Called Shot
		return SkillsWindow.SkillsID.THROWING -- throwing

	elseif spellId == 734 then -- Shield Bash
		return SkillsWindow.SkillsID.PARRYING -- parry

	elseif spellId == 735 then -- Body Guard
		return SkillsWindow.SkillsID.PARRYING -- parry

	elseif spellId == 736 then -- Heightened Senses
		return SkillsWindow.SkillsID.PARRYING -- parry

	elseif spellId == 736 then -- Intuition

		-- this spell works only if one of this 3 masteries are active
		if Spellbook.ActiveMastery == 1155775 then -- bushido
			return SkillsWindow.SkillsID.BUSHIDO

		elseif Spellbook.ActiveMastery == 1155776 then -- chivalry
			return SkillsWindow.SkillsID.CHIVALRY

		elseif Spellbook.ActiveMastery == 1155777 then -- ninjitsu
			return SkillsWindow.SkillsID.NINJITSU

		else  -- return the highest skill between the 3
			return SpellsInfo.GetHighestSkillID({ SkillsWindow.SkillsID.BUSHIDO, SkillsWindow.SkillsID.CHIVALRY, SkillsWindow.SkillsID.NINJITSU }, false)
		end

	elseif spellId == 716 then -- Anticipate Hits
		return killsWindow.SkillsID.BUSHIDO -- bushido

	elseif spellId == 717 then -- War Cry
		return killsWindow.SkillsID.BUSHIDO -- bushido

	elseif spellId == 719 then -- Rejuvenate
		return SkillsWindow.SkillsID.CHIVALRY -- chivalry

	elseif spellId == 720 then -- Holy Fist
		return SkillsWindow.SkillsID.CHIVALRY -- chivalry

	elseif spellId == 721 then -- Shadow
		return SkillsWindow.SkillsID.NINJITSU -- ninjitsu
	
	elseif spellId == 722 then -- Shadow
		return SkillsWindow.SkillsID.NINJITSU -- ninjitsu

	elseif spellId == 742 then -- Knockout
		return SkillsWindow.SkillsID.WRESTLING -- wrestling

	elseif spellId == 740 then -- Rampage
		return SkillsWindow.SkillsID.WRESTLING -- wrestling

	elseif spellId == 741 then -- Fists of Fury
		return SkillsWindow.SkillsID.WRESTLING -- wrestling

	elseif spellId == 715 then -- Enchanted Summoning

		-- this spell works only if one of this masteries are active
		if Spellbook.ActiveMastery == 1155771 then -- magery
			return SkillsWindow.SkillsID.MAGERY

		elseif Spellbook.ActiveMastery == 1155773 then -- necromancy
			return SkillsWindow.SkillsID.NECROMANCY

		elseif Spellbook.ActiveMastery == 1155774 then -- spellweaving
			return SkillsWindow.SkillsID.SPELLWEAVING

		elseif Spellbook.ActiveMastery == 1155772 then -- mysticism
			return SkillsWindow.SkillsID.MYSTICISM

		else  -- return the highest skill
			return SpellsInfo.GetHighestSkillID({ SkillsWindow.SkillsID.MAGERY, SkillsWindow.SkillsID.SPELLWEAVING, SkillsWindow.SkillsID.NECROMANCY, SkillsWindow.SkillsID.MYSTICISM }, false)
		end
	
	elseif spellId == 745 then -- Boarding
		return SkillsWindow.SkillsID.ANIMAL_TAMING -- taming

	elseif spellId == 743 then -- Whispering
		return SkillsWindow.SkillsID.ANIMAL_TAMING -- taming

	elseif spellId == 744 then -- Combat Training
		return SkillsWindow.SkillsID.ANIMAL_TAMING -- taming

	elseif spellId == 739 then -- Potency
		return SkillsWindow.SkillsID.POISONING -- poisoning

	elseif spellId == 737 then -- Tolerance
		return SkillsWindow.SkillsID.POISONING -- poisoning

	elseif spellId == 738 then -- Injected Strike
		return SkillsWindow.SkillsID.POISONING -- poisoning

	elseif spellId == 705 then -- Tribulation
		return SkillsWindow.SkillsID.DISCORDANCE -- discordance

	elseif spellId == 706 then -- Despair
		return SkillsWindow.SkillsID.DISCORDANCE -- discordance

	elseif spellId == 703 then -- Resilience
		return SkillsWindow.SkillsID.PEACEMAKING -- peacemaking

	elseif spellId == 704 then -- Perseverance
		return SkillsWindow.SkillsID.PEACEMAKING -- peacemaking

	elseif spellId == 701 then -- Inspire
		return SkillsWindow.SkillsID.PROVOCATION -- provocation

	elseif spellId == 702 then -- Invigorate
		return SkillsWindow.SkillsID.PROVOCATION -- provocation
	end
end

function SpellsInfo.GetMaxSpells(objectType) 
	if (objectType == 3834) then-- Magery 
		return 64
	elseif (objectType == 8787) then -- Necromancy
		return 17
	elseif (objectType == 8786) then -- Chivalry
		return 10
	elseif (objectType == 9100) then -- Bushido
		return 6
	elseif (objectType == 9120) then -- Ninjitsu
		return 8
	elseif (objectType == 11600) then -- Spellweaving
		return 16
	elseif (objectType == 11677) then -- Mysticism
		return 16
	end
end

function SpellsInfo.GetSpellDamage(spellId) 
	local skillId = 0
	local skillIdsec = 0
	local skillIdthi= 0
	local itemSDI = tonumber(WindowData.PlayerStatus["SpellDamageIncrease"])
	local int = tonumber(WindowData.PlayerStatus["Intelligence"]) 
	local intSDI = math.ceil(tonumber(WindowData.PlayerStatus["Intelligence"]) / 10)
	
	local inscribeSkillLevel = GetSkillValue(SkillsWindow.SkillsID.INSCRIPTION, true)
	local inscribeSDI = 0
	if (inscribeSkillLevel >= 100) then
		inscribeSDI = 10
	end
	
	local sdiit = ((intSDI + inscribeSDI + itemSDI) / 100) + 1
	
	local str = L""
	if (spellId >= 1 and spellId <= 64) then-- Magery 
		skillId = SkillsWindow.SkillsID.MAGERY -- magery
		skillIdsec = SkillsWindow.SkillsID.EVAL_INTELLIGENCE -- eval int
		
		local mainSkillLevel = GetSkillValue(skillId, true)
		local secondSkillLevel = GetSkillValue(skillIdsec, true)

		local evalSDI = ((secondSkillLevel * 3) / 100) + 1
		
		if (spellId == 5) then -- magic arrow
			
			local min = 3.1
			local max = 4.1
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 12) then -- harm
			
			local min = 5.2
			local max = 6.6
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154877), { min .. L" - " .. max .. GetStringFromTid(1154882)})
		elseif (spellId == 18) then -- fireball
			
			local min = 6
			local max = 7.2
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 30) then -- lightning
			
			local min = 6.9
			local max = 8
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154876), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 37) then -- mind blast
			
			local min = 6.9
			local max = 8
			min = math.floor(min + (mainSkillLevel + int) / 5)
			max = math.floor(max + (mainSkillLevel + int) / 5)
			str = ReplaceTokens(GetStringFromTid(1154877), { min .. L" - " .. max .. GetStringFromTid(1154882)})
		elseif (spellId == 42) then -- energy bolt
			
			local min = 12
			local max = 13.4
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154876), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 43) then -- explosion
			
			local min = 12
			local max = 13.4
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 49) then -- chain lightning
			
			local min = 15.5
			local max = 16.8
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. GetStringFromTid(1154881)})
		elseif (spellId == 51) then -- flamestrike
			
			local min = 12
			local max = 13.4
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 55) then -- Meteor swarm
			
			local min = 12
			local max = 13.4
			min = math.floor((min * evalSDI) * sdiit)
			max = math.floor((max * evalSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. GetStringFromTid(1154881)})
		elseif (spellId == 57) then -- hearthquake
			
			local min = 19
			local max = 21.2
			min = math.floor(min * evalSDI)
			max = math.floor(max * evalSDI)
			str = ReplaceTokens(GetStringFromTid(1154879), { min .. L" - " .. max .. GetStringFromTid(1154880)})
		end
		
	elseif (spellId >= 101 and spellId <= 200) then -- Necromancy
		skillId = SkillsWindow.SkillsID.NECROMANCY -- necromancy
		skillIdsec = SkillsWindow.SkillsID.SPIRIT_SPEAK -- spirit speak

	elseif (spellId >= 201 and spellId <= 300) then -- Chivalry
		skillId = SkillsWindow.SkillsID.CHIVALRY -- chivalry

	elseif (spellId >= 401 and spellId <= 500) then -- Bushido
		skillId = SkillsWindow.SkillsID.BUSHIDO -- bushido

	elseif (spellId >= 501 and spellId <= 600) then	-- Ninjitsu
		skillId = SkillsWindow.SkillsID.NINJITSU

	elseif (spellId >= 601 and spellId <= 677) then -- Spellweaving
		skillId = SkillsWindow.SkillsID.SPELLWEAVING

		local sw = GetSkillValue(skillId, true)
		
		local circle = Interface.ArcaneFocusLevel
		if (spellId == 605) then -- thunderstorm
			local min = math.max(11, 10 + (sw / 24)) + circle
			min = math.floor(min * sdiit)
			str = L"<BR>Energy Damage: " .. min .. L"<BR>"
		elseif (spellId == 611) then -- essence of wind
			local min = 25 + circle
			min = math.floor(min * sdiit)
			str = L"<BR>Cold Damage: " .. min .. L"<BR>"
		elseif (spellId == 614) then -- Word of Death
			local min = math.max((sw / 24), 1) + 4
			min = math.floor(min * sdiit)
			
			str = L"<BR>Chaos Damage: " .. min .. L"<BR>"
			local amount = circle * 5
			if (amount <=0) then
				amount =5 
			end
			min = 300
			min = math.floor(min * sdiit)
			str = str .. ReplaceTokens(GetStringFromTid(1154874), {towstring(amount), towstring(min)}) .. L"<BR>"
		end
		
		
	elseif (spellId >= 678 and spellId <= 700) then -- Mysticism
		skillId = SkillsWindow.SkillsID.MYSTICISM
		skillIdsec = SkillsWindow.SkillsID.IMBUING -- imbuing
		skillIdthi= SkillsWindow.SkillsID.FOCUS -- focus
		
		local mainSkillLevel = GetSkillValue(skillId, true)
		local secondSkillLevel = GetSkillValue(skillIdsec, true)
		local tempSkillLevel = GetSkillValue(skillIdthi, true)

		secondSkillLevel = math.max(tempSkillLevel,secondSkillLevel)
		
		local Perc = 412.5
        local focusSDI = (((Perc / 120) * secondSkillLevel) / 100) + 1
        if (spellId == 678) then -- nether bolt
			
			local min = 3.1
			local max = 4.1
			min = math.floor((min * focusSDI) * sdiit)
			max = math.floor((max * focusSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154875), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 683) then -- eagle strike
			
			local min = 5.0
			local max = 6.6
			min = math.floor((min * focusSDI) * sdiit)
			max = math.floor((max * focusSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154876), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 689) then -- bombard
			
			local min = 10
			local max = 12.2
			min = math.floor((min * focusSDI) * sdiit)
			max = math.floor((max * focusSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154878), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 691) then -- hail storm
			
			local min = 12
			local max = 14
			min = math.floor((min * focusSDI) * sdiit)
			max = math.floor((max * focusSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154877), { min .. L" - " .. max .. L"<BR>"})
		elseif (spellId == 692) then -- Nether cyclone
			
			local min = 12
			local max = 14
			min = math.floor((min * focusSDI) * sdiit)
			max = math.floor((max * focusSDI) * sdiit)
			str = ReplaceTokens(GetStringFromTid(1154875), { min .. L" - " .. max .. L"<BR>"})
		end
	end
	return str
end

function SpellsInfo.GetRecoverySpeed()
	local fcr = 	tonumber(WindowData.PlayerStatus["FasterCastRecovery"])
	return 1.5 - (0.25 * fcr)
end

function SpellsInfo.GetSpellSpeed(spellId)

	if not IsValidID(spellId) then
		return 0
	end

	local magery = GetSkillValue(SkillsWindow.SkillsID.MAGERY, true)
	local mysticism = GetSkillValue(SkillsWindow.SkillsID.MYSTICISM, true)
	local forceCap = false
	if (magery >=70 or mysticism >=70) then
		forceCap = true
	end
	
	local fc = 	tonumber(WindowData.PlayerStatus["FasterCasting"])
	if not WindowData.PlayerStatus["FasterCasting"] then
		fc = 0
	end

	local speed = nil
	if (spellId >= 1 and spellId <= 8) then-- Magery 
		speed = 0.5
		forceCap = true
	elseif (spellId >= 9 and spellId <= 16) then-- Magery 
		speed = 0.75
		forceCap = true
	elseif (spellId >= 17 and spellId <= 24) then-- Magery 
		speed = 1
		forceCap = true
	elseif (spellId >= 25 and spellId <= 32) then-- Magery 
		speed = 1.25
		forceCap = true
	elseif (spellId >= 33 and spellId <= 40) then-- Magery 
		if (spellId == 33) then
			speed = 5
			forceCap = false
		else
			speed = 1.5
			forceCap = true
		end
		
	elseif (spellId >= 41 and spellId <= 48) then-- Magery 
		speed = 1.75
		forceCap = true
	elseif (spellId >= 49 and spellId <= 56) then-- Magery 
		speed = 2
		forceCap = true
	elseif (spellId >= 57 and spellId <= 64) then-- Magery 
		speed = 2
		forceCap = true
		
	elseif (spellId == 104 or spellId == 109 or spellId == 105) then -- Necromancy
		speed = 1
		forceCap = true
	elseif (spellId == 102 or spellId == 108 or spellId == 101 or spellId == 115) then -- Necromancy
		speed = 1.5
		forceCap = true
	elseif (spellId == 103 or spellId == 110 or spellId == 117) then -- Necromancy
		speed = 2
		forceCap = true
	elseif (spellId == 111) then -- Necromancy
		speed =2.5
		forceCap = true
	elseif (spellId == 116 or spellId == 112 or spellId == 106 or spellId == 107 or spellId == 113 or spellId == 114) then -- Necromancy
		speed = 4
		forceCap = true
		
	elseif (spellId == 601) then -- Spellweaving
		speed = 0.5
	elseif (spellId == 602 or spellId == 611 or spellId == 612) then -- Spellweaving
		speed = 3
	elseif (spellId == 603 or spellId == 604) then -- Spellweaving
		speed = 1
	elseif (spellId == 605 or spellId == 606) then -- Spellweaving
		speed = 1.5
	elseif (spellId == 607 or spellId == 608) then -- Spellweaving
		speed = 2
	elseif (spellId == 609 or spellId == 610) then -- Spellweaving
		speed = 2.5
	elseif (spellId == 613 or spellId == 614) then -- Spellweaving
		speed = 3.5
	elseif (spellId == 615 or spellId == 616) then -- Spellweaving
		speed = 4
	elseif (spellId == 204) then -- Chivalry
		speed = 0.25
	elseif (spellId == 203 or spellId == 204 or spellId == 206) then -- Chivalry
		speed = 0.5
	elseif (spellId == 201 or spellId == 205) then -- Chivalry
		speed = 1.0
	elseif (spellId == 202 or spellId == 208 or spellId == 209 or spellId == 210) then -- Chivalry
		speed = 1.5
	elseif (spellId == 207) then -- Chivalry
		speed = 1.75
	elseif (spellId == 678) then -- Mysticism
		speed = 0.5
		forceCap = true
	elseif (spellId >= 680 and spellId <= 681) then -- Mysticism
		speed = 0.75
		forceCap = true
	elseif (spellId >= 682 and spellId <= 683) then -- Mysticism
		speed = 1
		forceCap = true
	elseif (spellId >= 684 and spellId <= 685) then -- Mysticism
		speed = 1.25
		forceCap = true
	elseif (spellId == 679 or spellId == 686) then
		speed = 5.5
		forceCap = true
	elseif (spellId == 687) then -- Mysticism
		speed = 1.5
		forceCap = true
	elseif (spellId >= 688 and spellId <= 689) then -- Mysticism
		speed = 1.75
		forceCap = true
	elseif (spellId >= 690 and spellId <= 691) then -- Mysticism
		speed = 2
		forceCap = true
	elseif (spellId >= 692 and spellId <= 693) then -- Mysticism
		speed = 2.25
		forceCap = true
		
	elseif (spellId == 402) then -- Bushido
		speed = 0.5
		forceCap = false
	elseif (spellId == 403) then -- Bushido
		speed = 0.25
		forceCap = false
	elseif (spellId == 404) then -- Bushido
		speed = 0.25
		forceCap = false
		
	elseif (spellId == 503) then -- Ninjitsu
		speed = 1.5
		forceCap = false
	elseif (spellId == 507) then -- Ninjitsu
		speed = 1.0
		forceCap = false
	elseif (spellId == 508) then -- Ninjitsu
		speed = 1.5
		forceCap = false

	elseif (spellId > 700) then -- Masteries
		speed = 1.5
		forceCap = false
	end
	
	if (forceCap and fc >= 2) then
		fc = 2
	end
	local itemFC = fc * 0.25
	
	
	if (speed and itemFC > 0) then
		speed = speed - itemFC
		if (speed < 0.25) then
			speed = 0.25
		end
	end
	return speed 
end

function SpellsInfo.SumonFamiliarSkillRequirements(animalTid) -- 0 = DOABLE, 1 = CANT DO IT

	local SkillLevel = GetSkillValue(SkillsWindow.SkillsID.NECROMANCY, true)
	local race = GetMobileRace(GetPlayerID())
	if race == PaperdollWindow.HUMAN and SkillLevel < 20 then
		SkillLevel = 20
	end
	
	local SkillSecondary = GetSkillValue(SkillsWindow.SkillsID.SPIRIT_SPEAK, true)
	if race == PaperdollWindow.HUMAN and SkillSecondary < 20 then
		SkillSecondary = 20
	end
	
	if animalTid == 1 then
		if SkillLevel >= 30 and SkillSecondary >= 30 then
			return 0
		end
	elseif animalTid == 2 then
		if SkillLevel >= 50 and SkillSecondary >= 50 then
			return 0
		end
	elseif animalTid == 3 then
		if SkillLevel >= 60 and SkillSecondary >= 60 then
			return 0
		end
	elseif animalTid == 4 then
		if SkillLevel >= 80 and SkillSecondary >= 80 then
			return 0
		end
	elseif animalTid == 5 then
		if SkillLevel >= 100 and SkillSecondary >= 100 then
			return 0
		end
	end
	return 1
end

function SpellsInfo.AnimalFormSkillRequirements(animalTid) -- 0 = DOABLE, 1 = CANT DO IT
	local SkillLevel = GetSkillValue(SpellsInfo.GetSkillID(503), true)
	local race = GetMobileRace(GetPlayerID())
	if race == PaperdollWindow.HUMAN and SkillLevel < 20 then
		SkillLevel = 20
	end

	local taliId = GetTalismanID()
	local taliName
	if taliId ~= 0 then
		taliName = wstring.lower(GetItemName(taliId))
	end
	
	if animalTid == 1028485 then
		if SkillLevel >= 0 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1028483 then
		if SkillLevel >= 20 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1075971 then

		if SkillLevel >= 20 and taliName and taliName == wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1075971))})) then
			return 0
		else
			return 1
		end
	elseif animalTid == 1018280 then
		if SkillLevel >= 40 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1018264 then
		if SkillLevel >= 40 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1075972 then
		if SkillLevel >= 40 and taliName and taliName == wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1075972))})) then
			return 0
		else
			return 1
		end
	elseif animalTid == 1028496 then
		if SkillLevel >= 50 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1018114 then
		if SkillLevel >= 50 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1031670 then
		if SkillLevel >= 60 and taliName and taliName == wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1031670))})) then
			return 0
		else
			return 1
		end
	elseif animalTid == 1028438 then
		if SkillLevel >= 70 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1018273 then
		if SkillLevel >= 70 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1030083 then
		if SkillLevel >= 85 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1028482 then
		if SkillLevel >= 85 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1075202 then
		if SkillLevel >= 90 and taliName and taliName == wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1075202))})) then
			return 0
		else
			return 1
		end
	elseif animalTid == 1029632 then
		if SkillLevel > 100 then
			return 0
		else
			return 1
		end
	elseif animalTid == 1018214 then
		if SkillLevel > 100 then
			return 0
		else
			return 1
		end
	end

end

-- Spell Trigger
function SpellsInfo.GetSpellTriggerButtonID(buttonId) -- 0 = force manual selection
	local spellId = 676 + buttonId
	local icon, serverId, tid, desctid, reagents, powerword, tithingcost, minskill, manacost  = GetAbilityData(spellId)
	skillId = SkillsWindow.SkillsID.MYSTICISM -- mysticism
	skillIdsec = SkillsWindow.SkillsID.IMBUING -- imbuing
	skillIdthi= SkillsWindow.SkillsID.FOCUS -- focus
	
	local mainSkillLevel = GetSkillValue(skillId, true)
	local secondSkillLevel = GetSkillValue(skillIdsec, true)
	local tempSkillLevel = GetSkillValue(skillIdthi, true)

	secondSkillLevel = math.max(tempSkillLevel,secondSkillLevel)
	local cando = 1
	if minskill <= 20 or (minskill <= mainSkillLevel and minskill <= secondSkillLevel) then
		return buttonId
	else
		return 0
	end
end

-- ANimal Form
function SpellsInfo.GetAnimalFormButtonID(animalTid) -- 0 = force manual selection
	local SkillLevel = GetSkillValue(SpellsInfo.GetSkillID(503), true)
	if GetMobileRace(GetPlayerID()) == PaperdollWindow.HUMAN and SkillLevel < 20 then
		SkillLevel = 20
	end

	local taliId = GetTalismanID()
	local taliName
	if taliId ~= 0 then
		taliName = wstring.lower(GetItemName(taliId))
	end
	
	-- 1 = cancel
	-- 2+ = trasformazioni
	-- 12 = next
	
	if animalTid == 1028485 then
		if SkillLevel < 20 then
			return 2
		elseif SkillLevel < 40 then
			return 3
		elseif SkillLevel < 50 then
			return 5
		elseif SkillLevel < 70 then
			return 7
		elseif SkillLevel < 85 then
			return 9
		elseif SkillLevel < 100 then
			return 11
		elseif SkillLevel >= 100 then
			return 15
		end
	elseif animalTid == 1028483 then
		if SkillLevel < 40 then
			return 2
		elseif SkillLevel < 50 then
			return 4
		elseif SkillLevel < 70 then
			return 6
		elseif SkillLevel < 85 then
			return 8
		elseif SkillLevel < 100 then
			return 10
		elseif SkillLevel >= 100 then
			return 14
		end
		
	elseif animalTid == 1075971 then
		if not taliName or taliName ~= wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1075971))})) then
			return 0
		end
		if SkillLevel < 40  then
			return 4
		elseif SkillLevel < 50 then
			return 6
		elseif SkillLevel < 70 then
			return 8
		elseif SkillLevel < 85 then
			return 10
		elseif SkillLevel < 100 then
			return 14
		elseif SkillLevel >= 100 then
			return 16
		end
		
	elseif animalTid == 1018280 then
		if SkillLevel < 50 then
			return 2
		elseif SkillLevel < 70 then
			return 4
		elseif SkillLevel < 85 then
			return 6
		elseif SkillLevel < 100 then
			return 8
		elseif SkillLevel >= 100 then
			return 10
		end
	elseif animalTid == 1018264 then
		if SkillLevel < 50 then
			return 3
		elseif SkillLevel < 70 then
			return 5
		elseif SkillLevel < 85 then
			return 7
		elseif SkillLevel < 100 then
			return 9
		elseif SkillLevel >= 100 then
			return 11
		end
		
	elseif animalTid == 1075972 then
		if not taliName or taliName ~= wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1075972))})) then
			return 0
		end
		if SkillLevel < 50 then
			return 6
		elseif SkillLevel < 70 then
			return 8
		elseif SkillLevel < 85 then
			return 10
		elseif SkillLevel < 100 then
			return 14
		elseif SkillLevel >= 100 then
			return 16
		end
		
	elseif animalTid == 1028496 then
		if SkillLevel < 70 then
			return 2
		elseif SkillLevel < 85 then
			return 4
		elseif SkillLevel < 100 then
			return 6
		elseif SkillLevel >= 100 then
			return 8
		end
	elseif animalTid == 1018114 then
		if SkillLevel < 70 then
			return 3
		elseif SkillLevel < 85 then
			return 5
		elseif SkillLevel < 100 then
			return 7
		elseif SkillLevel >= 100 then
			return 9
		end
		
	elseif animalTid == 1031670 then
		if not taliName or taliName ~= wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1031670))})) then
			return 0
		end
		if SkillLevel < 70  then
			return 8
		elseif SkillLevel < 85 then
			return 10
		elseif SkillLevel < 100 then
			return 14
		elseif SkillLevel >= 100 then
			return 16
		end
		
	elseif animalTid == 1028438 then
		if SkillLevel < 85 then
			return 2
		elseif SkillLevel < 100 then
			return 4
		elseif SkillLevel >= 100 then
			return 6
		end
	elseif animalTid == 1018273 then
		if SkillLevel < 85 then
			return 3
		elseif SkillLevel < 100 then
			return 5
		elseif SkillLevel >= 100 then
			return 7
		end
		
	elseif animalTid == 1030083 then
		if SkillLevel < 100 then
			return 2
		elseif SkillLevel >= 100 then
			return 4
		end
	elseif animalTid == 1028482 then
		if SkillLevel < 100 then
			return 3
		elseif SkillLevel >= 100 then
			return 5
		end
	
	elseif animalTid == 1075202 then
		if not taliName or taliName ~= wstring.lower(ReplaceTokens(GetStringFromTid(1075200), {FormatProperly(GetStringFromTid(1075202))})) then
			return 0
		end
		if SkillLevel < 100 then
			return 14
		elseif SkillLevel >= 100 then
			return 16
		end
		
	elseif animalTid == 1029632 then
		if SkillLevel >= 100 then
			return 2
		end
	elseif animalTid == 1018214 then
		if SkillLevel >= 100 then
			return 3
		end
	end

	return 0
end

function SpellsInfo.GetSpellSkills(spellId)
	
	-- is a valid spell id?
	if not IsValidID(spellId) then
		return
	end

	-- initialize array to return
	local returnArray = {}

	-- initialize skills id
	local skillId = SpellsInfo.GetSkillID(spellId) -- get the primary skill id
	local skillIdsec = 0
	local skillIdthi = 0

	-- getting the secondary skills ids
	if skillId == SkillsWindow.SkillsID.MAGERY then-- Magery 
		skillIdsec = SkillsWindow.SkillsID.EVAL_INTELLIGENCE -- eval int

	elseif skillId == SkillsWindow.SkillsID.NECROMANCY then -- Necromancy
		skillIdsec = SkillsWindow.SkillsID.SPIRIT_SPEAK -- spirit speak

	elseif skillId == SkillsWindow.SkillsID.MYSTICISM then -- Mysticism
		skillIdsec = SkillsWindow.SkillsID.IMBUING -- imbuing
		skillIdthi= SkillsWindow.SkillsID.FOCUS -- focus
	end

	-- default min skill value
	local minSkill = 0

	-- if the player is a human the default min skill is 20
	if GetMobileRace(GetPlayerID()) == PaperdollWindow.HUMAN then
		minSkill = 20
	end

	-- filling the array with the main skill and its value
	if IsValidID(skillId) then
		
		-- getting the skill value
		local skillValue = GetSkillValue(skillId, true)

		-- making sure the skill value is not less than the min possible value
		if skillValue < minSkill then
			skillValue = minSkill
		end

		-- adding the record to the array
		returnArray[1] = {skillId = skillId, skillValue = skillValue }
	end

	-- filling the array with the secondary skill and its value
	if IsValidID(skillIdsec) then

		-- getting the skill value
		local skillValue = GetSkillValue(skillIdsec, true)

		-- making sure the skill value is not less than the min possible value
		if skillValue < minSkill then
			skillValue = minSkill
		end

		-- adding the record to the array
		returnArray[2] = { skillId = skillIdsec, skillValue = skillValue }
	end

	-- filling the array with the third skill and its value
	if IsValidID(skillIdthi) then
	
		-- getting the skill value
		local skillValue = GetSkillValue(skillIdthi, true)

		-- making sure the skill value is not less than the min possible value
		if skillValue < minSkill then
			skillValue = minSkill
		end

		-- adding the record to the array
		returnArray[3] = {skillId = skillIdthi, skillValue = skillValue}
	end

	return returnArray
end

function SpellsInfo.CanUseSpell(spellId, spellTriggerCheck)
	
	-- is a valid spell id?
	if not IsValidID(spellId) then
		return
	end

	-- getting the spell info
	local _, _, _, _, _, _, _, minskill, manacost = GetAbilityData(spellId)

	-- do we have a min skill?
	if not IsValidID(minskill) then
		
		-- getting it from the spellsinfo
		minskill = SpellsInfo.GetMinSkill(spellId)

		-- if we still don't have it, we set 0 by default
		if not IsValidID(minskill) then
			minskill = 0
		end
	end

	-- getting the skills for the current spell
	local skills = SpellsInfo.GetSpellSkills(spellId)

	-- initializing the skill values to 0
	local mainSkillLevel = 0
	local secondSkillLevel = 0
	local thirdSkillLevel = 0

	-- loading the skills level in the variables
	if skills[1] then
		mainSkillLevel = skills[1].skillValue
	end

	if skills[2] then
		secondSkillLevel = skills[2].skillValue
	end

	if skills[3] then
		thirdSkillLevel = skills[3].skillValue
	end

	-- determining which one of the secondary skills is higher (only 1 can be taken into account)
	secondSkillLevel = math.max(thirdSkillLevel, secondSkillLevel)

	-- recall usable if wraith form is active
	if spellId == 32 and (mainSkillLevel < minskill and BuffDebuff.ActiveBuffs[1124]) then 
		return true
	end

	-- for spell trigger spells we much check primary and secondary skill
	if spellTriggerCheck then

		-- if the players skills are greater than the min skill, he can use the spell, otherwise no.
		if (mainSkillLevel >= minskill and secondSkillLevel >= minskill) then
			return true
		end

	else -- we check only the primary skill
		
		-- if the players main skill is greater than the requirement then he can use the spell
		if (mainSkillLevel >= minskill) then

			-- for summon familiar is required at least 30 in spirit speak
			if spellId == 112 and secondSkillLevel < 30 then
				return false

			-- for exorcism is required at least 100 in spirit speak
			elseif spellId == 117 and secondSkillLevel < 100 then
				return false
			end

			return true
		end

	end

	return false
end

function SpellsInfo.SpellEnabled(spellId, targetType)
	
	-- is a valid spell id?
	if not IsValidID(spellId) then
		return false
	end
	
	-- if no target type is specified we set target cursor as default
	if not targetType then
		targetType = SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR
	end

	-- initialize out of range on false by default
	local outOfRange = false

	-- we check for distance only on current target and only if we have a current target and if we have a range for the spell
	if IsValidID(TargetWindow.TargetId) and targetType == SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT then
		
		-- initialize the spell max range
		local distance = SpellsInfo.GetSpellDistance(spellId) or -1
		
		-- do we have a distance?
		if (distance and distance >= 0) then

			-- do we have a mobile as current target?
			if (TargetWindow.TargetType == TargetWindow.MobileType) then
			
				-- if the current target is out of range, then is out of range
				if GetDistanceFromPlayer(TargetWindow.TargetId) > distance then
					outOfRange = true
				end
			end
		end
	end

	-- getting the info about the spell
	local _, _, _, _, _, _, _, minskill, manacost  = GetAbilityData(spellId)

	-- initialize the mana variable
	local lmcMana = nil

	-- if we have the spell mana cost and the player lower mana cost value, we apply that to get the correct mana cost					
	if manacost and WindowData.PlayerStatus and WindowData.PlayerStatus["LowerManaCost"] then
		
		-- applying lmc
		lmcMana = math.ceil(manacost - (manacost * (tonumber(WindowData.PlayerStatus["LowerManaCost"]) / 100)))
	end

	-- mana phase buff set mana cost to 0
	if BuffDebuff.ActiveBuffs[1104] then
		lmcMana = 0
	end

	-- mastery spell
	if spellId > 700 then
	
		-- get the skill id for this mastery
		local skillId = SpellsInfo.GetSkillID(spellId) 

		-- is the right mastery active?
		if Spellbook.ActiveMastery ~= SpellsInfo.MasterySkillTID[skillId] then
			return false, SpellsInfo.DisabledReason.WRONG_MASTERY
		end
	end

	local isSummon, slots = SpellsInfo.IsSummonSpell(spellId)

	-- lack skills
	if not SpellsInfo.CanUseSpell(spellId) then
		return false, SpellsInfo.DisabledReason.LACK_REQUIREMENTS

	-- player is dead
	elseif Interface.IsPlayerDead then
		return false, SpellsInfo.DisabledReason.PLAYER_DEAD

	-- not enough mana
	elseif lmcMana and WindowData.PlayerStatus and tonumber(WindowData.PlayerStatus["CurrentMana"]) < lmcMana then
		return false, SpellsInfo.DisabledReason.LOW_MANA, lmcMana

	-- is this a summon ad do we have enough pet slots?
	elseif isSummon and (WindowData.PlayerStatus["Followers"] + slots > WindowData.PlayerStatus["MaxFollowers"]) then
		return false, SpellsInfo.DisabledReason.TOO_MANY_FOLLOWERS 
		
	-- you are flying and transformations are disabled
	elseif (spellId == 56 or spellId == 106 or spellId == 107 or spellId == 116 or spellId == 609 or spellId == 613 or spellId == 685 or spellId == 508 ) and BuffDebuff.ActiveBuffs[1054] then 
		return false, SpellsInfo.DisabledReason.CANT_USE_WHILE_FLYING 

	-- attunement is already active
	elseif spellId == 604 and BuffDebuff.Timers[1021] then 
		return false, SpellsInfo.DisabledReason.ALREADY_IN_EFFECT
	
	-- ethereal voyage is already active
	elseif spellId == 613 and BuffDebuff.Timers[1024] then 
		return false, SpellsInfo.DisabledReason.ALREADY_IN_EFFECT
	
	-- enchant is already active
	elseif spellId == 681 and BuffDebuff.Timers[1091] then 
		return false, SpellsInfo.DisabledReason.ALREADY_IN_EFFECT

	-- player is paralyzed
	elseif IsPlayerParalyzed() then
		return false, SpellsInfo.DisabledReason.PLAYER_PARALYZED

	-- still recoverying
	elseif Interface.SpellRecovery > 0 and Interface.Settings.DisableButtonsWhileCast then
		return false, SpellsInfo.DisabledReason.PLAYER_RECOVERYING

	-- player is casting
	elseif Interface.CurrentSpell.casting and Interface.Settings.DisableButtonsWhileCast then
		return false, SpellsInfo.DisabledReason.PLAYER_CASTING

	-- target out of range
	elseif outOfRange then
		return false, SpellsInfo.DisabledReason.OUT_OF_RANGE
	end
	
	return true
end

function SpellsInfo.IsSummonSpell(spellId)

	if (spellId == 33) then -- Blade Spirits
		return true, 0
	elseif (spellId == 58) then -- energy vortex
		return true, 0
	elseif (spellId == 60) then -- Air Elemental
		return true, 2
	elseif (spellId == 61) then -- Summon Daemon
		return true, 4
	elseif (spellId == 62) then -- Earth Elemental
		return true, 2
	elseif (spellId == 63) then -- Fire Elemental
		return true, 4
	elseif (spellId == 64) then -- Water Elemental
		return true, 3

	elseif (spellId == 114) then -- Vengeful Spirit
		return true, 0

	elseif (spellId == 508) then -- Mirror Image
		return true, 1

	elseif (spellId == 606) then -- Nature's Fury
		return true, 0
	elseif (spellId == 607) then -- Summon Fey
		return true, 1
	elseif (spellId == 608) then -- Summon Fiend
		return true, 1

	elseif (spellId == 684) then -- Animated Weapon
		return true, 0
	elseif (spellId == 693) then -- Rising Colossus
		return true, 0
	end

	return false
end

function SpellsInfo.GetMasterySpellCooldown(spellId)
	
	-- is a valid spell id?
	if not IsValidID(spellId) then
		return
	end

	-- have the masteries been initialized?
	if not Spellbook.MyMasteries then

		-- flag to check the mastery book
		Spellbook.MasteryGumpCheck = true

		return
	end

	-- whispering
	if spellId == 743 then
		
		-- do we have the tier level?
		if Spellbook.MyMasteries[1155785] then -- Animal Taming Mastery

			-- get the mastery tier
			local masteryTier = Spellbook.MyMasteries[1155785] -- Animal Taming Mastery

			-- the cooldown for whispering is tier based
			if masteryTier == 1 then
				return 4200 -- 70 minutes

			elseif masteryTier == 2 then
				return 3000 -- 50 minutes

			elseif masteryTier == 3 then
				return 1800 -- 30 minutes
			end
		end

	-- ethereal burst
	elseif spellId == 708 then

		-- do we have the tier level?
		if Spellbook.MyMasteries[1155771] then -- Magery Mastery
			
			-- get the mastery tier
			local masteryTier = Spellbook.MyMasteries[1155771] -- Magery Mastery

			-- base cooldown
			local baseCD

			-- first we get the base cooldown based on the mastery tier
			if masteryTier == 1 then
				baseCD = 21600 -- 6 hours

			elseif masteryTier == 2 then
				baseCD = 14400 -- 4 hours

			elseif masteryTier == 3 then
				baseCD = 7200 -- 2 hours
			end

			-- now we get magery and eval int real values
			local magery = GetSkillValue(SkillsWindow.SkillsID.MAGERY, false)
			local evalInt = GetSkillValue(SkillsWindow.SkillsID.EVAL_INTELLIGENCE, false)

			-- fist part: we get the result of this formula
			local result = ((magery - 90) * 2) + (evalInt - 90)

			-- is the result > than 0?
			if result > 0 then
				
				-- we get the modulo of 30 of the result 
				local mod = result % 30

				-- we remove the modulo from the result
				result = result - mod

				-- now we subtract the final result (converted in seconds) from the base cooldown and obtain the real cooldown.
				result = baseCD - (result * 60)

				return result

			else -- if the result is negative or equal to 0, we just return the base cooldown

				return baseCD
			end
		end

	-- rejuvenate
	elseif spellId == 719 then

		-- do we have the tier level?
		if Spellbook.MyMasteries[1155776] then -- Chivalry Mastery

			-- get the mastery tier
			local masteryTier = Spellbook.MyMasteries[1155776] -- Chivalry Mastery

			-- base cooldown
			local baseCD

			-- first we get the base cooldown based on the mastery tier
			if masteryTier == 1 then
				baseCD = 21600 -- 6 hours

			elseif masteryTier == 2 then
				baseCD = 14400 -- 4 hours

			elseif masteryTier == 3 then
				baseCD = 7200 -- 2 hours
			end

			-- now we get chivalry and the highest weapon skill real values
			local chivalry = GetSkillValue(SkillsWindow.SkillsID.CHIVALRY, false)
			local weaponSkill = GetSkillValue(SpellsInfo.GetHighestSkillID({ SkillsWindow.SkillsID.SWORDSMANSHIP, SkillsWindow.SkillsID.MACE_FIGHTING, SkillsWindow.SkillsID.FENCING, SkillsWindow.SkillsID.ARCHERY, SkillsWindow.SkillsID.THROWING }, false), false) -- weapon skill (swords, mace, fencing, archery, throwing)

			-- fist part: we get the result of this formula
			local result = ((chivalry - 90) * 2) + (weaponSkill - 90)

			-- is the result > than 0?
			if result > 0 then
				
				-- we get the modulo of 30 of the result 
				local mod = result % 30

				-- we remove the modulo from the result
				result = result - mod

				-- now we subtract the final result from the base cooldown and obtain the real cooldown.
				result = baseCD - (result * 60)

				-- for rejuvenate is the same procedure of ethereal burst, but the result is doubled at the end
				return result * 2

			else -- if the result is negative or equal to 0, we just return the base cooldown

				-- for rejuvenate is the same procedure of ethereal burst, but the result is doubled at the end
				return baseCD * 2
			end
		end
	end
end

function SpellsInfo.GetSpellDistance(spellId)
	
	-- get spell data from the buffer
	local data = Interface.AbilitiesDataBuffer[spellId]

	-- do we have the data and the spell has a range?
	if data and data.hasRange ~= nil then

		-- if the spell has a range we return the value
		if data.hasRange == true then
			return data.range

		else -- the spell don't have a range
			return
		end
	end

	-- make sure the data has been initialized
	if not SpellsInfo.SpellsData then
		SpellsInfo.Initialize()
	end

	-- getting the range for the spell
	for _, value in pairs(SpellsInfo.SpellsData) do
		if value.id == spellId then
			return value.distance
		end
	end
end