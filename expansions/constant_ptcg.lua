--[[
	Pokémon Trading Card Game Constants
	
	Usage: Put this file in the expansions folder
	
	Include the following code in your script
	
	local PTCG=require "expansions.constant_ptcg"
]]

local PTCG={}

--Card ID
--↑Rules
CARD_PTCG_RULES						=26000000	--Unofficial card (Pokemon Rules)
CARD_GX_MARKER						=26000999	--Unofficial card (GX Marker)
--↑String
PM_STRING_WIN						=26000001	--Win
PM_STRING_GAME						=26000002	--Game Progress
PM_STRING_CONDITION					=26000003	--Special Condition
PM_STRING_DESC						=26000004	--Action
PM_STRING_HINTMSG					=26000005	--Hint Message (Pokémon)
PM_STRING_HINTMSG2					=26000006	--Hint Message (Pokémon)
PM_STRING_HINTMSG3					=26000007	--Hint Message (Trainer)
PM_STRING_HINTMSG4					=26000008	--RESERVED
PM_STRING_HINTMSG5					=26000009	--Hint Message (Energy)
PM_STRING_HINTMSG6					=26000010	--Hint Message (Energy)
PM_STRING_HINTMSG7					=26000011	--Hint Message
PM_STRING_HINTMSG8					=26000012	--RESERVED
PM_STRING_HINTMSG9					=26000013	--RESERVED
PM_STRING_QHINTMSG					=26000014	--Question Hint Message
PM_STRING_SELECTMSG					=26000015	--Select Message (Energy)
PM_STRING_ATTACK					=26000016	--RESERVED
PM_STRING_ATTACK2					=26000017	--RESERVED
--↑Basic Energy cards
CARD_GRASS_ENERGY					=26001099	--Base Set 99/102
CARD_FIRE_ENERGY					=26001098	--Base Set 98/102
CARD_WATER_ENERGY					=26001102	--Base Set 102/102
CARD_LIGHTNING_ENERGY				=26001100	--Base Set 100/102
CARD_PSYCHIC_ENERGY					=26001101	--Base Set 101/102
CARD_FIGHTING_ENERGY				=26001097	--Base Set 97/102
CARD_DARKNESS_ENERGY				=26032129	--Diamond & Pearl 29/130
CARD_METAL_ENERGY					=26032130	--Diamond & Pearl 30/130
CARD_COLORLESS_ENERGY				=nil		--energy=CARD_COLORLESS_ENERGY in Card.IsEnergy(c, energy)
CARD_FAIRY_ENERGY					=26059140	--XY 140/146
--↑Special Energy cards
CARD_MIRACLE_ENERGY					=26011016	--Neo Destiny 16/105
--↑Pokémon that are part of an evolutionary line
CARD_WEEDLE							=26001069	--Weedle → Kakuna → Beedril (Base Set 69/102)
CARD_KAKUNA							=26001033	--Weedle → Kakuna → Beedril (Base Set 33/102)
CARD_BEEDRILL						=26001017	--Weedle → Kakuna → Beedril (Base Set 17/102)
CARD_HORSEA							=26003049	--Horsea → Seadra → Kingdra (Fossil 49/62)
CARD_SEADRA							=26003042	--Horsea → Seadra → Kingdra (Fossil 42/62)
CARD_KINGDRA						=26008008	--Horsea → Seadra → Kingdra (Neo Genesis 8/111)
CARD_MYSTERIOUS_FOSSIL				=26003062	--Mysterious Fossil → Omanyte (Fossil 62/62)
CARD_OMANYTE						=26003052	--Mysterious Fossil → Omanyte (Fossil 52/62)
CARD_SNUBBULL						=26008074	--Snubbull → Granbull (Neo Genesis 74/111)
CARD_GRANBULL						=26008037	--Snubbull → Granbull (Neo Genesis 37/111)
CARD_POOCHYENA						=26016063	--Poochyena → Mightyena (EX Ruby & Sapphire 63/109)
CARD_MIGHTYENA						=26016010	--Poochyena → Mightyena (EX Ruby & Sapphire 10/109)
CARD_TEAM_AQUAS_CARVANHA			=26019025	--Team Aqua's Carvanha → Team Aqua's Sharpedo (EX Team Magma vs Team Aqua 25/95)
CARD_TEAM_AQUAS_SHARPEDO			=26019005	--Team Aqua's Carvanha → Team Aqua's Sharpedo (EX Team Magma vs Team Aqua 5/95)
CARD_TEAM_MAGMAS_BALTOY				=26019032	--Team Magma's Baltoy → Team Magma's Claydol (EX Team Magma vs Team Aqua 32/95)
CARD_TEAM_MAGMAS_CLAYDOL			=26019008	--Team Magma's Baltoy → Team Magma's Claydol (EX Team Magma vs Team Aqua 8/95)
CARD_TEAM_AQUAS_POOCHYENA			=26019054	--Team Aqua's Poochyena → Team Aqua's Mightyena (EX Team Magma vs Team Aqua 54/95)
CARD_TEAM_AQUAS_MIGHTYENA			=26019015	--Team Aqua's Poochyena → Team Aqua's Mightyena (EX Team Magma vs Team Aqua 15/95)
CARD_TEAM_AQUAS_SPHEAL				=26019056	--Teram Aqua's Spheal → Team Aqua's Sealeo → Team Aqua's Walrein (EX Team Magma vs Team Aqua 56/95)
CARD_TEAM_AQUAS_SEALEO				=26019016	--Teram Aqua's Spheal → Team Aqua's Sealeo → Team Aqua's Walrein (EX Team Magma vs Team Aqua 16/95)
CARD_TEAM_AQUAS_WALREIN				=26019006	--Teram Aqua's Spheal → Team Aqua's Sealeo → Team Aqua's Walrein (EX Team Magma vs Team Aqua 6/95)
CARD_TEAM_MAGMAS_ARON				=26019058	--Team Magma's Aron → Team Magma's Lairon → Team Magma's Aggron (EX Team Magma vs Team Aqua 58/95)
CARD_TEAM_MAGMAS_LAIRON				=26019020	--Team Magma's Aron → Team Magma's Lairon → Team Magma's Aggron (EX Team Magma vs Team Aqua 20/95)
CARD_TEAM_MAGMAS_AGGRON				=26019007	--Team Magma's Aron → Team Magma's Lairon → Team Magma's Aggron (EX Team Magma vs Team Aqua 7/95)
CARD_TEAM_MAGMAS_NUMEL				=26019064	--Team Magma's Numel → Team Magma's Camerupt (EX Team Magma vs Team Aqua 64/95)
CARD_TEAM_MAGMAS_CAMERUPT			=26019019	--Team Magma's Numel → Team Magma's Camerupt (EX Team Magma vs Team Aqua 19/95)
CARD_TEAM_MAGMAS_POOCHYENA			=26019065	--Team Magma's Poochyena → Team Magma's Mightyena (EX Team Magma vs Team Aqua 65/95)
CARD_TEAM_MAGMAS_MIGHTYENA			=26019021	--Team Magma's Poochyena → Team Magma's Mightyena (EX Team Magma vs Team Aqua 21/95)
CARD_AXEW							=2618010	--Axew → Fraxure → Haxorus (Black Star Promo BW10)
CARD_FRAXURE						=26050087	--Axew → Fraxure → Haxorus (Noble Victories 87/101)
CARD_HAXORUS						=26050088	--Axew → Fraxure → Haxorus (Noble Victories 88/101)
CARD_PAWNIARD						=26050075	--Pawniard → Bisharp (Noble Victories 75/101)
CARD_BISHARP						=2624020	--Pawniard → Bisharp (Kalos Starter Set 20/39)
CARD_CHESPIN						=2623001	--Chespin → Quilladin → Chesnaught → Chesnaught BREAK (Black Star Promo XY01)
CARD_QUILLADIN						=2624004	--Chespin → Quilladin → Chesnaught → Chesnaught BREAK (Kalos Starter Set 4/39)
CARD_CHESNAUGHT						=2624005	--Chespin → Quilladin → Chesnaught → Chesnaught BREAK (Kalos Starter Set 5/39)
CARD_CHESNAUGHT_BREAK				=26066012	--Chespin → Quilladin → Chesnaught → Chesnaught BREAK (BREAKthrough 12/162)
CARD_FENNEKIN						=2623002	--Fennekin → Braixen → Delphox → Delphox BREAK (Black Star Promo XY02)
CARD_BRAIXEN						=2624009	--Fennekin → Braixen → Delphox → Delphox BREAK (Kalos Starter Set 9/39)
CARD_DELPHOX						=2624010	--Fennekin → Braixen → Delphox → Delphox BREAK (Kalos Starter Set 10/39)
CARD_DELPHOX_BREAK					=26066014	--Fennekin → Braixen → Delphox → Delphox BREAK (BREAKthrough 14/162)
CARD_FROAKIE						=2623003	--Froakie → Frogadier → Greninja → Greninja BREAK (Black Star Promo XY03)
CARD_FROGADIER						=2624013	--Froakie → Frogadier → Greninja → Greninja BREAK (Kalos Starter Set 13/39)
CARD_GRENINJA						=2624014	--Froakie → Frogadier → Greninja → Greninja BREAK (Kalos Starter Set 14/39)
CARD_GRENINJA_BREAK					=26067041	--Froakie → Frogadier → Greninja → Greninja BREAK (BREAKpoint 41/122)
CARD_TEAM_AQUAS_GRIMER				=2626007	--Team Aqua's Grimer → Team Aqua's Muk (Double Crisis 7/34)
CARD_TEAM_AQUAS_MUK					=2626008	--Team Aqua's Grimer → Team Aqua's Muk (Double Crisis 8/34)
--↑Restored Pokémon
CARD_AMAURA							=26061025	--"Fossil Researcher" (Furious Fists 92/111)
CARD_TYRUNT							=26061061	--"Fossil Researcher" (Furious Fists 92/111)
--↑You may have as many of the following cards in your deck as you like
CARD_ARCEUS							=26042094	--"Arceus LV.X" (Arceus AR1)
--↑Pokémon LV.X
CARD_MEWTWO							=26001010	--"Mewtwo LV.X" (Legends Awakened 144/146)
--↑Pokémon GX
CARD_SNORLAX_GX						=2629005	--"You can't use more than 1 GX attack in a game." (Black Star Promo SM05)
CARD_SILVALLY_GX					=26076090	--"Psychic Memory" (Crimson Invasion 94/111)
--↑Trainer
CARD_SABRINAS_ESP					=26006117	--"Sabrina's ESP" (Gym Heroes 117/132)
CARD_PUZZLE_OF_TIME					=26067109	--"Puzzle of Time" (BREAKpoint 109/122)
--Counters/Markers
PM_DAMAGE_COUNTER					=0x1600		--A Pokémon loses 10 HP for each Damage Counter on it
PM_BURN_MARKER						=0x1601		--When a Pokémon is Burned, put a Burn marker on it
PM_POISON_MARKER					=0x1602		--When a Pokémon is Poisoned, put a Poison marker on it
PM_COLORING_COUNTER					=0x1603		--"Smeargle" (Black Star Promo Wizards of the Coast 32/53)
PM_LIGHTNING_ROD_MARKER				=0x1604		--"Electabuzz" (Black Star Promo Wizards of the Coast 46/53)
PM_CHAR_COUNTER						=0x1605		--"Quilava" (Neo Genesis 47/111)
PM_DARK_IVYSAUR_MARKER				=0x1606		--"Dark Ivysaur" (Best of Game 6/9)
PM_IMPRISON_MARKER					=0x1607		--"Tropius δ" (Dragon Frontiers 23/101)
PM_SHOCKWAVE_MARKER					=0x1608		--"Tropius δ" (Dragon Frontiers 23/101)
--Win Reason
PM_WIN_REASON_INVALID				=0x4d		--"Your opponent had an invalid deck!"
PM_WIN_REASON_KNOCKOUT				=0x6a		--"Your opponent had no more Pokémon left in play!"
PM_WIN_REASON_PRIZE					=0x6b		--"Your opponent collected all the Prize cards to win the game!"
PM_WIN_REASON_LOST_WORLD			=0x6c		--"Once during each player's turn, if that player's opponent has 6 or more Pokémon in the Lost Zone, the player may choose to win the game."
PM_WIN_REASON_SLOWBRO				=0x6d		--"If you use this attack when you have only 1 Prize card left, you win this game."
--Min/Max Values
MAX_NUMBER							=999999999	--Max number allowed in YGOPro
--Locations (for SetRange)
PM_LOCATION_STADIUM					=LOCATION_FZONE		--Location for Stadium cards
--Locations
PM_LOCATION_RULES					=LOCATION_EXTRA		--Location for Pokemon Rules
PM_LOCATION_ACTIVE_POKEMON			=LOCATION_MZONE		--Location for Active Pokémon
PM_LOCATION_BENCH					=LOCATION_MZONE		--Location for Benched Pokémon
PM_LOCATION_BENCH_EXTENDED			=LOCATION_SZONE		--Location for Pokémon on an extended Bench
PM_LOCATION_IN_PLAY					=LOCATION_MZONE+LOCATION_SZONE	--Location for Active and Benched Pokémon
PM_LOCATION_ADJACENT_ACTIVE_POKEMON	=LOCATION_SZONE		--Location for Trainer cards that temporarily stay in play
PM_LOCATION_DISCARD_PILE			=LOCATION_GRAVE		--Location for cards taken out of play
PM_LOCATION_PRIZE_CARDS				=LOCATION_REMOVED	--Location for Prize cards
PM_LOCATION_LOST_ZONE				=LOCATION_REMOVED	--Location for cards no longer playable
PM_LOCATION_ATTACHED				=LOCATION_OVERLAY	--Location for cards under other cards 
--↑Location combinations
LOCATIONS_ALL						=0xff		--All locations
PM_LOCATIONS_PHDP					=PM_LOCATION_IN_PLAY+LOCATION_HAND+PM_LOCATION_DISCARD_PILE	--"Silent Lab" (Primal Clash 140/160)
--Positions
PM_POS_FACEUP_UPSIDE				=POS_FACEUP_ATTACK		--The default position of an In Play Pokémon
PM_POS_FACEDOWN_UPSIDE				=POS_FACEDOWN_ATTACK	--The temporary position of the starting Active Pokémon
PM_POS_FACEUP_COUNTERCLOCKWISE		=POS_FACEUP_DEFENSE		--The default position of an Asleep Pokémon
PM_POS_FACEDOWN_COUNTERCLOCKWISE	=POS_FACEDOWN_DEFENSE	--N/A
PM_POS_FACEUP_CLOCKWISE				=POS_FACEUP_DEFENSE		--The default position of a Paralyzed Pokémon
PM_POS_FACEDOWN_CLOCKWISE			=POS_FACEDOWN_DEFENSE	--N/A
PM_POS_FACEUP_SIDEWAYS				=POS_FACEUP_DEFENSE		--The default position of a Pokémon BREAK
PM_POS_FACEDOWN_SIDEWAYS			=POS_FACEDOWN_DEFENSE	--N/A
--Types
PM_TYPE_RULE						=TYPE_FUSION+TYPE_PENDULUM	--The type of Pokemon Rules to exist face-up in the extra deck
PM_TYPE_ABILITY						=TYPE_EFFECT	--A special effect that is not an attack
PM_TYPE_ANCIENT_TRAIT				=TYPE_SPIRIT	--A special effect that is not an ability
PM_TYPE_POKE_BODY					=TYPE_CONTINUOUS--A Pokémon Power/Ability that is always active
PM_TYPE_POKE_POWER					=TYPE_UNION		--A Pokémon Power/Ability that a player must trigger or announce using
--↑Pokémon
PM_TYPE_POKEMON						=TYPE_MONSTER	--Pokémon=Monster
PM_TYPE_BASIC_POKEMON				=0x1			--"Clefairy Doll" (Base Set 70/102)
PM_TYPE_EVOLUTION					=0x2			--"Devolution Spray" (Base Set 72/102)
PM_TYPE_STAGE_1							=0x3		--"Devolution Spray" (Base Set 72/102) (+PM_TYPE_EVOLUTION)
PM_TYPE_STAGE_2							=0x4		--"Devolution Spray" (Base Set 72/102) (+PM_TYPE_EVOLUTION)
PM_TYPE_BABY_POKEMON				=0x11			--"Pokémon Breeder Fields" (Neo Revelation 62/64)
PM_TYPE_EX_OLD						=0x17			--"Hariyama" (EX Ruby & Sapphire 8/109)
PM_TYPE_POKEMON_STAR				=0x1e			--"Mudkip Star" (EX Team Rocket Returns 107/109)
PM_TYPE_LEVEL_UP					=0x21			--"Empoleon LV.X" (Diamond & Pearl 120/130)
PM_TYPE_SP							=0x24			--"Champion's Room" (Supreme Victors 135/147)
PM_TYPE_LEGEND						=0x25			--"Legend Box" (Undaunted 75/91)
PM_TYPE_EX							=0x27			--"Shaymin-EX" (Next Destinies 5/99)
PM_TYPE_RESTORED					=0x28			--"Twist Mountain" (Dark Explorers 101/108)
PM_TYPE_MEGA							=0x2b		--"M Venusaur-EX" (XY 2/146) (+PM_TYPE_EVOLUTION)
PM_TYPE_BREAK							=0x2c		--"Druddigon" (Steam Siege 83/114) (+PM_TYPE_EVOLUTION)
PM_TYPE_GX							=0x2d			--"Decidueye-GX" (Sun & Moon 12/149)
--↑Trainer
PM_TYPE_TRAINER						=TYPE_SPELL		--Trainer=Spell
PM_TYPE_STADIUM						=TYPE_FIELD		--Stadium=Field
PM_TYPE_POKEMON_TOOL					=0x10		--"Balloon Berry" (Neo Revelation 60/64) (+PM_TYPE_ITEM)
PM_TYPE_SUPPORTER					=0x14			--"Bill's Maintenance" (Expedition 137/165)
PM_TYPE_TECHNICAL_MACHINE			=0x15			--"Sneasel" (Aquapolis 110/147)
PM_TYPE_ROCKETS_SECRET_MACHINE		=0x1c			--"Dark Slowking" (EX Team Rocket Returns 9/109)
PM_TYPE_ITEM						=0x26			--"Lillipup" (Black & White 80/114)
PM_TYPE_ACE_SPEC						=0x29		--"Computer Search" (Boundaries Crossed 137/149) (+PM_TYPE_ITEM)
--↑Energy
PM_TYPE_ENERGY						=TYPE_TRAP		--Energy=Trap
PM_TYPE_BASIC_ENERGY				=0x5			--"Energy Retrieval" (Base Set 81/102)
PM_TYPE_SPECIAL_ENERGY				=0xf			--"Smoochum" (Neo Revelation 54/64)
PM_TYPE_HOLON_ENERGY					=0x1020		--"Flareon δ" (EX Delta Species 5/113) (+PM_TYPE_SPECIAL_ENERGY)
--↑Setname
PM_SETNAME_MISTY						=0x6		--"Misty" (Gym Heroes 18/132) (+PM_SETNAME_OWNER)
PM_SETNAME_BROCK						=0x7		--"Brock's Geodude" (Gym Heroes 66/132) (+PM_SETNAME_OWNER)
PM_SETNAME_ERIKA						=0x8		--"Celadon City Gym" (Gym Heroes 107/132) (+PM_SETNAME_OWNER)
PM_SETNAME_SABRINA						=0x9		--"Sabrina's ESP" (Gym Heroes 117/132) (+PM_SETNAME_OWNER)
PM_SETNAME_LT_SURGE						=0xa		--"Vermilion City Gym" (Gym Heroes 120/132) (+PM_SETNAME_OWNER)
PM_SETNAME_BLAINE						=0xb		--"Blaine" (Gym Challenge 17/132) (+PM_SETNAME_OWNER)
PM_SETNAME_GIOVANNI						=0xc		--"Giovanni" (Gym Challenge 18/132) (+PM_SETNAME_OWNER)
PM_SETNAME_KOGA							=0xd		--"Koga" (Gym Challenge 19/132) (+PM_SETNAME_OWNER)
PM_SETNAME_UNOWN					=0xe			--"Unown [A]" (Neo Discovery 14/75)
PM_SETNAME_SHINING					=0x12			--"Miracle Energy" (Neo Destiny 16/105)
PM_SETNAME_LIGHT					=0x13			--"Miracle Energy" (Neo Destiny 16/105)
PM_SETNAME_BALL						=0x16			--"Apricorn Maker" (Skyridge 121/144)
PM_SETNAME_TEAM_MAGMA					=0x18		--"Team Aqua's Crawdaunt" (EX Team Magma vs Team Aqua 2/95) (+PM_SETNAME_OWNER)
PM_SETNAME_TEAM_AQUA					=0x19		--"Team Aqua's Kyogre" (EX Team Magma vs Team Aqua 3/95) (+PM_SETNAME_OWNER)
PM_SETNAME_DARK						=0x1a			--"The Boss's Way" (Team Rocket 73/82)
PM_SETNAME_OWNER					=0x1b			--"Ancient Technical Machine [Ice]" (EX Hidden Legends 84/101)
PM_SETNAME_ROCKETS						=0x1d		--"Rocket's Hideout" (EX Team Rocket Returns 87/109) (+PM_SETNAME_OWNER)
PM_SETNAME_DELTA					=0x1f			--"Espeon δ" (EX Delta Species 4/113), "Delta Rainbow Energy" (POP Series 5 9/17)
PM_SETNAME_HOLON					=0x20			--"Holon Transceiver" (EX Delta Species 98/113)
PM_SETNAME_FOSSIL					=0x22			--"Fossil Excavator" (Mysterious Treasures 111/123)
PM_SETNAME_TEAM_GALACTICS_INVENTION	=0x23			--"Honchkrow G" (Platinum 77/127)
PM_SETNAME_TEAM_PLASMA					=0x2a		--"Skarmory" (Plasma Storm 87/135)
--↑Special Energy (for PM_EFFECT_ADD_SETCODE only)
PM_TYPE_DOUBLE_COLORLESS_ENERGY		=0x999			--Double Colorless Energy (Base Set 96/102)
PM_TYPE_DOUBLE_WATER_ENERGY			=0x998			--Double Aqua Energy (Double Crisis 33/34)
PM_TYPE_DOUBLE_FIGHTING_ENERGY		=0x997			--Double Magma Energy (Double Crisis 34/34)
--Pokémon/Energy Type (color)
PM_ENERGY_ALL						=0xfff			--Include all 11 Energy types
PM_ENERGY_GRASS						=0x001			--EARTH
PM_ENERGY_FIRE						=0x002			--WATER
PM_ENERGY_WATER						=0x004			--FIRE
PM_ENERGY_LIGHTNING					=0x008			--WIND
PM_ENERGY_PSYCHIC					=0x010			--LIGHT
PM_ENERGY_FIGHTING					=0x020			--DARK
PM_ENERGY_DARKNESS					=0x040			--DIVINE
PM_ENERGY_METAL						=0x080			--???
PM_ENERGY_COLORLESS					=0x100			--???
PM_ENERGY_FAIRY						=0x200			--???
PM_ENERGY_DRAGON					=0x400			--???
--Reason
PM_REASON_KNOCKED_OUT				=REASON_DESTROY				--Knocked Out=Destroy
PM_REASON_ATTACK					=REASON_EFFECT+0x20000000	--Put damage counters on a card by an attack
--Summon Type
PM_SUMMON_TYPE_EVOLVE				=SUMMON_TYPE_XYZ	--Evolve=Xyz
PM_SUMMON_TYPE_LEVELUP				=0x4d000000			--Pokémon LV.X
--Status
PM_STATUS_NO_RETREAT_COST			=STATUS_NO_LEVEL		--Pokémon with no Retreat Cost
PM_STATUS_PLAY_TURN					=STATUS_SPSUMMON_TURN	--Pokémon that was played during the current turn
--Player
PLAYER_OWNER						=nil	--player=PLAYER_OWNER in Duel.Sendto..(targets, player, reason)
PLAYER_PLAYER						=0		--player=PLAYER_PLAYER in Effect.SetCondition(Auxiliary.turnpcon(player)), etc.
PLAYER_OPPONENT						=1		--player=PLAYER_OPPONENT in Effect.SetCondition(Auxiliary.turnpcon(player)), etc.
--Reset
--↑Reset combinations
RESETS_STANDARD						=0x1fe0000	--RESET_TURN_SET+RESET_TOGRAVE+RESET_REMOVE+RESET_TEMP_REMOVE+RESET_TOHAND+RESET_TODECK+RESET_LEAVE+RESET_TOFIELD
RESETS_STANDARD_DISABLE				=0x1ff0000	--0x1fe0000+RESET_DISABLE
RESETS_STANDARD_DISCONTROL			=0x3ff0000	--0x1ff0000+RESET_CONTROL
--Types
PM_EFFECT_TYPE_PLAY					=EFFECT_TYPE_ACTIVATE		--Trainer cards that a player can play each turn
PM_EFFECT_TYPE_POKEMON_TOOL			=EFFECT_TYPE_XMATERIAL		--Pokémon Tools that give Pokémon attacks or effects
PM_EFFECT_TYPE_ATTACHED_TRAINER		=EFFECT_TYPE_XMATERIAL		--Trainer cards that give Pokémon attacks or effects
--Flags
PM_EFFECT_FLAG_BENCH_PARAM			=EFFECT_FLAG_SPSUM_PARAM	--Included in Auxiliary.EnablePokemonAttribute
PM_EFFECT_FLAG_POKEMON_ATTACK		=0x10000000					--Included on all Pokémon attacks
--Codes
PM_EFFECT_NO_ABILITY				=EFFECT_DISABLE				--A Pokémon has no abilities
PM_EFFECT_CANNOT_PLAY				=EFFECT_CANNOT_ACTIVATE		--Prevent a card from being played or attached
PM_EFFECT_PUT_IN_PLAY_CONDITION		=EFFECT_SPSUMMON_CONDITION	--Limit the ways a Pokémon can be put In Play
PM_EFFECT_BENCH_PROC				=EFFECT_SPSUMMON_PROC		--Put a Pokémon onto the Bench
PM_EFFECT_KNOCK_OUT_REPLACE			=EFFECT_DESTROY_REPLACE		--Prevent a Pokémon from being Knocked Out
PM_EFFECT_UPDATE_HIT_POINTS			=EFFECT_UPDATE_ATTACK		--Increase or decrease a Pokémon's HP
PM_EFFECT_SELF_KNOCK_OUT			=EFFECT_SELF_DESTROY		--A Pokémon knocks itself out 
PM_EFFECT_CHANGE_ENERGY				=EFFECT_CHANGE_CODE			--Change an Energy type
PM_EFFECT_REMOVE_TYPE				=EFFECT_REMOVE_TYPE			--Remove a card type
PM_EFFECT_ADD_POKEMON_TYPE			=EFFECT_ADD_ATTRIBUTE		--Add a Pokémon type
PM_EFFECT_CHANGE_POKEMON_TYPE		=EFFECT_CHANGE_ATTRIBUTE	--Change a Pokémon type
PM_EFFECT_UPDATE_RETREAT_COST		=EFFECT_UPDATE_LEVEL		--Increase or decrease a Pokémon's Retreat Cost
PM_EFFECT_CHANGE_RETREAT_COST		=EFFECT_CHANGE_LEVEL		--Set a Pokémon's Retreat Cost ("Balloon Berry" Neo Revelation 60/64)
PM_EFFECT_CHANGE_RETREAT_COST_FINAL	=EFFECT_CHANGE_LEVEL_FINAL	--Set a Pokémon's final Retreat Cost (Auxiliary.EnableEvolve)
PM_EFFECT_ADD_SETCODE				=EFFECT_ADD_SETCODE			--Add a type or archetype to another card
PM_EFFECT_MULLIGAN_CHECK			=CARD_PTCG_RULES			--Check if a player took a mulligan
PM_EFFECT_PRIZE_CARD				=CARD_PTCG_RULES+1			--Check if a card is a Prize card
PM_EFFECT_PRIZE_CARD_CHECK			=CARD_PTCG_RULES+2			--Check if a player took a Prize card
PM_EFFECT_SUDDEN_DEATH_CHECK		=CARD_PTCG_RULES+3			--Check if a card can be reset during Sudden Death
PM_EFFECT_SUDDEN_DEATH_RESTART		=CARD_PTCG_RULES+4			--Workaround for not being able to change turn counter to 1
PM_EFFECT_LIMIT_SUPPORTER			=CARD_PTCG_RULES+5			--Prevent activating more than 1 Supporter card per turn
PM_EFFECT_LIMIT_STADIUM				=CARD_PTCG_RULES+6			--Prevent playing more than 1 Stadium card per turn
PM_EFFECT_LIMIT_ENERGY				=CARD_PTCG_RULES+7			--Prevent attaching more than 1 Energy card per turn
PM_EFFECT_LIMIT_GX_ATTACK			=CARD_SNORLAX_GX			--Prevent using more than 1 GX attack in a game
PM_EFFECT_WEAKNESS_X2_GRASS			=26000001	--Weakness: Grass x2
PM_EFFECT_WEAKNESS_10_GRASS			=26000002	--Weakness: Grass +10
PM_EFFECT_WEAKNESS_20_GRASS			=26000003	--Weakness: Grass +20
PM_EFFECT_WEAKNESS_30_GRASS			=26000004	--Weakness: Grass +30
PM_EFFECT_WEAKNESS_40_GRASS			=26000005	--Weakness: Grass +40
PM_EFFECT_RESISTANCE_20_GRASS		=26000006	--Resistance: Grass -20
PM_EFFECT_RESISTANCE_30_GRASS		=26000007	--Resistance: Grass -30
PM_EFFECT_WEAKNESS_X2_FIRE			=26000008	--Weakness: Fire x2
PM_EFFECT_WEAKNESS_10_FIRE			=26000009	--Weakness: Fire +10
PM_EFFECT_WEAKNESS_20_FIRE			=26000010	--Weakness: Fire +20
PM_EFFECT_WEAKNESS_30_FIRE			=26000011	--Weakness: Fire +30
PM_EFFECT_WEAKNESS_40_FIRE			=26000012	--Weakness: Fire +40
PM_EFFECT_RESISTANCE_20_FIRE		=26000013	--Resistance: Fire -20
PM_EFFECT_RESISTANCE_30_FIRE		=26000014	--Resistance: Fire -30
PM_EFFECT_WEAKNESS_X2_WATER			=26000015	--Weakness: Water x2
PM_EFFECT_WEAKNESS_10_WATER			=26000016	--Weakness: Water +10
PM_EFFECT_WEAKNESS_20_WATER			=26000017	--Weakness: Water +20
PM_EFFECT_WEAKNESS_30_WATER			=26000018	--Weakness: Water +30
PM_EFFECT_WEAKNESS_40_WATER			=26000019	--Weakness: Water +40
PM_EFFECT_RESISTANCE_20_WATER		=26000020	--Resistance: Water -20
PM_EFFECT_RESISTANCE_30_WATER		=26000021	--Resistance: Water -30
PM_EFFECT_WEAKNESS_X2_LIGHTNING		=26000022	--Weakness: Lightning x2
PM_EFFECT_WEAKNESS_10_LIGHTNING		=26000023	--Weakness: Lightning +10
PM_EFFECT_WEAKNESS_20_LIGHTNING		=26000024	--Weakness: Lightning +20
PM_EFFECT_WEAKNESS_30_LIGHTNING		=26000025	--Weakness: Lightning +30
PM_EFFECT_WEAKNESS_40_LIGHTNING		=26000026	--Weakness: Lightning +40
PM_EFFECT_RESISTANCE_20_LIGHTNING	=26000027	--Resistance: Lightning -20
PM_EFFECT_RESISTANCE_30_LIGHTNING	=26000028	--Resistance: Lightning -30
PM_EFFECT_WEAKNESS_X2_PSYCHIC		=26000029	--Weakness: Psychic x2
PM_EFFECT_WEAKNESS_10_PSYCHIC		=26000030	--Weakness: Psychic +10
PM_EFFECT_WEAKNESS_20_PSYCHIC		=26000031	--Weakness: Psychic +20
PM_EFFECT_WEAKNESS_30_PSYCHIC		=26000032	--Weakness: Psychic +30
PM_EFFECT_WEAKNESS_40_PSYCHIC		=26000033	--Weakness: Psychic +40
PM_EFFECT_RESISTANCE_20_PSYCHIC		=26000034	--Resistance: Psychic -20
PM_EFFECT_RESISTANCE_30_PSYCHIC		=26000035	--Resistance: Psychic -30
PM_EFFECT_WEAKNESS_X2_FIGHTING		=26000036	--Weakness: Fighting x2
PM_EFFECT_WEAKNESS_10_FIGHTING		=26000037	--Weakness: Fighting +10
PM_EFFECT_WEAKNESS_20_FIGHTING		=26000038	--Weakness: Fighting +20
PM_EFFECT_WEAKNESS_30_FIGHTING		=26000039	--Weakness: Fighting +30
PM_EFFECT_WEAKNESS_40_FIGHTING		=26000040	--Weakness: Fighting +40
PM_EFFECT_RESISTANCE_20_FIGHTING	=26000041	--Resistance: Fighting -20
PM_EFFECT_RESISTANCE_30_FIGHTING	=26000042	--Resistance: Fighting -30
PM_EFFECT_WEAKNESS_X2_DARKNESS		=26000043	--Weakness: Darkness x2
PM_EFFECT_WEAKNESS_10_DARKNESS		=26000044	--Weakness: Darkness +10
PM_EFFECT_WEAKNESS_20_DARKNESS		=26000045	--Weakness: Darkness +20
PM_EFFECT_WEAKNESS_30_DARKNESS		=26000046	--Weakness: Darkness +30
PM_EFFECT_WEAKNESS_40_DARKNESS		=26000047	--Weakness: Darkness +40
PM_EFFECT_RESISTANCE_20_DARKNESS	=26000048	--Resistance: Darkness -20
PM_EFFECT_RESISTANCE_30_DARKNESS	=26000049	--Resistance: Darkness -30
PM_EFFECT_WEAKNESS_X2_METAL			=26000050	--Weakness: Metal x2
PM_EFFECT_WEAKNESS_10_METAL			=26000051	--Weakness: Metal +10
PM_EFFECT_WEAKNESS_20_METAL			=26000052	--Weakness: Metal +20
PM_EFFECT_WEAKNESS_30_METAL			=26000053	--Weakness: Metal +30
PM_EFFECT_WEAKNESS_40_METAL			=26000054	--Weakness: Metal +40
PM_EFFECT_RESISTANCE_20_METAL		=26000055	--Resistance: Metal -20
PM_EFFECT_RESISTANCE_30_METAL		=26000056	--Resistance: Metal -30
PM_EFFECT_WEAKNESS_X2_COLORLESS		=26000057	--Weakness: Colorless x2
PM_EFFECT_WEAKNESS_10_COLORLESS		=26000058	--Weakness: Colorless +10
PM_EFFECT_WEAKNESS_20_COLORLESS		=26000059	--Weakness: Colorless +20
PM_EFFECT_WEAKNESS_30_COLORLESS		=26000060	--Weakness: Colorless +30
PM_EFFECT_WEAKNESS_40_COLORLESS		=26000061	--Weakness: Colorless +40
PM_EFFECT_RESISTANCE_20_COLORLESS	=26000062	--Resistance: Colorless -20
PM_EFFECT_RESISTANCE_30_COLORLESS	=26000063	--Resistance: Colorless -30
PM_EFFECT_WEAKNESS_X2_FAIRY			=26000064	--Weakness: Fairy x2
PM_EFFECT_WEAKNESS_10_FAIRY			=26000065	--Weakness: Fairy +10
PM_EFFECT_WEAKNESS_20_FAIRY			=26000066	--Weakness: Fairy +20
PM_EFFECT_WEAKNESS_30_FAIRY			=26000067	--Weakness: Fairy +30
PM_EFFECT_WEAKNESS_40_FAIRY			=26000068	--Weakness: Fairy +40
PM_EFFECT_RESISTANCE_20_FAIRY		=26000069	--Resistance: Fairy -20
PM_EFFECT_RESISTANCE_30_FAIRY		=26000070	--Resistance: Fairy -30
PM_EFFECT_WEAKNESS_X2_DRAGON		=26000071	--Weakness: Dragon x2
PM_EFFECT_WEAKNESS_10_DRAGON		=26000072	--Weakness: Dragon +10
PM_EFFECT_WEAKNESS_20_DRAGON		=26000073	--Weakness: Dragon +20
PM_EFFECT_WEAKNESS_30_DRAGON		=26000074	--Weakness: Dragon +30
PM_EFFECT_WEAKNESS_40_DRAGON		=26000075	--Weakness: Dragon +40
PM_EFFECT_RESISTANCE_20_DRAGON		=26000076	--Resistance: Dragon -20
PM_EFFECT_RESISTANCE_30_DRAGON		=26000077	--Resistance: Dragon -30
PM_EFFECT_RETREAT					=700	--Prevent a player from retreating their Pokémon more than once per turn
PM_EFFECT_ASLEEP					=701	--"Asleep" Special Condition
PM_EFFECT_BURNED					=702	--"Burned" Special Condition
PM_EFFECT_CONFUSED					=703	--"Confused" Special Condition
PM_EFFECT_PARALYZED					=704	--"Paralyzed" Special Condition
PM_EFFECT_POISONED					=705	--"Poisoned" Special Condition
PM_EFFECT_CANNOT_EVOLVE				=706	--"Devolution Spray" (Base Set 72/102)
PM_EFFECT_NO_ATTACK					=707	--"Mysterious Fossil" (Fossil 62/62)
PM_EFFECT_CANNOT_RETREAT			=708	--"Mysterious Fossil" (Fossil 62/62)
PM_EFFECT_CANNOT_BE_ASLEEP			=709	--"Mysterious Fossil" (Fossil 62/62)
PM_EFFECT_CANNOT_BE_CONFUSED		=710	--"Mysterious Fossil" (Fossil 62/62)
PM_EFFECT_CANNOT_BE_PARALYZED		=711	--"Mysterious Fossil" (Fossil 62/62)
PM_EFFECT_CANNOT_BE_POISONED		=712	--"Mysterious Fossil" (Fossil 62/62)
PM_EFFECT_CANNOT_REMOVE_ENERGY_ATTACK_TRAINER	=713	--"Brock's Protection" (Gym Challenge 101/132)
PM_EFFECT_NO_RETREAT_COST			=714	--YGOPro cannot change RC to 0 ("Balloon Berry" Neo Revelation 60/64)
PM_EFFECT_RETREAT_COST_REPLACE		=715	--"Balloon Berry" (Neo Revelation 60/64)
PM_EFFECT_RESTRICT_MIRACLE_ENERGY	=716	--"Miracle Energy" (Neo Destiny 16/105)
PM_EFFECT_RESTRICT_POKEMON_STAR		=717	--"Mudkip Star" (Team Rocket Returns 107/109)
PM_EFFECT_IMMUNE_DAMAGE				=718	--"Squirtle" (Base Set 63/102)
PM_EFFECT_IMMUNE_ATTACK				=719	--"Arceus" (Arceus AR9)
PM_EFFECT_IMMUNE_ATTACK_EFFECT		=720	--"Arceus" (Arceus AR9)
PM_EFFECT_IMMUNE_ATTACK_DAMAGE		=721	--"Arceus" (Arceus AR9)
PM_EFFECT_IMMUNE_ATTACK_POKEMONLVX	=722	--"Arceus" (Arceus AR9)
PM_EFFECT_IMMUNE_ATTACK_NONEVOLVED	=723	--"Mewtwo LV.X" (Legends Awakened 144/146)
PM_EFFECT_RESTRICT_ACE_SPEC			=724	--"Computer Search" (Boundaries Crossed 137/149)
PM_EFFECT_CANNOT_ATTACK				=725	--"Haxorus" (Noble Victories 88/101)
PM_EFFECT_EXTEND_BENCH_8			=726	--"Sky Field" (Roaring Skies 89/108)
PM_EFFECT_DAMAGE_ATTACK_REDUCE_20	=727	--"Chesnaught" (BREAKthrough 11/162)
PM_EFFECT_DAMAGE_ATTACK_REDUCE_30	=728	--"Mewtwo-EX" (BREAKthrough 61/162)
--Abilities that activate or actions that occur at the appropriate event
PM_EVENT_TO_DISCARDPILE				=EVENT_TO_GRAVE			--When a card is put into the discard pile
PM_EVENT_LEAVE_PLAY					=EVENT_LEAVE_FIELD		--When a card leaves play
PM_EVENT_KNOCKED_OUT				=EVENT_DESTROYED		--When a Pokémon is Knocked Out
PM_EVENT_PLAY_SUCCESS				=EVENT_SPSUMMON_SUCCESS	--When a Pokémon is put In Play
PM_EVENT_PRE_ATTACK					=EVENT_CHAIN_ACTIVATING	--Before a Confused Pokémon attacks
PM_EVENT_ATTACK_END					=EVENT_CHAIN_SOLVED		--When a Pokémon finishes its attack
PM_EVENT_TOSS_COIN_NEGATE			=EVENT_TOSS_COIN_NEGATE	--When a coin is flipped, the player may choose to re-flip it
PM_EVENT_ADD_COUNTER				=EVENT_ADD_COUNTER		--When a counter/marker is put on a card
--Categories
PM_CATEGORY_TOHAND					=CATEGORY_TOHAND	--"Pokémon Tower" (Black Star Promo Wizards of the Coast 42)
--Descriptions
--↑Win (Reserved: Can be used as HINT_OPSELECTED or HINT_MESSAGE with Duel.Hint)
PM_DESC_INVALID						=aux.Stringid(PM_STRING_WIN,0)	--"You have an invalid deck!"
PM_DESC_KNOCKOUT					=aux.Stringid(PM_STRING_WIN,1)	--"You have no more Pokémon left in play!"
PM_DESC_PRIZE						=aux.Stringid(PM_STRING_WIN,2)	--"You collected all the Prize cards to win the game!"
PM_DESC_LOST_WORLD					=aux.Stringid(PM_STRING_WIN,3)	--"Once during each player's turn, if that player's opponent has 6 or more Pokémon in the Lost Zone, the player may choose to win the game."
PM_DESC_SLOWBRO						=aux.Stringid(PM_STRING_WIN,4)	--"If you use this attack when you have only 1 Prize card left, you win this game."
--↑Game Progress (Reserved: Can be used as HINT_OPSELECTED or HINT_MESSAGE with Duel.Hint)
PM_DESC_MULLIGAN					=aux.Stringid(PM_STRING_GAME,0)	--"Your opening hand has no Basic Pokémon. Select OK to take a mulligan."
PM_DESC_MULLIGAN_WARN				=aux.Stringid(PM_STRING_GAME,1)	--"Your opponent had no Basic Pokémon in their hand and will redraw after you play your starting Pokémon."
PM_DESC_EMPTY_BENCH					=aux.Stringid(PM_STRING_GAME,2)	--"You have no additional Basic Pokémon to start on your Bench. Select OK to continue."
PM_DESC_SUDDEN_DEATH				=aux.Stringid(PM_STRING_GAME,3)	--"Sudden Death"
PM_DESC_DAMAGE_INCREASE				=aux.Stringid(PM_STRING_GAME,4)	--"Damage Increased"
PM_DESC_DAMAGE_DECREASE				=aux.Stringid(PM_STRING_GAME,5)	--"Damage Decreased"
PM_DESC_NO_TARGETS					=aux.Stringid(PM_STRING_GAME,6)	--"Sorry, there are no valid targets to select. Click OK to continue."
--↑Special Condition
PM_DESC_ASLEEP						=aux.Stringid(PM_STRING_CONDITION,0)	--"This Pokémon is Asleep."
PM_DESC_ASLEEP_DESC					=aux.Stringid(PM_STRING_CONDITION,1)	--"While Asleep, a Pokémon cannot attack or retreat."
PM_DESC_ASLEEP_CHECK				=aux.Stringid(PM_STRING_CONDITION,2)	--"Between turns, the owner flips a coin. If heads, the Pokémon wakes up."
PM_DESC_BURNED						=aux.Stringid(PM_STRING_CONDITION,3)	--"This Pokémon is Burned."
PM_DESC_BURNED_DESC					=aux.Stringid(PM_STRING_CONDITION,4)	--"Between turns, the owner flips a coin. If tails, put 2 damage counters on the Burned Pokémon.."
PM_DESC_BURNED_CHECK				=aux.Stringid(PM_STRING_CONDITION,5)	--"Between turns, the owner flips a coin. If tails, put 2 damage counters on the Burned Pokémon."
PM_DESC_CONFUSED					=aux.Stringid(PM_STRING_CONDITION,6)	--"This Pokémon is Confused."
PM_DESC_CONFUSED_DESC				=aux.Stringid(PM_STRING_CONDITION,7)	--"If you attack with a Confused Pokémon, flip a coin. If tails, the attack does nothing, and put 3 damage counters on the Confused Pokémon."
PM_DESC_CONFUSED_CHECK				=aux.Stringid(PM_STRING_CONDITION,8)	--"If you attack with a Confused Pokémon, flip a coin. If tails, the attack does nothing, and put 3 damage counters on the Confused Pokémon."
PM_DESC_PARALYZED					=aux.Stringid(PM_STRING_CONDITION,9)	--"This Pokémon is Paralyzed."
PM_DESC_PARALYZED_DESC				=aux.Stringid(PM_STRING_CONDITION,10)	--"While Paralyzed, a Pokémon cannot attack or retreat."
PM_DESC_PARALYZED_CHECK				=aux.Stringid(PM_STRING_CONDITION,11)	--"At the end of your turn, your Pokémon returns to normal."
PM_DESC_POISONED					=aux.Stringid(PM_STRING_CONDITION,12)	--"This Pokémon is Poisoned."
PM_DESC_POISONED_DESC				=aux.Stringid(PM_STRING_CONDITION,13)	--"When a Pokémon is Poisoned, put 1 damage counter on it between turns."
PM_DESC_POISONED_CHECK				=aux.Stringid(PM_STRING_CONDITION,14)	--"When a Pokémon is Poisoned, put 1 damage counter on it between turns."
--↑Action
PM_DESC_RETREAT						=aux.Stringid(PM_STRING_DESC,0)			--"Retreat"
PM_DESC_LVX							=aux.Stringid(PM_STRING_DESC,1)			--"Level Up"
PM_DESC_EVOLVE						=aux.Stringid(PM_STRING_DESC,2)			--"Evolve"
PM_DESC_ENERGY						=aux.Stringid(PM_STRING_DESC,3)			--"Attach the Energy to your Pokémon."
PM_DESC_TOOL						=aux.Stringid(PM_STRING_DESC,4)			--"Attach the Pokémon Tool to your Pokémon."
PM_DESC_SELF_DISCARD				=aux.Stringid(PM_STRING_DESC,5)			--"Discard this card."
PM_DESC_SELF_DETACH					=aux.Stringid(PM_STRING_DESC,6)			--"Detach this card."
--Hint Message
PM_HINTMSG_CARD						=aux.Stringid(PM_STRING_HINTMSG,0)		--"Select a card."
PM_HINTMSG_POKEMON					=aux.Stringid(PM_STRING_HINTMSG,1)		--"Select a Pokémon."
PM_HINTMSG_ACTIVEPOKEMON			=aux.Stringid(PM_STRING_HINTMSG,2)		--"Select an Active Pokémon."
PM_HINTMSG_BENCHEDPOKEMON			=aux.Stringid(PM_STRING_HINTMSG,3)		--"Select a Benched Pokémon."
PM_HINTMSG_BASICPOKEMON				=aux.Stringid(PM_STRING_HINTMSG,4)		--"Select a Basic Pokémon."
PM_HINTMSG_EVOLUTION				=aux.Stringid(PM_STRING_HINTMSG,5)		--"Select an Evolution card."
PM_HINTMSG_STAGE1					=aux.Stringid(PM_STRING_HINTMSG,6)		--"Select a Stage 1 Pokémon."
PM_HINTMSG_STAGE2					=aux.Stringid(PM_STRING_HINTMSG,7)		--"Select a Stage 2 Pokémon."
PM_HINTMSG_BABYPOKEMON				=aux.Stringid(PM_STRING_HINTMSG,8)		--"Select a Baby Pokémon."
PM_HINTMSG_POKEMON_EX				=aux.Stringid(PM_STRING_HINTMSG,9)		--"Select a Pokémon ex."
PM_HINTMSG_POKEMONSTAR				=aux.Stringid(PM_STRING_HINTMSG,10)		--"Select a Pokémon Star."
PM_HINTMSG_POKEMONLVX				=aux.Stringid(PM_STRING_HINTMSG,11)		--"Select a Pokémon LV.X."
PM_HINTMSG_POKEMONSP				=aux.Stringid(PM_STRING_HINTMSG,12)		--"Select a Pokémon SP."
PM_HINTMSG_POKEMONLEGEND			=aux.Stringid(PM_STRING_HINTMSG,13)		--"Select a Pokémon LEGEND."
PM_HINTMSG_POKEMONEX				=aux.Stringid(PM_STRING_HINTMSG,14)		--"Select a Pokémon-EX."
PM_HINTMSG_RESTORED					=aux.Stringid(PM_STRING_HINTMSG,15)		--"Select a Restored Pokémon."
PM_HINTMSG_MEGA						=aux.Stringid(PM_STRING_HINTMSG2,0)		--"Select a Mega Evolution Pokémon."
PM_HINTMSG_POKEMONBREAK				=aux.Stringid(PM_STRING_HINTMSG2,1)		--"Select a Pokémon BREAK."
PM_HINTMSG_POKEMONGX				=aux.Stringid(PM_STRING_HINTMSG2,2)		--"Select a Pokémon GX."
PM_HINTMSG_TRAINER					=aux.Stringid(PM_STRING_HINTMSG3,0)		--"Select a Trainer card."
PM_HINTMSG_ITEM						=aux.Stringid(PM_STRING_HINTMSG3,1)		--"Select an Item card."
PM_HINTMSG_POKEMONTOOL				=aux.Stringid(PM_STRING_HINTMSG3,2)		--"Select a Pokémon Tool card."
PM_HINTMSG_SUPPORTER				=aux.Stringid(PM_STRING_HINTMSG3,3)		--"Select a Supporter card."
PM_HINTMSG_TECHMACHINE				=aux.Stringid(PM_STRING_HINTMSG3,4)		--"Select a Technical Machine card."
PM_HINTMSG_ROCKETSMACHINE			=aux.Stringid(PM_STRING_HINTMSG3,5)		--"Select a Rocket's Secret Machine card."
PM_HINTMSG_ACESPEC					=aux.Stringid(PM_STRING_HINTMSG3,6)		--"Select an ACE SPEC card."
PM_HINTMSG_ENERGY					=aux.Stringid(PM_STRING_HINTMSG5,0)		--"Select an Energy card."
PM_HINTMSG_BASICENERGY				=aux.Stringid(PM_STRING_HINTMSG5,1)		--"Select a basic Energy card."
PM_HINTMSG_SPECIALENERGY			=aux.Stringid(PM_STRING_HINTMSG5,2)		--"Select a Special Energy card."
PM_HINTMSG_GENERGY					=aux.Stringid(PM_STRING_HINTMSG6,0)		--"Select a GRASS Energy card."
PM_HINTMSG_RENERGY					=aux.Stringid(PM_STRING_HINTMSG6,1)		--"Select a FIRE Energy card."
PM_HINTMSG_WENERGY					=aux.Stringid(PM_STRING_HINTMSG6,2)		--"Select a WATER Energy card."
PM_HINTMSG_LENERGY					=aux.Stringid(PM_STRING_HINTMSG6,3)		--"Select a LIGHTNING Energy card."
PM_HINTMSG_PENERGY					=aux.Stringid(PM_STRING_HINTMSG6,4)		--"Select a PSYCHIC Energy card."
PM_HINTMSG_FENERGY					=aux.Stringid(PM_STRING_HINTMSG6,5)		--"Select a FIGHTING Energy card."
PM_HINTMSG_DENERGY					=aux.Stringid(PM_STRING_HINTMSG6,6)		--"Select a DARKNESS Energy card."
PM_HINTMSG_MENERGY					=aux.Stringid(PM_STRING_HINTMSG6,7)		--"Select a METAL Energy card."
PM_HINTMSG_YENERGY					=aux.Stringid(PM_STRING_HINTMSG6,8)		--"Select a FAIRY Energy card."
PM_HINTMSG_ACTIVE					=aux.Stringid(PM_STRING_HINTMSG7,0)		--"Select a Pokémon to be the Active Pokémon."
PM_HINTMSG_BENCH					=aux.Stringid(PM_STRING_HINTMSG7,1)		--"Select a Pokémon to be on the Bench."
PM_HINTMSG_RETREAT					=aux.Stringid(PM_STRING_HINTMSG7,2)		--"Select a Pokémon to retreat."
PM_HINTMSG_PROMOTE					=aux.Stringid(PM_STRING_HINTMSG7,3)		--"Select a Pokémon to make Active."
PM_HINTMSG_DISCARDENERGY			=aux.Stringid(PM_STRING_HINTMSG7,4)		--"Select an Energy card to discard."
PM_HINTMSG_EVOLVE					=aux.Stringid(PM_STRING_HINTMSG7,5)		--"Select a Pokémon to evolve."
PM_HINTMSG_DEVOLVE					=aux.Stringid(PM_STRING_HINTMSG7,6)		--"Select a Pokémon to devolve."
PM_HINTMSG_LEVELUP					=aux.Stringid(PM_STRING_HINTMSG7,7)		--"Select a Pokémon to Level Up."
PM_HINTMSG_ATTACHENERGY				=aux.Stringid(PM_STRING_HINTMSG7,8)		--"Select a Pokémon to attach the Energy to."
PM_HINTMSG_MOVEENERGY				=aux.Stringid(PM_STRING_HINTMSG7,9)		--"Select a Pokémon to move the Energy to."
PM_HINTMSG_ATTACHTOOL				=aux.Stringid(PM_STRING_HINTMSG7,10)	--"Select a Pokémon to attach the Pokémon Tool to."
PM_HINTMSG_MOVETOOL					=aux.Stringid(PM_STRING_HINTMSG7,11)	--"Select a Pokémon to move the Pokémon Tool to."
PM_HINTMSG_ENERGYTYPE				=aux.Stringid(PM_STRING_HINTMSG7,12)	--"Choose a type."
PM_HINTMSG_TOHAND					=aux.Stringid(PM_STRING_HINTMSG7,13)	--"Select a card to put into your hand."
PM_HINTMSG_HEAL						=aux.Stringid(PM_STRING_HINTMSG7,14)	--"Select a Pokémon to heal."
PM_HINTMSG_TOBENCH					=aux.Stringid(PM_STRING_HINTMSG7,15)	--"Select a Pokémon to put onto the Bench."
PM_HINTMSG_DISCARD					=aux.Stringid(PM_STRING_HINTMSG8,0)		--"Select a card to discard."
PM_HINTMSG_TODECK					=aux.Stringid(PM_STRING_HINTMSG8,1)		--"Select a card to shuffle into the deck."
PM_HINTMSG_TODECKTOP				=aux.Stringid(PM_STRING_HINTMSG8,2)		--"Select a card to put on top of the deck."
PM_HINTMSG_TODECKBOT				=aux.Stringid(PM_STRING_HINTMSG8,3)		--"Select a card to put on the bottom of the deck."
PM_HINTMSG_TODISCARD				=aux.Stringid(PM_STRING_HINTMSG8,4)		--"Select a card to put into the discard pile."
--Question Hint Message
PM_QHINTMSG_DRAW					=aux.Stringid(PM_STRING_QHINTMSG,0)		--"Would you like to draw a card?"
--Select Message
--↑Coin
SELECT_HEADS						=60	--"Heads" coin call
SELECT_TAILS						=61	--"Tails" coin call
--↑Energy Type
PM_SELECT_GRASS						=aux.Stringid(PM_STRING_SELECTMSG,0)	--"Grass"
PM_SELECT_FIRE						=aux.Stringid(PM_STRING_SELECTMSG,1)	--"Fire"
PM_SELECT_WATER						=aux.Stringid(PM_STRING_SELECTMSG,2)	--"Water"
PM_SELECT_LIGHTNING					=aux.Stringid(PM_STRING_SELECTMSG,3)	--"Lightning"
PM_SELECT_PSYCHIC					=aux.Stringid(PM_STRING_SELECTMSG,4)	--"Psychic"
PM_SELECT_FIGHTING					=aux.Stringid(PM_STRING_SELECTMSG,5)	--"Fighting"
PM_SELECT_DARKNESS					=aux.Stringid(PM_STRING_SELECTMSG,6)	--"Darkness"
PM_SELECT_METAL						=aux.Stringid(PM_STRING_SELECTMSG,7)	--"Metal"
PM_SELECT_COLORLESS					=aux.Stringid(PM_STRING_SELECTMSG,8)	--"Colorless"
PM_SELECT_FAIRY						=aux.Stringid(PM_STRING_SELECTMSG,9)	--"Fairy"
PM_SELECT_DRAGON					=aux.Stringid(PM_STRING_SELECTMSG,10)	--"Dragon"
--Result
RESULT_TAILS						=0	--"Tails" coin result
RESULT_HEADS						=1	--"Heads" coin result
--Sequence
SEQUENCE_FIRST_SZONE				=0	--Card.IsLocation(LOCATION_SZONE) and Card.GetSequence()==SEQUENCE_FIRST_SZONE
SEQUENCE_FIELD_ZONE					=5	--Card.IsLocation(LOCATION_SZONE) and Card.GetSequence()==SEQUENCE_FIELD_ZONE
SEQUENCE_EXTRA_MZONE				=5	--Card.IsLocation(LOCATION_MZONE) and Card.GetSequence()==SEQUENCE_EXTRA_MZONE
--Deck Order
DECK_ORDER_TOP						=0	--seq=DECK_ORDER_TOP in Duel.SendtoDeck(targets, player, seq, reason)
DECK_ORDER_BOTTOM					=1	--seq=DECK_ORDER_BOTTOM in Duel.SendtoDeck(targets, player, seq, reason)
DECK_ORDER_SHUFFLE					=2	--seq=DECK_ORDER_SHUFFLE in Duel.SendtoDeck(targets, player, seq, reason)
DECK_ORDER_UNEXIST					=-2	--seq=DECK_ORDER_UNEXIST in Duel.SendtoDeck(targets, player, seq, reason)
return PTCG
