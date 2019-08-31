AnimalLore = {}

AnimalLore.gumpID = 475

AnimalLore.CurrentCreature = {}
AnimalLore.AnimalLoreTamables = {}

AnimalLore.Ratings = {}
AnimalLore.MinTaming = 0

AnimalLore.TargetID = 0

AnimalLore.KnownPetsType = {}

AnimalLore.PetProgress = {}

AnimalLore.Highlight = 
{
	["Str"] = true,
	["Dex"] = true,
	["Stamina"] = true,
	["Int"] = true,
	["Mana"] = true,
	["Hits"] = true,

	["Physical"] = true,
	["Fire"] = true,
	["Cold"] = true,
	["Poison"] = true,
	["Energy"] = true,

	["Wrestling"] = true,
	["Magery"] = true,
	["Tactics"] = true,
	["EvalInt"] = true,
	["Anatomy"] = true,
	["Meditation"] = true,
	["ResSpell"] = true,
	["PoisHeal"] = true,
}

AnimalLore.AnimalLog = false

AnimalLore.Label_TextIDs = {}

AnimalLore.Label_TextIDs.Name = 1

AnimalLore.Label_TextIDs.TrainingLabel = 2

AnimalLore.Label_TextIDs.HitPoints = 2
AnimalLore.Label_TextIDs.Stamina = 3
AnimalLore.Label_TextIDs.Mana = 4

AnimalLore.Label_TextIDs.Str = 5
AnimalLore.Label_TextIDs.Dex = 6
AnimalLore.Label_TextIDs.Int = 7

AnimalLore.Label_TextIDs.BardingDifficulty = 8

AnimalLore.Label_TextIDs.HitPointsRegen = 9
AnimalLore.Label_TextIDs.StaminaRegen = 10
AnimalLore.Label_TextIDs.ManaRegen = 11

AnimalLore.Label_TextIDs.Physical = 12
AnimalLore.Label_TextIDs.Fire = 13
AnimalLore.Label_TextIDs.Cold = 14
AnimalLore.Label_TextIDs.Poison = 15
AnimalLore.Label_TextIDs.Energy = 16

AnimalLore.Label_TextIDs.PhysDam = 17
AnimalLore.Label_TextIDs.FireDam = 18
AnimalLore.Label_TextIDs.ColdDam = 19
AnimalLore.Label_TextIDs.PoisDam = 20
AnimalLore.Label_TextIDs.EnerDam = 21

AnimalLore.Label_TextIDs.BaseDamage = 22

AnimalLore.Label_TextIDs.Wrestling = 23
AnimalLore.Label_TextIDs.Tactics = 24
AnimalLore.Label_TextIDs.ResSpell = 25
AnimalLore.Label_TextIDs.Anatomy = 26
AnimalLore.Label_TextIDs.Healing = 27
AnimalLore.Label_TextIDs.Poisoning = 28
AnimalLore.Label_TextIDs.DetectHidden = 29
AnimalLore.Label_TextIDs.Hiding = 30
AnimalLore.Label_TextIDs.Parrying = 31

AnimalLore.Label_TextIDs.Magery = 32
AnimalLore.Label_TextIDs.EvalInt = 33
AnimalLore.Label_TextIDs.Meditation = 34
AnimalLore.Label_TextIDs.Necromancy = 35
AnimalLore.Label_TextIDs.SpiritSpeak = 36
AnimalLore.Label_TextIDs.Mysticism = 37
AnimalLore.Label_TextIDs.Focus = 38
AnimalLore.Label_TextIDs.Spellweaving = 39
AnimalLore.Label_TextIDs.Discordance = 40
AnimalLore.Label_TextIDs.Bushido = 41
AnimalLore.Label_TextIDs.Ninjitsu = 42
AnimalLore.Label_TextIDs.Chivalry = 43

AnimalLore.Label_TextIDs.PetSlots = 44

AnimalLore.Label_TextIDs.MainData = 1
AnimalLore.Label_TextIDs.Loyalty = 18

AnimalLore.Label_TextIDs.Food = 96
AnimalLore.Label_TextIDs.PackInstinct = 98
AnimalLore.Label_TextIDs.TamingRequired = 101 -- param for value

AnimalLore.DamageTypes = 
{
	["PhysDam"] = 1,
	["FireDam"] = 2,
	["ColdDam"] = 3,
	["PoisDam"] = 4,
	["EnerDam"] = 5,
}

AnimalLore.Regenerations = 
{ 
	["HitPointsRegen"] = true,
	["StaminaRegen"] = true,
	["ManaRegen"] = true,
}

AnimalLore.Resistances = 
{
	["Physical"] = 1,
	["Fire"] = 2,
	["Cold"] = 3,
	["Poison"] = 4,
	["Energy"] = 5,
}

-- flag indicates halved on tame
AnimalLore.SecondaryStats =
{ 
	["HitPoints"] = true,
	["Stamina"] = true,
	["Mana"] = false,
}

-- flag indicates halved on tame
AnimalLore.MainStats = 
{ 
	["Str"] = true,
	["Dex"] = true,
	["Int"] = false,
}

AnimalLore.StatsWeight = 
{ 
	["Str"] = 3.0,
	["Dex"] = 0.1,
	["Int"] = 0.5,
	["HitPoints"] = 3.0,
	["Stamina"] = 0.5,
	["Mana"] = 0.5,
	["HitPointsRegen"] = 18.0,
	["StaminaRegen"] = 12.0,
	["ManaRegen"] = 12.0,
	["Resist"] = 3.0,
}

AnimalLore.DBSkills = 
{
	["Wrestling"] = true,
	["Tactics"] = true,
	["ResSpell"] = true,
	["Anatomy"] = true,
	["Healing"] = true,
	["Poisoning"] = true,
	["Magery"] = true,
	["EvalInt"] = true,
	["Meditation"] = true,
}

AnimalLore.OutOfDBSkills = 
{
	["Parrying"] = true,
	["DetectHidden"] = true,
	["Hiding"] = true,
	["Bushido"] = true,
	["Ninjitsu"] = true,
	["Necromancy"] = true,
	["SpiritSpeak"] = true,
	["Mysticism"] = true,
	["Focus"] = true,
	["Spellweaving"] = true,
	["Discordance"] = true,
	["Chivalry"] = true,
}

AnimalLore.ResistancesToTid = 
{
	["Physical"] = 1079764,
	["Fire"] = 1079763,
	["Cold"] = 1079761,
	["Poison"] = 1079765,
	["Energy"] = 1079762,
}

AnimalLore.DamageToTid = 
{
	["PhysDam"] = 1151800,
	["FireDam"] = 1151801,
	["ColdDam"] = 1151802,
	["PoisDam"] = 1151803,
	["EnerDam"] = 1151804,
}

AnimalLore.StatsToTid = 
{
	["Str"] = 1061146,
	["Dex"] = 1061147,
	["Int"] = 1061148,
	["HitPoints"] = 3010051,
	["Stamina"] = 3010055,
	["Mana"] = 3010053,
	["HitPointsRegen"] = 1075627,
	["StaminaRegen"] = 1079411,
	["ManaRegen"] = 1079410,
}

AnimalLore.SkillsToTid = 
{
	["Wrestling"] = 1044103,
	["Tactics"] = 1044087,
	["ResSpell"] = 1044086,
	["Anatomy"] = 1044061,
	["Healing"] = 1044077,
	["Poisoning"] = 1044090,
	["Magery"] = 1044085,
	["EvalInt"] = 1044076,
	["Meditation"] = 1044106,
	["Parrying"] = 1044065,
	["DetectHidden"] = 1044074,
	["Hiding"] = 1044081,
	["Bushido"] = 1044112,
	["Ninjitsu"] = 1044113,
	["Necromancy"] = 1044109,
	["SpiritSpeak"] = 1044092,
	["Mysticism"] = 1044115,
	["Focus"] = 1044110,
	["Spellweaving"] = 1044114,
	["Discordance"] = 1044075,
	["Chivalry"] = 1044111,
}

AnimalLore.LoyaltyRatings = 
{
	[1061643] = "wild", -- Wild
	[1049595] = "confused", -- Confused
	[1049596] = "extermely_unhappy", -- Extremely Unhappy
	[1049597] = "rather_unhappy", -- Rather Unhappy
	[1049598] = "unhappy", -- Unhappy
	[1049599] = "content_Isuppose", -- Somewhat Content
	[1049600] = "content", -- Content
	[1049601] = "happy", -- Happy
	[1049602] = "rather_happy", -- Rather Happy
	[1049603] = "very_happy", -- Very Happy
	[1049604] = "extremely_happy", -- Extremely Happy
	[1049605] = "wonderfully_happy", -- Wonderfully Happy
	[1049606] = true, -- Euphoric
}

AnimalLore.PreferredFoods = 
{
	[3000340] = true, -- None
	[1049564] = true, -- Meat
	[1049565] = true, -- Fruits and Vegetables
	[1049566] = true, -- Grains and Hay
	[1049567] = true, -- Metal
	[1049568] = true, -- Fish
	[1044477] = true, -- Eggs
	[473] = true, -- Fruits and Vegetables and... Shoes!
}

AnimalLore.PackInstincts = 
{
	[3000340] = true, -- None
	[1049570] = true, -- Canine
	[1049571] = true, -- Ostard
	[1049572] = true, -- Feline
	[1049573] = true, -- Arachnid
	[1049574] = true, -- Daemon
	[1049575] = true, -- Bear
	[1049576] = true, -- Equine
	[1049577] = true, -- Bull
	[1113442] = true, -- Raptor
}

AnimalLore.SkillToDBName = 
{
	[1044103] = "Wrestling",
	[1044087] = "Tactics",
	[1044086] = "ResSpell",
	[1044061] = "Anatomy",
	[1044077] = "Healing",
	[1044090] = "Poisoning",
	[1044074] = "DetectHidden",
	[1044081] = "Hiding",
	[1044065] = "Parrying",
	[1044112] = "Bushido",
	[1044113] = "Ninjitsu",
	[1044085] = "Magery",
	[1044076] = "EvalInt",
	[1044106] = "Meditation",
	[1044109] = "Necromancy",
	[1044092] = "SpiritSpeak",
	[1044115] = "Mysticism",
	[1044110] = "Focus",
	[1044114] = "Spellweaving",
	[1044075] = "Discordance",
	[1044111] = "Chivalry",
}

AnimalLore.DamageTypesIcons = 
{
	["PhysDam"] = "icon000748",
	["FireDam"] = "icon000740",
	["ColdDam"] = "icon000735",
	["PoisDam"] = "icon000749",
	["EnerDam"] = "icon000739",
}

AnimalLore.DamageTypesColors = 
{
	["PhysDam"] = { r = 255, g = 255, b = 255 },
	["FireDam"] = { r = 255, g = 128, b = 0 },
	["ColdDam"] = { r = 0, g = 128, b = 255 },
	["PoisDam"] = { r = 0, g = 255, b = 128 },
	["EnerDam"] = { r = 255, g = 0, b = 255 },
}

AnimalLore.DamageTypesTID = 
{
	["PhysDam"] = 1151800,
	["FireDam"] = 1151801,
	["ColdDam"] = 1151802,
	["PoisDam"] = 1151803,
	["EnerDam"] = 1151804,
}

AnimalLore.MultiSpecialsAbilitiesTID =
{
	[1075829] = { 1157559 }, -- Bleed
	[1028838] = { 1157559, 1157561 }, -- Armor Ignore
	[1015199] = { 1157559, 1157562, 1155784 }, -- Paralyze
	[1028846] = { 1157560,  }, -- Mortal Strike
	[1028840] = { 1157560 }, -- Concussion Blow
	[1028842] = { 1157560, 1157561, 1157562, 1155784 }, -- Disarm
	[1028855] = { 1157561, }, -- Nerve Strike
	[1044109] = { 1157393, 1157473 }, -- Necromancy
	[1002106] = { 1157393 }, -- Magery
	[1155771] = { 1157473 }, -- Magery Mastery
}

AnimalLore.MultiSpecialsTID =
{
	[1157559] = true, -- Piercing
	[1157560] = true, -- Bashing
	[1157561] = true, -- Slashing
	[1157562] = true, -- Battle Defense
	[1155784] = true, -- Wrestling Mastery
	[1157393] = true, -- Arcane Pyromancy
	[1157473] = true, -- Necromage
}

AnimalLore.SpecialsTID =
{
	[1157559] = 1157392, -- Trains the creature in the bleed, armor ignore, and paralyze special moves.  Also trains the creature in the Pierce & Thrust mastery abilities.
	[1157560] = 1157471, -- Trains the creature in the mortal strike, concussion, and disarm special moves.  Also trains the creature in the Toughness & Stagger mastery abilities.
	[1157561] = 1157396, -- Trains the creature in the nerve strike, armor ignore, and disarm special moves.  Also trains the creature in the Focused Eye & Onslaught mastery abilities.
	[1157562] = 1157395, -- Trains the creature in the disarm and paralyze special moves. Also trains the creature in the Heightened Senses & Shield Bash mastery abilities.
	[1155784] = 1157397, -- Trains the creature in the disarm and paralyze special moves. Also trains the creature in the Knockout & Rampage mastery abilities.
	[1157393] = 1157394, -- Trains the creature in the power of Arcane Pyromancy, a combination of Necromancy and Magery that harnesses the power of fire.
	[1157473] = 1157474, -- Trains the creature in the power of Necromagery, a combination of Necromancy and Magery.
	
	[1157412] = 1157413, -- Trains the creature in the Angry Fire special ability, causing the creature to deliver devastating fire attacks.
	[1157406] = 1157407, -- Trains the creature in the Conductive Blast special ability, causing reduction to a target's energy resistance.
	[1157414] = 1157415, -- Trains the creature in the Dragon Breath special ability, causing the creature to deliver devastating fire damage based on its target's health.
	[1157400] = 1157401, -- Trains the creature in the Grasping Claw special ability, causing the creature to use its claws to shred a target causing a loss in physical resistance and physical damage.
	[1157416] = 1157417, -- Trains the creature in the Inferno special ability, causing the creature to surround its targets with fire, causing a reduction to fire resistance and devastating fire damage.
	[1157408] = 1157409, -- Trains the creature in the Lightning Force special ability, causing the creature to attack with energy damage.
	[1157432] = 1157433, -- Trains the creature in the Mana Drain special ability, causing the creature to drain the mana of all nearby targets.
	[1157404] = 1157405, -- Trains the creature in the Raging Breath special ability, causing the creature to use a fiery breath inflicting a burst of fire damage that persists over time.
	[1157434] = 1157435, -- Trains the creature in the Repel special ability, causing all incoming damage to be reflected at the attacker.
	[1157422] = 1157423, -- Trains the creature in the Searing Wounds special ability, causing the creature to sear attackers resulting in a reduction in the effect of healing.
	[1157410] = 1157411, -- Trains the creature in the Steal Life special ability, causing the creature to attack with energy damage that will convert some of that damage back to health over time.
	[1157430] = 1157431, -- Trains the creature in the Venomous Bite special ability, causing the creature to poison all nearby targets.
	[1157398] = 1157399, -- Trains the creature in the Rune Corruption special ability, causing reduction to a target's damage resistances.
	[1157424] = 1157425, -- Trains the creature in the Life Leech special ability, causing the creature to leech life from incoming damage.
	[1157426] = 1157427, -- Trains the creature in the Sticky Skin special ability, causing a reduction in attack speed to attackers.
	[1157428] = 1157429, -- Trains the creature in the Tail Swipe special ability, causing the creature to lash its tail at targets resulting in direct damage and a chance of paralysis and confusion, resulting in a decrease of intelligence and dexterity.
	[1150005] = 509, -- Trains the creature the ability to go into a rage, that will allow it to inflict a small amount of damage over time to its enemy.
	[1157418] = 1157419, -- Trains the creature in the Flurry Force special ability, causing the creature to attack with a flurry reducing a target's physical resist and causing physical damage.
	[1157420] = 1157421, -- Trains the creature in the Vicious Bite special ability, causing the creature to inflict a festering wound on approaching targets that does direct damage over time.
	
	[1028855] = 1157436, -- Trains the creature in the Nerve Strike special move, causing paralysis and direct damage to a target.
	[1028856] = 1157441, -- Trains the creature in the Talon Strike special move, causing extra damage and reducing a target's hit point regeneration.
	[1028840] = 1157448, -- Trains the creature in the Concussion Blow special move, causing direct damage and a mana drain on a target.
	[1028864] = 1157442, -- Trains the creature in the Psychic Attack special move, causing physical damage and reducing a targets intelligence, spell damage increase, and lower mana cost.
	[1028838] = 1157443, -- Trains the creature in the Armor Ignore special move, which ignores a target's resistances while inflicting slightly less damage.
	[1028861] = 1157445, -- Trains the creature in the Bladeweave special move, allowing the use of randomly selected special moves including: bleed, armor ignore, block, mortal strike, feint, paralyzing blow, and crushing blow.
	[1028857] = 1157454, -- Trains the creature in the Feint special move, causing a decrease in incoming damage.
	[1075829] = 1157446, -- Trains the creature in the Bleed special move, causing bleeding wounds to a target that do damage over time.
	[1028841] = 1157449, -- Trains the creature in the Crushing Blow special move, delivering extra damage to a target.
	[1028843] = 1157451, -- Trains the creature in the Dismount special move, causing the creature to dismount a target.
	[1028866] = 1157455, -- Trains the creature in the Force of Nature special move, causing direct damage and a damage increase to the following attack.
	[1028860] = 1157444, -- Trains the creature in the Armor Pierce special move, causing increased damage while ignoring a portion of the target's resistance to damage.
	[1028852] = 1157456, -- Trains the creature in the Frenzied Whirlwind special move, causing damage to nearby targets.  Unlike the player's Frenzied Whirlwind special move, this attack does not reduce the movement of nearby enemies.
	[1028846] = 1157457, -- Trains the creature in the Mortal Strike special move, causing a target to be unable to heal.
	[1015199] = 1157458, -- Trains the creature in the Paralyze special move, causing a target to become paralyzed.
	[1157402] = 1157403, -- Trains the creature in the Cold Wind special ability, causing the creature to breathe an icy wind around targets that causes cold damage over time.
	[1028850] = 1157437, -- Trains the creature in the Whirlwind Attack special move, causing damage to all nearby targets. 
	[1028853] = 1157447, -- Trains the creature in the Block special move, causing an increase in defense chance for a period of time.
	[1028858] = 1157453, -- Trains the creature in the Dual Wield special move, increasing its swing speed.
	[1028842] = 1157450, -- Trains the creature in the Disarm special move, causing a target to unequip its weapons.
	[1028863] = 1157438, -- Trains the creature in the Lightning Arrow special move, causing energy damage to nearby targets.
	[1113283] = 1157439, -- Trains the creature in the Infused Throw special move, causing dismount or paralysis and extra damage.
	[1113282] = 1157440, -- Trains the creature in the Mystic Arc special move, causing extra chaos damage to nearby targets.
	[1028844] = 1157452, -- Trains the creature in the Double Strike special move, causing dual attacks but at reduced damage.
			
	[1157459] = 1157460, -- Trains the creature in the Aura of Energy area effect, causing energy damage to nearby targets.
	[1157463] = 1157464, -- Trains the creature in the Explosive Goo area effect, causing a fiery spray on nearby victims causing fire damage.
	[1157465] = 1157466, -- Trains the creature in the Essence of Earth area effect, causing physical damage to nearby targets.
	[1157467] = 1157468, -- Trains the creature in the Aura of Nausea area effect, causing nearby targets to suffer a reduction in swing speed, hit chance, defense chance, and faster casting.
	[1157475] = 1157476, -- Trains the creature in the Poison Breath area effect, causing lethal poison to nearby targets.
	[1157469] = 1157470, -- Trains the creature in the Essence of Disease area effect, causing poison damage to nearby targets.
	[1157461] = 1157462, -- Trains the creature in the Firestorm area effect, causing fire damage to nearby targets and setting the terrain ablaze.
			
	[1044075] = 1157385, -- Trains the creature in the power of Discordance.
	[1044111] = 1157384, -- Trains the creature in the power of Chivalry.  Creature must have positive karma.
	[1044114] = 1157390, -- Trains the creature in the power of Spellweaving.
	[1044115] = 1157386, -- Trains the creature in the power of Mysticism.
	[1044112] = 1157383, -- Trains the creature in the power of Bushido.
	[1044113] = 1157388, -- Trains the creature in the power of Ninjitsu.
	[1002122] = 1157389, -- Trains the creature in the power of Poisoning.
	[1044077] = 508, -- Trains the creature in the power of Healing.
	[1002106] = 1157391, -- Trains the creature in the power of Magery.
	[1044109] = 1157387, -- Trains the creature in the power of Necromancy.  Creature must have negative karma.
	[1155771] = 1157472, -- Trains the creature in advanced use of Magery spells.
}	

-- Pet abilities cost
AnimalLore.TrainedAbilities = 
{
	[1157412] =		100, -- Angry Fire
	[1157406] =		100, -- Conductive Blast
	[1157414] =		100, -- Dragon Breath
	[1157400] =		100, -- Grasping Claw
	[1157416] =		100, -- Inferno
	[1157408] =		100, -- Lightning Force
	[1157432] =		100, -- Mana Drain
	[1157404] =		100, -- Raging Breath
	[1157434] =		100, -- Repel
	[1157422] =		100, -- Searing Wounds
	[1157410] =		100, -- Steal Life
	[1157430] =		100, -- Venomous Bite
	[1157420] =		100, -- Vicious Bite
	[1157398] =		100, -- Rune Corruption
	[1157424] =		100, -- Life Leech
	[1157426] =		100, -- Sticky Skin
	[1157428] =		100, -- Tail Swipe
	[1028855] =		600, -- Nerve Strike
	[1028856] =		600, -- Talon Strike
	[1028864] =		100, -- Psychic Attack
	[1028838] =		100, -- Armor Ignore
	[1028860] =		100, -- Armor Pierce
	[1028861] =		600, -- Bladeweave
	[1075829] =		100, -- Bleed
	[1028853] =		600, -- Block
	[1028840] =		100, -- Concussion Blow
	[1028841] =		100, -- Crushing Blow
	[1028843] =		100, -- Dismount
	[1028857] =		600, -- Feint
	[1028866] =		100, -- Force of Nature
	[1028852] =		600, -- Frenzied Whirlwind
	[1028846] =		100, -- Mortal Strike
	[1015199] =		100, -- Paralyze
	[1028842] =		100, -- Disarm
	[1157402] =		100, -- Cold Wind
	[1157459] =		100, -- Aura of Energy
	[1157463] =		100, -- Explosive Goo
	[1157465] =		100, -- Essence of Earth
	[1157467] =		100, -- Aura of Nausea
	[1157475] =		100, -- Poison Breath
	[1157469] =		100, -- Essence of Disease
	[1150005] =		100, -- Rage
	[1044077] =		100, -- Healing
	[1044075] =		501, -- Discordance
	[1002106] =		1501, -- Magery
	[1044109] =		1501, -- Necromancy
	[1044114] =		501, -- Spellweaving
	[1044115] =		501, -- Mysticism
	[1044111] =		501, -- Chivalry
	[1155771] =		1, -- Magery Mastery
	[1157473] =		1, -- Necromage
	[1044112] =		501, -- Bushido
	[1044113] =		601, -- Ninjitsu
	[1002122] =		101, -- Poisoning
	[1157559] =		1, -- Piercing
	[1157560] =		1, -- Bashing
	[1157561] =		1, -- Slashing
	[1155784] =		1, -- Wrestling Mastery
	[1157562] =		1, -- Battle Defense
}
	
function AnimalLore.InitializeGump()
	
	-- reset the current data (if we have any)
	AnimalLore.CurrentCreature = {}
	AnimalLore.PetSelection = {}
	AnimalLore.Ratings = {}

	-- read the gump data
	AnimalLore.ReadData()

	-- mark the gump to stay hidden
	GumpsParsing.GumpMaps[AnimalLore.gumpID].show = false
	GumpsParsing.ToShow[AnimalLore.gumpID] = false

	-- load the animal lore window
	AnimalLore.LoadMainPage()
end

function AnimalLore.Shutdown()
	
	-- are we refreshing the window?
	if AnimalLore.HoldOn == nil then
		
		-- reset the current data
		AnimalLore.CurrentCreature = {}
		AnimalLore.PetSelection = {}
		AnimalLore.Ratings = {}
	end

	-- save the window position
	WindowUtils.SaveWindowPosition("AnimalLore", false)
end

function AnimalLore.ReadData(petSelect)

	-- is this a player's pet and we don't have the data array?
	if not AnimalLore.KnownPetsType[AnimalLore.TargetID] then

		-- initialize the data array
		AnimalLore.KnownPetsType[AnimalLore.TargetID] = {}

		-- is this a player's pet?
		if not IsObjectIdPet(AnimalLore.TargetID) then

			-- set the time for the data to be deleted (30 minutes)
			AnimalLore.KnownPetsType[AnimalLore.TargetID].forgetData = Interface.Clock.Timestamp + 1800
		end
	end

	-- do we have to select a pet from the DB?
	if not petSelect then

		-- set the pet to use from the DB as the index 1 in the list
		petSelect = AnimalLore.KnownPetsType[AnimalLore.TargetID] and AnimalLore.KnownPetsType[AnimalLore.TargetID].typeID or 1
	end
	
	-- get the main labels table
	local mainGump = GumpData.Gumps[AnimalLore.gumpID]

	-- create a pointer variable to the default text ids
	local defaultIDs = AnimalLore.Label_TextIDs

	-- create the data record for the current pet (to be stored later)
	local currentLore = {}

	-- get the creature name
	currentLore["Name"] = AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs.Name])

	-- will use this to increment the index of the default ID for the taming required
	local requirementsTraining = 0

	-- will use this to increment every other default IDs
	local petTraining = 0

	-- get the ID for the creature training status
	local found = AnimalLore.GetProgressID(AnimalLore.TargetID, currentLore["Name"])

	-- do we have a progress for the training?
	if wstring.find(mainGump.LabelsText[defaultIDs.TrainingLabel], L"%", 1, true) then
		
		-- store the current progress level
		currentLore["TrainProgress"] = AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs.TrainingLabel])
		
		-- create a new pet record for the progress table
		local pet = {}

		-- store the creature ID
		pet.id = AnimalLore.TargetID

		-- store the pet name
		pet.name = wstring.lower(currentLore["Name"])

		-- store the progress percent
		pet.perc = currentLore["TrainProgress"]

		-- is the current pet already inside the progress table?
		if found == 0 then

			-- add the pet to the progress table
			table.insert(AnimalLore.PetProgress, pet)

		else -- update the existing pet data
			AnimalLore.PetProgress[found] = pet
		end

		-- if the pet is in training, we increase the default ID for the taming required from this point on by 2
		requirementsTraining = 2

		-- increase every other ID by 1
		petTraining = 1

	else -- the pet is not in training (or not anymore), is
	
		-- was the pet in the table?
		if found > 0 then

			-- we remove the training progress data
			table.remove(AnimalLore.PetProgress, found)
		end

		-- do we have a training label and it's the begin animal training button?
		if (mainGump.Labels[defaultIDs.TrainingLabel] and mainGump.Labels[defaultIDs.TrainingLabel].tid == 1157487) then -- Begin Animal Training

			-- store the "Begin animal training" tid
			currentLore["TrainProgress"] = 1157487

			-- if the pet can begin the training, we increase the default ID for the taming required from this point on by 1
			requirementsTraining = 1
		end
	end

	-- scan al the labels
	for id, data in pairs(mainGump.Labels) do

		-- does the label has a TID?
		if data.tid then

			-- is this the pet training option button label?
			if data.tid == 1157492 then -- Pet Training Options

				-- if the pet can begin the training, we increase the default IDs from this point on by 1 more
				requirementsTraining = requirementsTraining + 1
			end
		end

		-- is this the preferred food label?
		if AnimalLore.PreferredFoods[data.tid] and data.tid ~= 3000340 then
			
			-- get the food type
			currentLore["Food"] = data.tid
		end

		-- is this the loyalty label?
		if AnimalLore.LoyaltyRatings[data.tid] then
			
			-- get the loyalty
			currentLore["Loyalty"] = data.tid
		end

		-- is this the pack instinct label?
		if AnimalLore.PackInstincts[data.tid] and data.tid ~= 3000340 then
			
			-- get the pack instinct
			currentLore["Packs"] = data.tid
		end
	end

	-- do we have the food? if not we set it to "NONE"
	if not currentLore["Food"] then
		currentLore["Food"] = 3000340
	end

	-- do we have a pack instinct? if not we set it to "NONE"
	if not currentLore["Packs"] then
		currentLore["Packs"] = 3000340
	end
	
	-- initialize the DB creature data
	local DBCreature

	-- do we have the list of compatible creatures?
	if not AnimalLore.PetSelection or #AnimalLore.PetSelection <= 0 then
	
		-- is this creature in a pet vendor?
		if AnimalLore.VendorPetType then
		
			-- determine the creature type by the type given by the vendor gump
			DBCreature = CreaturesDB.FindCompatibleCreaturesByName(AnimalLore.VendorPetType)

			-- reset the type variable
			AnimalLore.VendorPetType = nil

		else -- get the compatible creatures from the DB
			DBCreature = CreaturesDB.FindCompatibleCreatures(AnimalLore.TargetID, true)
		end
		
		-- have we found more creatures? (this could happen with few pets, we must pick one, but how to recognize the right one?)
		if DBCreature and #DBCreature > 1 then

			-- get the strength value
			local str = tonumber(AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs.Str + petTraining]))

			-- scan the compatible creatures
			for i, crt in pairsByIndex(DBCreature) do

				-- is this creature a dragon?
				if crt.creaturename == "Dragon" then
			
					-- is the strength of the pet greater than 795?
					if str >= 795 then

						-- this is a dragon
						petSelect = i

						-- save the type
						AnimalLore.KnownPetsType[AnimalLore.TargetID].typeID = i

					else -- this is a geater dragon, so we can delete the dragon from the list
						table.remove(DBCreature, i)
					end

					-- we can get out
					break
				end
			end
		
			-- copy the pet selection
			AnimalLore.PetSelection = table.copy(DBCreature)
			AnimalLore.PetSelected = petSelect

			-- There should be only 1 creature left at this point, except for hiryus and bouras.
			DBCreature = DBCreature[petSelect]

		 -- set the creature data to the only one we have
		elseif DBCreature then
			DBCreature = DBCreature[petSelect]

		else -- creature data missing, need to report
			Debug.Print(L"CREATURE DATA MISSING!!! Name: " .. currentLore["Name"] .. L" Body ID: " .. GetMobileBodyID(AnimalLore.TargetID) .. L" Hue: " .. GetMobileHue(AnimalLore.TargetID) .. L" Please include also the creature log.")

			-- save the data of the creature to be included in the bug report
			Interface.ExecuteWhenAvailable(
			{
				name = "SaveMissingCreatureLog",
				check = function() return AnimalLore.CurrentCreature["Name"] ~= nil end, 
				callback = function() AnimalLore.SaveLog() end,
				removeOnComplete = true,
			})
		end

	else -- copy the selection
		DBCreature = table.copy(AnimalLore.PetSelection[petSelect])

		-- store the pet selection
		AnimalLore.PetSelected = petSelect
	end
	
	-- if we don't have a DB match, we create an empty table to avoid errors
	if not DBCreature then
		DBCreature = {}
	end
	
	-- get the creature type
	currentLore["Type"] = DBCreature.creaturename

	-- check if we have a valid required taming value
	if mainGump.Labels[defaultIDs.TamingRequired + requirementsTraining] then

		-- store the required taming value
		currentLore["TamingRequired"] = tonumber(mainGump.Labels[defaultIDs.TamingRequired + requirementsTraining].tidParms[1])
	end

	-- get the taming value from the DB
	currentLore["DBTaming"] = DBCreature.tamable

	-- is the taming required 0 or less than what we have in the DB?
	if currentLore["DBTaming"] and currentLore["TamingRequired"] and (currentLore["TamingRequired"] == 0 or currentLore["TamingRequired"] < currentLore["DBTaming"]) then

		-- set the taming requirements to what we have on the DB
		currentLore["TamingRequired"] = currentLore["DBTaming"]
	end

	-- get the value for the half stat flag
	currentLore["HalfStat"] = DBCreature.halfstat
	currentLore["EightStat"] = DBCreature.eightstat

	-- check if we have a valid pet slots value
	if mainGump.LabelsText[defaultIDs.PetSlots] then

		-- get the stat value from the gump
		local gumpText =  AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs.PetSlots + petTraining])

		-- initialize the pet slots
		currentLore["PetSlots"] = table.copy(DBCreature["slots"]) or {}

		-- set the pet slots text data
		currentLore["PetSlots"].value = gumpText

		-- split the max/min values
		local split = wstring.split(gumpText, L"=>")

		-- make sure we have the min slots or we use 1 as default
		if not currentLore["PetSlots"].min then
			currentLore["PetSlots"].min = 1
		end

		-- get the current and max slots number
		currentLore["PetSlots"].current = tonumber(split[1])
		currentLore["PetSlots"].max = tonumber(split[2])
	end

	-- get the multislot value
	currentLore["Multislot"] = DBCreature.multislot

	-- get the barding difficulty
	currentLore["BardingDifficulty"] = AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs.BardingDifficulty + petTraining])

	-- initialize the stats array
	currentLore["Stats"] = {}

	-- scan the main stat labels
	for stat, _ in pairs(AnimalLore.MainStats) do

		-- initialize the stat
		currentLore["Stats"][stat] = table.copy(DBCreature[string.lower(stat)]) or {}

		-- get the stat value
		currentLore["Stats"][stat].value = tonumber(AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs[stat] + petTraining]))
	end

	-- scan the regenerations
	for stat, _ in pairs(AnimalLore.Regenerations) do

		-- initialize the stat
		currentLore["Stats"][stat] = {}

		-- get the stat value
		currentLore["Stats"][stat].value = tonumber(AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs[stat] + petTraining]))
	end

	-- scan the secondary stats
	for stat, _ in pairs(AnimalLore.SecondaryStats) do
	
		-- initialize the stat
		currentLore["Stats"][stat] = table.copy(DBCreature[string.lower(stat)]) or {}

		-- get the stat value from the gump
		local gumpText =  AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs[stat] + petTraining])

		-- split the max/min values
		local split = wstring.split(gumpText, L"/")

		-- do we have a single value?
		if #split == 1 then

			-- set the stat value as curr and total
			currentLore["Stats"][stat].value = { curr = tonumber(split[1]), total = tonumber(split[1]) }

		else -- min/max values

			-- get the min and max stat value2
			currentLore["Stats"][stat].value = { curr = tonumber(split[1]), total = tonumber(split[2]) }
		end
	end
	
	-- initialize the damage array
	currentLore["Damage"] = table.copy(DBCreature["damage"]) or {}

	-- get the damage value from the gump
	local gumpText = AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs.BaseDamage + petTraining])

	-- initialize the base damage
	currentLore["Damage"]["BaseDamage"] = {}

	-- set the base damage text
	currentLore["Damage"]["BaseDamage"].value = gumpText

	-- split the max/min values
	local split = wstring.split(gumpText, L"-")

	-- get the min/max damage value
	currentLore["Damage"]["BaseDamage"].min = tonumber(split[1])
	currentLore["Damage"]["BaseDamage"].max = tonumber(split[2])

	-- scan the damage types
	for dam, _ in pairs(AnimalLore.DamageTypes) do

		-- store the current damage type
		currentLore["Damage"][dam] = tonumber(AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs[dam] + petTraining]))
	end

	-- initialize the resistances array
	currentLore["Resistances"] = {}

	-- scan all the resistances
	for res, _ in pairs(AnimalLore.Resistances) do

		-- initialize the resistance record
		currentLore["Resistances"][res] = table.copy(DBCreature[string.lower(res)]) or {}

		-- get the resistance value
		currentLore["Resistances"][res].value = tonumber(AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs[res] + petTraining]))
		
		-- are we saving the pet data?
		if AnimalLore.KnownPetsType[AnimalLore.TargetID] then
			
			-- save the pet resistance
			AnimalLore.KnownPetsType[AnimalLore.TargetID][res] = tonumber(AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs[res] + petTraining]))
		end
	end
	
	-- initialize the skills array
	currentLore["Skills"] = {}

	-- get the innate skills flag
	currentLore["Skills"].InnateMagery = DBCreature["innatemagery"]
	currentLore["Skills"].InnateNecromancy = DBCreature["innatenecro"]
	currentLore["Skills"].InnatePoisoning = DBCreature["innatepoisoning"]
	currentLore["Skills"].InnateMysticism = DBCreature["innatemysticism"]

	-- scan all the skills included to the creatures DB
	for skill, _ in pairs(AnimalLore.DBSkills) do 

		-- initialize the skill record
		currentLore["Skills"][skill] = table.copy(DBCreature[string.lower(skill)]) or {}

		-- get the skill value from the gump
		local gumpText = AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs[skill] + petTraining])

		-- split the max/min values
		local split = wstring.split(gumpText, L"/")

		-- do we have a single value?
		if #split == 1 then

			-- is the value a 0?
			if wstring.find(split[1], L"---", 1, true) then

				-- set the skill value to 0
				currentLore["Skills"][skill].value = 0

			else -- get the skill value
				currentLore["Skills"][skill].value = tonumber(split[1])
			end
			
		else -- min/max values

			-- is the value a 0?
			if wstring.find(split[1], L"---", 1, true) then

				-- set the skill value to 0
				currentLore["Skills"][skill].value = 0

			else -- get the skill value
				currentLore["Skills"][skill].value = tonumber(split[1])
			end

			-- get the skill cap
			currentLore["Skills"][skill].cap = tonumber(split[2])

			-- is the current skill value greater than the cap?
			if currentLore["Skills"][skill].value > currentLore["Skills"][skill].cap then

				-- set the cap as the skill value
				currentLore["Skills"][skill].cap = currentLore["Skills"][skill].value
			end
		end
	end

	-- scan all the skills EXCLUDED from the creatures DB
	for skill, _ in pairs(AnimalLore.OutOfDBSkills) do
		
		-- initialize the skill record
		currentLore["Skills"][skill] = {}

		-- get the skill value from the gump
		local gumpText = AnimalLore.CleanTags(mainGump.LabelsText[defaultIDs[skill] + petTraining])

		-- split the max/min values
		local split = wstring.split(gumpText, L"/")

		-- do we have a single value?
		if #split == 1 then

			-- is the value a 0?
			if wstring.find(split[1], L"---", 1, true) then

				-- set the skill value to 0
				currentLore["Skills"][skill].value = 0

			else -- get the skill value
				currentLore["Skills"][skill].value = tonumber(split[1])
			end
			
		else -- min/max values

			-- is the value a 0?
			if wstring.find(split[1], L"---", 1, true) then

				-- set the skill value to 0
				currentLore["Skills"][skill].value = 0

			else -- get the skill value
				currentLore["Skills"][skill].value = tonumber(split[1])
			end

			-- get the skill cap
			currentLore["Skills"][skill].cap = tonumber(split[2])
		end
	end

	-- variable to store the first special label ID (it will stay -1 if there are none).
	local firstSpecial = -1

	-- scan all the labels after the pack instinct
	for k = defaultIDs.PackInstinct + 1, #mainGump.Labels do

		-- find the lore and knowledge title, from here we have the specials
		if mainGump.Labels[k].tid == 3001032 then -- Lore & Knowledge

			-- store the ID of the label
			firstSpecial = k

			-- we can get out of the loop
			break
		end
	end

	-- initialize the specials array
	currentLore["Specials"] = {}

	-- starting special index
	local i = 1

	-- first label to use for the specials search
	local text1 = mainGump.Labels[firstSpecial + i] 

	-- variable to store the first advancement label ID (it will stay -1 if there are none).
	local advancementsStart = -1
	
	-- searching all the special moves
	while text1 do

		-- is this the advancements category title?
		if text1.tid == 1157505 then -- Pet Advancements

			-- store the ID of the label
			advancementsStart = i

			-- we can get out of the loop
			break
		end

		-- initialize the record for the current special
		local special = {}

		-- store the special TID
		special.tid = text1.tid
		
		-- is this special a default one for this pet?
		if table.contains(DBCreature["specials"], text1.tid) then
		
			-- flag this special as an original special
			special.original = true
		end

		-- store the special tooltip
		special.tooltip = AnimalLore.SpecialsTID[text1.tid]

		-- insert the special data into the specials table
		table.insert(currentLore["Specials"], special)
		
		-- increase the specials count
		i = i + 1

		-- store the next label data
		text1 = mainGump.Labels[firstSpecial + i] 
	end

	-- initialize the advancements array
	currentLore["Advancements"] = {}

	-- do we have the advancements title ID?
	if advancementsStart > -1 then

		-- search starting ID
		i = advancementsStart + 1
		
		-- first label to use in the search
		text1 = mainGump.Labels[firstSpecial + i] 

		-- searching all the advancements
		while text1 do

			-- how much we should increment the index?
			local increment = 1

			-- initialize the record for the current advancement
			local advancement = {}

			-- store the advancement TID
			advancement.tid = text1.tid

			-- store the advancement tooltip
			advancement.tooltip = AnimalLore.SpecialsTID[text1.tid]

			-- green text (skill)
			if AnimalLore.SkillToDBName[text1.tid] and (mainGump.Labels[firstSpecial + i + 1] and tonumber(mainGump.Labels[firstSpecial + i + 1].LabelText)) then

				-- store the new cap
				currentLore["Skills"][AnimalLore.SkillToDBName[text1.tid]].advancementCap = tonumber(mainGump.Labels[firstSpecial + i + 1].LabelText)
				
				-- tooltip for the skillcap increase
				advancement.tooltip = 510

				-- flag the advancement as skill
				advancement.isSkill = true

				-- the skills take 2 labels
				increment = 2

			else
				-- flag the advancement that is red
				advancement.isRed = true
			end

			-- insert the advancement data into the advancements table
			table.insert(currentLore["Advancements"], advancement)

			-- increase the advancements count
			i = i + increment

			-- store the next label data
			text1 = mainGump.Labels[firstSpecial + i] 
		end
	end
	
	-- do we have a valid creature ID?
	if IsValidID(AnimalLore.TargetID) then

		-- store the body ID
		currentLore["BodyID"] = GetMobileBodyID(AnimalLore.TargetID)

		-- get the mobile hue
		local hue = GetMobileHue(AnimalLore.TargetID)
	
		-- is this creature paragon?
		if hue == 1281 then

			-- set the hue to 0 if it's paragon
			hue = 0

			-- set the creature as NOT tamable
			currentLore["DBTaming"] = nil
		end

		-- store the hue
		currentLore["Hue"] = hue

	else -- invalid ID, we use 0 for body and hue
		currentLore["BodyID"] = 0
		currentLore["Hue"] = 0
	end

	-- is this a trained pet?
	if currentLore["PetSlots"] and currentLore["PetSlots"].current > currentLore["PetSlots"].min or -- are the current slots greater than the min slots from the db?
		#currentLore["Advancements"] > 0 or -- do we have any advancement?
		tonumber(currentLore["TrainProgress"]) and tonumber(currentLore["TrainProgress"]) <= 100 or -- do we have a progress bar?
		currentLore["TrainProgress"] and currentLore["TrainProgress"] ~= 1157487 -- is the training button something different than "Begin animal training"?
	then
		currentLore["isTrained"] = true
	end

	-- store the current creature data
	AnimalLore.CurrentCreature = currentLore
end

function AnimalLore.LoadMainPage()

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- is the window already open?
	if DoesWindowExist(windowName) then

		-- prevent the gump from closing
		AnimalLore.HoldOn = true

		-- destroy the current window first
		DestroyWindow(windowName)
	end
	
	-- create the animal lore window
	CreateWindowFromTemplate(windowName, windowName, "Root")

	-- flag the window to be destroyed on close
	Interface.DestroyWindowOnClose[windowName] = true

	-- we no longer need to prevent the gump from closing
	AnimalLore.HoldOn = nil

	-- restore the window position
	WindowUtils.RestoreWindowPosition("AnimalLore", false)

	-- set the name of the pet as title for the window
	WindowUtils.SetWindowTitle(windowName, AnimalLore.CurrentCreature["Name"])

	-- get the loyalty rating value
	local loyalty = AnimalLore.CurrentCreature["Loyalty"]

	-- set the TID as ID for the loyalty
	WindowSetId(windowName .. "LoyaltyRatingIcon", loyalty)

	-- set the loyalty icon
	DynamicImageSetTexture(windowName .. "LoyaltyRatingIcon", AnimalLore.LoyaltyRatings[loyalty], 0 ,0)

	-- update the pet type
	AnimalLore.SetPetType()

	-- update the pet color
	AnimalLore.SetPetColor()

	-- scan the main stats
	for stat, _ in pairs(AnimalLore.MainStats) do
		
		-- update the pet stat
		AnimalLore.SetPetStat(stat)
	end

	-- scan the secondary stats
	for stat, _ in pairs(AnimalLore.SecondaryStats) do

		-- update the pet status bar
		AnimalLore.SetPetStatBar(stat)
	end

	-- sum of all the resistances
	local totalRes = 0
	local totalResCap = 0

	-- scan the resistances
	for res, _ in pairs(AnimalLore.Resistances) do

		-- sum the resistance
		totalRes = totalRes + AnimalLore.CurrentCreature.Resistances[res].value

		-- do we have the max possible from the DB?
		if AnimalLore.CurrentCreature.Resistances[res].max then
			totalResCap = totalResCap + AnimalLore.CurrentCreature.Resistances[res].max
		end

		-- update the pet res
		AnimalLore.SetPetRes(res)
	end

	-- save the total resistances
	AnimalLore.CurrentCreature.Resistances["Total"] = { value = totalRes, max = totalResCap }

	-- set the total resistances
	LabelSetText(windowName .. "TotalResLabel", towstring(totalRes))

	-- do we have the sum of the maximum resistances?
	if totalResCap > 0 then

		-- set the total resistances cap
		LabelSetText(windowName .. "TotalResCapLabel", towstring(totalResCap))

		-- set the total resistances sum
		LabelSetText(windowName .. "TotalResSumLabel", towstring(totalRes - totalResCap))
		
		-- color the label and the highlight
		AnimalLore.ColorResistancesTotal(windowName .. "TotalResSumLabel", windowName .. "TotalResSumIcon", totalRes - totalResCap)

	else
		-- set the total resistances sum to ? since we can't determine it...
		LabelSetText(windowName .. "TotalResSumLabel", L"?")
	end

	-- format the damage string
	local damage = wstring.gsub(AnimalLore.CurrentCreature.Damage["BaseDamage"].value, L"[-]", L" - ")

	-- set the damage value
	LabelSetText(windowName .. "DamageLabel", damage)

	-- create the damages bar
	AnimalLore.SetPetDamages()

	-- set the pet skills
	AnimalLore.SetPetSkills()
	
	-- update the barding difficulty for the pet
	AnimalLore.SetPetBardDiff()

	-- update the pet food
	AnimalLore.SetPetFood()

	-- update the pack instincts
	AnimalLore.SetPetPackInstincts()

	-- update the animal taming
	AnimalLore.SetPetTaming()

	-- update the pet slots
	AnimalLore.SetPetSlots()

	-- update the pet control chances
	AnimalLore.SetPetControlChances()
	
	-- update the pet ratio
	AnimalLore.SetPetRatio()

	-- set the cancel training text
	LabelSetText(windowName .. "CanelTrainingLabel", GetStringFromTid(506)) -- Cancel Training

	-- hide the cancel training label
	WindowSetShowing(windowName .. "CanelTrainingLabel", false)

	-- if the loyalty is wild, we shrink the training area
	if loyalty == 1061643 or not IsObjectIdPet(AnimalLore.TargetID) then

		-- hide the training button and the tooltips for weight and caps
		WindowSetShowing(windowName .. "TrainingLabel", false)
		WindowSetShowing(windowName .. "TrainingBTN", false)

		-- is the pet wild?
		if loyalty == 1061643 then

			-- caps and weight caps are only visible for tamed pets
			WindowSetShowing(windowName .. "CapsIcon", false)
			WindowSetShowing(windowName .. "WeightIcon", false)

		else
			-- reset the position of the caps button
			WindowClearAnchors(windowName .. "CapsIcon")

			-- move the button on the right (where the training button was)
			WindowAddAnchor(windowName .. "CapsIcon", "topright", windowName, "topright", -30, 33)
		end

	else -- tamed player pet

		-- is the training yet to start?
		if AnimalLore.CurrentCreature.TrainProgress == 1157487 then -- Begin animal training
		
			-- set the pet training label
			LabelSetText(windowName .. "TrainingLabel", GetStringFromTid(1157487)) -- Begin Animal Training

		-- is the training completed?
		elseif tonumber(AnimalLore.CurrentCreature.TrainProgress) and tonumber(AnimalLore.CurrentCreature.TrainProgress) == 100 then

			-- set the pet training label
			LabelSetText(windowName .. "TrainingLabel", GetStringFromTid(1157492)) -- Pet Training Options

			-- hide the cancel training label
			WindowSetShowing(windowName .. "CanelTrainingLabel", true)

		-- do we have a progress bar?
		elseif tonumber(AnimalLore.CurrentCreature.TrainProgress) then

			-- set the pet training label
			LabelSetText(windowName .. "TrainingLabel", GetStringFromTid(1157492)) -- Pet Training Options

			-- gray out the button
			WindowSetTintColor(windowName .. "TrainingBTN", 100, 100, 100)

			-- disable the button
			WindowSetHandleInput(windowName .. "TrainingBTN", false)

			-- gray out the text
			LabelSetTextColor(windowName .. "TrainingLabel", 150, 150, 150)

		else -- no buttons available
		
			-- hide the training button and the tooltips for weight and caps
			WindowSetShowing(windowName .. "TrainingLabel", false)
			WindowSetShowing(windowName .. "TrainingBTN", false)

			-- reset the position of the caps button
			WindowClearAnchors(windowName .. "CapsIcon")

			-- move the button on the right (where the training button was)
			WindowAddAnchor(windowName .. "CapsIcon", "topright", windowName, "topright", -30, 33)
		end
	end

	-- update the pet specials
	AnimalLore.SetPetSpecials()
end

function AnimalLore.SetPetSpecials()
	
	-- animal lore main window
	local windowName = "AnimalLore"

	-- advancement area anchor
	local advAnchor = windowName .. "SpecialsHLine12"

	-- max specials per line
	local maxPerLine = 4

	-- variables for the height of the 2 sections
	local specialsH = 0
	local advanceH = 0

	-- do we have special attacks?
	if #AnimalLore.CurrentCreature["Specials"] > 0 then

		-- special attacks title
		LabelSetText(windowName .. "SpecialsTitle", GetStringFromTid(1157480))

		-- table for the original specials
		local sortedSpecials = {}

		-- scan all the special moves (add the multi-specials on top of the list)
		for i, spec in pairsByIndex(AnimalLore.CurrentCreature["Specials"]) do
			
			-- is this a multi-special ability? (and not the pet advancements title)
			if AnimalLore.MultiSpecialsTID[spec.tid] and spec.tid ~= 1157505 then -- Pet Advancements
				
				-- add the ability to the sorted table
				table.insert(sortedSpecials, spec)
			end
		end

		-- scan all the special moves (add the innate abilities after the multi-special)
		for i, spec in pairsByIndex(AnimalLore.CurrentCreature["Specials"]) do
			
			-- is this a multi-special ability or is already in the sorted list or is the pet advancements title?
			if AnimalLore.MultiSpecialsTID[spec.tid] or table.contains(sortedSpecials, spec.tid) or spec.tid == 1157505 then -- Pet Advancements
				continue
			end

			-- is this an innate ability?
			if spec.original or (not AnimalLore.HasAdvancement(spec.tid) and not AnimalLore.IsPartOfMultiSpecial(spec.tid)) then
				
				-- add the ability to the sorted table
				table.insert(sortedSpecials, spec)
			end
		end

		-- scan all the special moves (all the other abilities)
		for i, spec in pairsByIndex(AnimalLore.CurrentCreature["Specials"]) do

			-- is this a multi-special ability or is already in the sorted list or is the pet advancements title?
			if AnimalLore.MultiSpecialsTID[spec.tid] or table.contains(sortedSpecials, spec.tid) or spec.tid == 1157505 then  -- Pet Advancements
				continue
			end

			-- is this NOT a native ability?
			if not spec.original then
				
				-- add the ability to the sorted table
				table.insert(sortedSpecials, spec)
			end
		end
		
		-- count the specials lines
		local lines = 1

		-- scan all the special moves
		for i, spec in pairsByIndex(sortedSpecials) do

			-- special window name
			local specialName = windowName .. "Special" .. i
			local prevSpecialName = windowName .. "Special" .. i - 1

			-- create the skill row
			CreateWindowFromTemplate(specialName, "AnimalLoreSpecialsTemplate", windowName .. "Specials")

			-- clear the window anchors
			WindowClearAnchors(specialName)

			-- is this the first special move?
			if i == 1 then
				
				-- anchor to the top line
				WindowAddAnchor(specialName, "bottomleft", windowName .. "SpecialsTitle", "topleft", -10, 6)

			elseif i % maxPerLine == 1 then

				-- new row window name
				local rowName = windowName .. "SpecialsMidRow" .. lines

				-- create the skill row
				CreateWindowFromTemplate(rowName, "AnimalLoreSpecialsTemplateLine", windowName .. "Specials")

				-- anchor to the line
				WindowAddAnchor(rowName, "bottomleft", windowName .. "SpecialsHLine13", "topleft", 0, (38 * lines))

				-- anchor to the first element of the previous line
				WindowAddAnchor(specialName, "bottomleft", windowName .. "Special" .. i - maxPerLine, "topleft", 0, 3)
				
				-- increase the lines count
				lines = lines + 1

			else -- any other label

				-- anchor to the previous special
				WindowAddAnchor(specialName, "right", prevSpecialName, "left", 3, 0)
			end

			-- set the special name
			LabelSetText(specialName, GetStringFromTid(spec.tid))
			
			-- do we have the tooltip?
			if spec.tooltip then

				-- set the ID of the special
				WindowSetId(specialName, spec.tooltip)

			else -- missing tooltip to be reported
				Debug.Print("MISSING TOOLTIP: " .. spec.tid)
			end

			-- is this ability native of the creature?
			if spec.original or AnimalLore.CurrentCreature["Loyalty"] == 1061643 then
				
				-- color the label light blue
				LabelSetTextColor(specialName, 0, 162, 232)
			else

				-- color the label green
				LabelSetTextColor(specialName, 0, 255, 0)
			end
		end

		-- calculate the specials height
		specialsH = 28 + (42 * lines)

		-- resize the specials area
		WindowSetDimensions(windowName .. "Specials", 655, specialsH)

	else -- no specials

		-- hide the specials area
		WindowSetShowing(windowName .. "Specials", false)

		-- advancement area anchor
		advAnchor = windowName .. "HLine11"
	end
	
	-- do we have advancements?
	if #AnimalLore.CurrentCreature["Advancements"] > 0 then

		-- count the specials lines
		local lines = 1

		-- clear the window anchors
		WindowClearAnchors(windowName .. "Advancements")

		-- anchor to the bottom line of the specials (or whatever)
		WindowAddAnchor(windowName .. "Advancements", "botttomleft", advAnchor, "topleft", 0, 0)

		-- special attacks title
		LabelSetText(windowName .. "AdvancementsTitle", GetStringFromTid(1157505))

		-- scan all the advancements
		for i, spec in pairsByIndex(AnimalLore.CurrentCreature["Advancements"]) do
			
			-- make sure the pet advancements title is not included (this shouldn't happen, but it might...)
			if spec.tid == 1157505 then  -- Pet Advancements
				continue
			end

			-- special window name
			local advName = windowName .. "Advancement" .. i
			local prevAdvName = windowName .. "Advancement" .. i - 1

			-- create the skill row
			CreateWindowFromTemplate(advName, "AnimalLoreSpecialsTemplate", windowName .. "Advancements")

			-- clear the window anchors
			WindowClearAnchors(advName)

			-- is this the first special move?
			if i == 1 then
				
				-- anchor to the top line
				WindowAddAnchor(advName, "bottomleft", windowName .. "AdvancementsTitle", "topleft", -10, 4)

			elseif i % maxPerLine == 1 then

				-- new row window name
				local rowName = windowName .. "AdvancementsMidRow" .. lines

				-- create the skill row
				CreateWindowFromTemplate(rowName, "AnimalLoreSpecialsTemplateLine", windowName .. "Specials")

				-- anchor to the line
				WindowAddAnchor(rowName, "bottomleft", windowName .. "AdvancementsHLine13", "topleft", 0, (38 * lines))

				-- anchor to the first element of the previous line
				WindowAddAnchor(advName, "bottomleft", windowName .. "Advancement" .. i - maxPerLine, "topleft", 0, 3)

				-- increase the lines count
				lines = lines + 1

			else -- any other label

				-- anchor to the previous advancement
				WindowAddAnchor(advName, "right", prevAdvName, "left", 3, 0)
			end

			-- initialize the cap string
			local cap = L""

			-- do we have the tooltip?
			if spec.tooltip then

				-- set the ID of the special
				WindowSetId(advName, spec.tooltip)

			else
				Debug.Print("MISSING TOOLTIP: " .. spec.tid)
			end

			-- is this a skill?
			if spec.isSkill then

				-- get the cap value
				cap = L" " .. wstring.format(L"%1.1f", AnimalLore.CurrentCreature["Skills"][AnimalLore.SkillToDBName[spec.tid]].advancementCap)
				
				-- color the label green
				LabelSetTextColor(advName, 0, 255, 0)

			else -- other case

				-- color the label red
				LabelSetTextColor(advName, 255, 0, 0)
			end

			-- set the advancement name
			LabelSetText(advName, GetStringFromTid(spec.tid) .. cap)
		end

		-- calculate the advancements heigh
		advanceH = 28 + (42 * lines)

		-- resize the specials area
		WindowSetDimensions(windowName .. "Advancements", 655, advanceH)

	else -- no specials

		-- hide the specials area
		WindowSetShowing(windowName .. "Advancements", false)
	end

	-- get the window dimensions
	local w = WindowGetDimensions(windowName)

	-- new height for the window count the specials and advancements
	local baseH = 535 + specialsH + advanceH

	-- resize the window
	WindowSetDimensions(windowName, w, baseH)
end

function AnimalLore.TypeSelectionMenu()

	-- do we have more than 1 compatible pet?
	if #AnimalLore.PetSelection > 1 then

		-- reset the context menu
		ContextMenu.CleanUp()

		-- scan the compatible pets
		for i, petData in pairsByIndex(AnimalLore.PetSelection) do

			-- add the creature to the list
			ContextMenu.CreateLuaContextMenuItem({str = FormatProperly(petData.creaturename), returnCode = i, pressed = i == AnimalLore.PetSelected})
		end

		-- show the context menu
		ContextMenu.ActivateLuaContextMenu(AnimalLore.PetSelectionMenuCallback)
	end
end

function AnimalLore.PetSelectionMenuCallback(returnCode)

	-- reset the current data
	AnimalLore.CurrentCreature = {}

	-- reset the gump
	AnimalLore.ReadData(returnCode)

	-- is this a player's pet?
	if IsObjectIdPet(AnimalLore.TargetID) then

		-- save the pet type for the current creature
		AnimalLore.KnownPetsType[AnimalLore.TargetID].typeID = returnCode
	end

	-- load the animal lore window
	AnimalLore.LoadMainPage()
end

function AnimalLore.SetPetRatio()
	
	-- animal lore main window
	local windowName = "AnimalLore" 

	-- pet ratio icon name
	local ratioIcon = windowName .. "PetRatingIcon"

	-- we rate only wild creatures and only if we have the data from the DB to do the rating. With Khyro's system, we rate any pet as long as we have the data.
	if (AnimalLore.CurrentCreature["Loyalty"] ~= 1061643 and not (Interface.Settings.AnimalLoreKhyrosRating and not AnimalLore.CurrentCreature["isTrained"])) or not AnimalLore.CurrentCreature["Type"] or not AnimalLore.CurrentCreature["DBTaming"] then

		-- hide the ratio icon
		WindowSetShowing(ratioIcon, false)

		return
	end

	-- initialize the pet rate percentage
	local ratePerc = 0

	-- is Khyro's rating enabled?
	if Interface.Settings.AnimalLoreKhyrosRating then
		
		ratePerc = AnimalLore.KhyrosRating()

	else -- old rating system
		-- rate the current pet (if possible)
		AnimalLore.RatePet()

		-- get the total rate of the pet
		ratePerc = (AnimalLore.Ratings["Res"] + AnimalLore.Ratings["HitPoints"] + AnimalLore.Ratings["Stats"] + AnimalLore.Ratings["Skills"]) / 100
	end

	-- get the rating from 1 to 5
	local StarsRating = (5 * ratePerc) * 10

	-- initialize the health bar background
	StatusBarSetBackgroundTint(ratioIcon, 200, 200, 200)

	-- show the rating
	StatusBarSetMaximumValue(ratioIcon, 50)
	StatusBarSetCurrentValue(ratioIcon, StarsRating)
end

function AnimalLore.SetPetControlChances()

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- set the control chances
	LabelSetText(windowName .. "ControlChanceLabel", wstring.format(L"%1.1f", AnimalLore.GetControlChance()) .. L"%" )
end

function AnimalLore.SetPetSlots()

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- initialize the pet slots to 0
	local slots = L"0"

	-- do we have the pet slots
	if AnimalLore.CurrentCreature["PetSlots"] then
		
		-- get the pet slots count
		slots = AnimalLore.CurrentCreature["PetSlots"].value
	end

	-- set the pet slots number
	LabelSetText(windowName .. "SlotsLabel", slots)
end

function AnimalLore.SetPetTaming()

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- get the required taming skill
	local taming = AnimalLore.CurrentCreature["TamingRequired"]

	-- do we have a valid skill value?
	if tonumber(taming) then

		-- format the taming skill value
		taming = wstring.format(L"%.1f", taming)

	else -- cannot be tamed
		taming = GetStringFromTid(476)

		-- hide the slots data
		WindowSetShowing(windowName .. "SlotsLabel", false)
		WindowSetShowing(windowName .. "SlotsIcon", false)

		-- hide the control chance
		WindowSetShowing(windowName .. "ControlChanceLabel", false)
		WindowSetShowing(windowName .. "ControlChanceIcon", false)
	end
	
	-- set the taming required values
	LabelSetText(windowName .. "TamingLabel", taming)
end

function AnimalLore.SetPetPackInstincts()

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- get the food type
	local packs = AnimalLore.CurrentCreature["Packs"]
	
	-- do we have the food TID?
	if not packs then

		-- set the TID to Unknown
		packs = 1074235
	end

	-- set the pack instinct
	LabelSetText(windowName .. "PacksLabel", GetStringFromTid(packs))
end

function AnimalLore.SetPetFood()

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- get the food type
	local food = AnimalLore.CurrentCreature["Food"]
	
	-- do we have the food TID?
	if not food then

		-- set the TID to Unknown
		food = 1074235
	end

	-- is this pet a goat?
	if CreaturesDB.IsGoat(AnimalLore.TargetID) then

		-- change the food TID
		food = 473
	end

	-- set the food type
	LabelSetText(windowName .. "FoodLabel", GetStringFromTid(food))
end

function AnimalLore.SetPetBardDiff()

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- get the barding difficulty
	local bdiff = AnimalLore.CurrentCreature["BardingDifficulty"]
	
	-- do we have a valid number value for the barding difficulty?
	if bdiff == L"---" then

		-- set the text to Immune
		bdiff = GetStringFromTid(475)

	else
		-- format the number properly
		bdiff = wstring.format(L"%1.1f", tonumber(bdiff))
	end

	-- set the barding difficulty value
	LabelSetText(windowName .. "BardingDifficultyLabel", bdiff)
end

function AnimalLore.SetPetSkills()

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- table for the sorted skill names
	local sortedSkills = {}

	-- scan the DB skills
	for skill, _ in pairs(AnimalLore.DBSkills) do

		-- add the skill with the text name to the sorted skills list
		sortedSkills[skill] = FormatProperly(GetStringFromTid(AnimalLore.SkillsToTid[skill]))
	end

	-- scan the out of DB skills
	for skill, _ in pairs(AnimalLore.OutOfDBSkills) do

		-- add the skill with the text name to the sorted skills list
		sortedSkills[skill] = FormatProperly(GetStringFromTid(AnimalLore.SkillsToTid[skill]))
	end

	-- previous skill label
	local prevSkill

	-- scan the DB skills
	for skill, textName in pairsByKeys(sortedSkills) do

		-- get the current skill value
		local val = AnimalLore.CurrentCreature.Skills[skill].value

		-- get the current skill cap
		local cap = AnimalLore.CurrentCreature.Skills[skill].cap

		-- get the current skill cap
		local max = AnimalLore.CurrentCreature.Skills[skill].max or 0
		
		-- make sure the max value is not less than 100
		if max and max < 100 then
			max = 100
		end

		-- if we have the skill data from the db and the skill can be higher than 112.3 and the pet is tamed we need to reduce the db cap
		if max and max > 112.3 and AnimalLore.CurrentCreature["Loyalty"] ~= 1061643 then
			max = max * 0.9
		end

		-- create the skill row
		CreateWindowFromTemplate(windowName .. "_" .. skill, "LabeledDataTemplate", windowName)

		-- clear the window anchors
		WindowClearAnchors(windowName .. "_" .. skill)

		-- is this the first skill?
		if not prevSkill then
			
			-- anchor to the top line
			WindowAddAnchor(windowName .. "_" .. skill, "bottomleft", windowName .. "HLine9", "topleft", 10, 8)

		else -- anchor to the previous skill
			WindowAddAnchor(windowName .. "_" .. skill, "bottomleft", prevSkill, "topleft", 0, 5)
		end

		-- set the skill name
		LabelSetText(windowName .. "_" .. skill .. "Label", textName)

		-- do we have a cap?
		if not cap then

			-- set the skill value
			LabelSetText(windowName .. "_" .. skill .. "Value", L"---")

		else
			-- set the skill value
			LabelSetText(windowName .. "_" .. skill .. "Value", wstring.format(L"%.1f", val) .. L" / " .. wstring.format(L"%.1f", cap))

			-- do we have the max value?
			if max then

				-- set the skill cap
				LabelSetText(windowName .. "_" .. skill .. "Cap", L"(" .. wstring.format(L"%.1f", max) .. L")")

				-- current value to parse for the highlight
				local parseValue = val

				-- is pointless to check values under 100 since any pet can get that far.
				if parseValue < 100 then
					parseValue = 100
				end

				-- parse the value and color the label (we use 100 as min so we can focus the highlight on the value over 100)
				AnimalLore.ColorLabelByStatRange(windowName .. "_" .. skill .. "Label", parseValue, 100, max)
				AnimalLore.ColorLabelByStatRange(windowName .. "_" .. skill .. "Value", parseValue, 100, max)
			end
		end

		-- store the previous skill
		prevSkill = windowName .. "_" .. skill
	end
end

function AnimalLore.SetPetDamages()

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- damage types count
	local damageTypes = 0

	-- table for the sorted damage types
	local sortedDamages = {}

	-- scan the damage types
	for dam, idx in pairs(AnimalLore.DamageTypes) do

		-- add the damage to the sorted table
		table.insert(sortedDamages, idx, dam)
	end

	-- max size of the damage types bar
	local maxSize = 250

	-- previous visible damage type
	local dmgPrev

	-- scan the damage types
	for idx, damage in pairsByIndex(sortedDamages) do

		-- get the pet current damage
		local val = AnimalLore.CurrentCreature.Damage[damage]

		-- is this damage type 0?
		if val > 0 then
			
			-- create the bar for this damage
			CreateWindowFromTemplate(windowName .. damage, "AnimalLore_DamageBarTemplate", windowName)

			-- set the pet damage value
			LabelSetText(windowName .. damage .. "Label", towstring(val) .. L"%")

			-- calculate the sie for the bar
			local size = maxSize * (val / 100)

			-- scale the damage bar based on the damage amount. in the end we'll have a 200px bar
			WindowSetDimensions(windowName .. damage, size, 16)
			WindowSetDimensions(windowName .. damage .. "Label", size, 16)

			-- reset the bar position
			WindowClearAnchors(windowName .. damage)

			-- do we have a previous bar?
			if dmgPrev then
				
				-- anchor to the right of the previous bar
				WindowAddAnchor(windowName .. damage, "right", dmgPrev, "left", 0, 0)

			else -- if we don't have previous damages, this is the first bar

				-- anchor the bar under the damage label
				WindowAddAnchor(windowName .. damage, "bottomleft", windowName .. "DamageLabel", "topleft", 0, 18)
			end
			
			-- draw the icon
			DynamicImageSetTexture(windowName .. damage .. "Icon", AnimalLore.DamageTypesIcons[damage], 0, 0)

			-- color the bar properly
			WindowSetTintColor(windowName .. damage .. "BarBG", AnimalLore.DamageTypesColors[damage].r, AnimalLore.DamageTypesColors[damage].g, AnimalLore.DamageTypesColors[damage].b)

			-- set the ID for the tooltip
			WindowSetId(windowName .. damage, AnimalLore.DamageTypesTID[damage])
			
			-- set this damage as the previous visible
			dmgPrev = windowName .. damage
		end
	end
end

function AnimalLore.SetPetRes(res)

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- get the pet current resistance
	local text = towstring(AnimalLore.CurrentCreature.Resistances[res].value)

	-- cap text
	local capText = L""

	-- do we have the max possible from the DB?
	if AnimalLore.CurrentCreature.Resistances[res].max then

		-- append the max value
		capText = L"(" .. StringUtils.AddCommasToNumber(AnimalLore.CurrentCreature.Resistances[res].max) .. L")"

		-- color the label based on the values we have
		AnimalLore.ColorLabelByStatRange(windowName .. res .. "Label", AnimalLore.CurrentCreature.Resistances[res].value, AnimalLore.CurrentCreature.Resistances[res].min, AnimalLore.CurrentCreature.Resistances[res].max)

	else -- disable the tooltip
		WindowSetHandleInput(windowName .. res .. "CapLabel", false)
	end

	-- set the pet value
	LabelSetText(windowName .. res .. "Label", text)

	-- set the pet cap value
	LabelSetText(windowName .. res .. "CapLabel", capText)
end

function AnimalLore.SetPetStatBar(stat)

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- get the pet current stat
	local data = AnimalLore.CurrentCreature.Stats[stat].value
	
	-- text to show
	local text = L""
	local capText = L""

	-- do we have the min/max value?
	if type(data) == "table" then
	
		-- set the current and max value
		text = StringUtils.AddCommasToNumber(data.curr) .. L" / " .. StringUtils.AddCommasToNumber(data.total)

	else -- if we have a single value, we show that
		text = StringUtils.AddCommasToNumber(data)
	end

	-- do we have the max possible from the DB?
	if AnimalLore.CurrentCreature.Stats[stat].max then

		-- get the max value for the stat
		local max = AnimalLore.CurrentCreature.Stats[stat].max

		-- get the max value for the stat
		local min = AnimalLore.CurrentCreature.Stats[stat].min

		-- get the current stat value
		local current = data.total

		-- this pet requires half stats after being tamed?
		if AnimalLore.CurrentCreature.HalfStat and AnimalLore.CurrentCreature["Loyalty"] ~= 1061643 and (stat == "Str" or stat == "HitPoints" or stat == "Dex" or stat == "Stamina") then
			
			-- does this creatures hp need to be divided by 8 after taming?
			if AnimalLore.CurrentCreature.EightStat and stat == "HitPoints" then
				max = math.floor(max / 8)
				min = math.floor(min / 8)

			else -- only halved
				max = math.floor(max / 2)
				min = math.floor(min / 2)
			end

			-- is the max lower than the current value?
			if max < current then
				max = current

			-- make sure the max value remains 125 (except hp)
			elseif max < 125 and stat ~= "HitPoints" then
				max = 125
			end
		end

		-- append the max value
		capText = L"(" .. StringUtils.AddCommasToNumber(max) .. L")"

		-- color the label based on the values we have
		AnimalLore.ColorLabelByStatRange(windowName .. stat .. "Label", current, min, max)

	else -- disable the tooltip
		WindowSetHandleInput(windowName .. stat .. "CapLabel", false)
	end

	-- set the pet value
	LabelSetText(windowName .. stat .. "Label", text)

	-- set the pet cap value
	LabelSetText(windowName .. stat .. "CapLabel", capText)

	-- set the pet regeneration value
	LabelSetText(windowName .. stat .. "RegenLabel", towstring(AnimalLore.CurrentCreature.Stats[stat .. "Regen"].value))

	-- healthbar window name
	local healthbar = windowName .. stat .. "Bar"

	-- initialize the health bar background
	StatusBarSetBackgroundTint(healthbar, 200, 200, 200)
	
	-- is this the hit points bar?
	if stat == "HitPoints" then
		
		-- update the healthbar
		AnimalLore.UpdateStatus(AnimalLore.TargetID)

	elseif data then -- other bars
		
		-- color the bar
		HealthBarColor.UpdateHealthBarColor(healthbar, HealthBarColor.HealthVisualState[stat] - 1)
			
		-- do we have the min/max value?
		if type(data) == "table" then

			-- update the bar
			StatusBarSetMaximumValue(healthbar, (data.total + 1) or 1)
			StatusBarSetCurrentValue(healthbar, (data.curr + 1) or 1)

		else -- single value

			-- update the bar
			StatusBarSetMaximumValue(healthbar, (data + 1) or 1)
			StatusBarSetCurrentValue(healthbar, (data + 1) or 1)
		end
	end
end

function AnimalLore.SetPetStat(stat)

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- get the pet stat
	local text = StringUtils.AddCommasToNumber(AnimalLore.CurrentCreature.Stats[stat].value)
	local capText = L""

	-- do we have the max value from the DB?
	if AnimalLore.CurrentCreature.Stats[stat].max then

		-- get the max value for the stat
		local max = AnimalLore.CurrentCreature.Stats[stat].max

		-- get the max value for the stat
		local min = AnimalLore.CurrentCreature.Stats[stat].min

		-- get the current stat value
		local current = AnimalLore.CurrentCreature.Stats[stat].value

		-- this pet requires half stats after being tamed?
		if AnimalLore.CurrentCreature.HalfStat and AnimalLore.CurrentCreature["Loyalty"] ~= 1061643 and (stat == "Str" or stat == "HitPoints" or stat == "Dex" or stat == "Stamina") then
			
			-- does this creatures hp need to be divided by 8 after taming?
			if AnimalLore.CurrentCreature.EightStat and stat == "HitPoints" then
				max = math.floor(max / 8)
				min = math.floor(min / 8)

			else -- only halved
				max = math.floor(max / 2)
				min = math.floor(min / 2)
			end

			-- is the max lower than the current value?
			if max < current then
				max = current

			-- make sure the max value remains 125 (except hp)
			elseif max < 125 and stat ~= "HitPoints" then
				max = 125
			end
		end

		-- append the max strenght to the string
		capText = L" (" .. StringUtils.AddCommasToNumber(max) .. L")"

		-- color the label based on the values we have
		AnimalLore.ColorLabelByStatRange(windowName .. stat .. "Label", current, min, max)

		-- enable the tooltip
		WindowSetHandleInput(windowName .. stat .. "CapLabel", true)
	end

	-- set the pet hp value
	LabelSetText(windowName .. stat .. "Label", text)
	LabelSetText(windowName .. stat .. "CapLabel", capText)
end

function AnimalLore.UpdateStatus(mobileId)

	--is this the mobile we are using animal lore to?
	if mobileId ~= AnimalLore.TargetID or not DoesWindowExist("AnimalLore") or not WindowGetShowing("AnimalLore") then
		return
	end

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- initialize the current and max hp values
	local min, max = 100, 100

	-- do we have the mobile data?
	if Interface.ActiveMobilesOnScreen[AnimalLore.TargetID] then

		-- get the health values from the mobile data
		min, max = Interface.ActiveMobilesOnScreen[mobileId].curHealth, Interface.ActiveMobilesOnScreen[mobileId].maxHealth

	else -- get the data from the server
		min, max = GetMobileHealth(mobileId, true)
	end

	-- healthbar window name
	local healthbar = windowName .. "HitPointsBar"

	-- update the healthbar
	StatusBarSetMaximumValue(healthbar, max or 1)
	StatusBarSetCurrentValue(healthbar, min or 1)	

	-- update the healthbar color (standard red)
	HealthBarColor.UpdateHealthBarColor(healthbar, 0)
end

function AnimalLore.SetPetColor()

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- set the pet color title
	LabelSetText(windowName .. "PetColorTitle", GetStringFromTid(1062277)) -- Color

	-- text to show as name for the hue
	local colorText = L""

	-- convert the hue into r, g, b
	local r, g, b = HueRGBAValue(AnimalLore.CurrentCreature["Hue"])

	-- create the hex string for the color
	local hexColor = wstring.upper(wstring.format(L"%02x", r)) .. wstring.upper(wstring.format(L"%02x", g)) .. wstring.upper(wstring.format(L"%02x", b))
	
	-- get the colors table (if we have one)
	local colorsTable = CreaturesDB.Colors[AnimalLore.CurrentCreature["BodyID"]]

	-- do we have a multiple pets selection?
	if table.countElements(colorsTable) > 1 then

		-- get the colors table for the selected pet
		colorsTable = colorsTable[AnimalLore.CurrentCreature["Type"]]
	end

	-- do we have the colors table?
	if colorsTable then

		-- get the data for the current hue
		local hueData = colorsTable[AnimalLore.CurrentCreature["Hue"]]

		-- do we have the hue data?
		if hueData then

			-- do we have the rarity for the color?
			if hueData.chance then

				-- set the text to the color name and chance
				colorText = FormatProperly(ReplaceTokens(GetStringFromTid(457), { GetStringFromTid(hueData.name), towstring(hueData.chance) .. L"%" }))
			else

				-- set the text to the color name
				colorText = FormatProperly(ReplaceTokens(GetStringFromTid(458), { hueData.name }))
			end
		end

	else -- set the text to the hue ID
		colorText = L"#" .. ReplaceTokens(GetStringFromTid(457), { hexColor, towstring(AnimalLore.CurrentCreature["Hue"]) })
	end

	-- set the pet type name
	LabelSetText(windowName .. "PetColorValueLabel", colorText)

	-- color the button
	WindowSetTintColor(windowName .. "PetColorValueButton", r, g, b)
end

function AnimalLore.SetPetType()

	-- animal lore main window
	local windowName = "AnimalLore" 

	-- set the pet type title
	LabelSetText(windowName .. "PetTypeTitle", GetStringFromTid(1078603)) -- Type

	-- get the type
	local petType = AnimalLore.CurrentCreature["Type"] or GetStringFromTid(1071999) -- unknown

	-- set the pet type name
	LabelSetText(windowName .. "PetTypeText", FormatProperly(petType)) -- L"ozymandias the lord of castle barataria"))--

	-- do we have only 1 DB type to match the creature?
	if #AnimalLore.PetSelection <= 1 then

		-- disable the button to pick another type
		WindowSetHandleInput(windowName .. "PetTypeText", false)
	end

	-- draw the correct portrait (it takes a short time to get the correct data)
	Interface.AddTodoList({name = "target window draw portrait", func = function() SetPortraitImage(AnimalLore.TargetID, windowName .. "Portrait") end, time = Interface.TimeSinceLogin + 0.5})
end

function AnimalLore.ColorsTooltip()
	
	-- get the window name
	local windowName = SystemData.ActiveWindow.name

	-- get the colors table (if we have one)
	local colorsTable = CreaturesDB.Colors[AnimalLore.CurrentCreature["BodyID"]]
	
	-- do we have a multiple pets selection?
	if table.countElements(colorsTable) > 1 then

		-- get the colors table for the selected pet
		colorsTable = colorsTable[AnimalLore.CurrentCreature["Type"]]
	end

	-- do we have the colors table?
	if colorsTable then

		-- hue sorted by chance
		local chanceSort = {}

		-- scan the colors table
		for hue, hueData in pairsByKeys(colorsTable) do

			-- add the color to the table
			table.insert(chanceSort, hue)
		end

		-- sort the table by chance
		local pos = 1

		-- loop through the list
		while pos <= #chanceSort do

			-- current hue chance
			local currChance = colorsTable[chanceSort[pos]].chance

			-- previous hue chance
			local prevChance = 0

			-- do we have a previous hue?
			if colorsTable[chanceSort[pos-1]] then
				prevChance = colorsTable[chanceSort[pos-1]].chance
			end
			
			-- is this the first element or the previous element is bigger than this one?
			if (pos == 1 or currChance <= prevChance) then

				-- move to the next element
				pos = pos + 1

			else -- store the element
				local swap = chanceSort[pos]

				-- move the previous element to th current position
				chanceSort[pos] = chanceSort[pos-1]

				-- move the store element to the previous position
				chanceSort[pos-1] = swap

				-- move to the previous position
				pos = pos - 1
			end
		end

		-- reset the tooltip
		Tooltips.ClearTooltip()

		-- scan the colors table
		for i, hue in pairsByKeys(chanceSort) do

			-- get the hue data
			local hueData = colorsTable[hue]

			-- convert the hue into r, g, b
			local r, g, b = HueRGBAValue(hue)

			-- make sure the color is visible
			if r < 30 and g < 30 and b < 30 then
				r = r + 30
				g = r + 30
				b = r + 30
			end

			-- do we have the rarity for the color?
			if hueData.chance then

				-- set the text to the color name and chance
				colorText = FormatProperly(ReplaceTokens(GetStringFromTid(457), { GetStringFromTid(hueData.name), towstring(hueData.chance) .. L"%" }))
			else

				-- set the text to the color name
				colorText = FormatProperly(ReplaceTokens(GetStringFromTid(458), { hueData.name }))
			end

			-- add the color text
			Tooltips.SetTooltipText(i, 1, colorText)
			
			-- set the text color
			Tooltips.SetTooltipColor(i, 1, r, g, b)
		end

		-- show the tooltip
		Tooltips.Finalize()

		-- anchor the tooltip
		Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	end
end

function AnimalLore.InitializeKnownPets()

	-- do we have the known pets table?
	if AnimalLore.KnownPetsAll == nil then

		-- create the known pets table
		AnimalLore.KnownPetsAll = {}
	end
	
	-- get the known pets table from the character saved variables
	AnimalLore.KnownPetsType = AnimalLore.KnownPetsAll

	-- mark the table as initialized
	AnimalLore.KnownPetsInitialized = true
end

function AnimalLore.CleanTags(str)

	-- do we have a valid string?
	if not IsValidWString(str) then
		return str
	end

	-- remove all the possible HTML tags
	str = wstring.gsub(str, L"<div align=right>", L"")
	str = wstring.gsub(str, L"</div>", L"")
	str = wstring.gsub(str, L"<div align=right>", L"")
	str = wstring.gsub(str, L"<center><i>", L"")
	str = wstring.gsub(str, L"</i></center>", L"")
	str = wstring.gsub(str, L"<BASEFONT COLOR=#000080>", L"")
	str = wstring.gsub(str, L"<BASEFONT COLOR=#008000>", L"")
	str = wstring.gsub(str, L"<BASEFONT COLOR=#57412F>", L"")
	str = wstring.gsub(str, L"<BASEFONT COLOR=#FF0000>", L"")
	str = wstring.gsub(str, L"<BASEFONT COLOR=#BF80FF>", L"")
	str = wstring.gsub(str, L"<DIV ALIGN=CENTER>", L"")
	str = wstring.gsub(str, L"<DIV ALIGN=RIGHT>", L"")

	-- return the cleaned string
	return str
end

function AnimalLore.GetProgressID(mobileId, mobName)

	-- invalid id
	if not IsValidID(mobileId) then
		return 0
	end

	-- not a pet
	if not IsObjectIdPet(mobileId) then
		return 0
	end

	-- searching by id first since the search by name is gonna be more resource expensive...
	for i, pet in pairs(AnimalLore.PetProgress) do

		-- is this the pet we're looking for?
		if	AnimalLore.PetProgress[i].id and AnimalLore.PetProgress[i].id == mobileId then
			return i
		end
	end

	-- invalid name or not specified
	if not IsValidWString(mobName) then
		
		-- get the mobile name
		mobName = GetMobileName(mobileId)
	end

	-- convert the name in lower case
	mobName = wstring.lower(mobName)

	-- scan again the table
	for i, pet in pairs(AnimalLore.PetProgress) do

		-- is this the pet we're looking for?
		if	AnimalLore.PetProgress[i].name == mobName  then -- name match
			return i
		end
	end

	return 0
end

function AnimalLore.ColorResistancesTotal(label, icon, difference)

	-- do we have valid parameters?
	if not DoesWindowExist(label) or not DoesWindowExist(icon) then
		return
	end

	-- default color: green
	local r, g, b = 0, 255, 0

	-- is the difference lower than -10?
	if difference <= -15 then

		-- set the colors to red
		r, g, b = 255, 83, 87

	-- is the difference lower than -15?
	elseif difference <= -10 then

		-- set the colors to yellow
		r, g, b = 255, 226, 128
	end
	
	-- set the label color
	LabelSetTextColor(label, r, g, b)

	-- set the highlight color
	WindowSetTintColor(icon, r, g, b)
end

function AnimalLore.ColorLabelByStatRange(label, value, min, max)

	-- do we have valid parameters?
	if not DoesWindowExist(label) then
		return
	end

	-- do we have the range of values?
	if not min or not max or not value then

		-- color the label white
		LabelSetTextColor(label, 255, 255, 255)

		-- we can get out
		return
	end

	-- calculate the range of values
	local range = max - min

	-- calculate the worst percentage
	local percCrap = range * (Interface.Settings.AnimalLoreVERYBADPerc / 100)

	-- calculate the bad percentage
	local percBad = range * (Interface.Settings.AnimalLoreBADPerc / 100)

	-- calculate the worst value
	local valueCrap = min + (range - percCrap)

	-- calculate the bad value
	local valueBad = min + (range - percBad)

	-- perfect values
	if value - valueBad >= 0 then

		-- color the label white
		LabelSetTextColor(label, 255, 255, 255)

	-- is the value in the worst range?
	elseif value < valueCrap then

		-- color the label red
		LabelSetTextColor(label, 255, 83, 87)

	-- is the value in the bad range?
	elseif value <= valueBad then

		-- color the label yellow
		LabelSetTextColor(label, 255, 226, 128)
	end
end

function AnimalLore.ToggleGump()

	-- show/hide the legacy gump
	GumpsParsing.GumpMaps[AnimalLore.gumpID].show = not GumpsParsing.GumpMaps[AnimalLore.gumpID].show
	GumpsParsing.ToShow[AnimalLore.gumpID] = GumpsParsing.GumpMaps[AnimalLore.gumpID].show
end

function AnimalLore.GetControlChance()

	-- do we have the taming required?
	if not AnimalLore.CurrentCreature["DBTaming"] and not AnimalLore.CurrentCreature["TamingRequired"] then
		return 0
	end

	-- initialize the variables
	local tam1, lore1, skillbonus, mod1, mod2

	-- get the animal lore skill
	local anil = GetSkillValue(SkillsWindow.SkillsID.ANIMAL_LORE, true)
	
	-- get the animal taming skill
	local tam = GetSkillValue(SkillsWindow.SkillsID.ANIMAL_TAMING, true)
	
	-- calculate the taming value from the gump
	local minTaming = tonumber(AnimalLore.CurrentCreature["TamingRequired"])

	-- is the player human?
	if WindowData.PlayerStatus["Race"] == 1 then

		-- is animal lore less than 20?
		if anil < 20 then

			-- set animal lore to 20
			anil = 20
		end

		-- is animal taming less than 20?
		if tam < 20 then

			-- set animal taming to 20
			tam = 20
		end
	end
	
	-- calculate the taming difference between pet and the character skill value
    tam1 = tam - minTaming

	-- calculate the lore difference between pet required taming and the character skill value
    lore1 = anil - minTaming

	-- calculate the first modifier
	-- if the taming difference is greater than 0 the modifier is 6
    if tam1 >= 0 then 
		mod1 = 6

	else -- if the taming difference is less than 0 the modifier is 28
		mod1 = 28
	end

	-- if the lore difference is greater than 0 the modifier is 6
    if lore1 >= 0 then 
		mod2 = 6

	else -- if the lore difference is less than 0 the modifier is 14
		mod2 = 14
	end

	-- calculate the taming modifier value
    tam1 = mod1 * tam1

	-- calculate the lore modifier value
    lore1 = mod2 * lore1

	-- calculate the skill bonus
    skillbonus = (tam1 + lore1) / 2

	-- calculate the chance of control
    local chanceControl = 70 + skillbonus

	-- are the chances less than 0?
    if chanceControl < 0 then 
		
		-- set the control chances to 0
		chanceControl = 0
	end

	-- are the control chances higher than 99?
    if chanceControl > 99 then 

		-- set the control chances to 99
		chanceControl = 99
	end

	return chanceControl
end

function AnimalLore.PetTrainingButton()
	
	-- begin training button ID
	local buttonId = 2

	-- is the training completed?
	if tonumber(AnimalLore.CurrentCreature.TrainProgress) == 100 then

		-- pet training options button ID
		buttonId = 3
	end

	-- press the training button
	GumpsParsing.PressButton(AnimalLore.gumpID, buttonId)
end

function AnimalLore.CancelPetTrainingButton()
	
	-- create the buttons data
	local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() GumpsParsing.PressButton(AnimalLore.gumpID, 4) end } -- OK
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL } -- Cancel

	-- create the dialog data
	local CancelTrainingWindow = 
				{
					windowName = "CancelTrainingDialog",
					bodyTid = 507,
					titleTid = 506,
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
				}

	-- create the cancel training confirm dialog
	UO_StandardDialog.CreateDialog(CancelTrainingWindow)	
end

function AnimalLore.RatePet()
	
	-- we rate only wild creatures and only if we have the data from the DB to do the rating
	if AnimalLore.CurrentCreature["Loyalty"] ~= 1061643 or not AnimalLore.CurrentCreature["Type"] or not AnimalLore.CurrentCreature["DBTaming"] then
		return
	end

	-- initialize the ratings array
	AnimalLore.Ratings = {}

	-- >>>>>>> RESISTANCES RATING (65% of the total) <<<<<<< --

	-- max value that a res can count
	local singleResRatio = 65 / table.countElements(AnimalLore.Resistances)

	-- initialize the res ratio
	AnimalLore.Ratings["Res"] = 0

	-- scan all the resistances
	for r, _ in pairs(AnimalLore.Resistances) do

		-- get the resistance data
		local currRes = AnimalLore.CurrentCreature.Resistances[r]

		-- is the min (or the current) resistance equal to the max or out of range?
		if currRes.min == currRes.max or currRes.value < currRes.min or currRes.value >= currRes.max then

			-- we have the max possible ratio
			AnimalLore.Ratings["Res"] = AnimalLore.Ratings["Res"] + singleResRatio

		else -- we have a valid resistance range.
			
			-- calculate the current resistance ratio compared to the max possible range, and get a value of the single res ratio as max
			AnimalLore.Ratings["Res"] = AnimalLore.Ratings["Res"] + (((currRes.value - currRes.min) / ((currRes.max - currRes.min) / (singleResRatio / 10))) * 10)
		end
	end

	-- safety check to keep the value in range (it shouldn't be necessary, but you never know...)
	if AnimalLore.Ratings["Res"] > 65 then
		AnimalLore.Ratings["Res"] = 65
	end

	-- >>>>>>> HP RATING (25% of the total) <<<<<<< --

	-- get the hit points data
	local hits = AnimalLore.CurrentCreature.Stats["HitPoints"]

	-- if the min value is the same of the max or the current value is less than the min value, the data is out of range, so we don't consider them
	if hits.min == hits.max or hits.value.total < hits.min or hits.value.total >= hits.max then

		-- since we can't evaluate the hp, we give the max rating so it won't hurt the final rating
		AnimalLore.Ratings["HitPoints"] = 25

	else -- we have a valid HP range.

		-- calculate the current HP ratio compared to the max possible range, and get a value of 25 max
		AnimalLore.Ratings["HitPoints"] = ((hits.value.total - hits.min) / ((hits.max - hits.min) / 2.5)) * 10
	end

	-- safety check to keep the value in range (it shouldn't be necessary, but you never know...)
	if AnimalLore.Ratings["HitPoints"] > 25 then
		AnimalLore.Ratings["HitPoints"] = 25
	end

	-- >>>>>>> STATS RATING (5% of the total) <<<<<<< --

	-- max value that a stat can count
	local singleStatRatio = 5 / table.countElements(AnimalLore.MainStats)

	-- initialize the stats ratio
	AnimalLore.Ratings["Stats"] = 0

	-- scan the main stats
	for s, _ in pairs(AnimalLore.MainStats) do
		
		-- get the stat data
		local currStat = AnimalLore.CurrentCreature.Stats[s]

		-- get the current stat value
		local currValue = currStat.value

		-- is the value is less than 125?
		if currValue < 125 then

			-- we consider the value as 125 (since all pets can be trained up to this level)
			currValue = 125
		end

		-- is the min (or the current) stat equal to the max or out of range?
		if currStat.min == currStat.max or currStat.value < currStat.min or currStat.value >= currStat.max then

			-- we have the max possible ratio
			AnimalLore.Ratings["Stats"] = AnimalLore.Ratings["Stats"] + singleStatRatio

		else -- we have a valid stat range.
			
			-- calculate the current stat ratio compared to the max possible range, and get a value base on the single stat ratio as max
			AnimalLore.Ratings["Stats"] = AnimalLore.Ratings["Stats"] + (((currStat.value - currStat.min) / ((currStat.max - currStat.min) / (singleStatRatio / 10))) * 10)
		end
	end

	-- safety check to keep the value in range (it shouldn't be necessary, but you never know...)
	if AnimalLore.Ratings["Stats"] > 5 then
		AnimalLore.Ratings["Stats"] = 5
	end

	-- >>>>>>> SKILLS RATING (5% of the total) <<<<<<< --

	-- max value that a skill can count
	local singleSkillRatio = 5 / table.countElements(AnimalLore.DBSkills)

	-- initialize the stats ratio
	AnimalLore.Ratings["Skills"] = 0

	-- scan the main skills
	for s, _ in pairs(AnimalLore.DBSkills) do
		
		-- get the skill data
		local currSkill = AnimalLore.CurrentCreature.Skills[s]

		-- is the min (or the current) skill equal to the max or out of range?
		if currSkill.min == currSkill.max or currSkill.value < currSkill.min or currSkill.value >= currSkill.max then

			-- we have the max possible ratio
			AnimalLore.Ratings["Skills"] = AnimalLore.Ratings["Skills"] + singleSkillRatio

		else -- we have a valid stat range.
			
			-- calculate the current skill ratio compared to the max possible range, and get a value base on the single skill ratio as max
			AnimalLore.Ratings["Skills"] = AnimalLore.Ratings["Skills"] + (((currSkill.value - currSkill.min) / ((currSkill.max - currSkill.min) / (singleSkillRatio / 10))) * 10)
		end
	end

	-- safety check to keep the value in range (it shouldn't be necessary, but you never know...)
	if AnimalLore.Ratings["Skills"] > 5 then
		AnimalLore.Ratings["Skills"] = 5
	end
end

function AnimalLore.RatingTooltip()

	-- we rate only wild creatures and only if we have the data from the DB to do the rating
	if (AnimalLore.CurrentCreature["Loyalty"] ~= 1061643 and not (Interface.Settings.AnimalLoreKhyrosRating and not AnimalLore.CurrentCreature["isTrained"])) or not AnimalLore.CurrentCreature["Type"] or not AnimalLore.CurrentCreature["DBTaming"] then
		return
	end

	-- get the window name
	local windowName = SystemData.ActiveWindow.name

	-- reset the tooltip
	Tooltips.ClearTooltip()

	-- is the Khyro's rating enabled?
	if Interface.Settings.AnimalLoreKhyrosRating then

		AnimalLore.KhyrosRatingTooltip()

	else -- default rating tooltip
		AnimalLore.DefaultRatingTooltip()
	end

	-- FINALIZE

	-- show the tooltip
	Tooltips.Finalize()

	-- anchor the tooltip
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function AnimalLore.DefaultRatingTooltip()

	-- TOTAL RATING:

	-- get the total rate of the pet
	local ratePerc = (AnimalLore.Ratings["Res"] + AnimalLore.Ratings["HitPoints"] + AnimalLore.Ratings["Stats"] + AnimalLore.Ratings["Skills"]) / 100
	
	-- get the rating from 1 to 5
	local StarsRating = (5 * ratePerc)

	-- add the total rating text
	Tooltips.SetTooltipText(1, 1, ReplaceTokens(GetStringFromTid(4), { wstring.format(L"%1.1f", StarsRating), wstring.format(L"%1.1f",  ratePerc * 100) .. L"%" }) )
	
	-- get the red scale
	local r, g, b = WindowUtils.GetRGBForTooltip(ratePerc * 100, 100)
	
	-- set the text color
	Tooltips.SetTooltipColor(1, 1, r, g, b)

	-- RESISTANCES:

	-- add the resistances rating text
	Tooltips.SetTooltipText(2, 1, ReplaceTokens(GetStringFromTid(480), { wstring.format(L"%1.1f", AnimalLore.Ratings["Res"]) .. L"%", wstring.format(L"%1.1f", 65) .. L"%" }) )
	
	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(AnimalLore.Ratings["Res"], 65)

	-- set the text color
	Tooltips.SetTooltipColor(2, 1, r, g, b)

	-- HP:

	-- add the hp rating text
	Tooltips.SetTooltipText(3, 1, ReplaceTokens(GetStringFromTid(481), { wstring.format(L"%1.1f", AnimalLore.Ratings["HitPoints"]) .. L"%", wstring.format(L"%1.1f", 25) .. L"%" }) )
	
	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(AnimalLore.Ratings["HitPoints"], 25)

	-- set the text color
	Tooltips.SetTooltipColor(3, 1, r, g, b)

	-- STATS:

	-- add the stats rating text
	Tooltips.SetTooltipText(4, 1, ReplaceTokens(GetStringFromTid(482), { wstring.format(L"%1.1f", AnimalLore.Ratings["Stats"]) .. L"%", wstring.format(L"%1.1f", 5) .. L"%" }) )
	
	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(AnimalLore.Ratings["Stats"], 5)

	-- set the text color
	Tooltips.SetTooltipColor(4, 1, r, g, b)

	-- SKILLS:

	-- add the skills rating text
	Tooltips.SetTooltipText(5, 1, ReplaceTokens(GetStringFromTid(483), { wstring.format(L"%1.1f", AnimalLore.Ratings["Skills"]) .. L"%", wstring.format(L"%1.1f", 5) .. L"%" }) )
	
	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(AnimalLore.Ratings["Skills"], 5)

	-- set the text color
	Tooltips.SetTooltipColor(5, 1, r, g, b)
end

function AnimalLore.KhyrosRatingTooltip()

	-- add the total rating text
	Tooltips.SetTooltipText(1, 1, ReplaceTokens(GetStringFromTid(543), { wstring.format(L"%1.0f", AnimalLore.Ratings["Total"].intensity),  wstring.format(L"%1.0f", AnimalLore.Ratings["Total"].maxIntensity), wstring.format(L"%1.1f",  AnimalLore.Ratings["Total"].perc) .. L"%" }) )
	
	-- get the red scale
	local r, g, b = WindowUtils.GetRGBForTooltip(AnimalLore.Ratings["Total"].perc, 100)
	
	-- set the text color
	Tooltips.SetTooltipColor(1, 1, r, g, b)

	-- add the stat rating text
	Tooltips.SetTooltipText(2, 1, ReplaceTokens(GetStringFromTid(544), { wstring.format(L"%1.0f", AnimalLore.Ratings["Stats"].intensity),  wstring.format(L"%1.0f", AnimalLore.Ratings["Stats"].maxIntensity), wstring.format(L"%1.1f",  AnimalLore.Ratings["Stats"].perc) .. L"%" }) )
	
	-- get the red scale
	local r, g, b = WindowUtils.GetRGBForTooltip(AnimalLore.Ratings["Stats"].perc, 100)
	
	-- set the text color
	Tooltips.SetTooltipColor(2, 1, r, g, b)

	-- add the res rating text
	Tooltips.SetTooltipText(3, 1, ReplaceTokens(GetStringFromTid(545), { wstring.format(L"%1.0f", AnimalLore.Ratings["Res"].intensity),  wstring.format(L"%1.0f", AnimalLore.Ratings["Res"].maxIntensity), wstring.format(L"%1.1f",  AnimalLore.Ratings["Res"].perc) .. L"%" }) )
	
	-- get the red scale
	local r, g, b = WindowUtils.GetRGBForTooltip(AnimalLore.Ratings["Res"].perc, 100)
	
	-- set the text color
	Tooltips.SetTooltipColor(3, 1, r, g, b)

	-- add the skills rating text
	Tooltips.SetTooltipText(4, 1, ReplaceTokens(GetStringFromTid(546), { wstring.format(L"%1.0f", AnimalLore.Ratings["Skills"].intensity),  wstring.format(L"%1.0f", AnimalLore.Ratings["Skills"].maxIntensity), wstring.format(L"%1.1f",  AnimalLore.Ratings["Skills"].perc) .. L"%" }) )
	
	-- get the red scale
	local r, g, b = WindowUtils.GetRGBForTooltip(AnimalLore.Ratings["Skills"].perc, 100)
	
	-- set the text color
	Tooltips.SetTooltipColor(4, 1, r, g, b)
end

function AnimalLore.SaveLog()

	-- default line break
	local lineBreak = L"\r\n"

	-- initialize the text to write in the log file
	local data = L"-"

	-- add a line at the beginning of the text file
	data = wstring.appendWithSeparator(data, L"------------------------------------", lineBreak)

	-- add the creature name to the log
	data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(1061639), { AnimalLore.CurrentCreature["Name"] }), lineBreak) -- Name: ~1_NAME~

	-- do we have the creature type?
	if AnimalLore.CurrentCreature["Type"] then

		-- add the creature type to the log
		data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(1151396), { AnimalLore.CurrentCreature["Type"] }), lineBreak) -- Type: ~1_val~
	end

	-- add the body ID to the log
	data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(484), { AnimalLore.CurrentCreature["BodyID"] }), lineBreak)

	-- add the creature color to the log
	data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(485), { AnimalLore.CurrentCreature["Hue"] }), lineBreak)

	-- add the creature loyalty rating to the log
	data = wstring.appendWithSeparator(data, GetStringFromTid(1049594) .. L": " .. GetStringFromTid(AnimalLore.CurrentCreature["Loyalty"]), lineBreak) -- Loyalty Rating

	-- get the barding difficulty
	local bdiff = AnimalLore.CurrentCreature["BardingDifficulty"]
	
	-- do we have a valid number value for the barding difficulty?
	if bdiff == L"---" then

		-- set the text to Immune
		bdiff = GetStringFromTid(475)

	else
		-- format the number properly
		bdiff = AddLeadingSpaces(wstring.format(L"%1.1f", tonumber(bdiff)))
	end

	-- add the creature loyalty rating to the log
	data = wstring.appendWithSeparator(data, GetStringFromTid(1070793) .. L": " .. bdiff, lineBreak) -- Barding Difficulty

	-- get the required taming skill
	local taming = AnimalLore.CurrentCreature["TamingRequired"]

	-- do we have a valid skill value?
	if tonumber(taming) then

		-- format the taming skill value
		taming = wstring.format(L"%.1f", taming)

		-- add the creature required taming to the log
		data = wstring.appendWithSeparator(data, GetStringFromTid(1002010) .. L": " .. taming, lineBreak) -- Animal Taming

		-- add the creature pet slots to the log
		data = wstring.appendWithSeparator(data, GetStringFromTid(1115783) .. L": " .. AnimalLore.CurrentCreature["PetSlots"].value, lineBreak) -- Pet Slots

	else -- cannot be tamed
		taming = GetStringFromTid(476)

		-- add the creature required taming to the log
		data = wstring.appendWithSeparator(data, GetStringFromTid(1002010) .. L": " .. taming, lineBreak) -- Animal Taming
	end

	-- get the food type
	local food = AnimalLore.CurrentCreature["Food"]
	
	-- do we have the food TID?
	if not food then

		-- set the TID to Unknown
		food = 1074235
	end

	-- is this pet a goat?
	if CreaturesDB.IsGoat(AnimalLore.TargetID) then

		-- change the food TID
		food = 473
	end

	-- add the creature preferred food to the log
	data = wstring.appendWithSeparator(data, GetStringFromTid(1049563) .. L": " .. GetStringFromTid(food), lineBreak) -- Preferred Foods

	-- add the creature pack instincts to the log
	data = wstring.appendWithSeparator(data, GetStringFromTid(1049569) .. L": " .. GetStringFromTid(AnimalLore.CurrentCreature["Packs"]), lineBreak) -- Pack Instincts
	
	-- add the stats title
	data = wstring.appendWithSeparator(data, L"---------" .. wstring.upper(GetStringFromTid(1114262)) .. L"---------", lineBreak) -- Stats

	-- scan the main stats
	for stat, _ in pairs(AnimalLore.MainStats) do

		-- initialize the stat value
		local statString = GetStringFromTid(AnimalLore.StatsToTid[stat]) .. L": " .. AnimalLore.CurrentCreature.Stats[stat].value

		-- do we have the max value from the DB?
		if AnimalLore.CurrentCreature.Stats[stat].max then

			-- add the cap to the stat value
			statString = statString .. L" (" .. AnimalLore.CurrentCreature.Stats[stat].max .. L")"
		end

		-- add the stat string to the log
		data = wstring.appendWithSeparator(data, statString, lineBreak)
	end

	-- scan the secondary stats
	for stat, _ in pairs(AnimalLore.SecondaryStats) do
	
		-- get the pet current stat
		local dt = AnimalLore.CurrentCreature.Stats[stat].value
		
		-- initialize the stat value
		local statString = GetStringFromTid(AnimalLore.StatsToTid[stat]) .. L": "

		-- do we have the min/max value?
		if type(dt) == "table" then
	
			-- set the current and max value
			statString = statString .. StringUtils.AddCommasToNumber(dt.total)

		else -- if we have a single value, we show that
			statString = statString .. StringUtils.AddCommasToNumber(dt)
		end

		-- do we have the max possible from the DB?
		if AnimalLore.CurrentCreature.Stats[stat].max then

			-- append the max value
			statString = statString ..  L" (" .. StringUtils.AddCommasToNumber(AnimalLore.CurrentCreature.Stats[stat].max) .. L")"
		end

		-- add the stat string to the log
		data = wstring.appendWithSeparator(data, statString, lineBreak)
	end

	-- scan the regenerations
	for stat, _ in pairs(AnimalLore.Regenerations) do

		-- add the regeneration string to the log
		data = wstring.appendWithSeparator(data, GetStringFromTid(AnimalLore.StatsToTid[stat]) .. L": " .. AnimalLore.CurrentCreature.Stats[stat].value, lineBreak)
	end

	-- add the damage title
	data = wstring.appendWithSeparator(data, L"---------" .. wstring.upper(GetStringFromTid(1017319)) .. L"---------", lineBreak) -- Damage

	-- format the damage string
	local damage = wstring.gsub(AnimalLore.CurrentCreature.Damage["BaseDamage"].value, L"[-]", L" - ")

	-- add the creature base damage to the log
	data = wstring.appendWithSeparator(data, GetStringFromTid(1076750) .. L": " .. damage, lineBreak) -- Base Damage

	-- table for the sorted damage types
	local sortedDamages = {}

	-- scan the damage types
	for dam, idx in pairs(AnimalLore.DamageTypes) do

		-- add the damage to the sorted table
		table.insert(sortedDamages, idx, dam)
	end

	-- scan the sorted damage types
	for idx, damage in pairsByIndex(sortedDamages) do

		-- get the pet current damage
		local val = AnimalLore.CurrentCreature.Damage[damage]

		-- add the creature damage type to the log
		data = wstring.appendWithSeparator(data, GetStringFromTid(AnimalLore.DamageToTid[damage]) .. L": " .. val .. L"%", lineBreak)
	end

	-- add the resistances title
	data = wstring.appendWithSeparator(data, L"---------" .. wstring.upper(GetStringFromTid(1061645)) .. L"---------", lineBreak) -- Resistances

	-- table for the sorted damage types
	local sortedRes = {}

	-- scan the resistances
	for dam, idx in pairs(AnimalLore.Resistances) do

		-- add the damage to the sorted table
		table.insert(sortedRes, idx, dam)
	end
	
	-- scan the sorted resistances
	for idx, res in pairsByKeys(sortedRes) do

		-- get the current resistance value
		local val = GetStringFromTid(AnimalLore.ResistancesToTid[res]) .. L": " .. AnimalLore.CurrentCreature.Resistances[res].value

		-- do we have the max possible from the DB?
		if AnimalLore.CurrentCreature.Resistances[res].max then

			-- append the max value
			val = val ..  L" (" .. StringUtils.AddCommasToNumber(AnimalLore.CurrentCreature.Resistances[res].max) .. L")"
		end

		-- add the creature resistance to the log
		data = wstring.appendWithSeparator(data, val, lineBreak)
	end

	-- add the creature total resistances to the log
	data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(486), { towstring(AnimalLore.CurrentCreature.Resistances["Total"].value), towstring(AnimalLore.CurrentCreature.Resistances["Total"].max) } ), lineBreak)

	-- add the skills title
	data = wstring.appendWithSeparator(data, L"---------" .. wstring.upper(GetStringFromTid(1115030)) .. L"---------", lineBreak) -- Skills

	-- table for the sorted skill names
	local sortedSkills = {}

	-- scan the DB skills
	for skill, _ in pairs(AnimalLore.DBSkills) do

		-- add the skill with the text name to the sorted skills list
		sortedSkills[skill] = FormatProperly(GetStringFromTid(AnimalLore.SkillsToTid[skill]))
	end

	-- scan the out of DB skills
	for skill, _ in pairs(AnimalLore.OutOfDBSkills) do

		-- add the skill with the text name to the sorted skills list
		sortedSkills[skill] = FormatProperly(GetStringFromTid(AnimalLore.SkillsToTid[skill]))
	end

	-- scan the DB skills
	for skill, textName in pairsByKeys(sortedSkills) do

		-- get the current skill value
		local val = AnimalLore.CurrentCreature.Skills[skill].value

		-- is the skill value 0?
		if val == 0 then

			-- set the skill value to ---
			val = L"---"

			-- add the creature skill to the log
			data = wstring.appendWithSeparator(data, textName .. L": " .. val, lineBreak)

			continue
		end

		-- get the current skill cap
		local cap = AnimalLore.CurrentCreature.Skills[skill].cap or L"---"

		-- get the current skill cap
		local max = AnimalLore.CurrentCreature.Skills[skill].max
		
		-- make sure the max value is not less than 100
		if max and max < 100 then
			max = 100
		end

		-- initialize the string text
		local skillString =  textName .. L": " .. val .. L" / " .. cap 

		-- do we have the max value from the DB?
		if max then

			-- append the max value
			skillString = skillString .. L" (" ..  max .. L")"
		end

		-- add the creature skill to the log
		data = wstring.appendWithSeparator(data, skillString, lineBreak)
	end
	
	-- do we have special attacks?
	if #AnimalLore.CurrentCreature["Specials"] > 0 then
		
		-- add the specials title
		data = wstring.appendWithSeparator(data, L"---------" .. wstring.upper(GetStringFromTid(1157480)) .. L"---------", lineBreak) -- Special Abilities

		-- scan all the special moves
		for i, spec in pairsByIndex(AnimalLore.CurrentCreature["Specials"]) do

			-- add the creature special move to the log
			data = wstring.appendWithSeparator(data, GetStringFromTid(spec.tid), lineBreak)
		end
	end

	-- do we have advancements?
	if #AnimalLore.CurrentCreature["Advancements"] > 0 then

		-- add the advancements title
		data = wstring.appendWithSeparator(data, L"---------" .. wstring.upper(GetStringFromTid(1157505)) .. L"---------", lineBreak) -- Pet Advancements

		-- scan all the advancements
		for i, spec in pairsByIndex(AnimalLore.CurrentCreature["Advancements"]) do

			-- get the current advancement
			local val = GetStringFromTid(spec.tid)

			-- does this advancement have a value (skill cap increase usually)
			if spec.isSkill then

				-- append the cap to the advancement
				val = val .. L" " .. towstring(AnimalLore.CurrentCreature["Skills"][AnimalLore.SkillToDBName[spec.tid]].advancementCap)
			end

			-- add the creature advancement to the log
			data = wstring.appendWithSeparator(data, val, lineBreak)
		end
	end

	-- we rate only wild creatures and only if we have the data from the DB to do the rating
	if AnimalLore.CurrentCreature["Loyalty"] == 1061643 and not Interface.Settings.AnimalLoreKhyrosRating and AnimalLore.CurrentCreature["Type"] ~= nil and AnimalLore.CurrentCreature["DBTaming"] ~= nil then
		
		-- add the ratings title
		data = wstring.appendWithSeparator(data, L"---------" .. L"RATINGS" .. L"---------", lineBreak)

		-- add the resistances rating to the log
		data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(480), { wstring.format(L"%1.1f", AnimalLore.Ratings["Res"]) .. L"%", wstring.format(L"%1.1f", 65) .. L"%" }), lineBreak)

		-- add the hit points rating to the log
		data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(481), { wstring.format(L"%1.1f", AnimalLore.Ratings["HitPoints"]) .. L"%", wstring.format(L"%1.1f", 25) .. L"%" }), lineBreak)

		-- add the stats rating to the log
		data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(482), { wstring.format(L"%1.1f", AnimalLore.Ratings["Stats"]) .. L"%", wstring.format(L"%1.1f", 5) .. L"%" }), lineBreak)

		-- add the skills rating to the log
		data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(483), { wstring.format(L"%1.1f", AnimalLore.Ratings["Skills"]) .. L"%", wstring.format(L"%1.1f", 5) .. L"%" }), lineBreak)

		-- get the total rate of the pet
		local ratePerc = (AnimalLore.Ratings["Res"] + AnimalLore.Ratings["HitPoints"] + AnimalLore.Ratings["Stats"] + AnimalLore.Ratings["Skills"]) / 100
	
		-- get the rating from 1 to 5
		local StarsRating = (5 * ratePerc)
		
		-- add the overall rating to the log
		data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(4), { wstring.format(L"%1.1f", StarsRating), wstring.format(L"%1.1f",  ratePerc * 100) .. L"%" }), lineBreak)

	-- Khyro's rating system only works on untrained pets, since trained pets increases their current slot, if they have more slots than the min from DB is trained.
	elseif Interface.Settings.AnimalLoreKhyrosRating and AnimalLore.CurrentCreature["Type"] ~= nil and AnimalLore.CurrentCreature["DBTaming"] ~= nil and  not AnimalLore.CurrentCreature["isTrained"] then

		-- add the ratings title
		data = wstring.appendWithSeparator(data, L"---------" .. L"RATINGS" .. L"---------", lineBreak)

		-- add the total rating to the log
		data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(543), { wstring.format(L"%1.0f", AnimalLore.Ratings["Total"].intensity),  wstring.format(L"%1.0f", AnimalLore.Ratings["Total"].maxIntensity), wstring.format(L"%1.1f",  AnimalLore.Ratings["Total"].perc) .. L"%" }), lineBreak)

		-- add the stats rating to the log
		data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(544), { wstring.format(L"%1.0f", AnimalLore.Ratings["Stats"].intensity),  wstring.format(L"%1.0f", AnimalLore.Ratings["Stats"].maxIntensity), wstring.format(L"%1.1f",  AnimalLore.Ratings["Stats"].perc) .. L"%" }), lineBreak)

		-- add the res rating to the log
		data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(545), { wstring.format(L"%1.0f", AnimalLore.Ratings["Res"].intensity),  wstring.format(L"%1.0f", AnimalLore.Ratings["Res"].maxIntensity), wstring.format(L"%1.1f",  AnimalLore.Ratings["Res"].perc) .. L"%" }), lineBreak)

		-- add the skills rating to the log
		data = wstring.appendWithSeparator(data, ReplaceTokens(GetStringFromTid(546), { wstring.format(L"%1.0f", AnimalLore.Ratings["Skills"].intensity),  wstring.format(L"%1.0f", AnimalLore.Ratings["Skills"].maxIntensity), wstring.format(L"%1.1f",  AnimalLore.Ratings["Skills"].perc) .. L"%" }), lineBreak)

	end
	
	-- save the log file
	CreateTextFile("logs/AnimalLore/" .."[" .. GetClockString() .. "] " ..  tostring(AnimalLore.CurrentCreature["Name"]) .. ".txt", data)
end

function AnimalLore.CapsTooltip()
	
	-- reset the tooltip
	Tooltips.ClearTooltip()

	-- create the tooltip
	Tooltips.SetTooltipText(1, 1, GetStringFromTid(494))

	-- str + int cap = 700
	local strInt = AnimalLore.CurrentCreature.Stats["Str"].value + AnimalLore.CurrentCreature.Stats["Int"].value

	-- show the str + int cap
	Tooltips.SetTooltipText(2, 1, ReplaceTokens(GetStringFromTid(495), { StringUtils.AddCommasToNumber(strInt), L"700" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(strInt, 700, true)

	-- set the text color
	Tooltips.SetTooltipColor(2, 1, r, g, b)

	-- dex cap = 150
	local dexCap = AnimalLore.CurrentCreature.Stats["Dex"].value

	-- show the dex cap
	Tooltips.SetTooltipText(3, 1, ReplaceTokens(GetStringFromTid(496), { StringUtils.AddCommasToNumber(dexCap), L"150" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(dexCap, 150, true)

	-- set the text color
	Tooltips.SetTooltipColor(3, 1, r, g, b)

	-- hp cap = 1100
	local hpCap = AnimalLore.CurrentCreature.Stats["HitPoints"].value

	-- do we have a single value?
	if type(hpCap) == "table" then
		hpCap = hpCap.total
	end

	-- show the hp cap
	Tooltips.SetTooltipText(4, 1, ReplaceTokens(GetStringFromTid(497), { StringUtils.AddCommasToNumber(hpCap), L"1100" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(hpCap, 1100, true)

	-- set the text color
	Tooltips.SetTooltipColor(4, 1, r, g, b)

	-- stam cap = 150
	local stamCap = AnimalLore.CurrentCreature.Stats["Stamina"].value

	-- do we have a single value?
	if type(stamCap) == "table" then
		stamCap = stamCap.total
	end

	-- show the stam cap
	Tooltips.SetTooltipText(5, 1, ReplaceTokens(GetStringFromTid(498), { StringUtils.AddCommasToNumber(stamCap), L"150" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(stamCap, 150, true)

	-- set the text color
	Tooltips.SetTooltipColor(5, 1, r, g, b)

	-- mana cap = 1500
	local manaCap = AnimalLore.CurrentCreature.Stats["Mana"].value

	-- do we have a single value?
	if type(manaCap) == "table" then
		manaCap = manaCap.total
	end

	-- show the mana cap
	Tooltips.SetTooltipText(6, 1, ReplaceTokens(GetStringFromTid(499), { StringUtils.AddCommasToNumber(manaCap), L"1,500" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(manaCap, 1500, true)

	-- set the text color
	Tooltips.SetTooltipColor(6, 1, r, g, b)

	-- res cap = 80 each
	local physCap = AnimalLore.CurrentCreature.Resistances["Physical"].value

	-- show the res cap
	Tooltips.SetTooltipText(7, 1, ReplaceTokens(GetStringFromTid(500), { StringUtils.AddCommasToNumber(physCap), L"80" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(physCap, 80, true)

	-- set the text color
	Tooltips.SetTooltipColor(7, 1, r, g, b)

	-- res cap = 80 each
	local fireCap = AnimalLore.CurrentCreature.Resistances["Fire"].value

	-- show the res cap
	Tooltips.SetTooltipText(8, 1, ReplaceTokens(GetStringFromTid(501), { StringUtils.AddCommasToNumber(fireCap), L"80" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(fireCap, 80, true)

	-- set the text color
	Tooltips.SetTooltipColor(8, 1, r, g, b)

	-- res cap = 80 each
	local coldCap = AnimalLore.CurrentCreature.Resistances["Cold"].value
	
	-- show the res cap
	Tooltips.SetTooltipText(9, 1, ReplaceTokens(GetStringFromTid(502), { StringUtils.AddCommasToNumber(coldCap), L"80" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(coldCap, 80, true)

	-- set the text color
	Tooltips.SetTooltipColor(9, 1, r, g, b)

	-- res cap = 80 each
	local poisCap = AnimalLore.CurrentCreature.Resistances["Poison"].value

	-- show the res cap
	Tooltips.SetTooltipText(10, 1, ReplaceTokens(GetStringFromTid(503), { StringUtils.AddCommasToNumber(poisCap), L"80" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(poisCap, 80, true)

	-- set the text color
	Tooltips.SetTooltipColor(10, 1, r, g, b)

	-- res cap = 80 each
	local enerCap = AnimalLore.CurrentCreature.Resistances["Energy"].value

	-- show the res cap
	Tooltips.SetTooltipText(11, 1, ReplaceTokens(GetStringFromTid(504), { StringUtils.AddCommasToNumber(enerCap), L"80" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(enerCap, 80, true)

	-- set the text color
	Tooltips.SetTooltipColor(11, 1, r, g, b)

	-- all res cap = 365 each
	local allresCap = AnimalLore.CurrentCreature.Resistances["Physical"].value + AnimalLore.CurrentCreature.Resistances["Fire"].value + AnimalLore.CurrentCreature.Resistances["Cold"].value + AnimalLore.CurrentCreature.Resistances["Poison"].value + AnimalLore.CurrentCreature.Resistances["Energy"].value

	-- show the res cap
	Tooltips.SetTooltipText(12, 1, ReplaceTokens(GetStringFromTid(505), { StringUtils.AddCommasToNumber(allresCap), L"365" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(allresCap, 365, true)

	-- set the text color
	Tooltips.SetTooltipColor(12, 1, r, g, b)

	-- FINALIZE

	-- show the tooltip
	Tooltips.Finalize()

	-- anchor the tooltip
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function AnimalLore.WeightsTooltip()

	-- get the window name
	local windowName = SystemData.ActiveWindow.name

	-- str, dex and int weight
	local strDexInt = 0

	-- hp, stam and mana weight
	local hpStamMana = 0

	-- hp, stam and mana weight
	local resists = 0

	-- regenerations weight
	local hpr = 0
	local sr = 0
	local mr = 0

	-- scan the main stats
	for stat, _ in pairs(AnimalLore.MainStats) do

		-- get the stat value
		local val = AnimalLore.CurrentCreature.Stats[stat].value

		-- sum the stat weight
		strDexInt = strDexInt + (AnimalLore.StatsWeight[stat] * val)
	end

	-- scan the secondary stats
	for stat, _ in pairs(AnimalLore.SecondaryStats) do

		-- get the stat value
		local val = AnimalLore.CurrentCreature.Stats[stat].value

		-- do we have the min/max value?
		if type(val) == "table" then
	
			-- set the current and max value
			val = val.total
		end
		
		-- sum the stat weight
		hpStamMana = hpStamMana + (AnimalLore.StatsWeight[stat] * val)
	end

	-- scan the resistances
	for res, _ in pairs(AnimalLore.Resistances) do
		
		-- get the res value
		local val = AnimalLore.CurrentCreature.Resistances[res].value

		-- sum the res weight
		resists = resists + (AnimalLore.StatsWeight["Resist"] * val)
	end

	-- calculate the hpr weight
	hpr = hpr + (AnimalLore.StatsWeight["HitPointsRegen"] * AnimalLore.CurrentCreature.Stats["HitPointsRegen"].value)

	-- calculate the hpr weight
	sr = sr + (AnimalLore.StatsWeight["StaminaRegen"] * AnimalLore.CurrentCreature.Stats["StaminaRegen"].value)

	-- calculate the hpr weight
	mr = mr + (AnimalLore.StatsWeight["ManaRegen"] * AnimalLore.CurrentCreature.Stats["ManaRegen"].value)

	-- reset the tooltip
	Tooltips.ClearTooltip()

	-- create the tooltip
	Tooltips.SetTooltipText(1, 1, GetStringFromTid(493))
	
	-- show the str, dex and int weight cap
	Tooltips.SetTooltipText(2, 1, ReplaceTokens(GetStringFromTid(487), { StringUtils.AddCommasToNumber(wstring.format(L"%1.1f", strDexInt)), L"2,300" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(strDexInt, 2300, true)

	-- set the text color
	Tooltips.SetTooltipColor(2, 1, r, g, b)

	-- show the hp, stam and mana weight cap
	Tooltips.SetTooltipText(3, 1, ReplaceTokens(GetStringFromTid(488), { StringUtils.AddCommasToNumber(wstring.format(L"%1.1f", hpStamMana)), L"3,300" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(hpStamMana, 3300, true)

	-- set the text color
	Tooltips.SetTooltipColor(3, 1, r, g, b)

	-- show the resistances weight cap
	Tooltips.SetTooltipText(4, 1, ReplaceTokens(GetStringFromTid(489), { StringUtils.AddCommasToNumber(wstring.format(L"%1.1f", resists)), L"1,095" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(resists, 1095, true)

	-- set the text color
	Tooltips.SetTooltipColor(4, 1, r, g, b)

	-- show the hpr weight cap
	Tooltips.SetTooltipText(5, 1, ReplaceTokens(GetStringFromTid(490), { StringUtils.AddCommasToNumber(wstring.format(L"%1.1f", hpr)), L"360" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(hpr, 360, true)

	-- set the text color
	Tooltips.SetTooltipColor(5, 1, r, g, b)

	-- show the sr weight cap
	Tooltips.SetTooltipText(6, 1, ReplaceTokens(GetStringFromTid(491), { StringUtils.AddCommasToNumber(wstring.format(L"%1.1f", sr)), L"360" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(sr, 360, true)

	-- set the text color
	Tooltips.SetTooltipColor(6, 1, r, g, b)

	-- show the mr weight cap
	Tooltips.SetTooltipText(7, 1, ReplaceTokens(GetStringFromTid(492), { StringUtils.AddCommasToNumber(wstring.format(L"%1.1f", mr)), L"360" } ) )

	-- get the red scale
	r, g, b = WindowUtils.GetRGBForTooltip(mr, 360, true)

	-- set the text color
	Tooltips.SetTooltipColor(7, 1, r, g, b)

	-- FINALIZE

	-- show the tooltip
	Tooltips.Finalize()

	-- anchor the tooltip
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function AnimalLore.SpecialTooltip()
	
	-- get the window name
	local windowName = SystemData.ActiveWindow.name

	-- get the special id?
	local id = WindowGetId(windowName)

	-- special tooltip
	if IsValidID(id) and string.find(windowName, "Special", 1, true) then

		-- create the tooltip
		Tooltips.CreateTextOnlyTooltip(windowName, AnimalLore.CurrentCreature["Specials"][id].tooltip)

	 -- advancement tooltip
	elseif IsValidID(id) and string.find(windowName, "Advancement", 1, true) then

		-- create the tooltip
		Tooltips.CreateTextOnlyTooltip(windowName, AnimalLore.CurrentCreature["Advancements"][id].tooltip)
	end
end

function AnimalLore.HasAdvancement(tid)

	-- scan all the advancements
	for i, spec in pairsByIndex(AnimalLore.CurrentCreature["Advancements"]) do

		-- is this the special we're looking for?
		if spec.tid == tid then
			return true
		end
	end

	return false
end

function AnimalLore.HasSpecial(tid)

	-- scan all the advancements
	for i, spec in pairsByIndex(AnimalLore.CurrentCreature["Specials"]) do

		-- is this the special we're looking for?
		if spec.tid == tid then
			return true
		end
	end

	return false
end

function AnimalLore.IsPartOfMultiSpecial(tid)
	
	-- determine if is inside the multi-specials table
	local multiSpecials = AnimalLore.MultiSpecialsAbilitiesTID[tid]

	-- is this ability part of a multi-special ability?
	if multiSpecials then

		-- scan the multi-special abilities related to this special
		for i, multiSpecial in pairsByIndex(multiSpecials) do

			-- do we have the multi-special related to this ability?
			if AnimalLore.HasSpecial(multiSpecial) then
				return true
			end
		end
	end

	return false
end

function AnimalLore.KhyrosRating()

	-- create a link to the current creature data
	local PetDB = AnimalLore.CurrentCreature

	-- make sure we have the creature data
	if not PetDB then
		return
	end

	-- initialize the ratings array
	AnimalLore.Ratings = {}

	-- initialize the intensities
	local MinSpawnIntensity, MaxSpawnIntensity, CurrentIntensity = multipleInitialize(0)

	-- calculate the stat intensities
	local MinStats, MaxStats, CurrentStats = AnimalLore.KhyrosStatIntensity()

	-- calculate the res intensities
	local MinRes, MaxRes, CurrentRes = AnimalLore.KhyrosResIntensity()

	-- calculate the damage intensity
	local BaseDamageIntensity, CurrentDamage = AnimalLore.KhyrosDamageIntensity()

	-- calculate the abilities intensity
	local BaseInnate, CurrentAbilities = AnimalLore.KhyrosInnateIntensity()

	-- calculate the skill intensities
	local MinSkill, MaxSkill, CurrentSkill = AnimalLore.KhyrosSkillsIntensity()

	-- sum the intensities
	MinSpawnIntensity = MinStats + MinRes + BaseDamageIntensity + BaseInnate + MinSkill
	MaxSpawnIntensity = MaxStats + MaxRes + BaseDamageIntensity + BaseInnate + MaxSkill

	CurrentIntensity = CurrentStats + CurrentRes + CurrentDamage + CurrentAbilities + CurrentSkill

	-- initialize the rating
	local rating = 0

	-- can this pet spawn with a different slots amount?
	if PetDB.Multislot then

		-- is this pet current amount of slots the minimum possible?
		if PetDB.PetSlots.current == PetDB.PetSlots.min then
		
			-- we are using the value from multislot here as the max spawn, because anything more than that and the pet will be a higher slot
			rating = ((CurrentIntensity - MinSpawnIntensity) / (PetDB.Multislot - MinSpawnIntensity))	

		else -- the pet requires more slot than the minimum possible

			-- similar to the low slot rating, the multislot is now the minimum spawn for this slot, so we use that value instead
			rating = ((CurrentIntensity - PetDB.Multislot) / (MaxSpawnIntensity - PetDB.Multislot))
		end
	
	else -- fixed amount of slots
		rating = ((CurrentIntensity - MinSpawnIntensity) / (MaxSpawnIntensity - MinSpawnIntensity))
	end

	-- store the single stats for the tooltip
	AnimalLore.Ratings["Total"] = { perc = rating * 100, intensity = CurrentIntensity, minIntensity = MinSpawnIntensity, maxIntensity = MaxSpawnIntensity }

	-- calculate the stat rating percentage
	local statPerc = ((CurrentStats - MinStats) / (MaxStats - MinStats)) * 100

	-- make sure the percentage is a number (it may be infinite if it's 0/0)
	if math.isINF(statPerc) or math.isNAN(statPerc) then
		statPerc = 100
	end

	-- store the data
	AnimalLore.Ratings["Stats"] = { perc = statPerc, intensity = CurrentStats, minIntensity = MinStats, maxIntensity = MaxStats }

	-- calculate the res rating percentage
	local resPerc = ((CurrentRes - MinRes) / (MaxRes - MinRes)) * 100

	-- make sure the percentage is a number (it may be infinite if it's 0/0)
	if math.isINF(resPerc) or math.isNAN(resPerc) then
		resPerc = 100
	end

	-- store the data
	AnimalLore.Ratings["Res"] = { perc = resPerc, intensity = CurrentRes, minIntensity = MinRes, maxIntensity = MaxRes }

	-- calculate the skills rating percentage
	local skillsPerc = ((CurrentSkill - MinSkill) / (MaxSkill - MinSkill)) * 100

	-- make sure the percentage is a number (it may be infinite if it's 0/0)
	if math.isINF(skillsPerc) or math.isNAN(skillsPerc) then
		skillsPerc = 100
	end

	-- store the data
	AnimalLore.Ratings["Skills"] = { perc = skillsPerc, intensity = CurrentSkill, minIntensity = MinSkill, maxIntensity = MaxSkill }

	return rating
end

function AnimalLore.KhyrosStatIntensity()

	-- create a link to the current creature data
	local PetDB = AnimalLore.CurrentCreature

	-- make sure we have the creature data
	if not PetDB then
		return
	end
	
	-- initialize the stats variables
	local MinHits, MaxHits, MinStr, MaxStr, MinDex, MaxDex, MinStam, MaxStam, MinInt, MaxInt, MinMana, MaxMana = multipleInitialize(0)
		
	local CurrentHits, CurrentStr, CurrentDex, CurrentStam, CurrentInt, CurrentMana = multipleInitialize(0)

	-- does this creature stats gets halved after taming?
	if PetDB.HalfStat then

		-- does this creature hp get divided by 8 instead of half?
		if PetDB.EightStat then

			MinHits = math.floor(math.floor((PetDB.Stats.HitPoints.min / 8)) * 3)
			MaxHits = math.floor(math.floor((PetDB.Stats.HitPoints.max / 8)) * 3)

			-- only for wild creatures
			if PetDB.Loyalty == 1061643 then
				CurrentHits = math.floor(math.floor((PetDB.Stats.HitPoints.value.total / 8)) * 3)
			end

		else -- only halved
			MinHits = math.floor(math.floor((PetDB.Stats.HitPoints.min / 2)) * 3)
			MaxHits = math.floor(math.floor((PetDB.Stats.HitPoints.max / 2)) * 3)

			-- only for wild creatures
			if PetDB.Loyalty == 1061643 then
				CurrentHits = math.floor(math.floor((PetDB.Stats.HitPoints.value.total / 2)) * 3)
			end
		end

		-- other stats
		MinStr = math.floor(math.floor((PetDB.Stats.Str.min / 2)) * 3)
		MaxStr = math.floor(math.floor((PetDB.Stats.Str.max / 2)) * 3)

		-- make sure the stat cap is no less than 125 * 3
		if MaxStr < 375 then
			MaxStr = 375
		end

		MinDex = math.floor(math.floor((PetDB.Stats.Dex.min / 2)) * 0.1)
		MaxDex = math.floor(math.floor((PetDB.Stats.Dex.max / 2)) * 0.1)

		-- make sure the stat cap is no less than 125 * 0.1
		if MaxDex < 12.5 then
			MaxDex = 12.5
		end

		MinStam = math.floor(math.floor((PetDB.Stats.Stamina.min / 2)) * 0.5)
		MaxStam = math.floor(math.floor((PetDB.Stats.Stamina.max / 2)) * 0.5)

		-- make sure the stat cap is no less than 125 * 0.5
		if MaxStam < 62.5 then
			MaxStam = 62.5
		end

		-- only for wild creatures
		if PetDB.Loyalty == 1061643 then

			CurrentStr = math.floor(math.floor((PetDB.Stats.Str.value / 2)) * 3)
			CurrentDex = math.floor(math.floor((PetDB.Stats.Dex.value / 2)) * 0.1)
			CurrentStam = math.floor(math.floor( PetDB.Stats.Stamina.value.total / 2) * 0.5)

		else -- tamed creatures
			CurrentStr = math.floor(PetDB.Stats.Str.value * 3)
			CurrentDex = math.floor(PetDB.Stats.Dex.value * 0.1)
			CurrentStam = math.floor(PetDB.Stats.Stamina.value.total * 0.5)
			CurrentHits = math.floor(PetDB.Stats.HitPoints.value.total * 3)
		end

	else -- not halved

		MinStr = math.floor(PetDB.Stats.Str.min * 3)
		MaxStr = math.floor(PetDB.Stats.Str.max * 3)

		CurrentStr = math.floor(PetDB.Stats.Str.value * 3)

		MinDex = math.floor(PetDB.Stats.Dex.min * 0.1)
		MaxDex = math.floor(PetDB.Stats.Dex.max * 0.1)

		CurrentDex = math.floor(PetDB.Stats.Dex.value * 0.1)

		MinStam = math.floor(PetDB.Stats.Stamina.min * 0.5)
		MaxStam = math.floor(PetDB.Stats.Stamina.max * 0.5)

		CurrentStam = math.floor(PetDB.Stats.Stamina.value.total * 0.5)

		MinHits = math.floor(PetDB.Stats.HitPoints.min * 3)
		MaxHits = math.floor(PetDB.Stats.HitPoints.max * 3)

		CurrentHits = math.floor(PetDB.Stats.HitPoints.value.total * 3)
	end

	-- This checks if the intensity value of stamina is over 75. 
	-- Stamina is capped at 150 after taming, which is 75 intensity. 
	-- We don't want to account for anything higher or it will throw off the rating
	if (CurrentStam > 75) then 
		CurrentStam = 75
	end

	-- int and mana intensities
	MinInt = math.floor(PetDB.Stats.Int.min * 0.5)
	MaxInt = math.floor(PetDB.Stats.Int.max * 0.5)

	CurrentInt = math.floor(PetDB.Stats.Int.value * 0.5)

	MinMana = math.floor(PetDB.Stats.Mana.min * 0.5)
	MaxMana = math.floor(PetDB.Stats.Mana.max * 0.5)
	
	CurrentMana = math.floor(PetDB.Stats.Mana.value.total * 0.5)

	-- stats total intensities
	local MinStats = MinHits + MinStr + MinDex + MinStam + MinInt + MinMana
	local MaxStats = MaxHits + MaxStr + MaxDex + MaxStam + MaxInt + MaxMana

	local CurrStats = CurrentHits + CurrentStr + CurrentDex + CurrentStam + CurrentInt + CurrentMana

	return MinStats, MaxStats, CurrStats
end

function AnimalLore.KhyrosResIntensity()

	-- create a link to the current creature data
	local PetDB = AnimalLore.CurrentCreature

	-- make sure we have the creature data
	if not PetDB then
		return
	end

	-- resistances intensities
	local MinPhys = (PetDB.Resistances.Physical.min * 3)
	local MaxPhys = (PetDB.Resistances.Physical.max * 3)

	local CurrentPhys = (PetDB.Resistances.Physical.value * 3)

	local MinFire = (PetDB.Resistances.Fire.min * 3)
	local MaxFire = (PetDB.Resistances.Fire.max * 3)

	local CurrentFire = (PetDB.Resistances.Fire.value * 3)

	local MinCold = (PetDB.Resistances.Cold.min * 3)
	local MaxCold = (PetDB.Resistances.Cold.max * 3)

	local CurrentCold = (PetDB.Resistances.Cold.value * 3)

	local MinPoison = (PetDB.Resistances.Poison.min * 3)
	local MaxPoison = (PetDB.Resistances.Poison.max * 3)

	local CurrentPoison = (PetDB.Resistances.Poison.value * 3)

	local MinEnergy = (PetDB.Resistances.Energy.min * 3)
	local MaxEnergy = (PetDB.Resistances.Energy.max * 3)

	local CurrentEnergy = (PetDB.Resistances.Energy.value * 3)

	-- res total intensities
	local MinRes = MinPhys + MinFire + MinCold + MinPoison + MinEnergy
	local MaxRes = MaxPhys + MaxFire + MaxCold + MaxPoison + MaxEnergy

	local CurrentRes = CurrentPhys + CurrentFire + CurrentCold + CurrentPoison + CurrentEnergy

	return MinRes, MaxRes, CurrentRes
end

function AnimalLore.KhyrosDamageIntensity()

	-- create a link to the current creature data
	local PetDB = AnimalLore.CurrentCreature

	-- make sure we have the creature data
	if not PetDB then
		return
	end

	-- initialize the intensity values
	local BaseDamageIntensity, Current = multipleInitialize(0)

	-- fire steed damage exception
	if PetDB.Damage.min == 11 and PetDB.Damage.max == 30 then	 
		BaseDamageIntensity = 80
		Current = 80

	-- shadow wyrms damage exception
	elseif PetDB.Damage.min == 29 and PetDB.Damage.max == 35 then
		BaseDamageIntensity = 125
		Current = 125

	else -- any other creature
		BaseDamageIntensity = math.ceil(PetDB.Damage.max / 1.5) * 5	
		Current = math.ceil(PetDB.Damage.BaseDamage.max / 1.5) * 5	
	end

	return BaseDamageIntensity, Current
end

function AnimalLore.KhyrosInnateIntensity()

	-- create a link to the current creature data
	local PetDB = AnimalLore.CurrentCreature

	-- make sure we have the creature data
	if not PetDB then
		return
	end

	-- initialize the intensity values
	local BaseInnate, Current = multipleInitialize(0)

	-- check for innate magical abilities
	if PetDB.Skills.InnateMagery then
		
		-- 1500 is the intensity cost for innate magery + eval int
		BaseInnate = 1500
		Current = 1500
	end

	if PetDB.Skills.InnateNecromancy then

		-- 1500 is the intensity cost for innate necromancy + spiritspeak
		BaseInnate = 1500
		Current = 1500
	end
	
	if PetDB.Skills.InnatePoisoning then

		-- 100 is the intensity cost for innate poisoning
		BaseInnate =  100
		Current = 100
	end
	
	if PetDB.Skills.InnateMysticism then

		-- 500 is the intensity cost for innate mysticism
		BaseInnate = 500
		Current = 500
	end

	-- scan all the specials to determine which skill has been imbued
	for adv, data in pairs(PetDB.Specials) do

		-- get the imbued intensity for the ability
		local imbue = AnimalLore.TrainedAbilities[data.tid]

		-- generate an error if the ability is not weighted or not recognized correctly
		if not imbue then
			Debug.Print("MISSING ABILITY (KHYROS RATING): " .. data.tid)
		end

		-- is this special a skill?
		if AnimalLore.SkillToDBName[data.tid] then
			
			-- make sure the skill is not innate
			if	(data.tid == 1044085 and not PetDB.Skills.InnateMagery) or
				(data.tid == 1044109 and not PetDB.Skills.InnateNecromancy) or
				(data.tid == 1044090 and not PetDB.Skills.InnatePoisoning) or
				(data.tid == 1044115 and not PetDB.Skills.InnateMysticism) then

				-- is this an innate ability?
				if data.original then

					-- for innate abilities we add them to both the initial and current intensity
					BaseInnate = BaseInnate + imbue
					Current = Current + imbue

				else -- if is not an innate ability, we add it only to the current intensity
					Current = Current + imbue
				end
			end

		-- is this an innate ability? (NOT a skill)
		elseif data.original then

			-- for innate abilities we add them to both the initial and current intensity
			BaseInnate = BaseInnate + imbue
			Current = Current + imbue

		else -- if is not an innate ability, we add it only to the current intensity
			Current = Current + imbue
		end
	end

	-- scan all the advancements to determine which skill has been imbued
	for adv, data in pairs(PetDB.Advancements) do

		-- get the imbued intensity for the ability
		local imbue = AnimalLore.TrainedAbilities[data.tid]

		-- generate an error if the ability is not weighted or not recognized correctly
		if not imbue then
			Debug.Print("MISSING ABILITY (KHYROS RATING): " .. data.tid)
		end

		-- is this advancement a skill?
		if AnimalLore.SkillToDBName[data.tid] then
			
			-- make sure the skill is not innate
			if	(data.tid == 1044085 and not PetDB.Skills.InnateMagery) or
				(data.tid == 1044109 and not PetDB.Skills.InnateNecromancy) or
				(data.tid == 1044090 and not PetDB.Skills.InnatePoisoning) or
				(data.tid == 1044115 and not PetDB.Skills.InnateMysticism) then

				-- is this an innate ability?
				if data.original then

					-- for innate abilities we add them to both the initial and current intensity
					BaseInnate = BaseInnate + imbue
					Current = Current + imbue

				else -- if is not an innate ability, we add it only to the current intensity
					Current = Current + imbue
				end
			end

		-- is this an innate ability? (NOT a skill)
		elseif data.original then

			-- for innate abilities we add them to both the initial and current intensity
			BaseInnate = BaseInnate + imbue
			Current = Current + imbue

		else -- if is not an innate ability, we add it only to the current intensity
			Current = Current + imbue
		end
	end

	return BaseInnate, Current
end

function AnimalLore.KhyrosSkillsIntensity()

	-- create a link to the current creature data
	local PetDB = AnimalLore.CurrentCreature

	-- make sure we have the creature data
	if not PetDB then
		return
	end

	-- initialize the stats variables
	local MinSkill, MaxSkill = multipleInitialize(0)

	-- calculate the min intensity for the skills that can go beyond 100

	-- is Wrestling min possible higher than 100?
	if PetDB.Skills.Wrestling.min > 100 then
		MinSkill = MinSkill + ((PetDB.Skills.Wrestling.min - 100) * 10)
	end

	-- is Tactics min possible higher than 100?
	if PetDB.Skills.Tactics.min > 100 then
		MinSkill = MinSkill + ((PetDB.Skills.Tactics.min - 100) * 10)
	end

	-- is ResSpell min possible higher than 100?
	if PetDB.Skills.ResSpell.min > 100 then
		MinSkill = MinSkill + (PetDB.Skills.ResSpell.min - 100) 
	end

	-- calculate the max intensity for the skills that can go beyond 100
	-- 112.3 is the magic number that gets to 101 skill when the skills are reduced by 90% after taming

	-- initialize the individual skill intensities
	local MaxWres, MaxTact, MaxRes, MaxMag, MaxEval, MaxPoison = multipleInitialize(0)
	
	-- triton is never wild so we don't need to reduce the skill by 90% to get the max value
	if AnimalLore.CurrentCreature["Type"] == L"triton" then
		MaxWres = math.floor((PetDB.Skills.Wrestling.max - 100) * 10)

	-- is Wrestling max possible higher than 112.3?
	elseif PetDB.Skills.Wrestling.max > 112.3 then
		MaxWres = (math.floor(PetDB.Skills.Wrestling.max * 0.9) - 100) * 10
	end

	-- is Tactics max possible higher than 112.3?
	if PetDB.Skills.Tactics.max > 112.3 then
		MaxTact = (math.floor(PetDB.Skills.Tactics.max * 0.9) - 100) * 10
	end

	-- triton is never wild so we don't need to reduce the skill by 90% to get the max value
	if AnimalLore.CurrentCreature["Type"] == L"triton" then
		MaxRes = PetDB.Skills.ResSpell.max - 100

	-- is ResSpell max possible higher than 112.3?
	elseif PetDB.Skills.ResSpell.max > 112.3 then
		MaxRes = (math.floor(PetDB.Skills.ResSpell.max * 0.9) - 100)
	end

	-- is Magery max possible higher than 112.3?
	if PetDB.Skills.Magery.max > 112.3 then
		MaxMag = (math.floor(PetDB.Skills.Magery.max * 0.9) - 100) * 5
	end

	-- is EvalInt max possible higher than 112.3?
	if PetDB.Skills.EvalInt.max > 112.3 then
		MaxEval = (math.floor(PetDB.Skills.EvalInt.max * 0.9) - 100) * 10
	end

	-- is Poisoning max possible higher than 112.3?
	if PetDB.Skills.Poisoning.max > 112.3 then
		MaxPoison = (math.floor(PetDB.Skills.Poisoning.max * 0.9) - 100)
	end

	-- sum the max skill intensity
	MaxSkill = MaxWres + MaxTact + MaxRes + MaxMag + MaxEval + MaxPoison

	-- initialize the current skill intensities
	local CurrWres, CurrTact, CurrRes, CurrMag, CurrEval, CurrPoison, CurrHeal = multipleInitialize(0)

	-- is this a wild creature?
	if PetDB.Loyalty == 1061643 then

		-- is Wrestling higher than 112.3?
		if PetDB.Skills.Wrestling.cap and PetDB.Skills.Wrestling.cap > 112.3 then
			CurrWres = (math.floor(PetDB.Skills.Wrestling.cap * 0.9) - 100) * 10
		end

		-- is Tactics higher than 112.3?
		if PetDB.Skills.Tactics.cap and PetDB.Skills.Tactics.cap > 112.3 then
			CurrTact = (math.floor(PetDB.Skills.Tactics.cap * 0.9) - 100) * 10
		end

		-- is ResSpell higher than 112.3?
		if PetDB.Skills.ResSpell.cap and PetDB.Skills.ResSpell.cap > 112.3 then
			CurrRes = (math.floor(PetDB.Skills.ResSpell.cap * 0.9) - 100)
		end

		-- is Magery higher than 112.3?
		if PetDB.Skills.Magery.cap and PetDB.Skills.Magery.cap > 112.3 then
			CurrMag = (math.floor(PetDB.Skills.Magery.cap * 0.9) - 100) * 5
		end

		-- is EvalInt higher than 112.3?
		if PetDB.Skills.EvalInt.cap and PetDB.Skills.EvalInt.cap > 112.3 then
			CurrEval = (math.floor(PetDB.Skills.EvalInt.cap * 0.9) - 100) * 10
		end

		-- is Poisoning higher than 112.3?
		if PetDB.Skills.Poisoning.cap and PetDB.Skills.Poisoning.cap > 112.3 then
			CurrPoison = (math.floor(PetDB.Skills.Poisoning.cap * 0.9) - 100)
		end

		-- is Healing higher than 112.3?
		if PetDB.Skills.Healing.cap and PetDB.Skills.Healing.cap > 112.3 then
			CurrHeal = (math.floor(PetDB.Skills.Healing.cap * 0.9) - 100)
		end

	else -- tamed creature, no need to get 90% value

		-- is Wrestling higher than 100?
		if PetDB.Skills.Wrestling.cap and PetDB.Skills.Wrestling.cap > 100 then
			CurrWres = (PetDB.Skills.Wrestling.cap - 100) * 10
		end

		-- is Tactics higher than 100?
		if PetDB.Skills.Tactics.cap and PetDB.Skills.Tactics.cap > 100 then
			CurrTact = (PetDB.Skills.Tactics.cap - 100) * 10
		end

		-- is ResSpell higher than 100?
		if PetDB.Skills.ResSpell.cap and PetDB.Skills.ResSpell.cap > 100 then
			CurrRes = (PetDB.Skills.ResSpell.cap - 100)
		end

		-- is Magery higher than 100?
		if PetDB.Skills.Magery.cap and PetDB.Skills.Magery.cap > 100 then
			CurrMag = (PetDB.Skills.Magery.cap - 100) * 5
		end

		-- is EvalInt higher than 100?
		if PetDB.Skills.EvalInt.cap and PetDB.Skills.EvalInt.cap > 100 then
			CurrEval = (PetDB.Skills.EvalInt.cap - 100) * 10
		end

		-- is Poisoning higher than 100?
		if PetDB.Skills.Poisoning.cap and PetDB.Skills.Poisoning.cap > 100 then
			CurrPoison = (PetDB.Skills.Poisoning.cap - 100)
		end

		-- is Healing higher than 100?
		if PetDB.Skills.Healing.cap and PetDB.Skills.Healing.cap > 100 then
			CurrHeal = (PetDB.Skills.Healing.cap - 100)
		end
	end

	-- sum all the intensities
	local CurrentSkill = CurrWres + CurrTact + CurrRes + CurrMag + CurrEval + CurrPoison + CurrHeal

	return MinSkill, MaxSkill, CurrentSkill
end

function AnimalLore.KnownPetsleaner(timePassed)

	-- scan all known creatures list
	for id, data in pairs(AnimalLore.KnownPetsType) do

		-- is it time to reset the current creature data?
		if data.forgetData and data.forgetData <= Interface.Clock.Timestamp then

			-- remove the creature from the list
			AnimalLore.KnownPetsType[id] = nil
		end
	end
end