
TextParsing = {}

TextParsing.SpecialColorsString =
{
	[L"*evades*"] = true,
	[L"You recover from the shock."] = true,
}

TextParsing.SpecialColors =
{
	[501770] = true, -- "You swallow the fish whole!"
	[501891] = true, -- "You extract the message from the bottle."
	[501240] = true, -- "You have hidden yourself well."
	[1005534] = true, -- "* The poison seems to have no effect. *"
	[1061914] = true, -- "* You push the strange green thorn into the ground *"
	[1061905] = true, -- "* You eat the orange petal.  You feel more resilient! *"
	[1061904] = true, -- "* You already feel resilient! You decide to save the petal for later *"
	[1080057] = true, -- "* The creature has been beaten into subjugation! *"
	[1114441] = true, -- "* You feel yourself resisting the effects of the poison *"
	[1010597] = true, -- "*You start to tame the creature.*"
	[1010598] = true, -- "*begins taming a creature.*"
	[502060] = true, -- "Your pet looks happier."
	[502799] = true, -- "It seems to accept you as master."
	[1071958] = true, -- * ~1_VAL~ seems resistant to the poison *
	[1061915] = true, -- * ~1_PLAYER_NAME~ pushes a strange green thorn into the ground. *
	[1080021] = true, -- Bank container has ~1_VAL~ items, ~2_VAL~ stones
}

TextParsing.Specials ={
	[501029] = Interface.Settings.Neutral, -- "Select Marked item."
	[1113405] = Interface.Settings.Green, -- "Your gem is now active. You may enter the Experimental Room"
	[1113402] = Interface.Settings.Green, -- "The next room has been unlocked! Hurry through the door before your gem's state changes again!"
	[1113383] = Interface.Settings.Green, -- "You finish assembling your key and may now unlock the third puzzle."
	[1113382] = Interface.Settings.Green, -- "You've solved the puzzle!! An item has been placed in your bag."
	[1054054] = Interface.Settings.Green, -- You have completed your study of this Solen Egg Nest. You put your notes away.
	[1054057] = Interface.Settings.Green, -- You complete your examination of this bizarre Egg Nest. The Naturalist will undoubtedly be quite interested in these notes!
	[1113403] = Interface.Settings.Green, -- Congratulations!! The last room has been unlocked!! Hurry through to claim your reward! 
	[1113579] = Interface.Settings.Green, -- Correct Code Entered. Crystal Lock Disengaged. 
}

TextParsing.OverHeadErrorsString =
{
	[L"* The sound of gas escaping is heard from the chest. *"] = true,
	[L"An arrow imbeds itself in your flesh!"] = true,
}

TextParsing.OverHeadErrors =
{
	[502630] = "fizzle", -- "More reagents are needed for this spell."
	[502632] = "fizzle", -- "The spell fizzles."
	[500852] = true, -- "You stepped onto a spike trap!"
	[500853] = true, -- "You stepped onto a blade trap!"
	[500855] = true, -- "You are enveloped by a noxious gas cloud!"
	[500854] = true, -- "You take damage from an exploding mushroom!"
	[1010571] = true, -- "OUCH!"
	[1008086] = true, -- "*rummages through a corpse and takes an item*"
	[1010406] = true, -- "You cannot heal that target in their current state."
	[1074165] = true, -- "You feel dizzy from a lack of clear air"
	[1060757] = true, -- "You are bleeding profusely"
	[1060758] = true, --  ~1_NAME~ is bleeding profusely
	[1061121] = true, -- "Your equipment is severely damaged."
	[500235] = true, -- "You must wait a few seconds before using another healing potion."
	[1019048] = true, -- "I am dead and cannot do that."
	[1076539] = true, -- "*looks confused*"
	[502358] = true, -- "I cannot recall from that object."
	[1078843] = true, -- "I cannot recall from that object right now."
	[1019045] = true, -- "I can't reach that."
	[501944] = true, -- "That location is blocked."
	[1042873] = true, -- "You have been revealed!"
	[501237] = true, -- "You can't seem to hide right now."
	[502625] = true, -- "Insufficient mana for this spell."
	[1112767] = true, -- "Medusa releases one of the petrified creatures!!"
	[1010410] = true, -- "This is already locked down."
	[503172] = true, -- "The fish don't seem to be biting here."
	[503173] = true, -- "The fish don't seem to be biting here."
	[500612] = true, -- "You play poorly, and there is no effect."
	[1113587] = true, -- "* The creature goes into a frenzied rage! *"
	[502998] = true, -- "A dart imbeds itself in your flesh!"
	[500263] = true, -- "*Splashing acid blood scars your weapon!*"
	[1114443] = true, -- "* Your body convulses from electric shock *"
	[1010523] = true, -- "A toxic vapor envelops thee."
	[1010525] = true, -- "Pain lances through thee from a sharp metal blade."
	[1010526] = true, -- "Lightning arcs through thy body."
	[1010524] = true, -- "Searing heat scorches thy skin."
	[1040024] = true, -- "You are still too dazed from being knocked off your mount to ride."
	[1112457] = true, -- "You are still too dazed to fly."
	[1080060] = true, -- "* The solen's damaged acid sac squirts acid! *"
	[1115755] = true, -- "The creature looks at you strangely and shakes its head no."
	[502800] = true, -- "You can't see that."
	[502801] = true, -- "You can't tame that!"
	[1049655] = true, -- "That creature cannot be tamed."
	[502803] = true, -- "It's too far away."
	[502804] = true, -- "That animal looks tame already."
	[1049650] = true, -- "Someone else is already taming that creature."
	[502805] = true, -- "You seem to anger the beast!"
	[502806] = true, -- "You have no chance of taming this creature."
	[1053091] = true, -- "* You feel the effects of your poison resistance wearing off *"
	[1053093] = true, -- "* The strength of the poison overcomes your resistance! *"
	[500384] = true, --  "Ah, art thou trying to fool me? Thou hast not so much gold!"
	[1054046] = true, -- You abandon your study of the Solen Egg Nest without gathering the needed information.
	[1113400] = true, -- "You fail to neutralize the gem in time and are expelled from the room!!"
	[1080038] = true, -- The solen's acid sac is burst open!
	[1043255] = true, -- ~1_NAME~ appears to have decided that it is better off without a master!
	[1042857] = true, -- "*You feel a bit nauseous*"
	[1042859] = true, -- "* You feel disoriented and nauseous! *"
	[1042861] = true, -- "* You begin to feel pain throughout your body! *"
	[1042863] = true, -- "* You feel extremely weak and are in severe pain! *"
	[1042865] = true, -- "* You are in extreme pain, and require immediate aid! *"
}

TextParsing.PoisonMessages = 
{
	[1042858] = true, -- *~1_PLAYER_NAME~ looks ill.*
	[1042860] = true, -- * ~1_PLAYER_NAME~ looks extremely ill. *
	[1042867] = true, -- * ~1_PLAYER_NAME~ looks extremely ill. *
	[1042862] = true, -- * ~1_PLAYER_NAME~ stumbles around in confusion and pain. *
	[1042868] = true, -- * ~1_PLAYER_NAME~ stumbles around in confusion and pain. *
	[1042864] = true, -- * ~1_PLAYER_NAME~ is wracked with extreme pain. *
	[1042869] = true, -- * ~1_PLAYER_NAME~ is wracked with extreme pain. *
	[1042866] = true, -- * ~1_PLAYER_NAME~ begins to spasm uncontrollably. *
	[1042870] = true, -- * ~1_PLAYER_NAME~ begins to spasm uncontrollably. *
}

TextParsing.PetProgress = 
{
	[1157564] = true, -- *The pet does not appear to train from that*
	[1157565] = true, -- *The pet's battle experience has slightly increased!*
	[1157573] = true, -- *The pet's battle experience has fairly increased!*
	[1157574] = true, -- *The pet's battle experience has greatly increased!*
}

TextParsing.TamingMasteryMessages = 
{
	[L"You guide your pet's behaviors, enhancing its skill gains!"] = true,
	[L"You ready your pet for combat, increasing its battle effectiveness!"] = true,
}

TextParsing.TauntsTable = 
{
	[L"[*]ah[*]"] = 			{[0] =1049, [1] =778 };
	[L"[*]ahha[*]"] = 			{[0] =1050, [1] =779 };
	[L"[*]applaud[*]"] = 		{[0] =1051, [1] =780 };
	[L"[*]blow nose[*]"] = 		{[0] =1052, [1] =781 };
	[L"[*]burp[*]"] = 			{[0] =1053, [1] =782 };
	[L"[*]cheer[*]"] = 			{[0] =1054, [1] =783 };
	[L"[*]clear throat*"] = 	{[0] =1055, [1] =784 };
	[L"[*]cough[*]"] = 			{[0] =1056, [1] =785 };
	[L"[*]cough laugh*"] =		{[0] =1057, [1] =786 };
	[L"[*]cry[*]"] = 			{[0] =1058, [1] =787 };
	[L"[*]fart[*]"] = 			{[0] =1064, [1] =792 };
	[L"[*]gasp[*]"] = 			{[0] =1065, [1] =793 };
	[L"[*]giggle[*]"] = 		{[0] =1066, [1] =794 };
	[L"[*]growl[*]"] = 			{[0] =1068, [1] =796 };
	[L"[*]groan[*]"] = 			{[0] =1067, [1] =795 };
	[L"[*]hey[*]"] = 			{[0] =1069, [1] =797 };
	[L"[*]hic[*]"] = 			{[0] =1070, [1] =798 };
	[L"[*]huh[*]"] = 			{[0] =1071, [1] =799 };
	[L"[*]kiss[*]"] = 			{[0] =1072, [1] =800 };
	[L"[*]laugh[*]"] = 			{[0] =1073, [1] =801 };
	[L"[*]no[*]"] = 			{[0] =1074, [1] =802 };
	[L"[*]oh[*]"] = 			{[0] =1075, [1] =803 };
	[L"[*]oooh[*]"] = 			{[0] =1085, [1] =811 };
	[L"[*]oops[*]"] = 			{[0] =1086, [1] =812 };
	[L"[*]puke[*]"] = 			{[0] =1087, [1] =813 };
	[L"[*]scream[*]"] = 		{[0] =1088, [1] =814 };
	[L"[*]shh[*]"] = 			{[0] =1089, [1] =815 };
	[L"[*]shush[*]"] = 			{[0] =1089, [1] =815 };
	[L"[*]sigh[*]"] = 			{[0] =1090, [1] =816 };
	[L"[*]sniff[*]"] = 			{[0] =1092, [1] =818 };
	[L"[*]sneeze[*]"] = 		{[0] =1091, [1] =817 };
	[L"[*]snore[*]"] = 			{[0] =1093, [1] =819 };
	[L"[*]spit[*]"] = 			{[0] =1094, [1] =820 };
	[L"[*]whistle[*]"] = 		{[0] =1095, [1] =821 };
	[L"[*]yawn[*]"] = 			{[0] =1096, [1] =822 };
	[L"[*]yeah[*]"] = 			{[0] =1097, [1] =823 };
	[L"[*]yell[*]"] = 			{[0] =1098, [1] =824 };
} 

TextParsing.Fame = 
{
	[1019051] = true; -- You have gained a little fame.
	[1019052] = true; -- You have gained some fame.
	[1019053] = true; -- You have gained a good amount of fame.
	[1019054] = true; -- You have gained a lot of fame.
	[1019055] = true; -- You have lost a little fame.
	[1019056] = true; -- You have lost some fame.
	[1019057] = true; -- You have lost a good amount of fame.
	[1019058] = true; -- You have lost a lot of fame.
}

TextParsing.Karma = 
{
	[1019059] = true; -- You have gained a little karma.
	[1019060] = true; -- You have gained some karma.
	[1019061] = true; -- You have gained a good amount of karma.
	[1019062] = true; -- You have gained a lot of karma.
	[1019063] = true; -- You have lost a little karma.
	[1019064] = true; -- You have lost some karma.
	[1019065] = true; -- You have lost a good amount of karma.
	[1019066] = true; -- You have lost a lot of karma.
}

TextParsing.DungeonPoints = 
{
	[1151634] = true; -- You gain ~1_AMT~ dungeon points for ~2_NAME~. Your total is now ~3_TOTAL~.
	[1151635] = true; -- You lost ~1_AMT~ dungeon points for ~2_NAME~. Your total is now ~3_TOTAL~.

	[1152649] = true; -- For your participation in the Battle for the Void Pool on ~1_FACET~, you have received ~2_POINTS~ reward points. Any reward points you have accumulated may be redeemed by visiting Vela in Cove.
	[1152650] = true; -- During the battle, you helped fight back ~1_COUNT~ out of ~2_TOTAL~ waves of enemy forces. Your final wave was ~3_MAX~. Your total score for the battle was ~4_SCORE~ points.
}

TextParsing.LastPetProgressID = 0 

function TextParsing.Emotize(string)
	return L"* " .. string .. L" *"
end

function TextParsing.ColorizeText()
	local senderText = SystemData.Text
	local emotized = false
	local channel = SystemData.TextChannelID

	local default = NewChatWindow.ChannelColors[SystemData.TextChannelID]
	if not default then
		default = {r=125,g=125,b=125}
	end
	local color = {r= default.r, g=default.g, b=default.b}
	
	local find = wstring.find
	
	if wstring.len(SystemData.Text) > 2 then
		if (find(wstring.sub(SystemData.Text, 1, 1), L'*', 1, true) and find(wstring.sub(SystemData.Text, -1), L'*', 1, true)) then
			channel = SystemData.ChatLogFilters.EMOTE
			emotized = true
			color = NewChatWindow.ChannelColors[ SystemData.ChatLogFilters.EMOTE ]
		end
	end

	if not ChatSettings then
		return
	end
		
	if (SystemData.TextColor ~= 0 and not emotized) then
		color = SystemData.TextColor
	end

	if SpellsInfo.SpellsData[tostring(senderText)] then
		return SpellsInfo.SpellsData[tostring(senderText)].color, channel
	end
			 
	if (SystemData.TextChannelID == 16) then
		SystemData.SourceName = GetStringFromTid(3000610)
		color.r,color.g,color.b = HueRGBAValue(1195)
		return color, channel
	end
		
	if (SystemData.TextID == 1113587) then -- The creature goes into a frenzied rage!
		senderText = TextParsing.Emotize(senderText)
	end
		
	if TextParsing.OverHeadErrors[senderText] or TextParsing.OverHeadErrors[SystemData.TextID] or TextParsing.PoisonMessages[SystemData.TextID] then
		if (TextParsing.OverHeadErrors[SystemData.TextID] == "fizzle") then
			Interface.CurrentSpell.CheckFizzle = true
		end
		return Interface.Settings.OverHeadError, channel
	end
	
	if TextParsing.SpecialColorsString[senderText] or TextParsing.SpecialColors[SystemData.TextID] then
		return Interface.Settings.SpecialColor, channel
	end
	
	if TextParsing.Specials[SystemData.TextID] then
		return special, channel
	end
	
	if (find(senderText , L"You are attacking ") or find(senderText , L" is attacking you!")) then
		return Interface.Settings.OverHeadError, channel
	end
	
	if (find(senderText , L"Thy current bank balance is:")) then
		return Interface.Settings.SpecialColor, channel
	end
	
	if (find(senderText , L"Into your bank box I have placed a check in the amount of:")
		or SystemData.TextID == 1112821 -- I need to add some ~1_INGREDIENT~.
		) then
		
		return Interface.Settings.POISON, channel
	end

	if (SystemData.TextID == 1154721 or SystemData.SourceName == L"VvV") then -- A Battle between Vice and Virtue is active! To Arms! The City of ~1_CITY~ is besieged!
		return {r=255, g=0, b=0}, channel
	end
	
	if (SystemData.TextID == 1151281) then -- "Your Clean Up Britannia point total is now ~1_VALUE~!"
		return {r=16,g=184, b=0}, channel
	end
	
	return color, channel
end

function TextParsing.CenterScreenText()
	local senderText = wstring.trim(SystemData.Text)
	local find = wstring.find
	
	if ((SystemData.TextID == 1080023 or  find(senderText, L"Servers going down: You have approximately", 1, true) and SystemData.SourceName == L"" )) then
		CenterScreenText.SendCenterScreenTexture("serverdown")
	end
	
	if (SystemData.TextID == 1074834) then -- Please enter [ to reply to the GM. 
		CenterScreenText.SendCenterScreenTexture("gmarrived")
	end
	
	if (SystemData.TextID == 1062317) then -- "For your valor in combating the fallen beast, a special artifact has been bestowed on you."
		CenterScreenText.SendCenterScreenTexture("artifact")
	end

	if (SystemData.TextID == 502088) then -- "A special gift has been placed in your backpack."
		CenterScreenText.SendCenterScreenTexture("artifact")
	end
	
	if (SystemData.TextID == 1154530) then -- "You notice the crest of Minax on your fallen foe's equipment and decide it may be of some value..."
		CenterScreenText.SendCenterScreenTexture("artifact")
	end
	
	if (SystemData.TextID == 1154554) then -- "You recover an artifact bearing the crest of Minax from the rubble."
		CenterScreenText.SendCenterScreenTexture("artifact")
	end

	if (SystemData.TextID == 1158673) then -- "You notice some of your fallen foes' equipment to be of the cult and decide it may be of some value..."
		CenterScreenText.SendCenterScreenTexture("artifact")
	end
	 	
	if (SystemData.TextID == 1112600) then -- "Your lenses crumble. You are no longer protected from Medusa's gaze!"
		CenterScreenText.SendCenterScreenTexture("gorgon")
	end
	
	if (SystemData.TextID ==  1075007) then -- "Your bone handled machete snaps in half as you force your way through the poisonous undergrowth."
		CenterScreenText.SendCenterScreenTexture("machete")
	end
	
	
	if (SystemData.TextID == 1152527) then -- "The battle for the Void Pool is beginning now!"
		CenterScreenText.SendCenterScreenTexture("battlebegin")
	end
	
	if Interface.Settings.CST_VvVAlert then
		if (SystemData.TextID == 1154721) then -- A Battle between Vice and Virtue is active! To Arms! The City of ~1_CITY~ is besieged!
			CenterScreenText.SendCenterScreenTexture("battlebegin")
		end
	end
	
	if (SystemData.TextID == 1152530) then -- "Cora's forces have destroyed the Void Pool walls. The battle is lost!"
		CenterScreenText.SendCenterScreenTexture("battlelost")
	end
	
	if (SystemData.TextID == 1154550) then -- "*A sound roars in the distance...Minax's Beacon is vulnerable to attack!!*"
		CenterScreenText.SendCenterScreenTexture("beacon")
	end
	
	if (SystemData.TextID == 1005603) then -- "You can move again!"
		if (not BuffDebuff.Timers[10037]) then
			CenterScreenText.SendCenterScreenTexture("free")
		end
	end
	
	if (SystemData.TextID == 1080016) then -- "That container cannot hold more weight."
		-- TODO: check for the backpack properties to make sure it's the backpack generating this message
		CenterScreenText.SendCenterScreenTexture("backpackfull")
	end
	
	if (SystemData.TextID == 1076776 and SystemData.TextSourceID == Interface.LastTarget) then  -- Want something really special? Of course you do!
		CenterScreenText.SendCenterScreenTexture("treat")
	end
  
	if (SystemData.TextID == 1156507) then  -- *You uncover a lava rock and carefully store it for later!*
		CenterScreenText.SendCenterScreenTexture("lavarock")
	end
  
	if (SystemData.TextID == 1156506) then   -- *The Volcano is becoming unstable!*
		CenterScreenText.SendCenterScreenTexture("eruption")
	end

	if (SystemData.TextID == 1072065) then   -- You gaze upon the dryad's beauty, and forget to continue battling!
		CenterScreenText.SendCenterScreenTexture("calmed")
	end

	if (SystemData.TextID == 1079552) then   -- Your luck just ran out.
		CenterScreenText.SendCenterScreenTexture("luckrunout")
	end

	if (SystemData.TextID == 1053091) then -- * You feel the effects of your poison resistance wearing off *
		CenterScreenText.SendCenterScreenTexture("petalsworeoff")
	end

	if		( SystemData.TextID == 1072197 ) or -- The creature's beauty makes your blood race. Your clothing is too confining.
			( SystemData.TextID == 1072196 ) or -- The creature's music makes your blood race. Your clothing is too confining.
			( SystemData.TextID == 1150803 ) -- You begin to take off your clothing.
	then 
		CenterScreenText.SendCenterScreenTexture("stripped")
	end

	if (SystemData.TextID == 1153493) then -- Your keen senses detect something hidden in the area...
		CenterScreenText.SendCenterScreenTexture("hiddencache")
	end

	if (SystemData.TextID == 500814 or SystemData.TextID == 500816 or SystemData.TextID == 1042873) then -- You have been revealed!
		CenterScreenText.SendCenterScreenTexture("revealed")
	end

	if (SystemData.TextID == 1155479) then -- *Your keen senses alert you to an incoming ambush of attackers!*
		CenterScreenText.SendCenterScreenTexture("ambush")
	end

	if (SystemData.TextID == 1158907) then -- You recover maritime trade cargo!
		CenterScreenText.SendCenterScreenTexture("cargocrate")
	end
end

function TextParsing.TimersNbuff()
	
	if (SystemData.TextID == 1070839) then -- "The creature attacks with stunning force!"
		HotbarSystem.StunTime = 4
	end
	
	if (SystemData.TextID ==  1115884) then -- "You started Honorable Combat!"
		Interface.HonorMobileConfirm(WindowData.Cursor.lastTarget)
	end
	
	if (SystemData.TextID == 1062074  and SystemData.TextSourceID == GetPlayerID()) then --"Anh Mi Sah Ko"
		HotbarSystem.SkillDelayTimeMax = 5
		HotbarSystem.SkillDelayTime = 5
	end
	
	if (SystemData.TextID == 500397) then --"To whom do you wish to grovel?"
		HotbarSystem.SkillDelayTimeMax = 11
		HotbarSystem.SkillDelayTime = 11
	end
	
	if (SystemData.TextID == 500612) then -- "You play poorly, and there is no effect."
		HotbarSystem.SkillDelayTimeMax = 6
		HotbarSystem.SkillDelayTime = 6
	end
	
	if (SystemData.TextID == 1010597) then --  "*You start to tame the creature.*" 
		HotbarSystem.SkillDelayTimeMax = 11
		HotbarSystem.SkillDelayTime = 11
	end
	
	if (SystemData.TextID == 502730) then --  "You begin to move quietly."
		if (HotbarSystem.SkillDelayTime > 5) then
			HotbarSystem.SkillDelayTimeMax = 5
			HotbarSystem.SkillDelayTime = 5
		end
	end
	
	if (SystemData.TextID == 501240) then --  "You have hidden yourself well."
		HotbarSystem.SkillDelayTimeMax = 11
		HotbarSystem.SkillDelayTime = 11
	end
	
	if (SystemData.TextID == 501241) then -- "You fail to hide."
		HotbarSystem.SkillDelayRestarted = true
		HotbarSystem.SkillDelayTime = 11
	end
	
	if (SystemData.TextID == 501596) then -- "You play rather poorly, and to no effect."
		HotbarSystem.SkillDelayTimeMax = 8
		HotbarSystem.SkillDelayTime = 8
	end

	if (SystemData.TextID == 1018086) then -- "What do you wish to track?"
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
	end
	
	if (SystemData.TextID == 502989) then -- "Tracking failed."
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
	end
	
	if ((SystemData.TextID == 500618 or SystemData.TextID ==  500877)  and TextParsing.InstrumentCheck) then -- "That is too far away!", "That is not a musical instrument."
		HotbarSystem.SkillDelayTime = 9
		TextParsing.InstrumentCheck = false
		HotbarSystem.SkillDelayTimeMax = 9
	end
	
	if (TextParsing.InstrumentCheck) then
		TextParsing.InstrumentCheck = false
	end
	
	if (SystemData.TextID == 500617 or SystemData.TextID == 500874 or SystemData.TextID == 501582) then -- "What instrument shall you play?" // "What instrument shall you play the music on?"
		TextParsing.InstrumentCheck = true
	end
	
	if (SystemData.TextID == 502368) then -- "Which trap will you attempt to disarm?"
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
	end
	
	if (SystemData.TextID == 500819) then -- "Where will you search?"
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
	end
	
	if (SystemData.TextID == 502698) then -- "Which item will you attempt to steal?"
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
	end
	
	if (SystemData.TextID == 1005584) then -- "Both hands must be free to steal."
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
	end	
	
	if (SystemData.TextID == 1049532) then -- "You play hypnotic music, calming your target."
		HotbarSystem.SkillDelayTimeMax = 8
		HotbarSystem.SkillDelayTime = 8
		
		if (Interface.BardMastery) then
			HotbarSystem.SkillDelayTimeMax = HotbarSystem.SkillDelayTimeMax -1
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end

	end
	
	if (SystemData.TextID == 500615) then -- "You play your hypnotic music, stopping the battle."
		HotbarSystem.SkillDelayTimeMax = 8
		HotbarSystem.SkillDelayTime = 8
		if (Interface.BardMastery) then
			HotbarSystem.SkillDelayTimeMax = HotbarSystem.SkillDelayTimeMax -1
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end
	end
	
	if (SystemData.TextID == 1049648) then -- "You play hypnotic music, but there is nothing in range for you to calm."
		HotbarSystem.SkillDelayTimeMax = 8
		HotbarSystem.SkillDelayTime = 8
		if (Interface.BardMastery) then
			HotbarSystem.SkillDelayTimeMax = HotbarSystem.SkillDelayTimeMax -1
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end
	end
	
	if (SystemData.TextID == 1049531) then -- "You attempt to calm your target, but fail."
		HotbarSystem.SkillDelayTimeMax = 6
		HotbarSystem.SkillDelayTime = 6
	end
	
	if (SystemData.TextID == 501602) then -- "Your music succeeds, as you start a fight."
		HotbarSystem.SkillDelayTimeMax = 6
		HotbarSystem.SkillDelayTime = 8
		if (Interface.BardMastery) then
			HotbarSystem.SkillDelayTimeMax = HotbarSystem.SkillDelayTimeMax -1
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end
	end
	
	if (SystemData.TextID == 501599) then -- "Your music fails to incite enough anger."
		HotbarSystem.SkillDelayTimeMax = 6
		HotbarSystem.SkillDelayTime = 6
	end
	
	if (SystemData.TextID == 1049539) then -- "You play jarring music, suppressing your target's strength."
		HotbarSystem.SkillDelayTimeMax = 8
		HotbarSystem.SkillDelayTime = 8
		if (Interface.BardMastery) then
			HotbarSystem.SkillDelayTimeMax = HotbarSystem.SkillDelayTimeMax -1
			HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime -1
		end
	end
	
	-- "You are at peace." "You cannot focus your concentration." "You are busy doing something else and cannot focus." "You enter a meditative trance."
	if (SystemData.TextID == 501846 or SystemData.TextID == 501850 or SystemData.TextID == 501845 or SystemData.TextID == 501851) then
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
	end
	
	if (SystemData.TextID == 502137) then -- "Select the poison you wish to use."
		HotbarSystem.SkillDelayTimeMax = 10
		HotbarSystem.SkillDelayTime = 10
	end
	
	if (SystemData.TextID == 1049540) then -- "You attempt to disrupt your target, but fail."
		HotbarSystem.SkillDelayTimeMax = 6
		HotbarSystem.SkillDelayTime = 6
	end
	
	-- Mana taint
	if (SystemData.TextID == 1151482) then -- "Your mana has been tainted!"
		CustomBuffs.ManaTaintTime = 4
	end
	
	if (SystemData.TextID == 1151483) then -- "Your mana is no longer corrupted."
		CustomBuffs.ManaTaintTime = 0
	end
	
	-- Mana divert
	if (SystemData.TextID == 1151485) then -- "Your mana is being diverted."
		CustomBuffs.ManaDivertTime = 4
	end
	
	if (SystemData.TextID == 1151486) then -- "Your mana is no longer being diverted."
		CustomBuffs.ManaDivertTime = 0
	end

	-- Mudded
	if (SystemData.TextID == 1150886) then -- "Splashes from the creature encrust your weapon and equipment, slowing your movement."
		CustomBuffs.MudTime = 7
	end
	
	if (SystemData.TextID == 1150887) then -- "You are no longer slowed and encrusted."
		CustomBuffs.MudTime = 0
	end
	
	-- Berserk Rage
	if (SystemData.TextID == 1151532) then -- "You enter a berserk rage!"
		CustomBuffs.BerserkRage = true
	end
	
	if (SystemData.TextID == 1151535) then -- "Your berserk rage has subsided."
		CustomBuffs.BerserkRage = false
	end
	
	-- Entangle
	if (SystemData.TextID == 1111641) then -- You become entangled in the acid drenched roots."
		CustomBuffs.Entangle = true
	end
	
	if (SystemData.TextID == 1111642) then -- "You manage to untangle yourself."
		CustomBuffs.Entangle = false
	end

	-- falling walls
	if (SystemData.TextID == 1114817) then -- "The Slasher emits a powerful howl, shaking the very walls around you and suppressing your ability to move."
		CustomBuffs.FallingWallsTime = 10
	end

	-- Stun
	if (SystemData.TextID == 1070839) then -- "The creature attacks with stunning force!"
		CustomBuffs.StunTime = 4
	end
	
	-- Honor
	if (SystemData.TextID == 1063235) then -- "You embrace your honor"
		CustomBuffs.HonorActive = true
	end
	
	if (SystemData.TextID == 1063236) then -- "You no longer embrace your honor"
		CustomBuffs.HonorActive = false
		CenterScreenText.SendCenterScreenTexture("honorwearoff")
	end

	if	SystemData.TextID == 1155789 or -- You feel completely rejuvenated!
		SystemData.TextID == 1155791 or -- You feel rejuvenated!
		SystemData.TextID == 1155790 -- Your target has been rejuvenated!
	then 
		-- ethereal burst
		if Interface.LastSpell == 708 then
			HotbarSystem.EtherealBurstCooldown = SpellsInfo.GetMasterySpellCooldown(708)

		-- rejuvenate
		elseif Interface.LastSpell == 719 then
			HotbarSystem.RejuvenateCooldown = SpellsInfo.GetMasterySpellCooldown(719)
		end
	end
	
	-- SPECIAL ATTACKS
	-- DEAL

	if  SystemData.SourceName == L"" and (
		SystemData.TextID == 1060076  or -- Your attack penetrates their armor!  
		SystemData.TextID == 1060078  or -- You strike and hide in the shadows!
		SystemData.TextID == 1060080  or -- Your precise strike has increased the level of the poison by 1
		SystemData.TextID == 1060082  or -- The force of your attack has dislodged them from their mount!
		SystemData.TextID == 1060086  or -- You deliver a mortal wound!
		SystemData.TextID == 1060090  or -- You have delivered a crushing blow!
		SystemData.TextID == 1060092  or -- You disarm their weapon!
		SystemData.TextID == 1060159  or -- Your target is bleeding!
		SystemData.TextID == 1060161  or -- The whirling attack strikes a target!
		SystemData.TextID == 1060163  or -- You deliver a paralyzing blow!
		SystemData.TextID == 1060165  or -- You have delivered a concussion!
		SystemData.TextID == 1060216  or -- Your shot was successful
		SystemData.TextID == 1063345  or -- You block an attack!
		SystemData.TextID == 1063356  or -- You cripple your target with a nerve strike!
		SystemData.TextID == 1063353  or -- You perform a masterful defense!
		SystemData.TextID == 1063360  or -- You baffle your target with a feint!
		SystemData.TextID == 1063362  or -- You dually wield for increased speed!
		SystemData.TextID == 1063358  or -- You deliver a talon strike!
		SystemData.TextID == 1063348  or -- You launch two shots at once!
		SystemData.TextID == 1063350  or -- You pierce your opponent's armor!
		SystemData.TextID == 1074381  or -- You fire an arrow of pure force.
		SystemData.TextID == 1074374  or -- You attack your enemy with the force of nature!
		SystemData.TextID == 1074383  or -- Your shot sends forth a wave of psychic energy.
		SystemData.TextID == 1149563  or -- The infused projectile strikes a target!
		SystemData.TextID == 1149565  or -- The mystic arc strikes the target!
	    SystemData.TextID == 1060084  -- You attack with lightning speed!
		
		) then 
	
		local icon, serverId, tid, desctid = GetAbilityData(Interface.LastSpecialMove + CharacterAbilities.WEAPONABILITY_OFFSET)
		if tid and tid ~= 0 then
			DamageWindow.waitSpecialDamage = GetStringFromTid(tid) .. L"!"
			DamageWindow.lastSpecialWaiting = Interface.LastSpecialMove
			Interface.LastSpecialMoveTime = 3
		end
	end
	
	-- updating the character sheet by opening the loyalty rating
	if TextParsing.Fame[SystemData.TextID] or TextParsing.Karma[SystemData.TextID] or TextParsing.DungeonPoints[SystemData.TextID] then
		-- we set a cooldown of 5 seconds between the updates.
		if (Interface.TimeSinceLogin - CharacterSheet.LastLoyaltyUpdate) >= CharacterSheet.minLoyaltyUpdate then
			ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.LoyaltyRating)
		else
			CharacterSheet.NextLoyaltyUpdate = Interface.TimeSinceLogin + CharacterSheet.minLoyaltyUpdate
		end
	end
	
	-- RECEIVED
	if  (SystemData.SourceName == L"" and AbilitiesInfo.MessageToID[SystemData.TextID]) then 
		
		local icon, serverId, tid, desctid = GetAbilityData(AbilitiesInfo.MessageToID[SystemData.TextID] + CharacterAbilities.WEAPONABILITY_OFFSET)
		if tid then
			DamageWindow.waitDamage = GetStringFromTid(tid) .. L"!"
		end
		Interface.OnSpecialMoveDamageReceived(Interface.LastSpecialMove)
	end
	
	-- MASTERY
	if SystemData.TextID == 1151949 then -- "You have changed to ~1_val~"
		
		-- getting the mastery TID from the token
		Spellbook.ActiveMastery = SystemData.TextIDToks[1]

		-- double check the mastery change (we might not have the TID for some reason...)
		Interface.AddTodoList({name = "mastery double check", func = function() ContainerWindow.MasteryChanged = true end, time = Interface.TimeSinceLogin + 1})

		-- flag the mastery as changed
		Spellbook.MasteryChanged = true

		-- update the mastery book
		Spellbook.InitMasteryIndexTab(true)

		-- update the timer for the last mastery change
		Spellbook.MasteryChangeCooldown = 600		
	end

	-- STABLECOUNT
	if SystemData.TextID == 1071250 then -- ~1_USED~/~2_MAX~ stable stalls used.

		-- is the stable gump open?
		if DoesWindowExist("PetsList") and WindowGetShowing("PetsList") then

			-- get the pet count
			local tokens = GetTokensFromString(SystemData.Text, 1071250)

			-- get the min and max values
			tokens = wstring.split(tokens[1], L"/")

			-- update the pets amount
			PetsList.PetsAmount = tonumber(tokens[1])

			-- update the pets cap
			PetsList.PetsCap = tonumber(tokens[2])

			-- update the pets count
			PetsList.UpdateCount()
		end
	end

	-- Shop unavailabe
	if SystemData.TextID == 1062904 then -- The promo code redemption system is currently unavailable. Please try again later.
		GenericGump.NextisShop = nil
	end

	-- new vendor search map
	if SystemData.TextID == 1154690 then  -- The vendor map has been placed in your backpack.
	
		-- update the backpack contents
		Interface.AddTodoList({func = function() Interface.BackPackItems = ContainerWindow.ScanQuantities(ContainerWindow.PlayerBackpack, true) ContainerWindow.UpdateVendorSearchMap() end, time = Interface.TimeSinceLogin + 1})
	end
end

function TextParsing.SpellCasting()
	if (SystemData.TextID == 1063218) then -- "You cannot use that ability in this form."
		Interface.CurrentSpell.CheckFizzle = true
	end
	
	if (SystemData.TextID == 501078) then -- "You must be holding a weapon."
		Interface.CurrentSpell.CheckFizzle = true
	end

	if (SystemData.TextID ==  1150066) then -- "Your magic reflection pool has been depleted."
		HotbarSystem.ReflectionCooldown = 30
	end

	if (SystemData.TextID == 501853 or SystemData.TextID == 501852) and Interface.LastSpell == 723 then  -- Target cannot be seen. // Target is too far away.
		HotbarSystem.FlamingShotCooldownStop = true
	end
	
	-- flaming shot failed
	if SystemData.TextID == 500946 and Interface.LastSpell == 723 then  -- You cannot cast this in town!
		HotbarSystem.FlamingShotCooldownStop = true
	end
end

function TextParsing.SpecialTexts()
	local senderText = SystemData.Text
	local find = wstring.find
	
	if (SystemData.TextID == 1151281) then -- "Your Clean Up Britannia point total is now ~1_VALUE~!"
		local num = tostring(wstring.match(senderText, L"%d+"))
		local num = StringUtils.AddCommasToNumber(num)
		SystemData.Text = wstring.gsub(GetStringFromTid(1151281),L"~1_VALUE~", num)
	end
	
	-- CHARYBDIS
	if (SystemData.TextID ==  1150191) then -- "The location you seek is:"
		clean =  wstring.gsub(GetStringFromTid(1150191),L" ~1_val~", L"")  -- The location you seek is: ~1_val~
		local coord = wstring.gsub(senderText, clean, "")
		coord = towstring(coord)
		local text2 = wstring.find(coord, L",", 1, true)
		local first = wstring.sub(coord, 1, text2 - 1)
		first = wstring.gsub(first, L"o ", L".")
		first = wstring.gsub(first, L"'", L"")
						

		local latDir = wstring.sub(first, -1)
		local latVal = wstring.sub(first,1, -2)
			
		local second = wstring.sub(coord, text2 + 3)
		second = wstring.gsub(second, L"o ", L".")
		second = wstring.gsub(second, L"'", L"")
		local longDir = wstring.sub(second, -1)
		local longVal = wstring.sub(second,1, -2)
		local x,y = MapCommon.ConvertToXYMinutes(tonumber(latVal), tonumber(longVal), latDir, longDir, 1, 1)
		--UOCreateUserWaypoint( MapCommon.WaypointCustomType, x, y, WindowData.PlayerLocation.facet, L"Charybdis" .. L"_ICON_100010_SCALE_" .. 0.69 )
		local wp = {facet=WindowData.PlayerLocation.facet, x=x, y=y, z=0, type=MapCommon.WaypointCustomType, name=L"Charybdis", Icon=100010, Scale=0.69}
		Interface.CharybdisLocation = wp
	end
	
	if (SystemData.TextID == 1077957) then -- "The intense energy dissipates. You are no longer under the effects of an accelerated skillgain scroll."
		Interface.AlacrityStart = 0
		Interface.SaveSetting( "AlacrityStart", Interface.AlacrityStart )
	end
	if (SystemData.TextID == 1077956) then -- "You are infused with intense energy. You are under the effects of an accelerated skillgain scroll."
		if (Interface.AlacrityStart <= 0) then
			Interface.AlacrityStart = 900
			Interface.SaveSetting( "AlacrityStart", Interface.AlacrityStart )
		end
	end
	
	if (SystemData.TextID == 1079730) then -- "The item has been placed into your bank box."
		CharacterSheet.NextBankGoldUpdate = Interface.TimeSinceLogin -- force bank gold update
	end
	
	if (SystemData.TextID == 1151638) then -- The total of your purchase is ~1_val~ gold, which has been drawn from your bank account.  My thanks for the patronage.
		CharacterSheet.NextBankGoldUpdate = Interface.TimeSinceLogin -- force bank gold update
	end
	
	if (SystemData.TextID == 1073480) then -- "Your arcane focus disappears."
		Interface.ArcaneFocusLevel = 0
	end
		
	if (SystemData.TextID == 501864) then -- "You can't dig while riding or flying."
		UserActionUseItem(GetPlayerID() ,false)
	end
	
	if (SystemData.TextID ==  500971) then -- "You can't fish while riding or flying!"
		Interface.Dismount = true
	end

	if (find(senderText, L"I was killed by", 1, true) and SystemData.TextChannelID == 9) then
		if (wstring.gsub(senderText, L"I was killed by  ", L"") == L"!!") then
			SystemData.Text = L"I killed myself !!"
		end
	end
	
	if (SystemData.TextID == 1043255) then -- "is better off without a master"
		MountsList.RemoveMount(SystemData.TextSourceID)
		
		if SystemData.TextSourceID == TargetWindow.TargetId then
			TargetWindow.DestroyButtons()
			TargetWindow.UpdateTarget()
		end
	end
	
	if (find(senderText , L"Thy current bank balance is:", 1, true)) then
		local cut = StringUtils.AddCommasToNumber(wstring.sub(SystemData.Text, 29))
		SystemData.Text = wstring.sub(SystemData.Text, 0,29) .. cut
	end
	

	if (find(senderText , L"Into your bank box I have placed a check in the amount of:", 1, true)) then
		local cut = StringUtils.AddCommasToNumber(wstring.sub(SystemData.Text,59))
		SystemData.Text = wstring.sub(SystemData.Text, 0,59) .. cut
	end
	
	if (wstring.lower(senderText) == L"give arties" and SystemData.TextSourceID == GetPlayerID()) then
		Interface.ArteReceived = 1
		Interface.SaveSetting( "ArteReceived" , Interface.ArteReceived )
	end
	
	if (wstring.lower(senderText) == L"give resources" and SystemData.TextSourceID == GetPlayerID()) then
		Interface.ResReceived = 1
		Interface.SaveSetting( "ResReceived" , Interface.ResReceived )
	end
	
	if (wstring.lower(senderText) == L"give air" and SystemData.TextSourceID == GetPlayerID()) then
		Interface.AirReceived = 1
		Interface.SaveSetting( "AirReceived" , Interface.AirReceived )
	end
	
	if (wstring.lower(senderText) == L"give seeds" and SystemData.TextSourceID == GetPlayerID()) then
		Interface.SeedsReceived = 1
		Interface.SaveSetting( "SeedsReceived" , Interface.SeedsReceived )
	end
	
	if (wstring.lower(senderText) == L"give tokens" and SystemData.TextSourceID == GetPlayerID()) then
		Interface.TokensReceived = 1
		Interface.SaveSetting( "TokensReceived" , Interface.TokensReceived )
	end
	
	if (SystemData.TextID == 1053079) then -- You need to plant a seed in the bowl first.
		Actions.GetSeeds = false
		Actions.GetResources = true
	end
	
	-- BOAT SMART COMMANDS
	if Interface.LastBoatDirection and PlayerIsOnBoat() then
		if wstring.lower(senderText) == L"turn left" or wstring.lower(senderText) == L"port" then
			Interface.LastBoatDirectionBackup = Interface.LastBoatDirection
			Interface.LastBoatDirection = (Interface.LastBoatDirection - 2) % 8
			Interface.SaveSetting("LastBoatDirection", Interface.LastBoatDirection)
		end
		
		if wstring.lower(senderText) == L"turn right" or wstring.lower(senderText) == L"starboard" then
			Interface.LastBoatDirectionBackup = Interface.LastBoatDirection
			Interface.LastBoatDirection = (Interface.LastBoatDirection + 2) % 8
			Interface.SaveSetting("LastBoatDirection", Interface.LastBoatDirection)
		end
		
		if wstring.lower(senderText) == L"come about" or wstring.lower(senderText) == L"turn around" then
			Interface.LastBoatDirectionBackup = Interface.LastBoatDirection
			Interface.LastBoatDirection = (Interface.LastBoatDirection + 4) % 8
			Interface.SaveSetting("LastBoatDirection", Interface.LastBoatDirection)
		end
		
		if (SystemData.TextID == 502521) then -- Ar, can't turn sir.
			Interface.LastBoatDirection = Interface.LastBoatDirectionBackup
			Interface.SaveSetting("LastBoatDirection", Interface.LastBoatDirection)
		end
		
		ActionsWindow.InitActionData()
	end
	
	-- PET POWER HOUR
	
	if (SystemData.TextID == 1157565 and IsObjectIdPet(SystemData.TextSourceID)) then -- *The pet's battle experience has slightly increased!*
		TextParsing.LastPetProgressID = SystemData.TextSourceID
		MobileHealthBar.ForceUpdatePetProgress()
	end
	
	if (SystemData.TextID == 1157569) then -- [Pet Training Power Hour]:  Your pet is under the effects of enhanced training progress for the next hour!
		if not MobileHealthBar.PetPowerHour then
			MobileHealthBar.PetPowerHours = CreateSaveStructureWithPlayerID(MobileHealthBar.PetPowerHours)
			MobileHealthBar.InitializePetPowerHour()
		end
		MobileHealthBar.PetPowerHour[TextParsing.LastPetProgressID] = 3600

		-- update the star on the healthbar
		MobileHealthBar.ManagePetPowerHour(mobileId)
	end

	if	 SystemData.TextID == 1075050 or -- You have killed all the required quest creatures of this type.
		 SystemData.TextID == 1075051 or -- You have killed a quest creature. ~1_val~ more left.
		 SystemData.TextID == 1073967 or -- You obtained what you seek, now receive your reward.
		 SystemData.TextID == 1049019 or -- You have accepted the Quest.
		 SystemData.TextID == 1074360 or -- You receive a reward: ~1_REWARD~
		 SystemData.TextID == 1115917 -- You receive a reward: ~1_QUANTITY~ ~2_ITEM~
	then
		
		-- rework all the markers when a quest is completed
		if	SystemData.TextID == 1074360 or -- You receive a reward: ~1_REWARD~
			SystemData.TextID == 1115917 -- You receive a reward: ~1_QUANTITY~ ~2_ITEM~
		then

			QuestLog.ClearAllMarkers()
		end

		-- rework all kill markers when a creature is killed
		if	SystemData.TextID == 1075050 or -- You have killed all the required quest creatures of this type.
			SystemData.TextID == 1075051 -- You have killed a quest creature. ~1_val~ more left.
		then

			QuestLog.ClearAllKillMarkers()
		end

		QuestLog.AutoScanLog()
	end

	-- join channel fix
	if wstring.find(wstring.lower(SystemData.Text) , L"you have joined the '", 1, true) then
		local txt = wstring.find(wstring.lower(SystemData.Text), L"you have joined the '", 1, true)
		local final = wstring.find(wstring.lower(SystemData.Text), L"' channel", 1, true)

		local channelName = wstring.sub(SystemData.Text, txt + 21, final - 1)

		WindowData.CurrentChannel = channelName
		NewChatWindow.currentChannel = channelName
	end

	-- already in the channel fix
	if wstring.find(wstring.lower(SystemData.Text) , L"you are already in channel '", 1, true) then
		local txt = wstring.find(wstring.lower(SystemData.Text), L"'", 1, true)
		local final = wstring.find(wstring.lower(SystemData.Text), L"'.", 2, true)

		local channelName = wstring.sub(SystemData.Text, txt + 1, final - 1)

		WindowData.CurrentChannel = channelName
		NewChatWindow.currentChannel = channelName
	end
end

function TextParsing.IgnoreTextManager()

	local ign = false
	if (NewChatWindow and not Interface.Settings.chat_showSpellsCasting) then
		if (SystemData.TextID == 502645) then -- You are already casting a spell.
			ign = true
		end 
		if (SystemData.TextID == 502642) then -- You are already casting a spell.
			ign = true
		end 
		if (SystemData.TextID == 502644) then -- You have not yet recovered from casting a spell.
			ign = true
		end
	end
	if (NewChatWindow and not Interface.Settings.chat_showPerfection) then
		if (SystemData.TextID == 1063255) then -- You gain in Perfection as you precisely strike your opponent.
			ign = true
		end 
		if (SystemData.TextID == 1063257) then -- You have lost some Perfection in fighting this opponent.
			ign = true
		end
	end
	if (NewChatWindow and not Interface.Settings.chat_showMultiple and Interface.LastJournalMSG == SystemData.Text) then
		ign = true
	else
		Interface.LastJournalMSG = SystemData.Text
	end
	if (not Interface.Settings.chat_showSpells and SpellsInfo.SpellsData[tostring(wstring.trim(SystemData.Text))]) then
		ign = true
	end
	return ign
end

function TextParsing.ForceOverhead()

	-- is this a pet training message?
	if TextParsing.PetProgress[SystemData.TextID] and IsObjectIdPet(SystemData.TextSourceID) then
		SendOverheadText(SystemData.Text, OverheadText.CustomMessageHues.RED, SystemData.TextSourceID)
	end

	if (SystemData.TextID == 1062001) then -- "You can no longer wield your ~1_WEAPON~"
		SendOverheadText(SystemData.Text, OverheadText.CustomMessageHues.RED)

		-- flag to force re-check durabilities
		Interface.AddTodoList({name = "paperdoll delayed durability check", func = function() PaperdollWindow.GotDamage = true end, time = Interface.TimeSinceLogin + 1})
	end

	if (SystemData.TextID == 1062002) then -- "You can no longer wear your ~1_ARMOR~"
		SendOverheadText(SystemData.Text, OverheadText.CustomMessageHues.RED)

		-- flag to force re-check durabilities
		Interface.AddTodoList({name = "paperdoll delayed durability check", func = function() PaperdollWindow.GotDamage = true end, time = Interface.TimeSinceLogin + 1})
	end

	if (SystemData.TextID == 1062003) then -- "You can no longer equip your ~1_SHIELD~"
		SendOverheadText(SystemData.Text, OverheadText.CustomMessageHues.RED)

		-- flag to force re-check durabilities
		Interface.AddTodoList({name = "paperdoll delayed durability check", func = function() PaperdollWindow.GotDamage = true end, time = Interface.TimeSinceLogin + 1})
	end
	
	if (SystemData.TextID == 1075051) then -- You have killed a quest creature. ~1_val~ more left.
		local num = tonumber(GetTokensFromString(SystemData.Text, 1075051)[1])
		SendOverheadText(ReplaceTokens(GetStringFromTid(1155217), { towstring(num) }), OverheadText.CustomMessageHues.GREEN)
	end
	
	if (SystemData.TextID ==  1151481) then -- "Channeling the corrupted mana has damaged you!"
		SendOverheadText(GetStringFromTid(1151481), OverheadText.CustomMessageHues.RED)
	end
	
	if (SystemData.TextID ==  1116778) then -- "The tainted life force energy damages you as your body tries to absorb it."
		SendOverheadText( GetStringFromTid(1116778), OverheadText.CustomMessageHues.RED)
	end
	
	if (SystemData.TextID ==  503170) then -- "Uh oh! That doesn't look like a fish!" 
		SendOverheadText( GetStringFromTid(503170), OverheadText.CustomMessageHues.RED)
		local sid = 1065
		if (GetMobileGender(GetPlayerID()) == 1) then
			sid = 793
		end
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
	end
	
	if (SystemData.TextID ==  1153493) then -- "Your keen senses detect something hidden in the area..."
		local sid = 1071
		if (GetMobileGender(GetPlayerID()) == 1) then
			sid = 799
		end
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
	end
	
	if (SystemData.TextID ==  1149918) then -- You have uncovered a ~1_SIZE~ deposit of niter! Mine it to obtain saltpeter.
		SendOverheadText(SystemData.Text, OverheadText.CustomMessageHues.RED)
	end
end

function TextParsing.Taunts()
	local senderText = SystemData.Text	
	if (SystemData.TextID == 1060093) then -- "Your weapon has been disarmed!"
		PlaySound(1, 323, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
	end
	
	if (SystemData.TextID == 1074776) then -- "You are no longer protected with Gift of Life."
		ECPlaySound(0, "gol_off.wav", 0)
	end
	
	if (SystemData.TextID == 1116364) then -- "**bob**"
		local objectId = SystemData.TextSourceID
		local itemData = Interface.GetObjectInfoData(objectId)
		if itemData then
			if not BuoyTool.Items then
				BuoyTool.Buoys = CreateSaveStructureWithPlayerID(BuoyTool.Buoys)
				BuoyTool.InitializeBuoys()
			end
			if not BuoyTool.Items[objectId]  then
				BuoyTool.Items[objectId] = {}
				BuoyTool.Items[objectId].bobs = 0
			end
		end
		local dt = Interface.GetItemPropertiesData( objectId, "Buoy props" )
		local props
		if dt then
			props = ItemProperties.BuildParamsArray( dt, true )
		end
		
		if props then
			if props[1116390] then -- ~1_NAME~'s lobster trap
				BuoyTool.Items[objectId].owner = props[1116390][1]
				BuoyTool.Items[objectId].bobs = BuoyTool.Items[objectId].bobs + 1
				BuoyTool.Items[objectId].lastbob = Interface.Clock.Timestamp
			end
		end
		ECPlaySound(0, "bob.wav", 0)
	end
	
	if (SystemData.TextID == 500969) then -- You finish applying the bandages.
		ECPlaySound(0, "medikit.wav", 0)
	end
	
	if (SystemData.TextID == 502543) then -- aye aye sir
		ECPlaySound(0, "aye aye sir.mp3", 0)
	end
	
	if (SystemData.TextID == 502519 or SystemData.TextID == 502537) then -- yes sir
		ECPlaySound(0, "yes sir.mp3", 0)
	end
	
	if (CustomSounds) then
        for text, sound in pairs(CustomSounds.Sounds) do
            local txt = wstring.find(wstring.lower(SystemData.Text) , wstring.lower(text), 1, true)
            if (txt) then
                ECPlaySound(0, sound, 0)
                break
            end
        end
    end
    
    -- EMOTES
	local wfind = wstring.find
	if (SystemData.SourceName ~= L"" and SystemData.TextSourceID ~= 0) then
		local mobileData = Interface.GetMobileData(SystemData.TextSourceID)
		if not mobileData then
			return
		end
		local sid

		for taunt, tbl in pairs(TextParsing.TauntsTable) do
			local text = wfind(wstring.lower(SystemData.Text), taunt, 1, true) 
			if (text ~= nil) then
				
				sid = tbl[mobileData.Gender] 
			end
		end
		if sid then
			PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		end
	end
end