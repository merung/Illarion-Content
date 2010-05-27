require("base.common")
--THE EDITABLE PART FOR NEW TOWNS OR GUILDS IS SOME LINES BELOW

module("base.factions", package.seeall())

function InitFactionLists()
   
	--Lists for Functions--
	NpcLocation = {};   --holds the location(townID) of the NPC
	TextRepeatCnt={}; --a value/counter to allow text repeation(e.g.for questions)
	
	--helps reading/writing faction values by index by using Factionvalues[DigitToIndex[digit]]
	DigitToIndex ={"towncnt","tid","rankC","rankR","rankG","rankTown", "rankGuild", "gid", "rankpointsC", "rankpointsR", "rankpointsG"}
	--Towns--
	TownIDList={};
    TownNameGList={};
    TownNameEList={};
    
	TownMainKey={};
	TownJailKey={};
    --Guilds
    GuildIDList={};
    GuildNameGList={};
    GuildNameEList={};
    GuildMainKey={};
	GuildJailKey={};
	
	--OtherLists

	          -- townchange   1 2 3 4 5  6  7..8.  9
    PriceListForTownChange = {1,2,4,6,8,16,32,64,128}; --includes the prices for a town change (in Silvercoins), every town change leads to a doubled price
					--aspirant guild, member guild, leader guild, main key guild, jail key guild
	PriceListForDecreeAndKey = {2, 10, 30, 2, 2}; --prices of the membership decrees for a guild and for the keys(in SILVERCOINS!)

    GuildRanklist = { {gusage = "(Anw�rter)", eusage = "(aspirant)"}, 
					  {gusage = "(vollst�ndiges Mitglied)", eusage = "(full member)"}, 
			 		  {gusage = "(Anf�hrer)", eusage = "(leader)"} };
	--A list with the Ranks, Rank 8 and Rank 9 can not be reached with faction points(e.g. npc quests), only with GM help, don't give any normal player rank 9!
	TownRankList = { {gRank = "Leibeigener", eRank = "serf"},                --rank 1
					 {gRank = "Bauer", eRank = "peasant"},           --rank 2
					 {gRank = "Arbeiter", eRank = "worker"},         --rank 3
					 {gRank = "Plebejer", eRank = "plebeian"},       --rank 4
					 {gRank = "B�rger", eRank = "citizen"},          --rank 5
					 {gRank = "Edelmann", eRank = "knight"},         --rank 6
					 {gRank = "Patrizier", eRank = "patrician"},     --rank 7
					 {gRank = "Adliger", eRank = "noble"},           --rank 8
					 {gRank = "Herrscher", eRank = "sovereign"}};    --rank 9
					 
	TownRankList[0] = {gRank="Ge�chteter", eRank="outcast"};         --rank 0
end


--[[
    AddTown
	Add a Town to the Faction System(be carefull, adding a new town needs further changes in the whole script!)
    @param TownID              - the ID of the town(1-9 allowed)
    @param TownNameG,TownNameE - the Townname in German and English
]]
function AddTown(TownID, TownNameG, TownNameE)
	table.insert(TownIDList,TownID);
    table.insert(TownNameGList,{TownNameG});
    table.insert(TownNameEList,{TownNameE});
end
--[[
    AddGuild
	Add a Guild to the Faction System
    @param GuildID              - the ID of the guild(11-99) allowed
    @param GuildNameG,GuildNameE - the Guildname in German and English
]]
function AddGuild(GuildID, GuildNameG, GuildNameE)
	table.insert(GuildIDList,GuildID);
	table.insert(GuildNameGList,GuildID,{ GuildNameG});
    table.insert(GuildNameEList,GuildID,{GuildNameE});
end

--Add another Name for the Town(e.g. Trollsbane, Trolls Bane, Troll's Bane)
function AddAdditionalTownName(TownNameG,TownNameE)
    table.insert(TownNameGList[table.getn(TownNameGList)],TownNameG)
    table.insert(TownNameEList[table.getn(TownNameEList)],TownNameE)
end
--Add an additional Name for the Guild(e.g. Trollsbane Guards, Trolls Bane Guards,..)
function AddAdditionalGuildName(GuildNameG,GuildNameE)
    table.insert(GuildNameGList[table.getn(GuildNameGList)],GuildNameG)
    table.insert(GuildNameEList[table.getn(GuildNameEList)],GuildNameE)
end

--[[
    AddTownMainKey/ AddTownJailKey / AddGuildMainKey / AddGuildJailKey
	Add the Main Key/Jail Key of the town of a faction with the Faction ID (TownMID)
    @param TownMID                  - the ID of the town the key shall be added
    @param KeyID,KeyQuality,KeyData - the ID,Quality and Data of the Key
]]
function AddTownMainKey(TownMID,KeyID, KeyQuality,KeyData)
	if KeyQuality==nil then KeyQuality=333; end
	table.insert(TownMainKey,TownMID, {KeyID,KeyQuality,KeyData});
end

function AddTownJailKey(TownJID,KeyID, KeyQuality,KeyData)
	if KeyQuality==nil then KeyQuality=333; end
	table.insert(TownJailKey,TownJID, {KeyID,KeyQuality,KeyData});
end

function AddGuildMainKey(GuildMID,KeyID, KeyQuality,KeyData)
	if KeyQuality==nil then KeyQuality=333; end
	table.insert(GuildMainKey,GuildMID,{KeyID,KeyQuality,KeyData});
end

function AddGuildJailKey(GuildJID,KeyID, KeyQuality,KeyData)
	if KeyQuality==nil then KeyQuality=333; end
	table.insert(GuildJailKey,GuildJID, {KeyID,KeyQuality,KeyData});
end

--[[
    CheckTheName
	Looks up whether the Guild the Player mentioned in "message" exists or not 
    @param message					- The Message the Player said
    @param originator				- The Player Struct
    
	@return bool					- true if GuildName found else false
]]
function CheckTheName(message,ListIndex,originator) --looks up for a trigger
    local TheList;

	--[[if originator:getPlayerLanguage()==0 then
		TheList=GuildNameGList;
	else
		TheList=GuildNameEList;
	end --]]
	TheList=GuildNameEList;
	
	if TheList[ListIndex]~=nil then
		for i,pattern in pairs(TheList[ListIndex]) do
	        if (string.find( message, string.lower(pattern) )~=nil) then
	            return true;
	        end
	    end
		
		TheList=GuildNameGList;
		                  
		for i,pattern in pairs(TheList[ListIndex]) do
	        if (string.find( message, string.lower(pattern) )~=nil) then
	            return true;
	        end
	    end
	    
	end
    return false;
end

--[[
    setLocation
	Looks in which town the npc is placed and sets and returns the townID of the town, needs to get executed in the initalizeNpc - Function
    @param thisNPC -- the NPCStruct

    @return digit - the townID of the town the npc is placed in
]]
function BF_setLocation(thisNPC)
	local townID = 0;
	if (border==nil) then
		border={}
	end
			--border-Xpos-left, border-Xpos-right, border-Ypos-top, border-Ypos-bottom
	border[1]={             0,                500,             415,                845};  --cadomyrs borders
			--border-Xpos-left, border-Xpos-right, border-Ypos-top, border-Ypos-bottom
	border[2]={           650,               1000,             380,                950}; --runewicks borders
			--border-Xpos-left, border-Xpos-right, border-Ypos-top, border-Ypos-bottom
	border[3]={           220,                650,             100,                415}; --galmairs borders

	if thisNPC.pos.x>border[1][1] and thisNPC.pos.x<border[1][2] then         --checks the x-Coordinates with the borders
	    if thisNPC.pos.y>border[1][3] and thisNPC.pos.y<border[1][4] then     --checks the y-Coordinates with the borders
			townID = 1;
		end
	end
	if thisNPC.pos.x>border[2][1] and thisNPC.pos.x<border[2][2] then         --checks the x-Coordinates with the borders
	    if thisNPC.pos.y>border[2][3] and thisNPC.pos.y<border[2][4] then     --checks the y-Coordinates with the borders
			townID = 2;
		end
	end
	if thisNPC.pos.x>border[3][1] and thisNPC.pos.x<border[3][2] then         --checks the x-Coordinates with the borders
	    if thisNPC.pos.y>border[3][3] and thisNPC.pos.y<border[3][4] then     --checks the y-Coordinates with the borders
			townID = 3;
		end
	end
	NpcLocation[thisNPC.id]=townID;
	return townID;
end

--[[
    BF_get_Faction
	Looks up to which Faction a Character belongs and checks also his rank
    @param originator -- the CharacterStruct

    @return Array - 1. a counter how often a Char changed the town, 2.the Town he belongs to ,
					3-5 the Ranks/Reputation in the Towns Cadomyr, Runewick and Galmair
]]
function BF_get_Faction(originator)

	local qpg = originator:getQuestProgress(200);
	if qpg==nil or qpg == 0 then
		originator:setQuestProgress(200,10111); --set the qpg to "zero"
	end

	local towncnt = math.floor(qpg/10^4); -- a counter which states how often a char switched the faction
	local 	  tid = math.floor ( (qpg-towncnt*10^4)/10^3 );   -- the id of the town the char belongs to
	local   rankC = math.floor ( (qpg - (towncnt*10^4 + tid*10^3))/10^2 ); --the reputation of the char in Cadomyr
	local   rankR = math.floor ( (qpg - (towncnt*10^4 + tid*10^3 + rankC*10^2))/10 ); --the reputation of the char in Runewick
	local   rankG = math.floor ( (qpg - (towncnt*10^4 + tid*10^3 + rankC*10^2 + rankR*10)) );

		if tid == 1 then rankTown = rankC;
	elseif tid == 2 then rankTown = rankR;
	elseif tid == 3 then rankTown = rankG; 
	else	rankTown = 0;			end

	return { towncnt = towncnt, tid = tid, rankC = rankC, rankR = rankR, rankG = rankG, rankTown = rankTown};
end

--[[
    BF_get_Guild
	Looks up to which Guild a Character belongs and his Rank in this guild
    @param originator -- the CharacterStruct

    @return Array - 1.the Guild the Char belongs to, 2. the Rank in the Guild
]]
function BF_get_Guild(originator)

	local qpg = originator:getQuestProgress(201);
	if qpg==nil or qpg == 0 then
		originator:setQuestProgress(201,110); --set the qpg to "zero" default: rank 1 and guild 10(== no guild)
	end

	local rankGuild = math.floor(qpg/100); -- the rank in the Guild(1 digit)
	local 		gid = (qpg - rankGuild*100);-- the Guild ID(2 digits(10-99))

	return {rankGuild = rankGuild, gid = gid};
end
--[[
    BF_get_Rankpoints
	Looks up how much Rankpoints a Character has
    @param originator -- the CharacterStruct

    @return Array - 1.the rankpoints in Cadomyr, 2.the Rankpoints for Runewick, 3.the Rankpoints for Galmair
]]
function BF_get_Rankpoints(originator)

	local qpg = originator:getQuestProgress(202); -- digit 1&2 = rankCadomyr, digit 3&4 = rankRunewick, digit 5&6 = rankGalmair
	if qpg==nil or qpg == 0 then
		originator:setQuestProgress(202,101010); --set the qpg to "zero"
	end

	local   rankpointsC = math.floor (qpg/10^4);
	local   rankpointsR = math.floor ( (qpg - rankpointsC*10^4)/10^2);
	local   rankpointsG = math.floor ( (qpg - (rankpointsC*10^4 + rankpointsR*10^2)) );

	return {rankpointsC = rankpointsC, rankpointsR = rankpointsR, rankpointsG = rankpointsG};
end

--[[
    BF_get
	Looks up to which Guild and Town a Character belongs to and his Rank
    @param originator -- the CharacterStruct

    @return Array - all values about Factionmembership, Guildmembership and Rankpoints
]]--
function BF_get(originator)

	local Faction = BF_get_Faction(originator);
	local Guild = BF_get_Guild(originator);
	local Rankpoints = BF_get_Rankpoints(originator);

	return {towncnt = Faction.towncnt, tid = Faction.tid, rankC = Faction.rankC, rankR = Faction.rankR, rankG = Faction.rankG, rankTown = Faction.rankTown,
			rankGuild = Guild.rankGuild, gid = Guild.gid,
			rankpointsC = Rankpoints.rankpointsC, rankpointsR = Rankpoints.rankpointsR, rankpointsG = Rankpoints.rankpointsG};
end

--[[
    BF_put_Faction//Guild
	Saves the Factionchanges of the Char//Guildchanges of the Char
    @param CharacterStruct - The character who gets the new Questprogress
    @param Faction//Guild - the Array which includes the values to be changed

]]
function BF_put_Faction(originator,Faction)

	oldFactionvalues=BF_get_Faction(originator);
	if oldFactionvalues.rankTown~=Faction.rankTown then
			if	Faction.tid == 1 then Faction.rankC = Faction.rankTown;
		elseif  Faction.tid == 2 then Faction.rankR = Faction.rankTown;
		elseif  Faction.tid == 3 then Faction.rankG = Faction.rankTown; end
	end
	--------don't allow unknown ranks-----
	if Faction.rankC>9 then Faction.rankC = 9 elseif Faction.rankC<0 then Faction.rankC = 0; end
	if Faction.rankR>9 then Faction.rankR = 9 elseif Faction.rankR<0 then Faction.rankR = 0; end
	if Faction.rankG>9 then Faction.rankG = 9 elseif Faction.rankG<0 then Faction.rankG = 0; end
	-------------write changes------------
	
	local qpg=(Faction.towncnt..Faction.tid..Faction.rankC..Faction.rankR..Faction.rankG)+1-1;
	originator:setQuestProgress(200,qpg);
end

function BF_put_Guild(originator,Guild)
	if Guild.gid ~= nil or Guild.rankGuild ~= nil then
		local qpg=(Guild.rankGuild..Guild.gid)+1-1;
		originator:setQuestProgress(201,qpg);
	else
		originator:inform("ERROR at BF_put_Guild, please inform a DEV");
	end
end



function IncreaseRank(rankpoints,rank)
	local overflow = 99;
	if (rankpoints-overflow) > 89 then rankpoints = overflow; else rankpoints = 10 + (rankpoints-99); end --max. number of rankpoints to add is 89!
	if rank<7 and rank>0 then
		rank = rank + 1;     --raise the Rank
	end
	return rankpoints,rank;
end

function DecreaseRank(rankpoints,rank)
	local underflow = 10;
	if (underflow - rankpoints>89) then rankpoints = underflow; else rankpoints = (99 + rankpoints) -10; end
	if rank<=8 and rank>0 then
		rank = rank - 1;     --sink the Rank
	end
	return rankpoints,rank;

end
--[[
    BF_put_Rankpoints
	Saves the Factionchanges of the Char//Guildchanges of the Char
    @param CharacterStruct - The character who gets the new Questprogress
    @param Rankpoints - the Array which includes the values Rankpoints

]]
function BF_put_Rankpoints(originator,Rankpoints)
	local Faction = BF_get_Faction(originator);
	 ---increase rank ----
	if (Rankpoints.rankpointsC >99) then
		local rank = Faction.rankC; Rankpoints.rankpointsC,Faction.rankC = IncreaseRank(Rankpoints.rankpointsC,Faction.rankC);
		if Faction.rankC>rank then  base.common.InformNLS( originator, "#w Du hast soeben einen neuen Rang in Cadomyr erreicht.", "#w You reached a new town rank in Cadomyr." ) end
	end

	if (Rankpoints.rankpointsR >99) then
		local rank = Faction.rankR; Rankpoints.rankpointsR,Faction.rankR = IncreaseRank(Rankpoints.rankpointsR,Faction.rankR);
		if Faction.rankR>rank then  base.common.InformNLS( originator, "#w Du hast soeben einen neuen Rang in Runewick erreicht.", "#w You reached a new town rank in Runewick." ) end
	end

	if (Rankpoints.rankpointsG >99) then
		local rank = Faction.rankG; Rankpoints.rankpointsG,Faction.rankG = IncreaseRank(Rankpoints.rankpointsG,Faction.rankG);
		if Faction.rankG>rank then  base.common.InformNLS( originator, "#w Du hast soeben einen neuen Rang in Galmair erreicht.", "#w You reached a new town rank in Galmair." ) end
	end
	------------------------
	----lower rank----------
	if (Rankpoints.rankpointsC <10) then
		local rank = Faction.rankC; Rankpoints.rankpointsC,Faction.rankC = DecreaseRank(Rankpoints.rankpointsC,Faction.rankC);
		if Faction.rankC<rank then  base.common.InformNLS( originator, "#w Durch deine st�ndigen Konflikte mit dem Gesetz ist dein Rang in Cadomyr um eine Stufe gesunken.", "#w Because of your permanent conflicts with the law your rank sinks for a degree in Cadomyr." ) end
	end

	if (Rankpoints.rankpointsR <10) then
		local rank = Faction.rankR; Rankpoints.rankpointsR,Faction.rankR = DecreaseRank(Rankpoints.rankpointsR,Faction.rankR);
		if Faction.rankR<rank then  base.common.InformNLS( originator, "#w Durch deine st�ndigen Konflikte mit dem Gesetz ist dein Rang in Runewick um eine Stufe gesunken.", "#w Because of your permanent conflicts with the law your rank sinks for a degree in Runewick." ) end
	end

	if (Rankpoints.rankpointsG <10) then
		local rank = Faction.rankG; Rankpoints.rankpointsG,Faction.rankG = DecreaseRank(Rankpoints.rankpointsG,Faction.rankG);
		if Faction.rankG<rank then  base.common.InformNLS( originator, "#w Durch deine st�ndigen Konflikte mit dem Gesetz ist dein Rang in Galmair um eine Stufe gesunken.", "#w Because of your permanent conflicts with the law your rank sinks for a degree in Galmair." ) end
	end
	------save changes----------------
	BF_put_Faction(originator,Faction);
	local qpg=(Rankpoints.rankpointsC..Rankpoints.rankpointsR..Rankpoints.rankpointsG)+1-1;
	originator:setQuestProgress(202,qpg);
end
--[[
    BF_put_
	Saves the Factionchanges of the Char//Guildchanges of the Char//Rankpoints
    @param CharacterStruct - The character who gets the new Questprogress
    @param Faction - the Array which includes the values Rankpoints//Guild Values//Town Values

]]
function BF_put(originator,Factionvalues)
	--town
    BF_put_Faction(originator,Factionvalues);
	-----------------------
	--guild
    BF_put_Guild(originator,Factionvalues);
	-----------------------
	--rankpoints town
	BF_put_Rankpoints(originator,Factionvalues);
end

if not InitFaction then
	InitFactionLists();
	InitFaction = true;
	RANK_OFFSET = 2;      --needed to know from where the ranks for each town begin (look return value of BF_get)
	RANKPOINTS_OFFSET = 8;--needed to know from where the rankpoints for each town begin (look return value of BF_get)
    citizenRank = 1;
    outcastRank = 0;
    leaderRank = 9;

--==================================ADD NEW TOWNS AND GUILDS HERE===============
--AddTown(TownID,TownName-German,TownName-English), IDs from 1-9
--AddAdditionalTownName(German Trigger, English Trigger)
--AddTownMainKey(TownID, KeyID, KeyQuality, KeyData)

AddTown(1, "Cadomyr", "Cadomyr");
AddTownMainKey(1,2121, 333, 5030);
AddTownJailKey(12,2121, 333, 5031);
AddTown(2, "Runewick", "Runewick");
AddTown(3, "Galmair", "Galmair");

--[[AddTown(12,"Silberbrand","Silverbrand", 1022, 102, 111);
AddTownMainKey(12,2121, 333, 5030);
AddTownJailKey(12,2121, 333, 5031);   ]]--




-------The Guilds        Same as above IDs from 11-99 only!
AddGuild(11,"Graue Rose","Grey Rose");
AddGuildMainKey(11,2121, 333,5014);
AddGuildJailKey(11,2121, 333,5015);
AddGuild(12,"Die Illarion Gruppe", "The Illarion Group");
AddGuild(13,"Stadtwache Cadomyr","Townguard Cadomyr");
AddGuildJailKey(13,2121, 333,5015);
AddGuild(14,"Stadtwache Runewick","Townguard Runewick");
AddGuild(15,"Stadtwache Galmair","Townguard Galmair");
end
--==================================END OF THE EDITABLE PART====================

--[[
    makeCharMemberOfTown
	makes the char citizen of the town//or leader if the char is a gm
    @param originator -- the PlayerStruct
    @param Factionvalues -- the List with the Factionvalues of the Char
    @param theRank(number) -- the rank the char shall get in the town
]]
function makeCharMemberOfTown(originator,Factionvalues,theRank)
	if theRank==leaderRank then --make char to leader of this town
		Factionvalues.tid = NpcLocation[thisNPC.id]; --make him member of this town
		Factionvalues.rankTown = leaderRank; --give him the leader rank
		Factionvalues = BF_put_Faction(originator,Factionvalues);
		return;

	elseif theRank==citizenRank then --make char to citizen
		if (Factionvalues.tid == NpcLocation[thisNPC.id]) then --already citizen
		 	gText="Ihr seid bereits B�rger dieser Stadt!";
			eText="You're already citizen of this town!";
			outText=base.common.GetNLS(originator,gText,eText);
			NPCTalking(thisNPC,outText);
			return;
		end

		local GAmount, SAmount,CAmount = CalcSilverCopper(100*PriceListForTownChange[Factionvalues.towncnt]);
		if not CheckMoney(originator,GAmount,SAmount,CAmount) then --not enough money!
		 	gText="Ihr habt nicht genug Geld dabei!";
			eText="You don't have enough money with you!";
			outText=base.common.GetNLS(originator,gText,eText);
			NPCTalking(thisNPC,outText);
			return;
		end
		
		Factionvalues[ DigitToIndex[Factionvalues.tid+RANKPOINTS_OFFSET] ]= --remove 80 rankpoints in old town
		     Factionvalues[ DigitToIndex[Factionvalues.tid+RANKPOINTS_OFFSET] ] -80;
		Factionvalues.tid = NpcLocation[thisNPC.id]; --set new Town ID
		
		Factionvalues[ DigitToIndex[Factionvalues.tid+RANKPOINTS_OFFSET] ]= 
		     Factionvalues[ DigitToIndex[Factionvalues.tid+RANKPOINTS_OFFSET] ] +20;--add 20 rankpoints for new town
				
		if Factionvalues.towncnt ~=9 then Factionvalues.towncnt = Factionvalues.towncnt+1; end -- raise the town counter
		Factionvalues = BF_put_Faction(originator,Factionvalues); --write Factionvalues in Questprogress
		Pay(originator,GAmount,SAmount,CAmount); --take money

		gText="Ihr seid nun als B�rger dieser Stadt eingetragen.";
		eText="You're now registered as citizen of this town.";
		outText=base.common.GetNLS(originator,gText,eText);
		NPCTalking(thisNPC,outText);
	end
	return;
end


--[[
    createChoice
	Creates the decree the char wanted//or creates the key for a guild
    @param originator -- the PlayerStruct
    @param Factionvalues -- the List with the Factionvalues of the Char
    @param message -- the text the player said(Guild name)
    @param choiceIndex(number) -- number which states what the char wants to buy, e.g. leader decree guild, jail key, main key,... 
]]
function createChoice(originator,message,choiceIndex,Factionvalues)
    message = string.lower(message);
    local theChoice = choiceIndex[originator.id];
	choiceIndex[originator.id] = nil;

--[[ f�r R�nge =2: Hauptschl�ssel, Kerkerschl�ssel   (full member)
	 f�r R�nge =3 UND Anf�hrer: Hauptschl�ssel, Kerkerschl�ssel, Anw�rterdekret, Mitglieddekret, Anf�hrerdekret (leader of guild)
	 f�r R�nge =1: Nix]]-- (aspirant of guild)
			     --aspirant Guild, full member, leader Guild
	choiceAuthorizationsGuild = { {nil}, {4,5}, {1,2,3,4,5}}; --includes the choices(key, member decree...) which are Allowed to get bought by the Guildrank

	if ((Factionvalues.rankTown == leaderRank) and (theChoice == 6)) then --if Character is leader in this town and wants a unban decree
		originator:createItem(3110,1,751,Factionvalues.tid);	--town id stored in the data
		gText="Hier euer Dekret.";
		eText="Here your decree.";
		outText=base.common.GetNLS(originator,gText,eText);
		NPCTalking(thisNPC,outText);
		return;
	end
    local guildID=11;  --the id from where the guild starts
	while not CheckTheName(message,guildID,originator) do
        guildID = guildID + 1;
        if ( guildID > (10+table.getn(GuildIDList)) ) then
			guildID=0;
			break;
        end
	end --guildID=0 if guild doesn't exist, otherwise it holds the ID of the guild

	if guildID==0 then  -- guild name wrong or guild does not exist
    	if (TextRepeatCnt[originator.id]==nil or TextRepeatCnt[originator.id] == 0) then TextRepeatCnt[originator.id]=1; end
		TextRepeatCnt[originator.id] = TextRepeatCnt[originator.id] +1;

		if TextRepeatCnt[originator.id]< 4 then
			gText="Tut mir leid, diese Gilde ist bei mir nicht verzeichnet, vielleicht habt ihr euch versprochen. Nennt mir bitte nochmal den Gildennamen.";
			eText="I'm sorry, these guild is not listed here, probably you slipped of the tongue. Please repeat the name of the guild again.";
			choiceIndex[originator.id] = theChoice;
		else
			gText="Leider finde ich die Gilde nicht auf der Liste. Informiert euch mal beim Baumeister dar�ber ob sie im Register verzeichnet ist.";
			eText="Unfortunately the guild seems not to be listed here. Ask the builder whether the guild is in the register.";
			TextRepeatCnt[originator.id]=nil; choiceIndex[originator.id] = nil;
		end
		outText=base.common.GetNLS(originator,gText,eText);
		NPCTalking(thisNPC,outText);
		return;
	end

	if (Factionvalues.gid ~= guildID) and (Factionvalues.rankTown ~= leaderRank) then -- he is not member of this guild
			gText="Ihr seid nicht als Mitglied dieser Gilde aufgelistet, ich kann euch nichts verkaufen.";
			eText="You're not listed as a member of this guild, i am not allowed to sell you anything.";
			outText=base.common.GetNLS(originator,gText,eText);
			NPCTalking(thisNPC,outText);
	        return;
	end

	length = table.getn(choiceAuthorizationsGuild[Factionvalues.rankGuild]);
	local wrongRank = true ;
	for i,length in pairs(choiceAuthorizationsGuild[Factionvalues.rankGuild]) do --checks if the Chars Rank allowes to buy this decree or key
        if (choiceAuthorizationsGuild[Factionvalues.rankGuild][i] == theChoice) then
            wrongRank = false;
        end
    end

    if (wrongRank and Factionvalues.rankTown ~= leaderRank) then --char has wrong rank and is no leader of this town
		gText="Ihr habt einen zu niedrigen Rang um diesen Gegenstand zu erwerben.";
		eText="You have a too low rank to buy this item.";
		outText=base.common.GetNLS(originator,gText,eText);
		NPCTalking(thisNPC,outText);
		return;
	end

	local GAmount, SAmount,CAmount = CalcSilverCopper(100*PriceListForDecreeAndKey[theChoice]);  --enough money?
	if not CheckMoney(originator,GAmount,SAmount,CAmount) then --not enough money!
	 	gText="Ihr habt nicht genug Geld dabei!";
		eText="You don't have enough money with you!";
		outText=base.common.GetNLS(originator,gText,eText);
		NPCTalking(thisNPC,outText);
		return;
	end

	if (theChoice==4) then  --check if Key exists, if yes create it
        if (GuildMainKey[guildID]==nil) then
			gText="F�r diese Gilde existiert kein Hauptschl�ssel!";
			eText="There does no main key exist for this guild!";
			outText=base.common.GetNLS(originator,gText,eText);
			NPCTalking(thisNPC,outText);
			return;
		else
			countUncreated = originator:createItem(GuildMainKey[guildID][1],1,GuildMainKey[guildID][2],GuildMainKey[guildID][3]); --creates Key
			gText="Hier ist euer Hauptschl�ssel.";
			eText="Here is your main key.";
		end
	elseif (theChoice==5) then --check if Key exists, if yes create it
        if (GuildJailKey[guildID]==nil) then
			gText="F�r diese Gilde existiert kein Kerkerschl�ssel!";
			eText="There does no jail key exist for this guild!";
			outText=base.common.GetNLS(originator,gText,eText);
			NPCTalking(thisNPC,outText);
			return;
		else
			countUncreated = originator:createItem(GuildJailKey[guildID][1],1,GuildJailKey[guildID][2],GuildJailKey[guildID][3]); --creates Key
			gText="Hier ist euer Kerkerschl�ssel.";
			eText="Here is your jail key.";
		end
	else    --create Decree

	--datavalue: digit 1: rank in the guild, digit 2&3: the guild id
		local data=(theChoice..guildID)+1-1;
		countUncreated = originator:createItem(3110,1,750,data); --the choice gets stored in the data value

		gText="Hier ist euer Dekret.";
		eText="Here is your decree.";
	end

	if (countUncreated>=1) then  ---3. Error Check
        gText="Tut mir leid, aber ihr habt nicht genug Platz in eurem Inventar.";
        eText="Sorry, you do not have enough spaces in your inventory.";
		outText=base.common.GetNLS(originator,gText,eText);
		NPCTalking(thisNPC,outText);
		return;
	end

	Pay(originator,GAmount,SAmount,CAmount); --take money

	outText=base.common.GetNLS(originator,gText,eText);
	NPCTalking(thisNPC,outText);
	return;
end


--[[
    deleteDecree
	Exchanges a decree against guild membership etc., 
    @param originator -- the PlayerStruct
]]
function deleteDecree(originator)
	if not ((originator:countItem(3110))==0) then --does he really have decrees
			Factionvalues = BF_get(originator); --read faction values
			  decree= originator:getItemList(3110); --get a list of decrees

			if decree[1].quality == 750 then --guild decree

				Factionvalues.rankGuild = math.floor(decree[1].data/100); -- the rank in the Guild(1 digit)
				Factionvalues.gid	    = (decree[1].data - Factionvalues.rankGuild*100);-- the Guild ID(2 digits(10-99))

				gText="Gut, ich werde euch als "..GuildRanklist[Factionvalues.rankGuild].gusage.." in der Gilde "..GuildNameGList[Factionvalues.gid][1].." eintragen.";
    			eText="Good, I will write your name down as "..GuildRanklist[Factionvalues.rankGuild].eusage.." in the guild "..GuildNameEList[Factionvalues.gid][1];
            	Factionvalues = BF_put(originator,Factionvalues); --write faction values
				world:erase(decree[1],1); --deletes 1 decree
			elseif decree[1].quality == 751 then -- unban decree
			
				if Factionvalues[DigitToIndex[decree[1].data+RANK_OFFSET]] == 0 then --really banned in the town?
					gText = "Ihr wurdet aus der Verbanntenliste gestrichen, nun k�nnt ihr B�rger dieser Stadt werden wenn Ihr es wollt.";
					eText = "You're now deleted from the banned register, now you can join this town as citizen, if you want.";
					Factionvalues[DigitToIndex[decree[1].data+RANK_OFFSET]] = 1; --set rank to 1
					Factionvalues = BF_put(originator,Factionvalues); --write faction values
					world:erase(decree[1],1);
				else
					gText = "Ihr seid in dieser Stadt nicht verbannt!";
					eText = "You're not banned in this town!";
				end
			else
				gText="Dieses Dekret ist nicht einl�sbar";
				eText="This decree is not exchangeable";
			end
			
			outText=base.common.GetNLS(originator,gText,eText);
			NPCTalking(thisNPC,outText);
			return;
	else
			gText="Es tut mir leid, aber ihr habt kein Dekret bei euch!";
			eText="I'm sorry but you have no decree with you!";
			outText=base.common.GetNLS(originator,gText,eText);
			NPCTalking(thisNPC,outText);
			return;
	end
end