
ContainersInfo = {  }

ContainersInfo.DefaultGump = 60 -- backpack
ContainersInfo.DefaultCorpse = 9 -- coffin

ContainersInfo.SUEDE_BACKPACK = 30558
ContainersInfo.POLAR_BEAR_BACKPACK = 30560
ContainersInfo.GHOUL_SKIN_BACKPACK = 30562

ContainersInfo.Data = 
{ 
-- [1.. N] = { name = "", ItemsId = {  }, GumpId = 0, Texture = ""  }
-- Texture can be null, but if specified will override the gumpId.

	[1]	 = { name = "bucket", ItemsId = { 5344 }, GumpId = 62 }, -- original gump id: 9
	[2]	 = { name = "cauldron", ItemsId = { 8296 }, GumpId = 9 },
	[3]	 = { name = "sacrificial altar", ItemsId = { 10906, 10907, 10908, 10909 }, GumpId = 9 },
	[4]	 = { name = "corpse", ItemsId = { 8198 }, GumpId = 9 },
	[5]	 = { name = "bones", ItemsId = { 3786, 3787, 3788, 3789, 3790,  3791, 3792, 3793, 3794  }, GumpId = 9 },
	[6]	 = { name = "backpack", ItemsId = { 2482, 3701 }, GumpId = 60 },
	[7]	 = { name = "belt pouch", ItemsId = { 3705 }, GumpId = 60 },
	[8]	 = { name = "bag", ItemsId = { 3702, 41775, 41776, 41777, 41778, 41779, 41780 }, GumpId = 61 },
	[9]	 = { name = "bagball", ItemsId = { 8790, 8791 }, GumpId = 61 },
	[10] = { name = "barrel", ItemsId = { 3703 }, GumpId = 62 },
	[11] = { name = "closed barrel", ItemsId = { 4014 }, GumpId = 62 },
	[12] = { name = "keg", ItemsId = { 3711 }, GumpId = 62 },
	[13] = { name = "short barrel", ItemsId = { 3715 }, GumpId = 62 },
	[14] = { name = "piknik basket", ItemsId = { 3706 }, GumpId = 63 },
	[15] = { name = "piknik basket with handle", ItemsId = { 9433, 9434 }, GumpId = 63 },
	[16] = { name = "short rect basket", ItemsId = { 9429, 9430 }, GumpId = 63 },
	[17] = { name = "incubator", ItemsId = { 16508, 16509 }, GumpId = 64 },
	[18] = { name = "round basket", ItemsId = { 2448 }, GumpId = 65 },
	[19] = { name = "basket", ItemsId = { 9437 }, GumpId = 65 },
	[20] = { name = "tall round basket", ItemsId = { 9432 }, GumpId = 65 },
	[21] = { name = "small round basket", ItemsId = { 9431 }, GumpId = 65 },
	[22] = { name = "round basket with handle", ItemsId = { 2476 }, GumpId = 65 },
	[23] = { name = "flat round basket ", ItemsId = { 2481 }, GumpId = 65 },
	[24] = { name = "golden metal chest", ItemsId = { 3648, 3649 }, GumpId = 66 },
	[25] = { name = "gargish chest", ItemsId = { 16421, 16422 }, GumpId = 66 },
	[26] = { name = "wooden box", ItemsId = { 3709, 2474 }, GumpId = 67 },
	[27] = { name = "small crate", ItemsId = { 2473, 3710 }, GumpId = 68 },
	[28] = { name = "large crate", ItemsId = { 3644, 3645 }, GumpId = 68 },
	[29] = { name = "medium crate", ItemsId = { 3646, 3647 }, GumpId = 68 },
	[30] = { name = "chest of drawers (red)", ItemsId = { 2608, 2616 }, GumpId = 72 },
	[31] = { name = "wooden chest", ItemsId = { 3650, 3651 }, GumpId = 73 },
	[32] = { name = "metal chest", ItemsId = { 2475, 3708 }, GumpId = 74 },
	[33] = { name = "strongbox", ItemsId = { 3712, 2472 }, GumpId = 75 },
	[34] = { name = "ship cargo", ItemsId = { 15973, 16019, 16046, 16057 }, GumpId = 76 },
	[35] = { name = "cargo hold", ItemsId = { 37374 }, GumpId = 76 },
	[36] = { name = "wooden shelf", ItemsId = { 2717, 2718 }, GumpId = 77 },
	[37] = { name = "wooden bookcase", ItemsId = { 2711, 2712, 2713, 2714, 2715, 2716 }, GumpId = 77 },
	[38] = { name = "armoire", ItemsId = { 2636, 2637, 2640, 2641 }, GumpId = 78 },
	[39] = { name = "armoire", ItemsId = { 2638, 2639, 2642, 2643 }, GumpId = 79 },
	[40] = { name = "chest of drawers (plain)", ItemsId = { 2604, 2612 }, GumpId = 81 },
	[41] = { name = "gift box", ItemsId = { 9002, 9003 }, GumpId = 258 },
	[42] = { name = "stocking", ItemsId = { 11225, 11226, 11227, 11228 }, GumpId = 259 },
	[43] = { name = "maple armoire", ItemsId = { 10331, 10332 }, GumpId = 260 },
	[44] = { name = "elven wash basin", ItemsId = { 12511, 12512, 12513, 12514 }, GumpId = 260 },
	[45] = { name = "elegant armoire", ItemsId = { 10329, 10330 }, GumpId = 262 },
	[46] = { name = "elven dresser", ItemsId = { 12515, 12516, 12517, 12518 }, GumpId = 262 },
	[47] = { name = "red armoire", ItemsId = { 10327, 10328 }, GumpId = 263 },
	[48] = { name = "cherry armoire", ItemsId = { 10333, 10334 }, GumpId = 263 },
	[49] = { name = "arcane bookshelf", ItemsId = { 12420, 12421, 12422, 12423 }, GumpId = 263 },
	[50] = { name = "tall square basket ", ItemsId = { 9435, 9436 }, GumpId = 264 },
	[51] = { name = "plain wooden chest", ItemsId = { 10251, 10252 }, GumpId = 265 },
	[52] = { name = "ornate wooden chest", ItemsId = { 10253, 10254 }, GumpId = 265 },
	[53] = { name = "gilded chest", ItemsId = { 10255, 10256 }, GumpId = 266 },
	[54] = { name = "wooden footlocker", ItemsId = { 10257, 10258 }, GumpId = 267 },
	[55] = { name = "finished wooden chest", ItemsId = { 10259, 10260 }, GumpId = 267 },
	[56] = { name = "rarewood chest", ItemsId = { 11761, 11762 }, GumpId = 268 },
	[57] = { name = "decorative box", ItemsId = { 11763, 11764 }, GumpId = 268 },
	[58] = { name = "tall cabinet", ItemsId = { 10261, 10262 }, GumpId = 268 },
	[59] = { name = "short cabinet", ItemsId = { 10263, 10264 }, GumpId = 268 },
	[60] = { name = "fancy elven armoire", ItemsId = { 11528, 11527 }, GumpId = 268 },
	[61] = { name = "simple elven armoire", ItemsId = { 11525, 11526 }, GumpId = 268 },
	[62] = { name = "ronate elven chest", ItemsId = { 12440, 12441, 12442, 12443 }, GumpId = 268 },
	[63] = { name = "ter-mur style dresser", ItemsId = { 16427, 16428, 16429, 16430 }, GumpId = 269 },
	[64] = { name = "blessed statue", ItemsId = { 6473, 6474 }, GumpId = 278 },
	[65] = { name = "mailbox", ItemsId = { 16705, 16706, 16707, 16708 }, GumpId = 282 },
	[66] = { name = "square xmas box", ItemsId = { 18082 }, GumpId = 283 },
	[67] = { name = "round xmas box", ItemsId = { 18083 }, GumpId = 284 },
	[68] = { name = "hex xmas box", ItemsId = { 18084 }, GumpId = 285 },
	[69] = { name = "rect xmas box", ItemsId = { 18086, 18085 }, GumpId = 286 },
	[70] = { name = "angel box", ItemsId = { 18087 }, GumpId = 287 },
	[71] = { name = "heart shaped box", ItemsId = { 18890, 18891, 18892, 18893, 18894, 18895, 18896, 18897, 18898, 18899 }, GumpId = 288 },
	[72] = { name = "tall gift box", ItemsId = { 18888, 18889 }, GumpId = 289 },
	[73] = { name = "fountain of life", ItemsId = { 10944, 10945, 10946, 10947, 10948, 10949 }, GumpId = 1156 },
	[74] = { name = "secret chest", ItemsId = { 38662 }, GumpId = 1422 },
	[75] = { name = "checker board", ItemsId = { 4006 }, GumpId = 2330 },
	[76] = { name = "backgammon", ItemsId = { 3612, 4013 }, GumpId = 2350 },
	[77] = { name = "king's collection box", ItemsId = { 19724, 19725 }, GumpId = 19724 },
	[78] = { name = "xmas box 2014", ItemsId = { 39570 }, GumpId = 30586 },
	[79] = { name = "xmas box 2016", ItemsId = { 40474 }, GumpId = 290 },
	[80] = { name = "wedding chest", ItemsId = { 40852, 40853 }, GumpId = 9834 },
	[81] = { name = "Obelisk Base", ItemsId = { 40866 }, GumpId = 9835 },
	[82] = { name = "wooden chest", ItemsId = { 40952, 40953 }, GumpId = 40153 },
	[83] = { name = "ore satchel", ItemsId = { 41586, 41587 }, GumpId = 40164 },
	[84] = { name = "wood satchel", ItemsId = { 41588, 41589 }, GumpId = 40165 },
	[85] = { name = "dolphin mailbox", ItemsId = { 41476, 41477, 41474, 41475 }, GumpId = 1747 },
	[86] = { name = "squirel mailbox", ItemsId = { 41478, 41479, 41480, 41481 }, GumpId = 1748 },
	[87] = { name = "barrel mailbox", ItemsId = { 41461, 41463, 41464, 41465 }, GumpId = 1749 },
	[88] = { name = "lighthouse mailbox", ItemsId = { 41577, 41579, 41576, 41581, 41583, 41580 }, GumpId = 1750 },
	[89] = { name = "cannon", ItemsId = { 16918, 16919, 16920, 16921, 16922, 16923, 16924, 16925, 41664, 41665, 41666, 41667 }, GumpId = 40167 },
	[90] = { name = "sitting kitten mailbox", ItemsId = { 41963, 41964, 41965, 41966 }, GumpId = 40247 },
	[91] = { name = "standing kitten mailbox", ItemsId = { 41967, 41968, 41969, 41970 }, GumpId = 40248 },
	[92] = { name = "scarecrow mailbox", ItemsId = { 41971, 41972, 41973, 41974 }, GumpId = 40249 },
	[93] = { name = "lion mailbox", ItemsId = { 41975, 41976, 41978, 41979 }, GumpId = 40250 },
 }

-- the anchors functions for the grid legacy containers
ContainersInfo.Anchors = { 
	[9] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 130)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -15, -30)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 130)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -15, -30)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "topleft", grid_view_this, "bottomleft", 10, -5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "topright", grid_view_this, "bottomright", -10, -5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "top", this, "top", 0, 20)
								
								end;
			 };
	[60] =	{ 	
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 75, 90)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -60, -80)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 75, 90)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -60, -80)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									
									if (id ~= ContainerWindow.PlayerBackpack) then
										WindowSetShowing(lock, false)
										WindowSetShowing(lootAll, true)

										WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 8)
										WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
										WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
										
										WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 8)
										WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
										
										
										WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", -10, 13)
									else
										WindowSetShowing(lock, true)
										WindowSetShowing(lootAll, false)
										
										WindowAddAnchor( lock, "top", this, "center", 0, 50)
										
										WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 8)
										
										WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 8)
										WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
										
										WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", -10, 13)
									end
								end;
			 };
	[61] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 35, 80)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -45, -110)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 35, 80)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -45, -110)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 25)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 25)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 30)
								
								end;
			 };
	[62] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 55)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -20, -110)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 55)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -20, -110)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 15, 10)
								
								end;
			 };
	[63] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 15, 50)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -15, -50)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 15, 50)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -15, -50)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 0, 10)
								
								end;
			 };
	[64] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 15, 50)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -15, -35)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 15, 50)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -15, -35)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[65] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 25, 60)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -25, -65)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 25, 60)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -25, -65)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 20, 10)
								
								end;
			 };
	[66] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 5, 150)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -5, -80)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 5, 150)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -5, -80)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 5, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 0, 10)
								
								end;
			 };
	[67] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 75)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -20, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 75)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -20, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 0, 10)
								
								end;
			 };
	[68] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 10, 5)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 10, 5)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[72] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 5)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -20, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 5)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -20, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -10, 15)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 15)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 20)
								
								end;
			 };
	[73] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 5, 150)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -5, -80)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 5, 150)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -5, -80)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 0, 10)
								
								end;
			 };
	[74] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 5, 150)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -5, -80)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 5, 150)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -5, -80)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 0, 10)
								
								end;
			 };
	[75] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 75)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -20, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 75)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -20, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 0, 10)
								
								end;
			 };
	[76] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 45, 112)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -60, -35)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 45, 112)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -60, -35)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "topleft", grid_view_this, "bottomleft", 10, -5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "topright", grid_view_this, "bottomright", -10, -5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "top", this, "top", 0, 20)
								
								end;
			 };
	[77] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 10, 5)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -15, -40)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 10, 5)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -15, -40)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -5, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[78] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 5, 15)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -5, -50)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 5, 15)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -5, -50)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -10, 0)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 8, 0)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 12, 5)
								
								end;
			 };	
	[79] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 5, 15)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -5, -50)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 5, 15)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -5, -50)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -10, 0)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 8, 0)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 12, 5)
								
								end;
			 };
	[81] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 15, 10)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -20, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 15, 10)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -20, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[258] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 40, 0)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -40, -80)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 40, 0)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -40, -80)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[259] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 40, 30)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -30, -130)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 40, 30)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -30, -130)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 15, 10)
								
								end;
			 };
	[260] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[261] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[262] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[263] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[264] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 27, 30)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -20, -40)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 27, 30)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -20, -40)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -15, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", 0, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[265] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 0, 5)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", 0, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 0, 5)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", 0, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 15, 10)
								
								end;
			 };
	[266] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 0, 5)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", 0, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 0, 5)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", 0, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 15, 10)
								
								end;
			 };
	[267] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 0, 5)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", 0, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 0, 5)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", 0, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 15, 10)
								
								end;
			 };
	[268] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 15, 10)
								
								end;
			 };
	[269] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 15, 10)
								
								end;
			 };
	[270] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[278] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 10, 30)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -50)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 10, 30)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -50)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 20, 10)
								
								end;
			 };
	[282] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -20, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 0, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", 0, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 5, 10)
								
								end;
			 };
	[283] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 60, 0)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -50, -95)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 60, 0)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -50, -95)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 15, 10)
								
								end;
			 };
	[284] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 30, 40)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -20, -155)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 30, 40)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -20, -155)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[285] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 40, 20)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -40, -110)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 40, 20)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -40, -110)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 15, 10)
								
								end;
			 };
	[286] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 40, 25)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -68)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 40, 25)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -68)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 0, 10)
								
								end;
			 };
	[287] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 60, 0)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -50, -107)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 60, 0)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -50, -107)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[288] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 60, 30)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -50, -70)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 60, 30)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -50, -70)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 0, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 20, 10)
								
								end;
			 };
	[289] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 100, 40)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -70, -85)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 100, 40)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -70, -85)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -15, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 15, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", 0, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 15, 10)
								
								end;
			 };
	[290] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 30, 40)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -20, -155)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 30, 40)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -20, -155)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[1156] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 0, 60)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", 0, -63)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 0, 60)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", 0, -63)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 15, 10)
								
								end;
			 };
	[1422] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 70, 165)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -75, -125)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 70, 165)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -75, -125)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "top", grid_view_this, "bottom", -95, -25)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(toggleView, "topright", lootSort, "topleft", 8, 5)
									
									WindowAddAnchor(restock, "topright", toggleView, "topleft", 5, -5)
									WindowAddAnchor(organize, "topright", restock, "topleft", 5, 0)

								end;
			 };
	[19724] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 35, 85)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -35, -88)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 35, 85)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -35, -88)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[30558] =	{ 	
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 75, 90)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -60, -80)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 75, 90)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -60, -80)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									
									if (id ~= ContainerWindow.PlayerBackpack) then
										WindowSetShowing(lock, false)
										WindowSetShowing(lootAll, true)

										WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 8)
										WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
										WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
										
										WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 8)
										WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
										
										
										WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", -10, 13)
									else
										WindowSetShowing(lock, true)
										WindowSetShowing(lootAll, false)
										
										WindowAddAnchor( lock, "top", this, "center", 0, 50)
										
										WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 8)
										
										WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 8)
										WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
										
										WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", -10, 13)
									end
								end;
			 };
	[30560] =	{ 	
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 75, 90)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -60, -80)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 75, 90)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -60, -80)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									
									if (id ~= ContainerWindow.PlayerBackpack) then
										WindowSetShowing(lock, false)
										WindowSetShowing(lootAll, true)

										WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 8)
										WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
										WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
										
										WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 8)
										WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
										
										
										WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", -10, 13)
									else
										WindowSetShowing(lock, true)
										WindowSetShowing(lootAll, false)
										
										WindowAddAnchor( lock, "top", this, "center", 0, 50)
										
										WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 8)
										
										WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 8)
										WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
										
										WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", -10, 13)
									end
								end;
			 };
	[30562] =	{ 	
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 75, 90)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -60, -80)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 75, 90)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -60, -80)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									
									if (id ~= ContainerWindow.PlayerBackpack) then
										WindowSetShowing(lock, false)
										WindowSetShowing(lootAll, true)

										WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 8)
										WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
										WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
										
										WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 8)
										WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
										
										
										WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", -10, 13)
									else
										WindowSetShowing(lock, true)
										WindowSetShowing(lootAll, false)
										
										WindowAddAnchor( lock, "top", this, "center", 0, 50)
										
										WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 8)
										
										WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 8)
										WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
										
										WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", -10, 13)
									end
								end;
			 };
	[30586] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 40, 0)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -40, -145)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 40, 0)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -40, -145)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[39934] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 5, 15)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -5, -50)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 5, 15)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -5, -50)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -10, 0)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 8, 0)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 12, 5)
								
								end;
			 };	
	[9834] =	{  
		grid =			function(this) 
							local grid_view_this = this.."GridView" 
							WindowClearAnchors(grid_view_this) 
							WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 75)
							WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -20, -60)
						end;
						
		list =			function(this) 
							local list_view_this = this.."ListView" 
							WindowClearAnchors(list_view_this) 
							WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 75)
							WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -20, -60)
						end;
				
		buttons =		function(this) 
							local id = WindowGetId(this)
									
							local lootAll = this.."LootAll"        
							local restock = this.."Restock"
							local organize = this.."Organize"
							local lock = this.."Lock"
							local search = this.."Search"
							local toggleView = this.."ViewButton"
							local grid_view_this = this.."GridView"
							local lootSort = this.."LootSort"
									
							WindowClearAnchors(lootSort)
							WindowClearAnchors(lootAll)
							WindowClearAnchors(restock)
							WindowClearAnchors(organize)
							WindowClearAnchors(lock)
							WindowClearAnchors(search)
							WindowClearAnchors(toggleView)
									
							WindowSetShowing(lock, false)
							WindowSetShowing(lootAll, true)

							WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
							WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
							WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
							WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
							WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
							WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 0, 10)
								
						end;
	 };
	[9835] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 75)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -20, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 75)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -20, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 0, 10)
								
								end;
			 };
	[40153] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 10)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -60)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 10, 10)
								
								end;
			 };
	[40164] =	{ 	
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 75, 90)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -60, -80)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 75, 90)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -60, -80)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									
									if (id ~= ContainerWindow.PlayerBackpack) then
										WindowSetShowing(lock, false)
										WindowSetShowing(lootAll, true)

										WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 8)
										WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
										WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
										
										WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 8)
										WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
										
										
										WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", -10, 13)
									else
										WindowSetShowing(lock, true)
										WindowSetShowing(lootAll, false)
										
										WindowAddAnchor( lock, "top", this, "center", 0, 50)
										
										WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 8)
										
										WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 8)
										WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
										
										WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", -10, 13)
									end
								end;
			 };
	[40165] =	{ 	
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 75, 90)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -60, -80)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 75, 90)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -60, -80)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									
									if (id ~= ContainerWindow.PlayerBackpack) then
										WindowSetShowing(lock, false)
										WindowSetShowing(lootAll, true)

										WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 0, 8)
										WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
										WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
										
										WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 8)
										WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
										
										
										WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", -10, 13)
									else
										WindowSetShowing(lock, true)
										WindowSetShowing(lootAll, false)
										
										WindowAddAnchor( lock, "top", this, "center", 0, 50)
										
										WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 8)
										
										WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 8)
										WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
										
										WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", -10, 13)
									end
								end;
			 };
	[1747] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -20, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 0, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", 0, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 5, 10)
								
								end;
			 };
	[1748] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -20, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 0, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", 0, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 5, 10)
								
								end;
			 };
	[1749] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -20, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 0, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", 0, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 5, 10)
								
								end;
			 };
	[1750] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -20, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 0, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", 0, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 5, 10)
								
								end;
			 };
	[40167] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 25, 60)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -25, -65)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 25, 60)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -25, -65)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", 10, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 5, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", -10, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", -5, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 20, 10)
								
								end;
			 };
	[40247] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -20, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 0, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", 0, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 5, 10)
								
								end;
			 };
	[40248] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -20, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 0, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", 0, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 5, 10)
								
								end;
			 };
	[40249] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -20, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 0, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", 0, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 5, 10)
								
								end;
			 };
	[40250] =	{  
				grid =			function(this) 
									local grid_view_this = this.."GridView" 
									WindowClearAnchors(grid_view_this) 
									WindowAddAnchor( grid_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(grid_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
						
				list =			function(this) 
									local list_view_this = this.."ListView" 
									WindowClearAnchors(list_view_this) 
									WindowAddAnchor( list_view_this,	"topleft", this, "topleft", 20, 96)
									WindowAddAnchor(list_view_this,		"bottomright", this, "bottomright", -10, -108)
								end;
				
				buttons =		function(this) 
									local id = WindowGetId(this)
									
									local lootAll = this.."LootAll"        
									local restock = this.."Restock"
									local organize = this.."Organize"
									local lock = this.."Lock"
									local search = this.."Search"
									local toggleView = this.."ViewButton"
									local grid_view_this = this.."GridView"
									local lootSort = this.."LootSort"
									
									WindowClearAnchors(lootSort)
									WindowClearAnchors(lootAll)
									WindowClearAnchors(restock)
									WindowClearAnchors(organize)
									WindowClearAnchors(lock)
									WindowClearAnchors(search)
									WindowClearAnchors(toggleView)
									
									WindowSetShowing(lock, false)
									WindowSetShowing(lootAll, true)

									WindowAddAnchor(search, "bottomleft", grid_view_this, "topleft", -20, 5)
									WindowAddAnchor(lootAll, "topright", search, "topleft", 0, 0)
									WindowAddAnchor(lootSort, "topright", lootAll, "topleft", 0, 0)
									
									WindowAddAnchor(organize, "bottomright", grid_view_this, "topright", 0, 5)
									WindowAddAnchor(restock, "topleft", organize, "topright", 0, 0)
									
									WindowAddAnchor(toggleView, "bottom", grid_view_this, "top", 5, 10)
								
								end;
			 };
 }

-- Content label location on legacy containers
ContainersInfo.LegacyContentLabelLocation = { 
	[9] = { x=-40, y=10 },
	[60] = { x=0, y=-20 },
	[61] = { x=-10, y=10 },
	[62] = { x=-20, y=10 },
	[63] = { x=0, y=-40 },
	[64] = { x=0, y=-10 },
	[65] = { x=0, y=10 },
	[66] = { x=-40, y=10 },
	[67] = { x=0, y=-50 },
	[68] = { x=0, y=-60 },
	[72] = { x=0, y=-30 },
	[73] = { x=-40, y=10 },
	[74] = { x=-40, y=10 },
	[75] = { x=0, y=-40 },
	[76] = { x=0, y=-60 },
	[77] = { x=0, y=-90 },
	[78] = { x=-40, y=0 },
	[79] = { x=-40, y=0 },
	[81] = { x=5, y=-30 },
	[258] = { x=0, y=-90 },
	[259] = { x=10, y=-10 },
	[260] = { x=5, y=-30 },
	[261] = { x=5, y=-30 },
	[262] = { x=5, y=-30 },
	[263] = { x=5, y=-30 },
	[264] = { x=10, y=-30 },
	[265] = { x=5, y=-30 },
	[266] = { x=5, y=-30 },
	[267] = { x=5, y=-30 },
	[268] = { x=5, y=-30 },
	[269] = { x=5, y=-30 },
	[270] = { x=5, y=-30 },
	[278] = { x=10, y=-50 },
	[282] = { x=-60, y=0 },
	[283] = { x=5, y=-70 },
	[284] = { x=0, y=0 },
	[285] = { x=0, y=-30 },
	[286] = { x=20, y=-150 },
	[287] = { x=5, y=-60 },
	[288] = { x=10, y=-80 },
	[289] = { x=10, y=-110 },
	[290] = { x=0, y=0 },
	[1156] = { x=0, y=-10 },
	[1422] = { x=10, y=-110 },
	[2330] = { x=0, y=-60 },
	[2350] = { x=0, y=-90 },
	[19724] = { x=5, y=-60 },
	[30558] = { x=0, y=-20 },
	[30560] = { x=0, y=-20 },
	[30562] = { x=0, y=-20 },
	[30586] = { x=0, y=0 },
	[39934] = { x=-40, y=0 },
	[9834] = { x=0, y=-40 },
	[9835] = { x=0, y=-40 },
	[40153] = { x=0, y=-20 },
	[40164] = { x=0, y=-20 },
	[40165] = { x=0, y=-20 },
	[40167] = { x=0, y=10 },
 }

-- View button location on legacy containers
ContainersInfo.LegacyViewButtonLocation = { 
	[9] = { x=87, y=60 },
	[60] = { x=141, y=218 },
	[61] = { x=100, y=200 },
	[62] = { x=100, y=240 },
	[63] = { x=125, y=185 },
	[64] = { x=100, y=175 },
	[65] = { x=110, y=205 },
	[66] = { x=110, y=255 },
	[67] = { x=125, y=185 },
	[68] = { x=125, y=160 },
	[72] = { x=100, y=150 },
	[73] = { x=110, y=255 },
	[74] = { x=110, y=255 },
	[75] = { x=130, y=180 },
	[76] = { x=160, y=10 },
	[77] = { x=0, y=0 },
	[78] = { x=70, y=0 },
	[79] = { x=70, y=0 },
	[81] = { x=100, y=150 },
	[258] = { x=145, y=150 },
	[259] = { x=130, y=170 },
	[260] = { x=110, y=150 },
	[261] = { x=100, y=150 },
	[262] = { x=100, y=150 },
	[263] = { x=110, y=150 },
	[264] = { x=110, y=150 },
	[265] = { x=100, y=150 },
	[266] = { x=100, y=150 },
	[267] = { x=105, y=150 },
	[268] = { x=110, y=150 },
	[269] = { x=110, y=150 },
	[270] = { x=100, y=150 },
	[278] = { x=100, y=150 },
	[282] = { x=80, y=0 },
	[283] = { x=140, y=150 },
	[284] = { x=130, y=180 },
	[285] = { x=130, y=170 },
	[286] = { x=180, y=170 },
	[287] = { x=140, y=190 },
	[288] = { x=130, y=170 },
	[289] = { x=150, y=150 },
	[290] = { x=130, y=180 },
	[1156] = { x=100, y=160 },
	[1422] = { x=255, y=100 },
	[19724] = { x=165, y=230 },
	[30558] = { x=141, y=218 },
	[30560] = { x=141, y=218 },
	[30562] = { x=141, y=218 },
	[30586] = { x=135, y=190 },
	[39934] = { x=70, y=0 },
	[40153] = { x=100, y=160 },
	[40164] = { x=141, y=218 },
	[40165] = { x=141, y=218 },
	[40167] = { x=110, y=205 },
 }

function ContainersInfo.IsValidContainer(id)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return false
	end

	-- is this a corpse?
	if IsCorpse(id) then
		return true
	end

	if id == ContainerWindow.PlayerBackpack or id == ContainerWindow.PlayerBank then
		return true
	end

	-- get the object type for the container
	local objectType = GetItemType(id)

	-- do we have a valid object type?
	if IsValidID(objectType) then

		-- searching for the right texture for this object type
		for i = 1, #ContainersInfo.Data do

			-- get the data about this container
			local val = ContainersInfo.Data[i]

			-- parsing the object types of this container
			for k = 1, #val.ItemsId do

				-- have we found the right object type?
				if val.ItemsId[k] == objectType then

					-- the container is valid!
					return true
				end
			end
		end
	end

	return false
end

function ContainersInfo.GetGump(id, defaultGump)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return defaultGump
	end

	-- is this the bank box?
	if id == ContainerWindow.PlayerBank then
		return 74, "metal chest"
	end

	-- is this the player backpack?
	if (id == ContainerWindow.PlayerBackpack) then
		
		-- suede backpack style
		if (SystemData.Settings.GameOptions.myLegacyBackpackType == SystemData.Settings.LegacyBackpackStyle.LEGACY_BACKPACK_SUEDE) then			
			return ContainersInfo.SUEDE_BACKPACK			
		end

		-- polar bear backpack style
		if (SystemData.Settings.GameOptions.myLegacyBackpackType == SystemData.Settings.LegacyBackpackStyle.LEGACY_BACKPACK_POLAR_BEAR) then			
			return ContainersInfo.POLAR_BEAR_BACKPACK			
		end

		-- ghoul skin backpack style
		if (SystemData.Settings.GameOptions.myLegacyBackpackType == SystemData.Settings.LegacyBackpackStyle.LEGACY_BACKPACK_GHOUL_SKIN) then			
			return ContainersInfo.GHOUL_SKIN_BACKPACK			
		end
	end

	-- get the object type for the container
	local objectType = GetItemType(id)
	
	-- is this a corpse?
	if IsCorpse(id) then
		return ContainersInfo.DefaultCorpse, "corpse" -- coffin gump
	end

	-- do we have a valid object type?
	if IsValidID(objectType) then

		-- searching for the right texture for this object type
		for i = 1, #ContainersInfo.Data do

			-- get the data about this container
			local val = ContainersInfo.Data[i]

			-- parsing the object types of this container
			for k = 1, #val.ItemsId do

				-- have we found the right object type?
				if val.ItemsId[k] == objectType then

					-- return gump ID, container name and texture ID
					return val.GumpId, val.name, val.Texture
				end
			end
		end
	end

	-- if we don't have a valid default gump ID, we assign one...
	if not IsValidID(defaultGump) then
		defaultGump = ContainersInfo.DefaultGump 
	end

	return defaultGump
end