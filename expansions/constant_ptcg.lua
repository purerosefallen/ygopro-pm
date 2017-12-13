--[[
	Pokémon Trading Card Game Constants
	
	Usage: Put this file in the expansions folder
	
	Include the following code in your script
	
	local PTCG=require "expansions.constant_ptcg"
	
]]

local PTCG={}

--Card ID
--↑Rules
CARD_PTCG_RULES						=26000000	--Pokémon Rules
CARD_PTCG_PRIZE						=26000999	--Prize cards are attached to this card (may be temporary)
--↑Energy cards
CARD_GRASS_ENERGY					=26001099	--Base Set 99/102
CARD_FIRE_ENERGY					=26001098	--Base Set 98/102
CARD_WATER_ENERGY					=26001102	--Base Set 102/102
CARD_LIGHTNING_ENERGY				=26001100	--Base Set 100/102
CARD_PSYCHIC_ENERGY					=26001101	--Base Set 101/102
CARD_FIGHTING_ENERGY				=26001097	--Base Set 97/102
CARD_DARKNESS_ENERGY				=26032129	--Diamond & Pearl 29/130
CARD_METAL_ENERGY					=26032130	--Diamond & Pearl 30/130
CARD_COLORLESS_ENERGY				=nil		--energy=CARD_COLORLESS_ENERGY in Card.IsEnergy (c, energy)
CARD_FAIRY_ENERGY					=26059140	--XY 140/146
--Counters/Markers
PM_DAMAGE_COUNTER					=0x1600		--A Pokémon loses 10 HP for each Damage Counter on it
PM_BURN_MARKER						=0x1601		--When a Pokémon is Burned, put a Burn marker on it
PM_POISON_MARKER					=0x1602		--When a Pokémon is Poisoned, put a Poison marker on it
PM_COLORING_COUNTER					=0x1603		--"Smeargle" (Wizards Promo 32/53)
PM_LIGHTNING_ROD_MARKER				=0x1604		--"Electabuzz" (Wizards Promo 46/53)
PM_CHAR_COUNTER						=0x1605		--"Quilava" (Neo Genesis 47/111)
PM_DARK_IVYSAUR_MARKER				=0x1606		--"Dark Ivysaur" (Best of Game 6/9)
PM_IMPRISON_MARKER					=0x1607		--"Tropius δ" (Dragon Frontiers 23/101)
PM_SHOCKWAVE_MARKER					=0x1608		--"Tropius δ" (Dragon Frontiers 23/101)
--Win Reason
PM_WIN_REASON_INVALID				=0x4d		--"Your opponent had an invalid deck."
PM_WIN_REASON_KNOCKOUT				=0x6a		--"Your opponent had no more Pokémon left in play!"
PM_WIN_REASON_PRIZE					=0x6b		--"Your opponent collected all the Prize cards to win the game!"
PM_WIN_REASON_LOST_WORLD			=0x6c		--"Once during each player's turn, if that player's opponent has 6 or more Pokémon in the Lost Zone, the player may choose to win the game."
PM_WIN_REASON_SLOWBRO				=0x6d		--"If you use this attack when you have only 1 Prize card left, you win this game."
--Min/Max Values
MAX_NUMBER							=999999999	--Max number allowed in YGOPro
--Locations (for SetRange)
PM_LOCATION_STADIUM					=LOCATION_FZONE		--Location for Stadium cards
--Locations
PM_LOCATION_RULES					=LOCATION_EXTRA		--Location for Pokémon Rules
PM_LOCATION_ACTIVE_POKEMON			=LOCATION_MZONE		--Location for Active Pokémon
PM_LOCATION_BENCH					=LOCATION_MZONE		--Location for Benched Pokémon
PM_LOCATION_PRIZE_CARDS				=LOCATION_SZONE		--Location for Prize cards
PM_LOCATION_ADJACENT_ACTIVE_POKEMON	=LOCATION_SZONE
PM_LOCATION_DISCARD_PILE			=LOCATION_GRAVE		--Location for cards taken out of play
PM_LOCATION_LOST_ZONE				=LOCATION_REMOVED	--Location for cards no longer playable
PM_LOCATION_IN_PLAY					=LOCATION_MZONE+LOCATION_SZONE	--Location for Active and Benched Pokémon
--↑Location combinations
LOCATIONS_ALL						=0xff		--All locations
--Positions
PM_POS_FACEUP_UPSIDE				=POS_FACEUP_ATTACK		--The default position of an in play Pokémon
PM_POS_FACEDOWN_UPSIDE				=POS_FACEDOWN_ATTACK	--The temporary position of the starting Active Pokémon
PM_POS_FACEUP_COUNTERCLOCKWISE		=POS_FACEUP_DEFENSE		--The default position of an Asleep Pokémon
PM_POS_FACEDOWN_COUNTERCLOCKWISE	=POS_FACEDOWN_DEFENSE	--N/A
PM_POS_FACEUP_CLOCKWISE				=POS_FACEUP_DEFENSE		--The default position of a Paralyzed Pokémon
PM_POS_FACEDOWN_CLOCKWISE			=POS_FACEDOWN_DEFENSE	--N/A
PM_POS_FACEUP_SIDEWAYS				=POS_FACEUP_DEFENSE		--The default position of a Pokémon BREAK
PM_POS_FACEDOWN_SIDEWAYS			=POS_FACEDOWN_DEFENSE	--N/A
--Types
PM_TYPE_RULE						=TYPE_FUSION+TYPE_PENDULUM	--The type of Pokémon Rules to exist face-up in the extra deck
--↑Pokémon
PM_TYPE_POKEMON						=TYPE_MONSTER	--Pokémon=Monster
PM_TYPE_BASIC_POKEMON				=0x1			--"Unown J" (Wizards Promo 38/53)
PM_TYPE_EVOLUTION					=0x2			--"Mew" (Wizards Promo 8/53)
PM_TYPE_STAGE_1						=0x3			--"Devolution Spray" (Base Set 72/102) (+PM_TYPE_EVOLUTION)
PM_TYPE_STAGE_2						=0x4			--"Devolution Spray" (Base Set 72/102) (+PM_TYPE_EVOLUTION)
PM_TYPR_BABY_POKEMON				=0x5			--"Pokémon Breeder Fields" (Neo Revelation 62/64)
PM_TYPE_EX							=0x6			--"Hariyama" (EX Ruby & Sapphire 8/109), "Shaymin-EX" (Next Destinies 5/99)
PM_TYPE_POKEMON_STAR				=0x7			--"Mudkip Star" (EX Team Rocket Returns 107/109)
PM_TYPE_LEVEL_UP					=0x8			--"Empoleon LV.X" (Diamond & Pearl 120/130)
PM_TYPE_SP							=0x9			--"Champion's Room" (Supreme Victors 135/147)
PM_TYPE_LEGEND						=0xa			--"Legend Box" (Undaunted 75/91)
PM_TYPE_RESTORED					=0xb			--"Twist Mountain" (Dark Explorers 101/108)
PM_TYPE_MEGA						=0xc			--"M Venusaur-EX" (XY 2/146) (+PM_TYPE_EVOLUTION)
PM_TYPE_BREAK						=0xd			--"Giratina" (XY Promo XY184) (+PM_TYPE_EVOLUTION)
PM_TYPE_GX							=0xe			--"Decidueye-GX" (Sun & Moon 12/149)
--↑Trainer
PM_TYPE_TRAINER						=TYPE_SPELL		--Trainer=Spell
PM_TYPE_STADIUM						=TYPE_FIELD		--Stadium=Field
PM_TYPE_ITEM						=0xf			--"Lillipup" (Black & White 80/114)
PM_TYPE_POKEMON_TOOL					=0x10		--"Balloon Berry" (Neo Revelation 60/64) (+PM_TYPE_ITEM)
PM_TYPE_ACE_SPEC						=0x11		--"Computer Search" (Boundaries Crossed 137/149) (+PM_TYPE_ITEM)
PM_TYPE_GOLDENROD_GAME_CORNER		=0x12			--"Arcade Game" (Neo Genesis 83/111) & Card-Flip Game (Neo Genesis 92/111)
PM_TYPE_SUPPORTER					=0x13			--"Bill's Maintenance" (Expedition 137/165)
PM_TYPE_TECHNICAL_MACHINE			=0x14			--"Sneasel" (Aquapolis 110/147)
PM_TYPE_ROCKETS_SECRET_MACHINE		=0x15			--"Dark Slowking" (EX Team Rocket Returns 9/109)
--↑Energy
PM_TYPE_ENERGY						=TYPE_TRAP		--Energy=Trap
PM_TYPE_BASIC_ENERGY				=0x16			--"Mewtwo" (Wizards Promo 12/53)
PM_TYPE_SPECIAL_ENERGY				=0x17			--"Smoochum" (Neo Revelation 54/64)
PM_TYPE_HOLON_ENERGY					=0x1018		--"Flareon δ" (EX Delta Species 5/113) (+PM_TYPE_SPECIAL_ENERGY)
--new special energy goes here
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
--Setname
PM_SETNAME_DARK						=0x100			--"The Boss's Way" (Team Rocket 73/82)
PM_SETNAME_MISTY						=0x101		--"Misty" (Gym Heroes 18/132) (+PM_SETNAME_OWNER)
PM_SETNAME_BROCK						=0x102		--"Brock's Geodude" (Gym Heroes 66/132) (+PM_SETNAME_OWNER)
PM_SETNAME_ERIKA						=0x103		--"Celadon City Gym" (Gym Heroes 107/132) (+PM_SETNAME_OWNER)
PM_SETNAME_SABRINA						=0x104		--"Sabrina's ESP" (Gym Heroes 117/132) (+PM_SETNAME_OWNER)
PM_SETNAME_LT_SURGE						=0x105		--"Vermilion City Gym" (Gym Heroes 120/132) (+PM_SETNAME_OWNER)
PM_SETNAME_BLAINE						=0x106		--"Blaine" (Gym Challenge 17/132) (+PM_SETNAME_OWNER)
PM_SETNAME_GIOVANNI						=0x107		--"Giovanni" (Gym Challenge 18/132) (+PM_SETNAME_OWNER)
PM_SETNAME_KOGA							=0x108		--"Koga" (Gym Challenge 19/132) (+PM_SETNAME_OWNER)
PM_SETNAME_UNOWN					=0x109			--"Unown [A]" (Neo Discovery 14/75)
PM_SETNAME_SHINING					=0x10a			--"Miracle Energy" (Neo Destiny 16/105)
PM_SETNAME_LIGHT					=0x10b			--"Miracle Energy" (Neo Destiny 16/105)
PM_SETNAME_BALL						=0x10c			--"Apricorn Maker" (Skyridge 121/144)
PM_SETNAME_TEAM_MAGMA					=0x10d		--"Team Aqua's Crawdaunt" (EX Team Magma vs Team Aqua 2/95) (+PM_SETNAME_OWNER)
PM_SETNAME_TEAM_AQUA					=0x10e		--"Team Aqua's Kyogre" (EX Team Magma vs Team Aqua 3/95) (+PM_SETNAME_OWNER)
PM_SETNAME_OWNER					=0x10f			--"Ancient Technical Machine [Ice]" (EX Hidden Legends 84/101)
PM_SETNAME_ROCKETS						=0x110		--"Rocket's Hideout" (EX Team Rocket Returns 87/109) (+PM_SETNAME_OWNER)
PM_SETNAME_DELTA					=0x111			--"Espeon δ" (EX Delta Species 4/113), "Delta Rainbow Energy" (POP Series 5 9/17)
PM_SETNAME_HOLON					=0x18			--"Holon Transceiver" (EX Delta Species 98/113)
PM_SETNAME_FOSSIL					=0x112			--"Fossil Excavator" (Mysterious Treasures 111/123)
PM_SETNAME_TEAM_GALACTICS_INVENTION	=0x113			--"Honchkrow G" (Platinum 77/127)
PM_SETNAME_TEAM_PLASMA					=0x114		--"Skarmory" (Plasma Storm 87/135)
--Reason
PM_REASON_KNOCKED_OUT				=REASON_DESTROY		--Knocked Out=Destroy
--Summon Type
PM_SUMMON_TYPE_EVOLVE				=SUMMON_TYPE_XYZ	--Evolve=Xyz
--Status
PM_STATUS_NO_RETREAT_COST			=STATUS_NO_LEVEL	--Pokémon with no Retreat Cost
--Player
PLAYER_OWNER						=nil	--player=PLAYER_OWNER in Duel.Sendto.. (targets, player, reason)
PLAYER_PLAYER						=0		--player=PLAYER_PLAYER in Effect.SetCondition (Auxiliary.turnpcon(player)), etc.
PLAYER_OPPONENT						=1		--player=PLAYER_OPPONENT in Effect.SetCondition (Auxiliary.turnpcon(player)), etc.
--Descriptions
--↑Reset combinations
RESETS_STANDARD						=0x1fe0000	--RESET_TURN_SET+RESET_TOGRAVE+RESET_REMOVE+RESET_TEMP_REMOVE+RESET_TOHAND+RESET_TODECK+RESET_LEAVE+RESET_TOFIELD
RESETS_STANDARD_DISABLE				=0x1ff0000	--0x1fe0000+RESET_DISABLE
--Codes
PM_EFFECT_LIMIT_SUPPORTER			=CARD_PTCG_RULES+1	--"You can play only one Supporter card each turn."
PM_EFFECT_LIMIT_STADIUM				=CARD_PTCG_RULES+2	--"You can play only one Stadium card each turn."
PM_EFFECT_LIMIT_BASIC_ENERGY		=CARD_PTCG_RULES+3	--"You can attach Energy just once each turn."
--Categories
PM_CATEGORY_COIN					=CATEGORY_COIN	--"Sabrina's ESP" (Gym Heroes 117)
PM_CATEGORY_RECYCLE					=0x80000000		--"Pokémon Tower" (Wizards Promo 42)
--Select Message
--↑Coin
SELECT_HEADS						=60	--"Heads" coin call
SELECT_TAILS						=61	--"Tails" coin call
--Result
RESULT_TAILS						=0	--"Tails" coin result
RESULT_HEADS						=1	--"Heads" coin result
--Sequence
SEQUENCE_FIRST_SZONE				=0	--Card.IsLocation(LOCATION_SZONE) and Card.GetSequence()==SEQUENCE_FIRST_SZONE
SEQUENCE_EXTRA_MZONE				=5	--Card.IsLocation(LOCATION_MZONE) and Card.GetSequence()==SEQUENCE_EXTRA_MZONE
--Deck Order
DECK_ORDER_TOP						=0	--seq=DECK_ORDER_TOP in Duel.SendtoDeck (targets, player, seq, reason)
DECK_ORDER_BOTTOM					=1	--seq=DECK_ORDER_BOTTOM in Duel.SendtoDeck (targets, player, seq, reason)
DECK_ORDER_SHUFFLE					=2	--seq=DECK_ORDER_SHUFFLE in Duel.SendtoDeck (targets, player, seq, reason)
DECK_ORDER_UNEXIST					=-2	--seq=DECK_ORDER_UNEXIST in Duel.SendtoDeck (targets, player, seq, reason)
return PTCG
