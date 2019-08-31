
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CleanupBritannia = {}
--								  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32
CleanupBritannia.ItemsPerPage = { 3, 4, 6, 5, 5, 5, 5, 5, 5, 5, 5, 2, 3, 6, 3, 2, 3, 5, 5, 6, 6, 4, 3, 5, 4, 4, 4, 4, 4, 4, 6, 1 }
CleanupBritannia.ItemsDB = {
	-- BASE DATA: {nameTid tooltipTid objectType deedItem hue cost buttonId}
	{nameTid = 1113927; tooltipTid = 1113927; objectType = 16706; hue = 0; cost = 1000; buttonId = 1; category = 1; }; -- Mailbox
	{nameTid = 1151202; tooltipTid = 1151202; objectType = 7939; hue = 0; cost = 1000; buttonId = 2; category = 0; }; -- Humans & Elves are our friends!
	{nameTid = 1151203; tooltipTid = 1151203; objectType = 7939; hue = 0; cost = 1000; buttonId = 3; category = 0; }; -- Gargoyles are our friends!
	{nameTid = 1151204; tooltipTid = 1151204; objectType = 7939; hue = 0; cost = 1000; buttonId = 5; category = 0; }; -- We are pirates!
	{nameTid = 1151205; tooltipTid = 1151205; objectType = 7939; hue = 0; cost = 1000; buttonId = 6; category = 0; }; -- Follower of Bane
	{nameTid = 1151206; tooltipTid = 1151206; objectType = 7939; hue = 0; cost = 1000; buttonId = 7; category = 0; }; -- Queen Dawn Forever
	
	{nameTid = 1023517; tooltipTid = 1023517; objectType = 3516; hue = 0; cost = 5000; buttonId = 8; category = 1; }; -- lilly pad
	{nameTid = 1023518; tooltipTid = 1023518; objectType = 3518; hue = 0; cost = 5000; buttonId = 11; category = 1; }; -- lilly pads
	{nameTid = 1023349; tooltipTid = 1023349; objectType = 3343; hue = 0; cost = 5000; buttonId = 12; category = 1; }; -- mushrooms
	{nameTid = 1023349; tooltipTid = 1023349; objectType = 3346; hue = 0; cost = 5000; buttonId = 13; category = 1; }; -- mushrooms
	{nameTid = 1023349; tooltipTid = 1023349; objectType = 3345; hue = 0; cost = 5000; buttonId = 14; category = 1; }; -- mushrooms
	{nameTid = 1023349; tooltipTid = 1023349; objectType = 3344; hue = 0; cost = 5000; buttonId = 15; category = 1; }; -- mushrooms
	{nameTid = 1023349; tooltipTid = 1023349; objectType = 3347; hue = 0; cost = 5000; buttonId = 16; category = 1; }; -- mushrooms
	{nameTid = 1080189; tooltipTid = 1151243; objectType = 4231; hue = 997; cost = 5000; buttonId = 17; category = 0; }; -- Nocturne Earrings
	
	{nameTid = 1080171; tooltipTid = 1080171; objectType = 8400; hue = 2959; cost = 10000; buttonId = 18; category = 1; }; -- Sherry the Mouse Statue
	{nameTid = 1154340; tooltipTid = 1154414; objectType = 39270; hue = 1152; cost = 10000; buttonId = 21; category = 0; }; -- Refinement Amalgamator
	{nameTid = 1080490; tooltipTid = 1080490; deedItem = true; cost = 10000; buttonId = 21; category = 1; }; -- Chaos Tile Deed
	{nameTid = 1080488; tooltipTid = 1080488; deedItem = true; cost = 10000; buttonId = 22; category = 1; }; -- Honesty Virtue Tile Deed
	{nameTid = 1080481; tooltipTid = 1080481; deedItem = true; cost = 10000; buttonId = 23; category = 1; }; -- Compassion Virtue Tile Deed
	{nameTid = 1080487; tooltipTid = 1080487; deedItem = true; cost = 10000; buttonId = 24; category = 1; }; -- Justice Virtue Tile Deed
	{nameTid = 1080486; tooltipTid = 1080486; deedItem = true; cost = 10000; buttonId = 27; category = 1; }; -- Valor Virtue Tile Deed
	{nameTid = 1080484; tooltipTid = 1080484; deedItem = true; cost = 10000; buttonId = 28; category = 1; }; -- Spirituality Virtue Tile Deed
	{nameTid = 1080485; tooltipTid = 1080485; deedItem = true; cost = 10000; buttonId = 29; category = 1; }; -- Honor Virtue Tile Deed
	{nameTid = 1080483; tooltipTid = 1080483; deedItem = true; cost = 10000; buttonId = 30; category = 1; }; -- Humility Virtue Tile Deed
	{nameTid = 1080482; tooltipTid = 1080482; deedItem = true; cost = 10000; buttonId = 31; category = 1; }; -- Sacrifice Virtue Tile Deed
	{nameTid = 1153344; tooltipTid = 1153344; objectType = 5359; hue = 0; cost = 10000; buttonId = 34; category = 1; }; -- Steward Deed
	
	{nameTid = 1080156; tooltipTid = 1151244; objectType = 5129; hue = 1150; cost = 10000; buttonId = 35; category = 9; }; -- Knight's Close Helm
	{nameTid = 1080157; tooltipTid = 1151245; objectType = 5134; hue = 1150; cost = 10000; buttonId = 36; category = 9; }; -- Knight's Norse Helm 
	{nameTid = 1080158; tooltipTid = 1151246; objectType = 5138; hue = 1150; cost = 10000; buttonId = 39; category = 9; }; -- Knight's Plate Helm
	{nameTid = 1080159; tooltipTid = 1151247; objectType = 5132; hue = 1150; cost = 10000; buttonId = 40; category = 9; }; -- Knight's Bascinet
	{nameTid = 1080160; tooltipTid = 1151248; objectType = 5139; hue = 1150; cost = 10000; buttonId = 41; category = 9; }; -- Knight's Gorget
	{nameTid = 1080161; tooltipTid = 1151249; objectType = 5140; hue = 1150; cost = 10000; buttonId = 42; category = 9; }; -- Knight's Gloves
	{nameTid = 1080162; tooltipTid = 1151250; objectType = 5136; hue = 1150; cost = 10000; buttonId = 43; category = 9; }; -- Knight's Arms
	{nameTid = 1080163; tooltipTid = 1151251; objectType = 5137; hue = 1150; cost = 10000; buttonId = 44; category = 9; }; -- Knight's Legs
	{nameTid = 1080164; tooltipTid = 1151252; objectType = 5141; hue = 1150; cost = 10000; buttonId = 44; category = 9; }; -- Knight's Breastplate
	{nameTid = 1080164; tooltipTid = 1151253; objectType = 7172; hue = 1150; cost = 10000; buttonId = 47; category = 9; }; -- Knight's Breastplate
	
	{nameTid = 1080472; tooltipTid = 1151254; objectType = 11118; hue = 1148; cost = 10000; buttonId = 48; category = 10; }; -- Scout's Circlet
	{nameTid = 1080473; tooltipTid = 1151255; objectType = 10116; hue = 1148; cost = 10000; buttonId = 49; category = 10; }; -- Scout's Small Plate Jingasa
	{nameTid = 1080474; tooltipTid = 1151256; objectType = 5078; hue = 1148; cost = 10000; buttonId = 50; category = 10; }; -- Scout's Studded Gorget
	{nameTid = 1080475; tooltipTid = 1151257; objectType = 5076; hue = 1148; cost = 10000; buttonId = 51; category = 10; }; -- Scout's Studded Sleeves
	{nameTid = 1080476; tooltipTid = 1151258; objectType = 5083; hue = 1148; cost = 10000; buttonId = 54; category = 10; }; -- Scout's Studded Tunic
	{nameTid = 1080477; tooltipTid = 1151259; objectType = 5077; hue = 1148; cost = 10000; buttonId = 55; category = 10; }; -- Scout's Studded Gloves
	{nameTid = 1080478; tooltipTid = 1151260; objectType = 5082; hue = 1148; cost = 10000; buttonId = 56; category = 10; }; -- Scout's Studded Leggings
	{nameTid = 1080479; tooltipTid = 1151261; objectType = 7170; hue = 1148; cost = 10000; buttonId = 57; category = 10; }; -- Scout's Female Studded Armor
	{nameTid = 1080480; tooltipTid = 1151262; objectType = 7180; hue = 1148; cost = 10000; buttonId = 58; category = 10; }; -- Scout's Studded Bustier

	{nameTid = 1080465; tooltipTid = 1151263; objectType = 5912; hue = 1165; cost = 10000; buttonId = 61; category = 11; }; -- Sorcerer's Hat
	{nameTid = 1080466; tooltipTid = 1151264; objectType = 5063; hue = 1165; cost = 10000; buttonId = 62; category = 11; }; -- Sorcerer's Gorget
	{nameTid = 1080467; tooltipTid = 1151265; objectType = 5061; hue = 1165; cost = 10000; buttonId = 63; category = 11; }; -- Sorcerer's Sleeves
	{nameTid = 1080468; tooltipTid = 1151266; objectType = 5068; hue = 1165; cost = 10000; buttonId = 64; category = 11; }; -- Sorcerer's Tunic
	{nameTid = 1080469; tooltipTid = 1151267; objectType = 7174; hue = 1165; cost = 10000; buttonId = 65; category = 11; }; -- Sorcerer's Female Armor
	{nameTid = 1080470; tooltipTid = 1151268; objectType = 5062; hue = 1165; cost = 10000; buttonId = 68; category = 11; }; -- Sorcerer's Gloves
	{nameTid = 1080471; tooltipTid = 1151269; objectType = 7176; hue = 1165; cost = 10000; buttonId = 69; category = 11; }; -- Sorcerer's Skirt
	{nameTid = 1080489; tooltipTid = 1151270; objectType = 5067; hue = 1165; cost = 10000; buttonId = 70; category = 11; }; -- Sorcerer's Leggings

	{nameTid = 1080261; tooltipTid = 1080261; objectType = 3383; hue = 0; cost = 15000; buttonId = 73; category = 1; }; -- Yucca Tree
	{nameTid = 1151220; tooltipTid = 1151220; objectType = 18882; hue = 0; cost = 15000; buttonId = 74; category = 1; }; -- table lamp
	{nameTid = 1080262; tooltipTid = 1080262; objectType = 9325; hue = 0; cost = 15000; buttonId = 77; category = 1; };  -- Bamboo
	
	{nameTid = 1080212; tooltipTid = 1080212; deedItem = true; cost = 20000; buttonId = 78; category = 1; }; -- Horse Barding
	{nameTid = 1152084; tooltipTid = 1152084; objectType = 5359; hue = 1195; cost = 20000; buttonId = 79; category = 0; }; -- Scroll of Alacrity
	{nameTid = 1080124; tooltipTid = 1151224; objectType = 5899; hue = 2009; cost = 20000; buttonId = 82; category = 4; }; -- Snake Skin Boots
	{nameTid = 1151207; tooltipTid = 1151223; objectType = 5899; hue = 1654; cost = 20000; buttonId = 83; category = 4; }; -- Boots of the Lava Lizard
	{nameTid = 1151208; tooltipTid = 1151225; objectType = 5899; hue = 1154; cost = 20000; buttonId = 84; category = 4; }; -- Boots of the Ice Wyrm
	{nameTid = 1151209; tooltipTid = 1151226; objectType = 5899; hue = 1150; cost = 20000; buttonId = 85; category = 4; }; -- Boots of the Crystal Hydra
	{nameTid = 1151210; tooltipTid = 1151227; objectType = 5899; hue = 1175; cost = 20000; buttonId = 86; category = 4; }; -- Boots of the Thrasher

	{nameTid = 1154373; tooltipTid = 1154374; objectType = 3740; hue = 2075; cost = 20000; buttonId = 87; category = 3; }; -- Nature's Tears
	{nameTid = 1154723; tooltipTid = 1154737; objectType = 3740; hue = 1927; cost = 20000; buttonId = 90; category = 3; }; -- Primordial Decay
	{nameTid = 1154724; tooltipTid = 1154738; objectType = 3740; hue = 1944; cost = 20000; buttonId = 91; category = 3; }; -- Arachnid Doom
	
	{nameTid = 1151222; tooltipTid = 1151222; objectType = 11632; hue = 0; cost = 50000; buttonId = 92; category = 1; }; -- sophisticated elven tapestry
	{nameTid = 1071396; tooltipTid = 1071396; objectType = 11634; hue = 0; cost = 50000; buttonId = 95; category = 1; }; -- ornate elven tapestry
	{nameTid = 1071393; tooltipTid = 1071393; objectType = 2604; hue = 0; cost = 50000; buttonId = 96; category = 1; }; -- chest of drawers
	{nameTid = 1151221; tooltipTid = 1151221; objectType = 2608; hue = 0; cost = 50000; buttonId = 99; category = 1; }; -- footed chest of drawers
	{nameTid = 1080209; tooltipTid = 1080209; objectType = 8756; hue = 0; cost = 50000; buttonId = 100; category = 1; }; -- Dragon Head
	{nameTid = 1080260; tooltipTid = 1080260; objectType = 6868; hue = 0; cost = 50000; buttonId = 101; category = 1; }; -- Nest With Eggs
	
	{nameTid = 1151189; tooltipTid = 1151237; objectType = 5062; hue = 2578; cost = 50000; buttonId = 104; category = 8; }; -- Fisherman's Eelskin Gloves
	{nameTid = 1151190; tooltipTid = 1151238; objectType = 5910; hue = 2578; cost = 50000; buttonId = 105; category = 8; }; -- Fisherman's Tall Straw Hat
	{nameTid = 1151191; tooltipTid = 1151239; objectType = 5082; hue = 2578; cost = 50000; buttonId = 106; category = 8; }; -- Fisherman's Trousers
	{nameTid = 1151192; tooltipTid = 1151240; objectType = 5068; hue = 2578; cost = 50000; buttonId = 107; category = 8; }; -- Fisherman's Vest
	{nameTid = 1151574; tooltipTid = 1151578; objectType = 778; hue = 2578; cost = 50000; buttonId = 108; category = 8; }; -- Fisherman's Chestguard
	{nameTid = 1151575; tooltipTid = 1151579; objectType = 16484; hue = 2578; cost = 50000; buttonId = 111; category = 8; }; -- Fisherman's Kilt
	{nameTid = 1151576; tooltipTid = 1151580; objectType = 770; hue = 2578; cost = 50000; buttonId = 112; category = 8; }; -- Fisherman's Arms
	{nameTid = 1151577; tooltipTid = 1151581; objectType = 16915; hue = 2578; cost = 50000; buttonId = 113; category = 8; }; -- Fisherman's Earrings

	{nameTid = 1151197; tooltipTid = 1151229; objectType = 5445; hue = 2010; cost = 50000; buttonId = 114; category = 7; }; -- Bestial Helm
	{nameTid = 1151198; tooltipTid = 1151230; objectType = 5062; hue = 2010; cost = 50000; buttonId = 115; category = 7; }; -- Bestial Gloves
	{nameTid = 1151199; tooltipTid = 1151231; objectType = 5067; hue = 2010; cost = 50000; buttonId = 118; category = 7; }; -- Bestial Leggings
	{nameTid = 1151200; tooltipTid = 1151232; objectType = 5063; hue = 2010; cost = 50000; buttonId = 119; category = 7; }; -- Bestial Gorget
	{nameTid = 1151543; tooltipTid = 1151547; objectType = 16915; hue = 2010; cost = 50000; buttonId = 120; category = 7; }; -- Bestial Earrings
	{nameTid = 1151545; tooltipTid = 1151549; objectType = 16456; hue = 2010; cost = 50000; buttonId = 121; category = 7; }; -- Bestial Arms
	{nameTid = 1151546; tooltipTid = 1151550; objectType = 780; hue = 2010; cost = 50000; buttonId = 122; category = 7; }; -- Bestial Kilt
	{nameTid = 1151544; tooltipTid = 1151548; objectType = 16915; hue = 2010; cost = 50000; buttonId = 123; category = 7; }; -- Bestial Necklace
	
	{nameTid = 1151320; tooltipTid = 1151324; objectType = 5916; hue = 1374; cost = 50000; buttonId = 126; category = 12; }; -- Virtuoso's Cap
	{nameTid = 1151321; tooltipTid = 1151325; objectType = 5083; hue = 1374; cost = 50000; buttonId = 127; category = 12; }; -- Virtuoso's Tunic
	{nameTid = 1151322; tooltipTid = 1151560; objectType = 5062; hue = 1374; cost = 50000; buttonId = 128; category = 12; }; -- Virtuoso's Kid Gloves
	{nameTid = 1151555; tooltipTid = 1151323; objectType = 5063; hue = 1374; cost = 50000; buttonId = 129; category = 12; }; -- Virtuoso's Collar
	{nameTid = 1151556; tooltipTid = 1151561; objectType = 16912; hue = 1374; cost = 50000; buttonId = 130; category = 12; }; -- Virtuoso's Necklace
	{nameTid = 1151557; tooltipTid = 1151562; objectType = 16915; hue = 1374; cost = 50000; buttonId = 131; category = 12; }; -- Virtuoso's Earpieces
	{nameTid = 1151558; tooltipTid = 1151563; objectType = 776; hue = 1374; cost = 50000; buttonId = 134; category = 12; }; -- Virtuoso's Armbands
	{nameTid = 1151559; tooltipTid = 1151564; objectType = 16484; hue = 1374; cost = 50000; buttonId = 135; category = 12; }; -- Virtuoso's Kilt

	{nameTid = 1114226; tooltipTid = 1114226; objectType = 6589; hue = 0; cost = 75000; buttonId = 136; category = 0; }; -- giant toad costume
	{nameTid = 1114222; tooltipTid = 1114222; objectType = 6589; hue = 0; cost = 75000; buttonId = 137; category = 0; }; -- zombie costume
	{nameTid = 1080206; tooltipTid = 1080206; objectType = 10750; hue = 0; cost = 75000; buttonId = 140; category = 1; }; -- Fire Pit
	{nameTid = 1154745; tooltipTid = 1154745; objectType = 13042; hue = 0; cost = 75000; buttonId = 141; category = 1; }; -- Presentation Stone
	
	{nameTid = 1080263; tooltipTid = 1080263; objectType = 2330; hue = 0; cost = 80000; buttonId = 142; category = 1; }; -- Beehive
	{nameTid = 1080205; tooltipTid = 1080205; objectType = 4107; hue = 0; cost = 80000; buttonId = 145; category = 1; }; -- Archery Butte

	{nameTid = 1080238; tooltipTid = 1151241; objectType = 4234; hue = 1165; cost = 150000; buttonId = 146; category = 6; }; -- Etoile Bleue
	{nameTid = 1080239; tooltipTid = 1151242; objectType = 4230; hue = 1165; cost = 150000; buttonId = 147; category = 6; }; -- Novo Bleue
	
	{nameTid = 1154372; tooltipTid = 1154380; objectType = 4234; hue = 1165; cost = 150000; buttonId = 148; category = 6; }; -- Lune Rouge
	{nameTid = 1154371; tooltipTid = 1154382; objectType = 4230; hue = 1166; cost = 150000; buttonId = 149; category = 6; }; -- Soleil Rouge
	
	{nameTid = 1154732; tooltipTid = 1154732; objectType = 3839; hue = 2691; cost = 250000; buttonId = 152; category = 2; }; -- Intense Teal Pigment
	{nameTid = 1154735; tooltipTid = 1154735; objectType = 3839; hue = 2716; cost = 250000; buttonId = 152; category = 2; }; -- Tyrian Purple Pigment
	{nameTid = 1154734; tooltipTid = 1154734; objectType = 3839; hue = 2714; cost = 250000; buttonId = 152; category = 2; }; -- Mottled Sunset Pigment
	{nameTid = 1154731; tooltipTid = 1154731; objectType = 3839; hue = 2684; cost = 250000; buttonId = 152; category = 2; }; -- Mossy Green Pigment
	
	{nameTid = 1154736; tooltipTid = 1154736; objectType = 3839; hue = 2725; cost = 250000; buttonId = 152; category = 2; }; -- Vibrant Ocher Pigment
	{nameTid = 1154733; tooltipTid = 1154733; objectType = 3839; hue = 2709; cost = 250000; buttonId = 153; category = 2; }; -- Olive Green Pigment
	{nameTid = 1151909; tooltipTid = 1151909; objectType = 3839; hue = 1944; cost = 250000; buttonId = 154; category = 2; }; -- Polished Bronze Pigment
	{nameTid = 1151910; tooltipTid = 1151910; objectType = 3839; hue = 1916; cost = 250000; buttonId = 155; category = 2; }; -- Glossy Blue Pigment
	
	{nameTid = 1151911; tooltipTid = 1151911; objectType = 3839; hue = 1979; cost = 250000; buttonId = 158; category = 2; }; -- Black and Green Pigment
	{nameTid = 1151912; tooltipTid = 1151912; objectType = 3839; hue = 1929; cost = 250000; buttonId = 159; category = 2; }; -- Deep Violet Pigment
	{nameTid = 1152308; tooltipTid = 1152308; objectType = 3839; hue = 1967; cost = 250000; buttonId = 160; category = 2; }; -- Aura of Amber Pigment
	{nameTid = 1152309; tooltipTid = 1152309; objectType = 3839; hue = 1992; cost = 250000; buttonId = 161; category = 2; }; -- Murky Seagreen Pigment
	
	{nameTid = 1152310; tooltipTid = 1152310; objectType = 3839; hue = 1960; cost = 250000; buttonId = 164; category = 2; }; -- Shadowy Blue Pigment
	{nameTid = 1152311; tooltipTid = 1152311; objectType = 3839; hue = 1930; cost = 250000; buttonId = 165; category = 2; }; -- Gleaming Fuchsia Pigment
	{nameTid = 1152347; tooltipTid = 1152347; objectType = 3839; hue = 1919; cost = 250000; buttonId = 166; category = 2; }; -- Glossy Fuchsia Pigment
	{nameTid = 1152348; tooltipTid = 1152348; objectType = 3839; hue = 1939; cost = 250000; buttonId = 167; category = 2; }; -- Deep Blue Pigment
	
	{nameTid = 1152349; tooltipTid = 1152349; objectType = 3839; hue = 1970; cost = 250000; buttonId = 170; category = 2; }; -- Vibrant Seagreen Pigment
	{nameTid = 1152350; tooltipTid = 1152350; objectType = 3839; hue = 1989; cost = 250000; buttonId = 171; category = 2; }; -- Murky Amber Pigment
	{nameTid = 1153386; tooltipTid = 1153386; objectType = 3839; hue = 1964; cost = 250000; buttonId = 172; category = 2; }; -- Vibrant Crimson Pigment
	{nameTid = 1153387; tooltipTid = 1153387; objectType = 3839; hue = 1910; cost = 250000; buttonId = 173; category = 2; }; -- Reflective Shadow Pigment 
	
	{nameTid = 1154121; tooltipTid = 1154121; objectType = 3839; hue = 2723; cost = 250000; buttonId = 176; category = 2; }; -- Star Blue Pigment
	{nameTid = 1154120; tooltipTid = 1154120; objectType = 3839; hue = 2720; cost = 250000; buttonId = 177; category = 2; }; -- Mother of Pearl Pigment
	{nameTid = 1154213; tooltipTid = 1154213; objectType = 3839; hue = 1923; cost = 250000; buttonId = 178; category = 2; }; -- Liquid Sunshine Pigment
	{nameTid = 1154214; tooltipTid = 1154214; objectType = 3839; hue = 2068; cost = 250000; buttonId = 179; category = 2; }; -- Dark Void Pigment
	
	{nameTid = 1154725; tooltipTid = 1154739; objectType = 12123; hue = 1923; cost = 300000; buttonId = 182; category = 5; }; -- Lucky Charm
	{nameTid = 1154726; tooltipTid = 1154740; objectType = 12123; hue = 1902; cost = 300000; buttonId = 183; category = 5; }; -- Soldier's Medal
	{nameTid = 1154727; tooltipTid = 1154741; objectType = 12120; hue = 1902; cost = 300000; buttonId = 184; category = 5; }; -- Duelist's Edge
	{nameTid = 1154728; tooltipTid = 1154742; objectType = 12122; hue = 1912; cost = 300000; buttonId = 185; category = 5; }; -- Necromancer's Phylactery
	{nameTid = 1154729; tooltipTid = 1154743; objectType = 12120; hue = 1912; cost = 300000; buttonId = 186; category = 5; }; -- Wizard's Curio
	{nameTid = 1154730; tooltipTid = 1154744; objectType = 12123; hue = 1912; cost = 300000; buttonId = 187; category = 5; }; -- Mystic's Memento
	
	{nameTid = 1113629; tooltipTid = 1113629; objectType = 7961; hue = 1154; cost = 500000; buttonId = 190; category = 0; }; -- A Vollem Held in Crystal
}

CleanupBritannia.GumpID = 17000

CleanupBritannia.CurrentPoints = 0
CleanupBritannia.ScrollPosition = 0

CleanupBritannia.CategoriesWindow = {}
function CleanupBritannia.Initialize()

	CleanupBritannia.Categories = {
		[0] = {nameTid=1015283}; -- Miscellaneous
		[1] = {nameTid=1044501}; -- Decorations
		[2] = {name=GetStringFromTid(236)}; -- pigments
		[3] = {name=GetStringFromTid(237)}; -- musical instruments
		[4] = {nameTid=1015291}; -- boots
		[5] = {name=GetStringFromTid(235)}; -- talismans
		[6] = {name=GetStringFromTid(228)}; -- jewelry sets
		[7] = {name=GetStringFromTid(232)}; -- bestial set
		[8] = {name=GetStringFromTid(233)}; -- fisherman set
		[9] = {name=GetStringFromTid(229)}; -- knight set
		[10] = {name=GetStringFromTid(231)}; -- scout set
		[11] = {name=GetStringFromTid(230)}; -- sorcerer set
		[12] = {name=GetStringFromTid(234)}; -- virtuoso set
	}

	local windowName = "CleanupBritanniaWindow"
	WindowUtils.RestoreWindowPosition("CleanupBritanniaWindow")
	LabelSetText("CleanupBritanniaWindowTitle", GetStringFromTid(1151316)) -- Clean Up Britannia
	LabelSetText("CleanupBritanniaWindowPoints", GetStringFromTid(1072843)) -- Your Reward Points:
	
	CleanupBritannia.ScrollPosition = Interface.LoadSetting("CleanupBritannia_ScrollPosition", CleanupBritannia.ScrollPosition)
	
	local page = 1
	local index = 1
	local itmThisPage = 0
	for i = 1, #CleanupBritannia.ItemsDB do
		CleanupBritannia.ItemsDB[i].buttonId = index
		itmThisPage = itmThisPage + 1
		-- page turn
		if itmThisPage == CleanupBritannia.ItemsPerPage[page] then
		 	-- first page has 1 button less than the other pages
			if page == 1 then
				index = index + 2
			else
				index = index + 3
			end
			page = page + 1
			itmThisPage = 0
		else
			index = index + 1
		end
	end
end

function CleanupBritannia.Shutdown()
	WindowUtils.SaveWindowPosition("CleanupBritanniaWindow")
	CleanupBritannia.Close()
end

function CleanupBritannia.Close()
	CleanupBritannia.ScrollPosition = ScrollWindowGetOffset("CleanupBritanniaSecondSW")
	Interface.SaveSetting("CleanupBritannia_ScrollPosition", CleanupBritannia.ScrollPosition)
	WindowSetShowing("CleanupBritanniaWindow", false)
	GumpsParsing.DestroyGump(CleanupBritannia.GumpID)
end

function CleanupBritannia.Show()
	CleanupBritannia.CurrentPoints = 0
	if GumpData.Gumps[CleanupBritannia.GumpID].LabelsText then
		CleanupBritannia.CurrentPoints = tonumber(GumpData.Gumps[CleanupBritannia.GumpID].LabelsText[1])
	end
	
	LabelSetText("CleanupBritanniaWindowPointsValue", StringUtils.AddCommasToNumber(CleanupBritannia.CurrentPoints))
	
	local currentId = Interface.LoadSetting("CleanupBritannia_CurrentCategory", nil, 0)
	
	if currentId then
		CleanupBritannia.SetCurrentCategory(currentId)
	end
	
	for i, windowName in pairs(CleanupBritannia.CategoriesWindow) do
		if DoesWindowExist(windowName) then
			DestroyWindow(windowName)
		end
	end
	CleanupBritannia.CategoriesWindow = {}
	
	local parent = "CleanupBritanniaMainSWScrollChild"
	local prev
	
	for i, data in pairsByKeys(CleanupBritannia.Categories) do
		local current = parent .. "Category" .. i
		CreateWindowFromTemplate(current, "CBCategoryItem", parent)
		WindowClearAnchors(current)
		if not prev then
			WindowAddAnchor(current, "topleft", parent, "topleft", 10, 10)
		else
			WindowAddAnchor(current, "bottomleft", prev, "topleft", 0, 10)
		end
		local name
		if data.nameTid then
			name = GetStringFromTid(data.nameTid)
		else
			name = data.name
		end
		LabelSetText(current .. "Label", FormatProperly(name)) 
		if currentId == i then
			LabelSetTextColor(current .. "Label", 255, 255 ,0)
		end
		table.insert(CleanupBritannia.CategoriesWindow, current)
		WindowSetId(current, i)
		prev = current
	end
	
	ScrollWindowUpdateScrollRect( "CleanupBritanniaMainSW" ) 
	
	ScrollWindowSetOffset("CleanupBritanniaSecondSW", CleanupBritannia.ScrollPosition )
end

function CleanupBritannia.Update(timePassed)
	if not GumpData.Gumps[CleanupBritannia.GumpID] or (GumpsParsing.ParsedGumps[CleanupBritannia.GumpID] and GumpsParsing.ParsedGumps[CleanupBritannia.GumpID] ~= "CleanupBritannia") then
		WindowSetShowing("CleanupBritanniaWindow", false)
	end
end

function CleanupBritannia.OnCategoryClicked()
	local windowName = WindowGetParent(SystemData.ActiveWindow.name)
	local id = WindowGetId(windowName)
	
	for i, win in pairs(CleanupBritannia.CategoriesWindow) do
		if WindowGetId(win) == id then
			LabelSetTextColor(win .. "Label", 255, 255 ,0)
		else
			LabelSetTextColor(win .. "Label", 255, 255 ,255)
		end
	end
	CleanupBritannia.SetCurrentCategory(id)
	
end

CleanupBritannia.VisibleItems = {}
function CleanupBritannia.ClearItems()
	for i, windowName in pairs(CleanupBritannia.VisibleItems) do
		if DoesWindowExist(windowName) then
			DestroyWindow(windowName)
		end
	end
	CleanupBritannia.VisibleItems = {}
end

function CleanupBritannia.SetCurrentCategory(id)
	CleanupBritannia.ClearItems()
	
	local parent = "CleanupBritanniaSecondSWScrollChild"
	local prev
	for i, data in pairsByKeys(CleanupBritannia.ItemsDB) do
		if data.category == id then
			local current = parent .. "Item" .. i
			CreateWindowFromTemplate(current, "CBItemTemplate", parent)
			WindowClearAnchors(current)
			if not prev then
				WindowAddAnchor(current, "topleft", parent, "topleft", 10, 10)
			else
				WindowAddAnchor(current, "bottomleft", prev, "topleft", 0, 0)
			end
			WindowSetAlpha(current.. "BG", 0.3)
			WindowSetShowing(current.. "BG", false)
			local name
			if data.nameTid then
				name = GetStringFromTid(data.nameTid)
			else
				name = data.name
			end
			LabelSetText(current .. "Name", FormatProperly(name)) 
			
			LabelSetText(current .. "Cost", StringUtils.AddCommasToNumber(data.cost)) 
			if data.cost > CleanupBritannia.CurrentPoints then
				LabelSetTextColor(current .. "Cost", 255, 0, 0)
			end
			if data.objectType ~= 0 and not data.deedItem then

				local hue = data.hue
				if not hue then
					hue = 0
				end
				EquipmentData.DrawObjectIconAtWindowDimensions(data.objectType, hue, current .. "Icon")
	
			elseif data.deedItem then
				local iconId = data.nameTid
				local name, x, y = GetIconData(iconId)
				local newWidth, newHeight = UOGetTextureSize("icon"..iconId)

				DynamicImageSetTextureDimensions(current .. "Icon", newWidth, newHeight)
				WindowSetDimensions(current.. "Icon", newWidth, newHeight)
				DynamicImageSetTexture(current .. "Icon", name, x, y )
			end
			
			local w, h = WindowGetDimensions(current.. "Icon")
			if h < 50 then
				h = 50
			end
			WindowSetDimensions(current, 400 , h + 20)
			
			WindowSetId(current, i)
			table.insert(CleanupBritannia.VisibleItems, current)
			
			prev = current
		end
	end
	ScrollWindowUpdateScrollRect( "CleanupBritanniaSecondSW" ) 
	ScrollWindowSetOffset( "CleanupBritanniaSecondSW", 0 )
	
	Interface.SaveSetting("CleanupBritannia_CurrentCategory", id)
end

function CleanupBritannia.ItemMouseOver()
	local windowName = SystemData.ActiveWindow.name
	WindowSetShowing(windowName.. "BG", true)
	
	LabelSetFont(windowName .. "Name", "Arial_Black_Shadow_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	LabelSetFont(windowName .. "Cost", "Arial_Black_Shadow_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	
	local id = WindowGetId(windowName)
	local data = CleanupBritannia.ItemsDB[id]
	
	if data and data.tooltipTid then
		
		-- generate the item properties for the item
		GenericGump.ParseTooltipItemProperties(windowName, WindowUtils.translateMarkup(GetStringFromTid(data.tooltipTid)), data.objectType, data.hue)
	end
end

function CleanupBritannia.ItemMouseOverEnd()
	local windowName = SystemData.ActiveWindow.name
	WindowSetShowing(windowName.. "BG", false)
	
	LabelSetFont(windowName .. "Name", "MyriadPro_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	LabelSetFont(windowName .. "Cost", "MyriadPro_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)

	-- reset the flag that indicates we're seeing a gump item property
	GenericGump.CurrentOver = ""
end

function CleanupBritannia.OnItemClicked()
	local windowName = SystemData.ActiveWindow.name
	local id = WindowGetId(windowName)
	
	local data = CleanupBritannia.ItemsDB[id]
	if data then
		if data.cost < CleanupBritannia.CurrentPoints then
			GumpsParsing.PressButton(CleanupBritannia.GumpID, data.buttonId)
		end
	end
end