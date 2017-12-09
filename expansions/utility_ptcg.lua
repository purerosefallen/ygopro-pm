--[[
	Pokémon Trading Card Game Utility

	Usage: Put this file in the expansions folder
	
	Include the following code in your script
	
	local pm=require "expansions.utility_ptcg"
]]

--CONTENTS
--[+UniversalFunctions]......................................functions that are included on every script

local Auxiliary={}
local PTCG=require "expansions.constant_ptcg"
PM_LOCATION_ACTIVE=PM_LOCATION_ACTIVE_POKEMON
PM_LOCATION_DPILE=PM_LOCATION_DISCARD_PILE
PM_LOCATION_PRIZE=PM_LOCATION_PRIZE_CARDS
PM_LOCATION_LOST=PM_LOCATION_LOST_ZONE
PM_REASON_KO=PM_REASON_KNOCKED_OUT

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
function Card.IsGoldenRodGameCorner(c)
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
--check if a card is a Basic Energy
function Card.IsBasicEnergy(c)
	return c:IsEnergy() and c:IsSubType(PM_TYPE_BASIC_ENERGY)
end
--check if a card is a Special Energy
function Card.IsSpecialEnergy(c)
	return c:IsEnergy() and c:IsSubType(PM_TYPE_SPECIAL)
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
Card.IsFaceupActive=aux.AND(Card.IsFaceup,Card.IsActive)
Card.IsFacedownActive=aux.AND(Card.IsFacedown,Card.IsActive)
--check if a pokémon is on the bench
function Card.IsBench(c)
	return c:IsLocation(LOCATION_MZONE) and c:GetSequence()<SEQUENCE_EXTRA_MZONE
end
Card.IsFaceupBench=aux.AND(Card.IsFaceup,Card.IsBench)
Card.IsFacedownBench=aux.AND(Card.IsFacedown,Card.IsBench)
--check if a card is vertical
Card.IsUpside=Card.IsAttackPos
--check if a card is horizontal
Card.IsCounterclockwise=Card.IsDefensePos
Card.IsFaceupCounterclockwise=aux.AND(Card.IsFaceup,Card.IsDefensePos)
Card.IsFacedownCounterclockwise=aux.AND(Card.IsFacedown,Card.IsDefensePos)
Card.IsFaceupDefense=aux.AND(Card.IsFaceup,Card.IsDefensePos)
Card.IsFacedownDefense=aux.AND(Card.IsFacedown,Card.IsDefensePos)
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
--put a counter on a card
Card.AddCounter=Card.AddCounter
--put a marker on a card
Card.AddMarker=Card.AddCounter
--remove a counter from a card
Card.RemoveCounter=Card.RemoveCounter
--remove a marker from a card
Card.RemoveMarker=Card.RemoveCounter
--check if a card has a counter on it
Card.GetCounter=Card.GetCounter
--check if a card has a marker on it
Card.GetMarker=Card.GetCounter
--allow a card to have a counter put on it
Card.EnableCounterPermit=Card.EnableCounterPermit
--allow a card to have a marker put on it
Card.EnableMarkerPermit=Card.EnableCounterPermit
--limit the number of counters that can be put on a card
Card.SetCounterLimit=Card.SetCounterLimit
--limit the number of markers that can be put on a card
Card.SetMarkerLimit=Card.SetCounterLimit
--check if a counter can be put on a card
Card.IsCanAddCounter=Card.IsCanAddCounter
--check if a marker can be put on a card
Card.IsCanAddMarker=Card.IsCanAddCounter
--check if a counter can be removed from a card
Card.IsCanRemoveCounter=Card.IsCanRemoveCounter
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
--========== Duel ==========
--get all attached cards in a specified location
Duel.GetAttachmentGroup=Duel.GetOverlayGroup
--send targets to the discard pile by discarding them
Duel.PDiscard=Duel.SendtoGrave
--send targets to the discard pile
Duel.SendtoDiscardPile=Duel.SendtoGrave
Duel.SendtoDPile=Duel.SendtoDiscardPile
--check if a player can put a counter on a card
Duel.IsCanAddCounter=Duel.IsCanAddCounter
--check if a player can put a marker on a card
Duel.IsCanAddMarker=Duel.IsCanAddCounter
--a player removes a counter from cards in play
Duel.RemoveCounter=Duel.RemoveCounter
--a player removes a marker from cards in play
Duel.RemoveMarker=Duel.RemoveCounter
--check if a player can remove a counter from cards in play
Duel.IsCanRemoveCounter=Duel.IsCanRemoveCounter
--check if a player can remove a marker from cards in play
Duel.IsCanRemoveMarker=Duel.IsCanRemoveCounter
--get the number of counters that are on cards in play
Duel.GetCounter=Duel.GetCounter
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
--get a player's current prize cards
function Duel.GetPrizeGroup(tp,player)
	local lc=Duel.GetMatchingGroup(Auxiliary.PrizeCardsFilter,player,PM_LOCATION_PRIZE,0,nil):GetFirst()
	if not lc then return end
	return lc:GetAttachmentGroup()
end
--let a player draw cards equal to or less than count with a reason and return the number of cards drawn
local dr=Duel.Draw
function Duel.Draw(player,count,reason)
	local ct=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if count>ct then count=ct end
	return dr(player,count,reason)
end
--check if a player can draw cards according to the pokémon trading card game's rules
local ipcd=Duel.IsPlayerCanDraw
function Duel.IsPlayerCanDraw(player,count)
	local ct=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if ct==0 then return end
	if count>ct then count=ct end
	return ipcd(player,count)
end
return Auxiliary
