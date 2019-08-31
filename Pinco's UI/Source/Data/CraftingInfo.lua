----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CraftingInfo = {}

CraftingInfo.CraftingToolMaterialTidsConversion =
{
	[1072848] = 1072942, -- Parasitic Poison
	[1072849] = 1072942, -- Darkglow Poison
	[1044571] = 1072943, -- Green Potions
	[1044569] = 1044551, -- Purple Potions

	[1112247] = 1027124, -- wooden shafts
	[1044570] = 1027163, -- Crossbow Bolts

	[1025141] = 1046431, -- Platemail Tunic
	[1150738] = 1150675, -- empty metal keg

	[1044286] = 1044458, -- Cloth

	[1044449] = 1044377, -- Blank Maps or Scrolls

	[1044468] = 1024153, -- Flour
	[1044518] = 1041339, -- Uncooked Quiches
	[1044519] = 1041338, -- Uncooked Meat Pies
	[1044520] =	1041337, -- uncooked sausage pizzas
	[1044521] =	1041341, -- uncooked cheese pizzas
	[1044522] =	1041334, -- unbaked fruit pies
	[1044523] =	1041335, -- unbaked peach cobblers
	[1044524] =	1041336, -- unbaked apple pies
	[1046461] =	1041336, -- unbaked pumpkin pies
	[1158768] =	1024156, -- bread
	[1073467] = 1044545, -- Greater Heal Potion
	[1073466] = 1044547, -- Greater Strength Potion

	[1044445] = 1044412, -- Recall Scrolls
	[1044446] = 1044432, -- Gate Scrolls
	[1153499] = 1044441, -- summon daemon scrolls

	[1044455] = 1044458, -- Yards of Cloth

	[1044169] = 1024187, -- Axles
	[1044170] = 1024177, -- Axles with Gears
	[1044172] = 1024181, -- Hinges
	[1044174] = 1024173, -- Clock Frames
	[1044251] = 1027608, -- Barrel Lids
	[1044252] = 1024100, -- Keg Taps
	[1044255] = 1023711, -- Empty Kegs

}

function CraftingInfo.Initialize()

	CraftingInfo.CraftingToolNames =
	{
		[1044001] = { name = "AlchemyMenu",			skillId = SkillsWindow.SkillsID.ALCHEMY,		skillTID = GetSkillTID(SkillsWindow.SkillsID.ALCHEMY),		categoryStartId = 4,	hasEnhance = false,		totalMaterials = 0 },
		[1044002] = { name = "BlacksmithMenu",		skillId = SkillsWindow.SkillsID.BLACKSMITH,		skillTID = GetSkillTID(SkillsWindow.SkillsID.BLACKSMITH),	categoryStartId = 7,	hasEnhance = true,		totalMaterials = 2 },
		[1044006] = { name = "BowcraftMenu",		skillId = SkillsWindow.SkillsID.FLETCHING,		skillTID = GetSkillTID(SkillsWindow.SkillsID.FLETCHING),	categoryStartId = 5,	hasEnhance = true,		totalMaterials = 1 },
		[1044004] = { name = "CarpentryMenu",		skillId = SkillsWindow.SkillsID.CARPENTRY,		skillTID = GetSkillTID(SkillsWindow.SkillsID.CARPENTRY),	categoryStartId = 6,	hasEnhance = true,		totalMaterials = 1 },
		[1044008] = { name = "CartographyMenu",		skillId = SkillsWindow.SkillsID.CARTOGRAPHY,	skillTID = GetSkillTID(SkillsWindow.SkillsID.CARTOGRAPHY),	categoryStartId = 4,	hasEnhance = false,		totalMaterials = 0 },
		[1044003] = { name = "CookingMenu",			skillId = SkillsWindow.SkillsID.COOKING,		skillTID = GetSkillTID(SkillsWindow.SkillsID.COOKING),		categoryStartId = 4,	hasEnhance = false,		totalMaterials = 0 },
		[1044622] = { name = "GlassblowingMenu",	skillId = SkillsWindow.SkillsID.ALCHEMY,		skillTID = 1072393,											categoryStartId = 5,	hasEnhance = false,		totalMaterials = 0 },
		[1044009] = { name = "InscriptionMenu",		skillId = SkillsWindow.SkillsID.INSCRIPTION,	skillTID = GetSkillTID(SkillsWindow.SkillsID.INSCRIPTION),	categoryStartId = 4,	hasEnhance = false,		totalMaterials = 0 },
		[1044500] = { name = "MasonryMenu",			skillId = SkillsWindow.SkillsID.CARPENTRY,		skillTID = 1072392,											categoryStartId = 5,	hasEnhance = true,		totalMaterials = 1 },
		[1044005] = { name = "TailoringMenu",		skillId = SkillsWindow.SkillsID.TAILORING,		skillTID = GetSkillTID(SkillsWindow.SkillsID.TAILORING),	categoryStartId = 6,	hasEnhance = true,		totalMaterials = 1 },
		[1044007] = { name = "TinkeringMenu",		skillId = SkillsWindow.SkillsID.TINKERING,		skillTID = GetSkillTID(SkillsWindow.SkillsID.TINKERING),	categoryStartId = 6,	hasEnhance = true,		totalMaterials = 1 }

	}

	CraftingInfo.Tools = 
	{
		[GetSkillTID(SkillsWindow.SkillsID.ALCHEMY)] =		{ 3739 };
		[GetSkillTID(SkillsWindow.SkillsID.BLACKSMITH)] =	{ 4020, 4021, 4027, 4028, 5091 };
		[GetSkillTID(SkillsWindow.SkillsID.FLETCHING)] =	{ 4130 };
		[GetSkillTID(SkillsWindow.SkillsID.CARPENTRY)] =	{ 4136, 4137, 4138, 4140, 4142, 4144, 4146, 4148, 4324, 4325, 4326, 4327 };
		[GetSkillTID(SkillsWindow.SkillsID.CARTOGRAPHY)] =	{ 4032 };
		[GetSkillTID(SkillsWindow.SkillsID.COOKING)] =		{ 2431, 4158, 4163 };
		[1072393] =											{ 3722 }; -- Glassblowing
		[GetSkillTID(SkillsWindow.SkillsID.INSCRIPTION)] =	{ 4031 };
		[1072392] =											{ 4787 }; -- Masonry
		[GetSkillTID(SkillsWindow.SkillsID.TAILORING)] =	{ 3997 };
		[GetSkillTID(SkillsWindow.SkillsID.TINKERING)] =	{ 7864, 7865, 7868 };
	}

	CraftingInfo.MaterialToSkill =
	{
		-- MINING
		[1044036] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Ingots
		[1038039] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- bronze ingots:
		[1044514] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Stones
		[1044625] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Sand
		[1116302] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- saltpeter
		[1150016] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- a small piece of blackrock
		[1044231] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Star Sapphires
		[1032690] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Dark Sapphire
		[1026249] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Dark Sapphire
		[1032691] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Turquoise
		[1032692] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Perfect Emerald
		[1032693] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Ecru Citrine
		[1032694] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- White Pearl
		[1032695] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Fire Ruby
		[1032696] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Blue Diamond
		[1032697] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Brilliant Amber
		[1044232] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Emeralds
		[1044233] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Sapphires
		[1044234] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Rubies
		[1044235] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Citrines
		[1044236] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Amethysts
		[1044237] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Tourmalines
		[1044238] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Amber
		[1044239] = GetSkillTID(SkillsWindow.SkillsID.MINING), -- Diamonds

		-- LUMBERJACKING
		[1044041] = GetSkillTID(SkillsWindow.SkillsID.LUMBERJACKING), -- Boards or Logs
		[1032687] = GetSkillTID(SkillsWindow.SkillsID.LUMBERJACKING), -- Bark Fragment
		[1032688] = GetSkillTID(SkillsWindow.SkillsID.LUMBERJACKING), -- Parasitic Plant
		[1032689] = GetSkillTID(SkillsWindow.SkillsID.LUMBERJACKING), -- Luminescent Fungi
		[1113347] = GetSkillTID(SkillsWindow.SkillsID.LUMBERJACKING), -- crystal shards
		[1073464] = GetSkillTID(SkillsWindow.SkillsID.LUMBERJACKING), -- Switch
		[1032127] = GetSkillTID(SkillsWindow.SkillsID.LUMBERJACKING), -- Switch

		-- FISHING
		[1044476] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- Raw Fish Steaks
		[1116298] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- great barracuda steak
		[1116301] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- yellowtail barracuda steak
		[1116306] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- giant koi steak
		[1116307] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- fire fish steak
		[1116308] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- reaper fish steak
		[1116309] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- crystal fish steak
		[1116310] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- bull fish steak
		[1116311] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- summer dragonfish steak
		[1116312] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- fairy salmon steak
		[1116313] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- lava fish steak
		[1116314] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- autumn dragonfish steak
		[1116315] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- holy mackerel steak
		[1116316] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- unicorn fish steak
		[1116317] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- stone crab meat
		[1116318] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- blue lobster meat
		[1116320] = GetSkillTID(SkillsWindow.SkillsID.FISHING), -- spider crab meat

		-- STEALING
		[1026265] = GetSkillTID(SkillsWindow.SkillsID.STEALING), -- copper wire
		[1023137] = GetSkillTID(SkillsWindow.SkillsID.STEALING), -- dried herbs
		[1071202] = GetSkillTID(SkillsWindow.SkillsID.STEALING), -- academic books

		-- IMBUING
		[1031699] = GetSkillTID(SkillsWindow.SkillsID.IMBUING), -- Relic Fragment

		-- MISC
		[1044572] = 616, -- Faction Silver
		[1032675] = 617, -- Blight
		[1032676] = 617, -- Corruption
		[1032677] = 617, -- Scourge
		[1032678] = 617,-- Putrefaction
		[1032679] = 617, -- Taint
		[1032680] = 617, -- Muculent
		[1032681] = 1031650, -- Lard of Paroxysmus -- Chief Paroxysmus
		[1032682] = 1031651, -- Dread Horn Mane -- Dread Horn
		[1032634] = 1031651, -- Dread Horn Mane -- Dread Horn
		[1032683] = 1031652, -- Diseased Bark -- Lady Melisande
		[1032684] = 1031653, -- Grizzled Bones -- Monstrous Interred Grizzle
		[1032685] = 1031654, -- Eye of the Travesty -- Travesty
		[1032686] = 1031655, -- Captured Essence -- Shimmering Effusion
		[1075095] = 1031655, -- Shimmering Crystals -- Shimmering Effusion

		[1153988] = 654, -- broken crystals

		[1044462] = 619, -- Leather or Hides
		[1113463] = 619, -- Scales
		[1060883] = 619, -- Dragon Scales
		[1156799] = 619, -- Sea Serpent or Dragon Scales
		[1123908] = 619, -- Tiger Pelt
		[1156268] = 619, -- Tiger Pelts
		[1123910] = 619, -- Dragon Turtle Scute
		[1044562] = 619, -- Feathers
		[1044482] = 619, -- Raw Meat
		[1044470] = 619, -- Raw Birds
		[1044473] = 619, -- Raw Chicken Legs
		[1044478] = 619, -- Raw Legs of Lamb
		[1044485] = 619, -- Raw Ribs
		[1031705] = 619, -- raw rotworm meat
		[1159202] = 619, -- raw sea serpent steak

		[1073426] = 1098336, -- Clockwork Assembly -- Exodus 
		[1112811] = 1098336, -- power crystal -- Exodus

		[1112327] = 620, -- Void Essence
		[1113334] = 620, -- void core

		[1074761] = 1094932, -- Resolve's Bridle -- Red Death
		[1025370] = 1029634, -- rope -- kraken

		[1071200] = 621, -- animal pheromone 
		[1063488] = 622, -- Phillip's Wooden Steed

		[1061597] = 1111792, -- Hat of The Magi -- Doom Gauntlet
		[1061104] = 1111792, -- Ring of the Elements -- Doom Gauntlet
		[1157343] = 1111792, -- Blood of the Dark Father -- Doom Gauntlet
		[1157354] = 1111792, -- the scholar's halo -- Doom Gauntlet
		[1061093] = 1111792, -- Midnight Bracers -- Doom Gauntlet
		[1061600] = 1111792, -- Staff of the Magi -- Doom Gauntlet
		[1061100] = 1111792, -- Leggings of Bane -- Doom Gauntlet

		[1156993] = 618, -- Black Moonstone

		[1044353] = 623, -- Black Pearl
		[1044354] = 623, -- Blood Moss
		[1044355] = 623, -- Garlic
		[1044356] = 623, -- Ginseng
		[1044357] = 623, -- Mandrake Root
		[1044358] = 623, -- Nightshade
		[1044359] = 623, -- Sulfurous Ash
		[1044360] = 623, -- Spiders' Silk

		[1023982] = 623, -- Nox Crystal
		[1023983] = 623, -- Grave Dust
		[1023965] = 623, -- Daemon Blood
		[1023978] = 623, -- Pig Iron
		[1023965] = 623, -- Daemon Blood
		[1023960] = 623, -- Batwing

		[1023968] = 623, -- Daemon Bone
		[1023966] = 623, -- Bone
		[1023969] = 623, -- Fertile Dirt
		[1095375] = 623, -- Dragon's Blood

		[1044529] = 623, -- Empty Bottles
		[1044250] = 623, -- Empty Bottles

		[1044447] = 636, -- Unmarked Runes
		[1025154] = 637, -- Beeswax
		[1155627] = 1155625, -- Ancient Parchment -- Ancient Clay Vase
		[1155630] = 638, -- Antique Documents Kit
		
		[1157002] = 624, -- Inoperative Automaton Head
		[1156997] = 625, -- Automaton Actuator
		[1156623] = 624, -- Stasis Chamber Power Core

		[1112248] = 626, -- dry reeds
		[1112131] = 626, -- Plant Clippings
		[1157872] = 627, -- Quicksilver

		[1044453] = 628, -- Bolts of Cloth

		[1113344] = 629, -- crystalline blackrock
		[1113333] = 1095911, -- vile tentacles -- maddening horror

		[1073381] = 630, -- Mace and Shield Reading Glasses
		
		[1024009] = 631, -- dyes
		[1073462] = 632, -- Spools of Thread
		[1049064] = 633, -- Bones

		[1113348] = 634, -- lodestone
		[1071460] = 635, -- Leurocian's Mempo of Fortune
		[1075043] = 617, -- Crimson Cincture

		[1113332] = 1113545, -- fey wings -- fairy dragon

		[1159168] = 642, -- ethereal sand

		[1044489] = 639, -- Wheat
		[1046458] = 640, -- Water
		[1044472] = 637, -- Honey
		[1080530] = 1080532, -- cocoa pulp -- cocoa tree
		[1025629] = 641, -- pewter bowl
		[1044486] = 641, -- Cheese
		[1025628] = 641, -- bowl of peas
		[1155735] = 1123480, -- Coffee Grounds -- Potted Coffee Plant

		[1044477] = 643, -- Eggs
		[1044481] = 643, -- Pears
		[1044480] = 643, -- Peaches
		[1044479] = 643, -- Apples
		[1044484] = 643, -- Pumpkin
		[1023184] = 643, -- head of lettuce
		[1031235] = 643, -- Fresh Ginger
		[1073470] = 649, -- Bananas
		[1080011] = 643, -- Pitcher of Milk
		[1023190] = 643, -- carrots
		[1023195] = 643, -- head of cabbage
		[1023183] = 643, -- onions
		[1023186] = 643, -- squash
		[1023199] = 643, -- ear of corn

		[1046460] = 1079799, -- Tribal Berries -- Savage
		[1112173] = 1018184, -- silver serpent venom -- silver serpent
		[1022503] = 640, -- bottle of wine
		[1116338] = 644, -- Samuel's Secret Sauce
		[1116299] = 644, -- Mento Seasoning
		[1116300] = 644, -- dark truffle
		[1022505] = 647, -- ham
		[1080003] = 648, -- Sack of sugar
		[1073470] = 649, -- Bananas
		[1073472] = 650, -- Wooden Bowl
		[1080009] = 651, -- Vanilla
		[1124032] = 652, -- foil sheet
		[1029911] = 1111749, -- zoogi fungus -- Solen Hive

		[1156721] = 1156562, -- Unabridged Atlas of Eodon

		[1113358] = 645, -- faery dust
		[1112291] = 1113551, -- toxic venom sac -- toxic slith

		[1156727] = 1156262, -- Lava Berry -- Valley of Eodon
		[1156731] = 1156262, -- River Moss -- Valley of Eodon
		[1156733] = 1156262, -- Blue Corn -- Valley of Eodon
		[1156730] = 1029618, -- Perfect Bananas -- silverback gorilla

		[1022459] = 640, -- bottle of liquor
		[1023613] = 653, -- ball of yarn

		[1159163] = 1073894, -- salted serpent steak -- Message in a Bottle
		[1159162] = 1073894, -- ocean sapphire -- Message in a Bottle
		[1159133] = 1073894, -- Live Rock -- Message in a Bottle
		--[1159201] = , -- salt -- ???WHERE FROM???
	}
	
end