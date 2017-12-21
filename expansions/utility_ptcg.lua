--[[
	Pokémon Trading Card Game Utility

	Usage: Put this file in the expansions folder
	
	Include the following code in your script
	
	local pm=require "expansions.utility_ptcg"
]]

--CONTENTS
--[+UniversalFunctions]......................................functions that are included on every script
--[+RuleFunctions]...........................................functions that are included on the rules card
--[+Pokémon].................................................functions that are included on every Pokémon card
--[+Energy]..................................................functions that are included on every Energy card
--[+Trainer].................................................functions that are included on every Trainer card
--[+Attack]..................................................attacks that are shared by many pokémon
--[+Ability].................................................non-attack effects that are shared by many pokémon
--[+Conditions]..............................................condition functions
--[+Targets].................................................target functions
--[+Filters].................................................filter functions

local Auxiliary={}
local PTCG=require "expansions.constant_ptcg"
PM_LOCATION_ACTIVE=PM_LOCATION_ACTIVE_POKEMON
PM_LOCATION_DPILE=PM_LOCATION_DISCARD_PILE
PM_LOCATION_PRIZE=PM_LOCATION_PRIZE_CARDS
PM_LOCATION_ADJACENT_ACTIVE=PM_LOCATION_ADJACENT_ACTIVE_POKEMON
PM_LOCATION_LOST=PM_LOCATION_LOST_ZONE
PM_EFFECT_UPDATE_HP=PM_EFFECT_UPDATE_HIT_POINTS
PM_EVENT_TO_DPILE=PM_EVENT_TO_DISCARDPILE

--==========[+UniversalFunctions]==========
--functions that are included on every script
function Auxiliary.GetID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local scard=_G[str]
	local sid=tonumber(string.sub(str,2))
	return scard,sid
end
--include this code on each script: local scard,sid=pm.GetID()

--========== Card ==========
--check if a card is a Pokémon
function Card.IsPokemon(c)
	return c:IsType(PM_TYPE_POKEMON)
end
--check if a card is a Trainer
function Card.IsTrainer(c)
	return c:IsType(PM_TYPE_TRAINER) and not c:IsHasEffect(PM_EFFECT_REMOVE_TRAINER)
end
--check if a card is an Energy
function Card.IsEnergy(c)
	return c:IsType(PM_TYPE_ENERGY)
end
--check if a card is a Prize card + PM_LOCATION_PRIZE
function Card.IsPrize(c)
	return c:IsFacedown()
end
--check if a card is or was a type of Pokémon, Trainer or Energy
Card.IsSubType=Card.IsSetCard
Card.IsPreviousSubType=Card.IsPreviousSetCard
--check what a card's original type is
Card.IsOriginalSubType=Card.IsOriginalSetCard
--check if a card is a Basic Pokémon
function Card.IsBasicPokemon(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_BASIC_POKEMON)
end
--check if a card is an Evolution Pokémon
function Card.IsEvolution(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_EVOLUTION)
end
--check if a card is a Stage 1 Pokémon
function Card.IsStage1(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_STAGE_1)
end
--check if a card is a Stage 2 Pokémon
function Card.IsStage2(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_STAGE_2)
end
--check if a card is a Baby Pokémon
function Card.IsBabyPokemon(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_BABY_POKEMON)
end
--check if a card is a Pokémon-EX (Pokémon-ex)
function Card.IsPokemonEX(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_EX)
end
Card.IsPokemonEx=Card.IsPokemonEX
--check if a card is a Pokémon star
function Card.IsPokemonStar(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_POKEMON_STAR)
end
--check if a card is a Pokémon LV.X (Pokémon Level-Up)
function Card.IsPokemonLVX(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_LEVEL_UP)
end
--check if a card is a Pokémon SP
function Card.IsPokemonSP(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_SP)
end
--check if a card is a Pokémon LEGEND
function Card.IsPokemonLEGEND(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_LEGEND)
end
--check if a card is a Restored Pokémon
function Card.IsRestoredPokemon(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_RESTORED)
end
--check if a card is a Mega Evolution Pokémon
function Card.IsMegaEvolution(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_MEGA)
end
--check if a card is a Pokémon BREAK
function Card.IsPokemonBREAK(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_BREAK)
end
--check if a card is a Pokémon-GX
function Card.IsPokemonGX(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_GX)
end
--check if a pokémon has an owner
function Card.IsOwnerPokemon(c)
	return c:IsPokemon() and (c:IsSetCard(PM_SETNAME_MISTY)
		or c:IsSetCard(PM_SETNAME_BROCK) or c:IsSetCard(PM_SETNAME_ERIKA) or c:IsSetCard(PM_SETNAME_SABRINA)
		or c:IsSetCard(PM_SETNAME_LT_SURGE) or c:IsSetCard(PM_SETNAME_BLAINE) or c:IsSetCard(PM_SETNAME_GIOVANNI)
		or c:IsSetCard(PM_SETNAME_KOGA) or c:IsSetCard(PM_SETNAME_TEAM_MAGMA) or c:IsSetCard(PM_SETNAME_TEAM_AQUA)
		or c:IsSetCard(PM_SETNAME_ROCKETS)) --update with new owners here
end
--check if a card is a Stadium
function Card.IsStadium(c)
	return c:IsTrainer() and c:IsType(PM_TYPE_STADIUM)
end
--check if a card is an Item
function Card.IsItem(c)
	return c:IsTrainer() and c:IsSubType(PM_TYPE_ITEM)
end
--check if a card is a Pokémon Tool
function Card.IsPokemonTool(c)
	return c:IsTrainer() and c:IsSubType(PM_TYPE_POKEMON_TOOL)
end
--check if a card is an ACE SPEC
function Card.IsACESPEC(c)
	return c:IsTrainer() and c:IsSubType(PM_TYPE_ACE_SPEC)
end
--check if a card is a Goldenrod Game Corner
function Card.IsGoldenrodGameCorner(c)
	return c:IsTrainer() and c:IsSubType(PM_TYPE_GOLDENROD_GAME_CORNER)
end
--check if a card is a Supporter
function Card.IsSupporter(c)
	return c:IsTrainer() and c:IsSubType(PM_TYPE_SUPPORTER)
end
--check if a card is a Technical Machine
function Card.IsTechnicalMachine(c)
	return c:IsTrainer() and c:IsSubType(PM_TYPE_TECHNICAL_MACHINE)
end
--check if a card is a Rocket's Secret Machine
function Card.IsRocketsSecretMachine(c)
	return c:IsTrainer() and c:IsSubType(PM_TYPE_ROCKETS_SECRET_MACHINE)
end
--check if a card is a basic Energy
function Card.IsBasicEnergy(c)
	return c:IsEnergy() and c:IsSubType(PM_TYPE_BASIC_ENERGY)
end
--check what type of basic Energy a card is 
function Card.IsEnergyCard(c,energy)
	if energy then
		return c:IsEnergy() and c:IsCode(energy)
	else
		return c:IsEnergy() and c:IsCode(CARD_GRASS_ENERGY,CARD_FIRE_ENERGY,CARD_WATER_ENERGY,CARD_LIGHTNING_ENERGY,
		CARD_PSYCHIC_ENERGY,CARD_FIGHTING_ENERGY,CARD_DARKNESS_ENERGY,CARD_METAL_ENERGY,CARD_FAIRY_ENERGY)
	end
end
--check if a card is a [G] Energy
function Card.IsGrassEnergy(c)
	return c:IsEnergy() and c:IsCode(CARD_GRASS_ENERGY)
end
--check if a card is a [R] Energy
function Card.IsFireEnergy(c)
	return c:IsEnergy() and c:IsCode(CARD_FIRE_ENERGY)
end
--check if a card is a [W] Energy
function Card.IsWaterEnergy(c)
	return c:IsEnergy() and c:IsCode(CARD_WATER_ENERGY)
end
--check if a card is a [L] Energy
function Card.IsLightningEnergy(c)
	return c:IsEnergy() and c:IsCode(CARD_LIGHTNING_ENERGY)
end
--check if a card is a [P] Energy
function Card.IsPsychicEnergy(c)
	return c:IsEnergy() and c:IsCode(CARD_PSYCHIC_ENERGY)
end
--check if a card is a [F] Energy
function Card.IsFightingEnergy(c)
	return c:IsEnergy() and c:IsCode(CARD_FIGHTING_ENERGY)
end
--check if a card is a [D] Energy
function Card.IsDarknessEnergy(c)
	return c:IsEnergy() and c:IsCode(CARD_DARKNESS_ENERGY)
end
--check if a card is a [M] Energy
function Card.IsMetalEnergy(c)
	return c:IsEnergy() and c:IsCode(CARD_METAL_ENERGY)
end
--check if a card is a [C] Energy
function Card.IsColorlessEnergy(c)
	return c:IsEnergy() and c:IsCode(CARD_COLORLESS_ENERGY)
end
--check if a card is a [Y] Energy
function Card.IsFairyEnergy(c)
	return c:IsEnergy() and c:IsCode(CARD_FAIRY_ENERGY)
end
--check if a card is a Special Energy
function Card.IsSpecialEnergy(c)
	return c:IsEnergy() and c:IsSubType(PM_TYPE_SPECIAL)
end
--check if a card can only have one copy of itself in a player's deck
function Card.IsHasDeckRestriction(c)
	return c:IsHasEffect(PM_EFFECT_RESTRICT_MIRACLE_ENERGY) or c:IsHasEffect(PM_EFFECT_RESTRICT_ACE_SPEC)
		or c:IsHasEffect(PM_EFFECT_RESTRICT_POKEMON_STAR) --update with new effects here
end
--get the cards attached underneath another card
Card.GetAttachmentGroup=Card.GetOverlayGroup
--get a pokémon's CURRENT type (color)
Card.GetEnergyType=Card.GetAttribute
--get a pokémon's ORIGINAL type (color)
Card.GetOriginalEnergyType=Card.GetOriginalAttribute
--get the type (color) a pokémon had when it was on the field
Card.GetPreviousEnergyType=Card.GetPreviousAttributeOnField
--check what a pokémon's current type (color) is
Card.IsEnergyType=Card.IsAttribute
--check if a pokémon is active
function Card.IsActive(c)
	return c:IsLocation(LOCATION_MZONE) and c:GetSequence()>=SEQUENCE_EXTRA_MZONE
end
--check if a pokémon is on the bench
function Card.IsBench(c)
	return (c:IsLocation(LOCATION_MZONE) and c:GetSequence()<SEQUENCE_EXTRA_MZONE)
		--bench extended by "Sky Field ROS 89"
		or (c:IsLocation(LOCATION_SZONE) and c:GetSequence()~=SEQUENCE_FIRST_SZONE and c:GetSequence()~=SEQUENCE_FIELD_ZONE)
end
--check if a card is vertical
Card.IsUpside=Card.IsAttackPos
Card.IsFaceupUpside=aux.AND(Card.IsFaceup,Card.IsAttackPos)
Card.IsFacedownUpside=aux.AND(Card.IsFacedown,Card.IsAttackPos)
--check if a card is clockwise
Card.IsClockwise=Card.IsDefensePos
Card.IsFaceupClockwise=aux.AND(Card.IsFaceup,Card.IsDefensePos)
Card.IsFacedownClockwise=aux.AND(Card.IsFacedown,Card.IsDefensePos)
--check if a card is counter-clockwise
Card.IsCounterclockwise=Card.IsDefensePos
Card.IsFaceupCounterclockwise=aux.AND(Card.IsFaceup,Card.IsDefensePos)
Card.IsFacedownCounterclockwise=aux.AND(Card.IsFacedown,Card.IsDefensePos)
--check if a pokémon's retreat cost is n or less
Card.IsRetreatCostBelow=Card.IsLevelBelow
--check if a pokémon's retreat cost is n or more
Card.IsRetreatCostAbove=Card.IsLevelAbove
--get a pokémon's CURRENT retreat cost
Card.GetRetreatCost=Card.GetLevel
--get a pokémon's ORIGINAL retreat cost
Card.GetOriginalRetreatCost=Card.GetOriginalLevel
--get the retreat cost a pokémon had when it was on the field
Card.GetPreviousRetreatCostOnField=Card.GetPreviousLevelOnField
--get a card's CURRENT hit points
Card.GetHP=Card.GetAttack
--get a card's ORIGINAL hit points
Card.GetBaseHP=Card.GetBaseAttack
--get the hit points printed on a card
Card.GetTextHP=Card.GetTextAttack
--get the hit points a card had when it was on the field
Card.GetPreviousHPOnField=Card.GetPreviousAttackOnField
--check if a card's hit points is n or less
Card.IsHPBelow=Card.IsAttackBelow
--check if a card's hit points is n or more
Card.IsHPAbove=Card.IsAttackAbove
--put a marker on a card
Card.AddMarker=Card.AddCounter
--remove a marker from a card
Card.RemoveMarker=Card.RemoveCounter
--check if a card has a marker on it
Card.GetMarker=Card.GetCounter
--allow a card to have a marker put on it
Card.EnableMarkerPermit=Card.EnableCounterPermit
--limit the number of markers that can be put on a card
Card.SetMarkerLimit=Card.SetCounterLimit
--check if a marker can be put on a card
Card.IsCanAddMarker=Card.IsCanAddCounter
--check if a marker can be removed from a card
Card.IsCanRemoveMarker=Card.IsCanRemoveCounter
--check if a pokémon can be put in play
Card.IsCanBePutOnBench=Card.IsCanBeSpecialSummoned
--set the group underneath a card as attachments that belong to it
Card.SetAttachment=Card.SetMaterial
--check if a card can be put in the discard pile
Card.IsAbleToDiscardPile=Card.IsAbleToGrave
Card.IsAbleToDPile=Card.IsAbleToDiscardPile
--check if a card can be put in the discard pile as a cost
Card.IsAbleToDiscardPileAsCost=Card.IsAbleToGraveAsCost
Card.IsAbleToDPileAsCost=Card.IsAbleToDiscardPileAsCost
--prevent a card from being sent to the discard pile when it resolves
Card.CancelToDiscardPile=Card.CancelToGrave
Card.CancelToDPile=Card.CancelToDiscardPile
--check if a card is not public knowledge
Card.IsSecret=aux.NOT(Card.IsPublic)
--add the pokémon value to the non-pokémon card
Card.AddPokemonAttribute=Card.AddMonsterAttribute
Card.AddPokemonAttributeComplete=Card.AddMonsterAttributeComplete
--check if a pokémon can attack
function Card.IsCanAttack(c)
	return not (Duel.IsFirstTurn() or c:IsHasEffect(PM_EFFECT_CANNOT_ATTACK))
end
--check if an active pokémon can be retreated to the bench
function Card.IsRetreatable(c)
	local rc=c:GetRetreatCost()
	return Auxiliary.ActivePokemonFilter(c) and (c:GetAttachmentGroup():FilterCount(Card.IsEnergy,nil)>=rc or rc==0)
end
--========== Duel ==========
--set aside prize cards face-down
Duel.SetPrizeCard=Duel.Remove
--knock out a pokémon
Duel.KnockOut=Duel.Destroy
--get all attached cards in a specified location
Duel.GetAttachmentGroup=Duel.GetOverlayGroup
--send targets to the discard pile by discarding them
Duel.PDiscard=Duel.SendtoGrave
--send targets to the discard pile
Duel.SendtoDiscardPile=Duel.SendtoGrave
Duel.SendtoDPile=Duel.SendtoDiscardPile
--check if a player can put a marker on a card
Duel.IsCanAddMarker=Duel.IsCanAddCounter
--a player removes a marker from cards in play
Duel.RemoveMarker=Duel.RemoveCounter
--check if a player can remove a marker from cards in play
Duel.IsCanRemoveMarker=Duel.IsCanRemoveCounter
--get the number of markers that are on cards in play
Duel.GetMarker=Duel.GetCounter
--evolve a pokémon by playing it on top of another pokémon
Duel.Evolve=Duel.Overlay
--level up a pokémon by putting it on top of the active pokémon
Duel.LevelUp=Duel.Overlay
--attach a card to another card
Duel.Attach=Duel.Overlay
--a player puts a pokémon in play
Duel.PlayPokemon=Duel.SpecialSummon
Duel.PlayPokemonStep=Duel.SpecialSummonStep
Duel.PlayPokemonComplete=Duel.SpecialSummonComplete
--a player puts a pokémon onto their bench
Duel.PutOnBench=Duel.SpecialSummon
Duel.PutOnBenchStep=Duel.SpecialSummonStep
Duel.PutOnBenchComplete=Duel.SpecialSummonComplete
--check if a player can put a pokémon in play
Duel.IsPlayerCanPlayPokemon=Duel.IsPlayerCanSpecialSummonMonster
--check if a player can put a pokémon onto their bench
Duel.IsPlayerCanPutPokemonOnBench=Duel.IsPlayerCanSpecialSummonMonster
--check if it is the first turn of the game
function Duel.IsFirstTurn()
	return Duel.GetTurnCount()==1 or Duel.GetFlagEffect(tp,PM_EFFECT_SUDDEN_DEATH_RESTART)>0
end
--get a player's current prize cards
function Duel.GetPrizeGroup(tp,player)
	return Duel.GetMatchingGroup(Card.IsPrize,player,PM_LOCATION_PRIZE,0,nil)
end
--return the number of prize cards a player has
function Duel.GetPrizeGroupCount(tp,player)
	return Duel.GetPrizeGroup(tp,player):GetCount()
end
--let a player draw cards equal to or less than count with a reason and return the number of cards drawn
local dr=Duel.Draw
function Duel.Draw(player,count,reason)
	local count=count or 1
	local ct=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if count>ct then count=ct end
	return dr(player,count,reason)
end
--check if a player can draw cards according to the pokémon trading card game's rules
local ipcd=Duel.IsPlayerCanDraw
function Duel.IsPlayerCanDraw(player,count)
	local count=count or 1
	local ct=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if ct==0 then return end
	if count>ct then count=ct end
	return ipcd(player,count)
end

--==========[+RuleFunctions]==========
--functions that are included on the rules card
function Auxiliary.EnableProtection(c)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e1b=e1:Clone()
	e1b:SetCode(EFFECT_IMMUNE_EFFECT)
	e1b:SetValue(function(e,re)
		return re:GetHandler()~=e:GetHandler()
	end)
	c:RegisterEffect(e1b)
	--indestructible
	Auxiliary.EnableSingleIndestructible(c)
	--cannot release
	Auxiliary.EnableCannotRelease(c)
	--cannot be material
	Auxiliary.EnableCannotBeMaterial(c)
	--cannot change zone
	Auxiliary.EnableCannotChangeZone(c)
end
--indestructible (EFFECT_TYPE_SINGLE)
function Auxiliary.EnableSingleIndestructible(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e1b=e1:Clone()
	e1b:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	c:RegisterEffect(e1b)
	local e1c=e1:Clone()
	e1c:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e1c)
end
--cannot release
function Auxiliary.EnableCannotRelease(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UNRELEASABLE_SUM)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e1b=e1:Clone()
	e1b:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e1b)
	local e1c=e1:Clone()
	e1c:SetCode(EFFECT_UNRELEASABLE_EFFECT)
	c:RegisterEffect(e1c)
end
--cannot be material
function Auxiliary.EnableCannotBeMaterial(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e1b=e1:Clone()
	e1b:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e1b)
	local e1c=e1:Clone()
	e1c:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e1c)
	local e1d=e1:Clone()
	e1d:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	c:RegisterEffect(e1d)
end
--cannot change zone
function Auxiliary.EnableCannotChangeZone(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_TO_HAND)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(PM_LOCATION_RULES)
	c:RegisterEffect(e1)
	local e1b=e1:Clone()
	e1b:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e1b)
	local e1c=e1:Clone()
	e1c:SetCode(EFFECT_CANNOT_REMOVE) 
	c:RegisterEffect(e1c)
	local e1d=e1:Clone()
	e1d:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e1d)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_MONSTER_SSET)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e2)
	local e2b=e2:Clone()
	e2b:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e2b)
	local e2c=e2:Clone()
	e2c:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e2c)
	local e2d=e2:Clone()
	e2d:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e2d)
	local e2e=e2:Clone()
	e2e:SetCode(EFFECT_CANNOT_MSET)
	c:RegisterEffect(e2e)
	local e2f=e2:Clone()
	e2f:SetCode(EFFECT_CANNOT_SSET)
	c:RegisterEffect(e2f)
	local e2g=e2:Clone()
	e2g:SetCode(EFFECT_CANNOT_USE_AS_COST)
	c:RegisterEffect(e2g)
end
--remove type
function Auxiliary.EnableRemoveType(c,val,range)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_REMOVE_TYPE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	if range then e1:SetRange(range) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--cannot bp
function Auxiliary.EnableCannotBP(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(1,0)
	c:RegisterEffect(e1)
end
--infinite hand
function Auxiliary.EnableInfiniteHand(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_HAND_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(1,0)
	e1:SetValue(MAX_NUMBER)
	c:RegisterEffect(e1)
end
--cannot change position
function Auxiliary.EnableCannotChangePosition(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(LOCATION_MZONE,0)
	c:RegisterEffect(e1)
end
--rule: cannot attack (EFFECT_TYPE_FIELD)
function Auxiliary.EnableCannotAttack(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(function(e,c)
		return c:IsBench()
	end)
	c:RegisterEffect(e1)
end
--cannot direct attack
function Auxiliary.EnableCannotDirectAttack(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(LOCATION_MZONE,0)
	c:RegisterEffect(e1)
end
--indestructible (EFFECT_TYPE_FIELD)
function Auxiliary.EnableIndestructible(c,code1,...)
	--code1,...: EFFECT_INDESTRUCTABLE, EFFECT_INDESTRUCTABLE_EFFECT and/or EFFECT_INDESTRUCTABLE_BATTLE
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(code1)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	for i,code in ipairs{...} do
		local e2=e1:Clone()
		e2:SetCode(code)
		c:RegisterEffect(e2)
	end
end
--no battle damage
function Auxiliary.EnableNoBattleDamage(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	c:RegisterEffect(e2)
end
--no effect damage
function Auxiliary.EnableNoEffectDamage(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(1,0)
	e1:SetValue(function(e,re,val,r,rp,rc)
		if bit.band(r,REASON_EFFECT)~=0 then return 0 end
		return val
	end)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_NO_EFFECT_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(PM_LOCATION_RULES)
	e2:SetTargetRange(1,0)
	c:RegisterEffect(e2)
end
--cannot summon/mset
function Auxiliary.EnableCannotSummonMSet(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(1,0)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_MSET)
	c:RegisterEffect(e2)
end
--cannot sset
function Auxiliary.EnableCannotSSet(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SSET)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(1,0)
	c:RegisterEffect(e1)
end

--==========[+Pokémon]==========
--Pokémon card
function Auxiliary.EnablePokemonAttribute(c)
	c:SetMarkerLimit(PM_BURN_MARKER,1)
	c:SetMarkerLimit(PM_POISON_MARKER,1)
	--bench
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(PM_EFFECT_BENCH_PROC)
	e1:SetProperty(PM_EFFECT_FLAG_BENCH_PARAM+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(PM_POS_FACEUP_UPSIDE,0)
	e1:SetCondition(Auxiliary.BenchCondition)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--retreat
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(PM_DESC_RETREAT)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(PM_LOCATION_ACTIVE)
	e2:SetCondition(Auxiliary.RetreatCondition)
	e2:SetCost(Auxiliary.RetreatCost)
	e2:SetTarget(Auxiliary.HintTarget)
	e2:SetOperation(Auxiliary.RetreatOperation)
	c:RegisterEffect(e2)
end
function Auxiliary.BenchCondition(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,PM_LOCATION_BENCH)>0 and c:IsBasicPokemon()
end
function Auxiliary.RetreatCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,PM_EFFECT_RETREAT)==0 and e:GetHandler():IsRetreatable()
end
function Auxiliary.RetreatCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Auxiliary.BenchPokemonFilter,tp,PM_LOCATION_BENCH,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_PROMOTE)
	local g=Duel.SelectMatchingCard(tp,Auxiliary.BenchPokemonFilter,tp,PM_LOCATION_BENCH,0,1,1,nil)
	Duel.HintSelection(g)
	g:KeepAlive()
	e:SetLabelObject(g)
	local c=e:GetHandler()
	local og=c:GetAttachmentGroup()
	local rc=c:GetRetreatCost()
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARDENERGY)
	local sog=og:FilterSelect(tp,Card.IsEnergy,rc,rc,nil)
	Duel.PDiscard(sog,REASON_COST+REASON_DISCARD)
end
function Auxiliary.RetreatOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=e:GetLabelObject()
	if g:GetCount()==0 then return end
	Duel.SwapSequence(c,g:GetFirst())
	Duel.RegisterFlagEffect(tp,PM_EFFECT_RETREAT,RESET_PHASE+PHASE_END,0,1)
end

--==========[+Energy]==========
--Energy card
function Auxiliary.EnableEnergyAttribute(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(PM_DESC_ENERGY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(Auxiliary.EnergyTarget)
	e1:SetOperation(Auxiliary.EnergyOperation)
	c:RegisterEffect(e1)
end
function Auxiliary.EnergyFilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function Auxiliary.EnergyTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Auxiliary.EnergyFilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
end
function Auxiliary.EnergyOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ATTACHENERGY)
	local g=Duel.SelectMatchingCard(tp,Auxiliary.EnergyFilter,tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Attach(g:GetFirst(),Group.FromCards(e:GetHandler()))
end

--==========[+Trainer]==========
--Trainer card
function Auxiliary.EnableTrainerActivate(c,cate,targ_func,op_func,con_func,cost_func,prop)
	--activate
	local e1=Effect.CreateEffect(c)
	if cate then e1:SetCategory(cate) end
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	if prop then e1:SetProperty(prop) end
	if con_func then e1:SetCondition(con_func) end
	if cost_func then e1:SetCost(cost_func) end
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
	if not c.old_supporter then return end
	--remain field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e2)
	--self discard
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(PM_LOCATION_ADJACENT_ACTIVE)
	e3:SetCondition(Auxiliary.TrainerDiscardCondition)
	e3:SetOperation(Auxiliary.TrainerDiscardOperation)
	c:RegisterEffect(e3)
end
function Auxiliary.TrainerDiscardCondition(e)
	return e:GetHandler():IsOnField() and Duel.GetTurnPlayer()==e:GetHandlerPlayer()
end
function Auxiliary.TrainerDiscardOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDPile(e:GetHandler(),REASON_RULE)
end

--==========[+Attack]==========
--Pokémon attack
function Auxiliary.EnablePokemonAttack(c,desc_id,cate,con_func,targ_func,op_func,cost_func,prop)
	--con_func: include Card.IsActive and Card.IsCanAttack
	--targ_func: include Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	if cate then e1:SetCategory(cate) end
	e1:SetType(EFFECT_TYPE_IGNITION)
	if prop then
		e1:SetProperty(PM_EFFECT_FLAG_POKEMON_ATTACK+prop)
	else
		e1:SetProperty(PM_EFFECT_FLAG_POKEMON_ATTACK)
	end
	e1:SetRange(PM_LOCATION_ACTIVE)
	if con_func then e1:SetCondition(con_func) end
	if cost_func then e1:SetCost(cost_func) end
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end

--==========[+Ability]==========
--Pokémon ability
function Auxiliary.EnablePokemonAbility(c,desc_id,cate,targ_func,op_func,con_func,count,cost_func,prop)
	--targ_func: include Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(c:GetOriginalCode(),desc_id))
	if cate then e1:SetCategory(cate) end
	e1:SetType(EFFECT_TYPE_IGNITION)
	if prop then e1:SetProperty(prop) end
	e1:SetRange(PM_LOCATION_IN_PLAY)
	if count then
		e1:SetCountLimit(count)
	else
		e1:SetCountLimit(1)
	end
	if con_func then e1:SetCondition(con_func) end
	if cost_func then e1:SetCost(cost_func) end
	if targ_func then e1:SetTarget(targ_func) end
	e1:SetOperation(op_func)
	c:RegisterEffect(e1)
end

--==========[+Conditions]==========
--condition for a player's turn
function Auxiliary.TurnPlayerCondition(p)
	return	function(e)
				local tp=e:GetHandlerPlayer()
				local player=nil
				if p==PLAYER_PLAYER or p==tp then player=tp
				elseif p==PLAYER_OPPONENT or p==1-tp then player=1-tp end
				return Duel.GetTurnPlayer()==player
			end
end
Auxiliary.turnpcon=Auxiliary.TurnPlayerCondition
--condition for attacks with an Energy Cost of 1 Energy
function Auxiliary.AttackCostCondition1(ener1,count1)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local ct1=c:GetAttachmentGroup():FilterCount(Card.IsEnergyCard,nil,ener1)
				local ct2=c:GetAttachmentGroup():FilterCount(Card.IsBasicEnergy,nil)
				local ct3=c:GetAttachmentGroup():FilterCount(Card.IsCode,nil,CARD_DOUBLE_COLORLESS_ENERGY)*2
				if ener1==CARD_COLORLESS_ENERGY then ct1=0 end
				return Auxiliary.ActivePokemonFilter(c) and c:IsCanAttack()
					and (ct1>0 or ct2>0 or ct3>0) and ct1+ct2+ct3>=count1
			end
end
Auxiliary.econ1=Auxiliary.AttackCostCondition1
--condition for attacks with an Energy Cost of 2 different Energy
function Auxiliary.AttackCostCondition2(ener1,count1,ener2,count2)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local sum=count1+count2
				local c=e:GetHandler()
				local g1=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,nil,ener1)
				local g2=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,g1,ener2)
				local g3=c:GetAttachmentGroup():Filter(Card.IsBasicEnergy,g1)
				local g4=c:GetAttachmentGroup():Filter(Card.IsCode,nil,CARD_DOUBLE_COLORLESS_ENERGY)
				local ct1=g1:GetCount()
				local ct2=g2:GetCount()
				local ct3=g3:GetCount()
				local ct4=g4:GetCount()*2
				if ener1==CARD_COLORLESS_ENERGY then ct1=0
				elseif ener2==CARD_COLORLESS_ENERGY then ct2=0 end
				return Auxiliary.ActivePokemonFilter(c) and c:IsCanAttack()
					and (ct1>0 or ct2>0 or ct3>0 or ct4>0) and ct1+ct2+ct3+ct4>=sum
			end
end
Auxiliary.econ2=Auxiliary.AttackCostCondition2
--condition for attacks with an Energy Cost of 3 different Energy
function Auxiliary.AttackCostCondition3(ener1,count1,ener2,count2,ener3,count3)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local sum=count1+count2+count3
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				local g1=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,nil,ener1)
				exg:Merge(g1)
				local g2=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,g1,ener2)
				exg:Merge(g2)
				local g3=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,exg,ener3)
				local g4=c:GetAttachmentGroup():Filter(Card.IsBasicEnergy,exg)
				local g5=c:GetAttachmentGroup():Filter(Card.IsCode,nil,CARD_DOUBLE_COLORLESS_ENERGY)
				local ct1=g1:GetCount()
				local ct2=g2:GetCount()
				local ct3=g3:GetCount()
				local ct4=g4:GetCount()
				local ct5=g5:GetCount()*2
				if ener1==CARD_COLORLESS_ENERGY then ct1=0
				elseif ener2==CARD_COLORLESS_ENERGY then ct2=0
				elseif ener3==CARD_COLORLESS_ENERGY then ct3=0 end
				return Auxiliary.ActivePokemonFilter(c) and c:IsCanAttack()
					and (ct1>0 or ct2>0 or ct3>0 or ct4>0 or ct5>0) and ct1+ct2+ct3+ct4+ct5>=sum
			end
end
Auxiliary.econ3=Auxiliary.AttackCostCondition3
--condition for attacks with an Energy Cost of 4 different Energy
function Auxiliary.AttackCostCondition4(ener1,count1,ener2,count2,ener3,count3,ener4,count4)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local sum=count1+count2+count3+count4
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				local g1=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,nil,ener1)
				exg:Merge(g1)
				local g2=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,g1,ener2)
				exg:Merge(g2)
				local g3=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,exg,ener3)
				exg:Merge(g3)
				local g4=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,exg,ener4)
				local g5=c:GetAttachmentGroup():Filter(Card.IsBasicEnergy,exg)
				local g6=c:GetAttachmentGroup():Filter(Card.IsCode,nil,CARD_DOUBLE_COLORLESS_ENERGY)
				local ct1=g1:GetCount()
				local ct2=g2:GetCount()
				local ct3=g3:GetCount()
				local ct4=g4:GetCount()
				local ct5=g5:GetCount()
				local ct6=g6:GetCount()*2
				if ener1==CARD_COLORLESS_ENERGY then ct1=0
				elseif ener2==CARD_COLORLESS_ENERGY then ct2=0
				elseif ener3==CARD_COLORLESS_ENERGY then ct3=0
				elseif ener4==CARD_COLORLESS_ENERGY then ct4=0 end
				return Auxiliary.ActivePokemonFilter(c) and c:IsCanAttack()
					and (ct1>0 or ct2>0 or ct3>0 or ct4>0 or ct5>0 or ct6>0) and ct1+ct2+ct3+ct4+ct5+ct6>=sum
			end
end
Auxiliary.econ4=Auxiliary.AttackCostCondition4
--condition for attacks with an Energy Cost of 5 different energy
function Auxiliary.AttackCostCondition5(ener1,count1,ener2,count2,ener3,count3,ener4,count4,ener5,count5)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local sum=count1+count2+count3+count4+count5
				local c=e:GetHandler()
				local exg=Group.CreateGroup()
				local g1=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,nil,ener1)
				exg:Merge(g1)
				local g2=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,g1,ener2)
				exg:Merge(g2)
				local g3=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,exg,ener3)
				exg:Merge(g3)
				local g4=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,exg,ener4)
				exg:Merge(g4)
				local g5=c:GetAttachmentGroup():Filter(Card.IsEnergyCard,exg,ener5)
				local g6=c:GetAttachmentGroup():Filter(Card.IsBasicEnergy,exg)
				local g7=c:GetAttachmentGroup():Filter(Card.IsCode,nil,CARD_DOUBLE_COLORLESS_ENERGY)
				local ct1=g1:GetCount()
				local ct2=g2:GetCount()
				local ct3=g3:GetCount()
				local ct4=g4:GetCount()
				local ct5=g5:GetCount()
				local ct6=g6:GetCount()
				local ct7=g7:GetCount()*2
				if ener1==CARD_COLORLESS_ENERGY then ct1=0
				elseif ener2==CARD_COLORLESS_ENERGY then ct2=0
				elseif ener3==CARD_COLORLESS_ENERGY then ct3=0
				elseif ener4==CARD_COLORLESS_ENERGY then ct4=0
				elseif ener5==CARD_COLORLESS_ENERGY then ct5=0 end
				return Auxiliary.ActivePokemonFilter(c) and c:IsCanAttack()
					and (ct1>0 or ct2>0 or ct3>0 or ct4>0 or ct5>0 or ct6>0 or ct7>0) and ct1+ct2+ct3+ct4+ct5+ct6+ct7>=sum
			end
end
Auxiliary.econ5=Auxiliary.AttackCostCondition5

--==========[+Targets]==========
--target for Duel.Hint(hint,player,desc) only
function Auxiliary.HintTarget(e,tp,eg,ep,ev,re,r,rp,chk,hint,p,desc)
	hint=hint or HINT_OPSELECTED
	p=p or 1-tp
	desc=desc or e:GetDescription()
	local player=nil
	if p==PLAYER_PLAYER or p==tp then player=tp
	elseif p==PLAYER_OPPONENT or p==1-tp then player=1-tp end
	if chk==0 then return true end
	Duel.Hint(hint,player,desc)
end
Auxiliary.hinttg=Auxiliary.HintTarget

--==========[+Filters]==========
--filter for the active pokémon + PM_LOCATION_ACTIVE
function Auxiliary.ActivePokemonFilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsActive()
end
--filter for pokémon on the bench + PM_LOCATION_BENCH
function Auxiliary.BenchPokemonFilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsBench()
end
return Auxiliary
