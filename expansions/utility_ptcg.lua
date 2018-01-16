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
--[+Evolution]...............................................functions that are included on every Evolution card
--[+LVX].....................................................functions that are included on every Pokémon LV.X card
--[+Energy]..................................................functions that are included on every Energy card
--[+Trainer].................................................functions that are included on every Trainer card
--[+Attack]..................................................attacks that are shared by many pokémon
--[+Ability].................................................effects that are shared by many cards
--[+SpecialCondition]........................................asleep, burned, confused, paralyzed and poisoned
--[+Conditions]..............................................condition functions
--[+Costs]...................................................cost functions
--[+Targets].................................................target functions
--[+Filters].................................................filter functions
--[+Lists]...................................................lists of data that are included on many cards

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
--check if a card is an Energy (or what type of Energy a card is)
function Card.IsEnergy(c,energy)
	if energy then
		return c:IsType(PM_TYPE_ENERGY) and c:IsCode(energy)
	else
		return c:IsType(PM_TYPE_ENERGY)
	end
end
--check if a card is a Prize card + PM_LOCATION_PRIZE
function Card.IsPrize(c)
	return c:GetFlagEffect(PM_EFFECT_PRIZE_CARD)~=0
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
--check if a card is a Pokémon-ex
function Card.IsPokemonex(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_EX_OLD)
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
--check if a card is a Pokémon-EX
function Card.IsPokemonEX(c)
	return c:IsPokemon() and c:IsSubType(PM_TYPE_EX)
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
	return c:IsPokemon() and (c:IsSetCard(PM_SETNAME_OWNER)
		or c:IsSetCard(PM_SETNAME_MISTY) or c:IsSetCard(PM_SETNAME_BROCK) or c:IsSetCard(PM_SETNAME_ERIKA)
		or c:IsSetCard(PM_SETNAME_SABRINA) or c:IsSetCard(PM_SETNAME_LT_SURGE) or c:IsSetCard(PM_SETNAME_BLAINE)
		or c:IsSetCard(PM_SETNAME_GIOVANNI) or c:IsSetCard(PM_SETNAME_KOGA) or c:IsSetCard(PM_SETNAME_TEAM_MAGMA)
		or c:IsSetCard(PM_SETNAME_TEAM_AQUA) or c:IsSetCard(PM_SETNAME_ROCKETS)) --update with new owners here
end
--check if a pokémon has a Pokémon Power/Ability
function Card.IsHasAbility(c)
	return c:IsType(PM_TYPE_ABILITY)
end
--check if a pokémon has an Ancient Trait
function Card.IsHasAncientTrait(c)
	return c:IsType(PM_TYPE_ANCIENT_TRAIT)
end
--check if a pokémon has a Poké-Body
function Card.IsHasPokeBody(c)
	return c:IsType(PM_TYPE_POKE_BODY)
end
--check if a pokémon has a Poké-Power
function Card.IsHasPokePower(c)
	return c:IsType(PM_TYPE_POKE_POWER)
end
--check what type of Weakness a pokémon has
function Card.IsHasWeakness(c,weak)
	return (c.weakness_x2 and c.weakness_x2==weak)
		or (c.weakness_10 and c.weakness_10==weak)
		or (c.weakness_20 and c.weakness_20==weak)
		or (c.weakness_30 and c.weakness_30==weak)
		or (c.weakness_40 and c.weakness_40==weak)
		--update with new weakness here
end
--check what type of Resistance a pokémon has
function Card.IsHasResistance(c,resist)
	return (c.resistance_20 and c.resistance_20==resist)
		or (c.resistance_30 and c.resistance_30==resist)
		--update with new resistance here
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
--check if an Energy card provides [W][W]
function Card.IsDoubleWaterEnergy(c)
	return c:IsEnergy() and c:IsSetCard(PM_TYPE_DOUBLE_WATER_ENERGY)
end
--check if an Energy card provides [F][F]
function Card.IsDoubleFightingEnergy(c)
	return c:IsEnergy() and c:IsSetCard(PM_TYPE_DOUBLE_FIGHTING_ENERGY)
end
--check if an Energy card provides [C][C]
function Card.IsDoubleColorlessEnergy(c)
	return c:IsEnergy() and c:IsSetCard(PM_TYPE_DOUBLE_COLORLESS_ENERGY)
end
--check if a card can only have one copy of itself in a player's deck
function Card.IsHasDeckRestriction(c)
	return c:IsHasEffect(PM_EFFECT_RESTRICT_MIRACLE_ENERGY) or c:IsHasEffect(PM_EFFECT_RESTRICT_ACE_SPEC)
		or c:IsHasEffect(PM_EFFECT_RESTRICT_POKEMON_STAR) --update with new effects here
end
--get the cards attached to a card
Card.GetAttachmentGroup=Card.GetOverlayGroup
--get the number of cards attached to a card
Card.GetAttachmentCount=Card.GetOverlayCount
--get the card the attached cards are attached to
Card.GetAttachmentTarget=Card.GetOverlayTarget
--get a pokémon's CURRENT type (color)
Card.GetPokemonType=Card.GetAttribute
--get a pokémon's ORIGINAL type (color)
Card.GetOriginalPokemonType=Card.GetOriginalAttribute
--get the type (color) a pokémon had when it was on the field
Card.GetPreviousPokemonType=Card.GetPreviousAttributeOnField
--check what a pokémon's current type (color) is
Card.IsPokemonType=Card.IsAttribute
--check if a pokémon is active
function Card.IsActive(c)
	return c:IsLocation(LOCATION_MZONE) and c:GetSequence()>=SEQUENCE_EXTRA_MZONE
end
--check if a pokémon is on the bench
function Card.IsBench(c)
	return (c:IsLocation(LOCATION_MZONE) and c:GetSequence()<SEQUENCE_EXTRA_MZONE)
		--extend bench by "Sky Field ROS 89"
		or (c:IsLocation(LOCATION_SZONE) and c:GetSequence()~=SEQUENCE_FIELD_ZONE)
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
--get the player who put the pokémon in play
Card.GetPlayPlayer=Card.GetSummonPlayer
--check if a pokémon can be put in play
Card.IsCanBePutInPlay=Card.IsCanBeSpecialSummoned
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
--check if a pokémon is asleep
function Card.IsAsleep(c)
	return c:GetFlagEffect(PM_EFFECT_ASLEEP)~=0 and c:IsPosition(PM_POS_FACEUP_COUNTERCLOCKWISE)
end
--check if a pokémon is burned
function Card.IsBurned(c)
	return c:GetFlagEffect(PM_EFFECT_BURNED)~=0 and c:GetMarker(PM_BURN_MARKER)~=0
end
--check if a pokémon is confused
function Card.IsConfused(c)
	return c:GetFlagEffect(PM_EFFECT_CONFUSED)~=0
end
--check if a pokémon is paralyzed
function Card.IsParalyzed(c)
	return c:GetFlagEffect(PM_EFFECT_PARALYZED)~=0 and c:IsPosition(PM_POS_FACEUP_CLOCKWISE)
end
--check if a pokémon is poisoned
function Card.IsPoisoned(c)
	return c:GetFlagEffect(PM_EFFECT_POISONED)~=0 and c:GetMarker(PM_POISON_MARKER)~=0
end
--check if a pokémon is affected by a special condition
function Card.IsAffectedBySpecialCondition(c)
	return c:IsAsleep() or c:IsBurned() or c:IsConfused() or c:IsParalyzed() or c:IsPoisoned()
end
--check if a pokémon can be asleep
function Card.IsCanBeAsleep(c)
	return not c:IsHasEffect(PM_EFFECT_CANNOT_BE_ASLEEP)
end
--check if a pokémon can be burned
function Card.IsCanBeBurned(c)
	return not c:IsHasEffect(PM_EFFECT_CANNOT_BE_BURNED)
end
--check if a pokémon can be confused
function Card.IsCanBeConfused(c)
	return not c:IsHasEffect(PM_EFFECT_CANNOT_BE_CONFUSED)
end
--check if a pokémon can be paralyzed
function Card.IsCanBeParalyzed(c)
	return not c:IsHasEffect(PM_EFFECT_CANNOT_BE_PARALYZED)
end
--check if a pokémon can be poisoned
function Card.IsCanBePoisoned(c)
	return not c:IsHasEffect(PM_EFFECT_CANNOT_BE_POISONED)
end
--check if a pokémon can be affected by a special condition
--reserved
function Card.IsCanBeAffectedBySpecialCondition(c)
	return c:IsCanBeAsleep() and c:IsCanBeBurned() and c:IsCanBeConfused() and c:IsCanBeParalyzed() and c:IsCanBePoisoned()
end
--check if a pokémon can attack
function Card.IsCanAttack(c)
	return not (Duel.IsFirstTurn() or c:IsAsleep() or c:IsParalyzed() or c:IsHasEffect(PM_EFFECT_CANNOT_ATTACK))
end
--check if an active pokémon can be retreated to the bench
function Card.IsRetreatable(c)
	local rc=c:GetRetreatCost()
	local ct=c:GetAttachmentGroup():FilterCount(Card.IsEnergy,nil)
	if c:IsHasEffect(PM_EFFECT_NO_RETREAT_COST) then rc=0 end
	if c:IsHasEffect(PM_EFFECT_RETREAT_COST_REPLACE) then
		ct=c:GetAttachmentGroup():FilterCount(Card.IsHasEffect,nil,PM_EFFECT_RETREAT_COST_REPLACE)
	end
	if c:IsAsleep() or c:IsParalyzed() or c:IsHasEffect(PM_EFFECT_CANNOT_RETREAT) then
		return false
	else
		return Auxiliary.ActivePokemonFilter(c) and (ct>=rc or rc==0)
	end
end
--check if a pokémon can have an attached energy card to it removed by an attack or trainer card
function Card.IsAbleToRemoveEnergy(c)
	return not c:IsHasEffect(PM_EFFECT_CANNOT_REMOVE_ENERGY_ATTACK_TRAINER)
end
--check if a pokémon is unaffected by all effects of attacks, including damage
function Card.IsImmuneToAttack(c)
	if c:IsHasEffect(PM_EFFECT_IMMUNE_ATTACK) then return true end
	return false
end
--check if a pokémon is unaffected by damage done by attacks
function Card.IsImmuneToAttackDamage(c)
	if c:IsHasEffect(PM_EFFECT_IMMUNE_ATTACK_DAMAGE) then return true end
	return false
end
--check if a pokémon is unaffected by all effects of attacks, except damage
function Card.IsImmuneToAttackEffect(c)
	if c:IsHasEffect(PM_EFFECT_IMMUNE_ATTACK_EFFECT) then return true end
	return false
end
--check if a pokémon is unaffected by all damage
function Card.IsImmuneToDamage(c)
	if c:IsHasEffect(PM_EFFECT_IMMUNE_DAMAGE) then return true end
	return false
end
--========== Duel ==========
--let a player draw cards equal to or less than count with a reason and return the number of cards drawn
local duel_draw=Duel.Draw
function Duel.Draw(player,count,reason)
	local count=count or 1
	local ct=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if count>ct and reason~=REASON_RULE then count=ct end
	return duel_draw(player,count,reason)
end
--check if a player can draw cards according to the pokémon trading card game's rules
local duel_is_player_can_draw=Duel.IsPlayerCanDraw
function Duel.IsPlayerCanDraw(player,count)
	local count=count or 1
	local ct=Duel.GetFieldGroupCount(player,LOCATION_DECK,0)
	if ct==0 then return end
	if count>ct then count=ct end
	return duel_is_player_can_draw(player,count)
end
--set aside prize cards face-down
Duel.SetPrizeCard=Duel.Remove
--knock out a pokémon
Duel.KnockOut=Duel.Destroy
--get all attached cards in a specified location
Duel.GetAttachmentGroup=Duel.GetOverlayGroup
--get a player's stadium card
Duel.GetStadiumCard=Duel.GetFieldCard
--send targets to the discard pile (discard them)
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
Duel.PutInPlay=Duel.SpecialSummon
Duel.PutInPlayStep=Duel.SpecialSummonStep
Duel.PutInPlayComplete=Duel.SpecialSummonComplete
--check if a player can put a pokémon in play
Duel.IsPlayerCanPutPokemonInPlay=Duel.IsPlayerCanSpecialSummonMonster
--a player's active pokémon attacks the opponent's defending pokémon
Duel.PokemonAttack=Duel.CalculateDamage
--negate a pokémon's attack
Duel.NegatePokemonAttack=Duel.NegateActivation
--check if it is the first turn of the game
function Duel.IsFirstTurn()
	return Duel.GetTurnCount()==1
		or Duel.GetFlagEffect(0,PM_EFFECT_SUDDEN_DEATH_RESTART)>0
		or Duel.GetFlagEffect(1,PM_EFFECT_SUDDEN_DEATH_RESTART)>0
end
--get a player's current prize cards
function Duel.GetPrizeGroup(tp,player)
	return Duel.GetMatchingGroup(Card.IsPrize,player,PM_LOCATION_PRIZE,0,nil)
end
--return the number of prize cards a player has
function Duel.GetPrizeGroupCount(tp,player)
	return Duel.GetPrizeGroup(tp,player):GetCount()
end
--get the active pokémon that does the attack
function Duel.GetAttackingPokemon()
	return Duel.GetFirstMatchingCard(Auxiliary.ActivePokemonFilter,Duel.GetTurnPlayer(),PM_LOCATION_ACTIVE,0,nil)
end
--get the active pokémon that receives the attack
function Duel.GetDefendingPokemon()
	return Duel.GetFirstMatchingCard(Auxiliary.ActivePokemonFilter,Duel.GetTurnPlayer(),0,PM_LOCATION_ACTIVE,nil)
end
--put a damage counter on the defending pokémon for each 10 damage the attacking pokémon's attack does
function Duel.AttackDamage(count,targets,weak,resist,effect)
	--count: attack damage
	--targets: the target for the pokémon attack
	--weak: false to not apply weakness to the defending pokémon
	--resist: false to not apply resistance to the defending pokémon
	--effect: false to not apply effects on the defending pokémon
	local a=Duel.GetAttackingPokemon()
	local d=Duel.GetDefendingPokemon()
	count=count/10
	targets=targets or d
	local weak=weak or true
	local resist=resist or true
	local effect=effect or true
	local turnp=Duel.GetTurnPlayer()
	Duel.PokemonAttack(a,Duel.GetDefendingPokemon())
	local energy=a:GetPokemonType()
	local weakness_x2=d.weakness_x2==energy
	local weakness_10=d.weakness_10==energy
	local weakness_20=d.weakness_20==energy
	local weakness_30=d.weakness_30==energy
	local weakness_40=d.weakness_40==energy
	local resistance_20=d.resistance_20==energy
	local resistance_30=d.resistance_30==energy
	local ct=count
	local typ=Auxiliary.GetValueType(targets)
	local tc=nil
	if typ=="Card" then
		targets=Group.FromCards(targets)
		tc=targets:GetFirst()
	elseif typ=="Group" then
		tc=targets:GetFirst()
	end
	for tc in aux.Next(targets) do
		if ct==0 or tc:IsFacedown() or tc:IsImmuneToAttack() or tc:IsImmuneToAttackDamage()
			or tc:IsImmuneToDamage() or not d:IsRelateToBattle() then return end
		if tc:IsHasEffect(PM_EFFECT_IMMUNE_ATTACK_NONEVOLVED) and not a:IsEvolution() then return end
	end
	--apply effects before weakness & resistance
	--reserved
	--apply weakness
	if weak then
		if weakness_x2 then ct=count*2
		elseif weakness_10 then ct=count+1
		elseif weakness_20 then ct=count+2
		elseif weakness_30 then ct=count+3
		elseif weakness_40 then ct=count+4 end
	end
	--apply resistance
	if resist then
		if resistance_20 then ct=count-2
		elseif resistance_30 then ct=count-3 end
	end
	--apply effects after weakness & resistance
	--reserved
	if ct>count and tc==d then Duel.Hint(HINT_OPSELECTED,1-turnp,PM_DESC_DAMAGE_INCREASE)
	elseif ct<count and tc==d then Duel.Hint(HINT_OPSELECTED,1-turnp,PM_DESC_DAMAGE_DECREASE) end
	for tc in aux.Next(targets) do
		if tc~=d then ct=count end
		tc:AddCounter(PM_DAMAGE_COUNTER,ct)
	end	
end
--put a damage counter(s) on a pokémon due to an effect
function Duel.EffectDamage(count,c1,c2,weak,resist)
	--count: the number of damage
	--c1: the pokémon with the effect
	--c2: the pokémon that receives the damage
	--weak: false to not apply weakness to c2
	--resist: false to not apply resistance c2
	count=count/10
	local d=Duel.GetDefendingPokemon()
	local c1=c1 or Duel.GetAttackingPokemon()
	local c2=c2 or d
	local weak=weak or true
	local resist=resist or true
	local turnp=Duel.GetTurnPlayer()
	local energy=c1:GetPokemonType()
	local weakness_x2=c2.weakness_x2==energy
	local weakness_10=c2.weakness_10==energy
	local weakness_20=c2.weakness_20==energy
	local weakness_30=c2.weakness_30==energy
	local weakness_40=c2.weakness_40==energy
	local resistance_20=c2.resistance_20==energy
	local resistance_30=c2.resistance_30==energy
	local ct=count
	if ct==0 or c2:IsFacedown() or c2:IsImmuneToAttack() or c2:IsImmuneToAttackDamage()
		or c2:IsImmuneToDamage() then return end
	if c2:IsHasEffect(PM_EFFECT_IMMUNE_ATTACK_NONEVOLVED) and not c1:IsEvolution() then return end
	--apply effects before weakness & resistance
	--reserved
	--apply weakness
	if weak and c2==d then
		if weakness_x2 then ct=count*2
		elseif weakness_10 then ct=count+1
		elseif weakness_20 then ct=count+2
		elseif weakness_30 then ct=count+3
		elseif weakness_40 then ct=count+4 end
	end
	--apply resistance
	if resist and c2==d then
		if resistance_20 then ct=count-2
		elseif resistance_30 then ct=count-3 end
	end
	--apply effects after weakness & resistance
	--reserved
	if ct>count and c2==d then Duel.Hint(HINT_OPSELECTED,1-turnp,PM_DESC_DAMAGE_INCREASE)
	elseif ct<count and c2==d then Duel.Hint(HINT_OPSELECTED,1-turnp,PM_DESC_DAMAGE_DECREASE) end
	c2:AddCounter(PM_DAMAGE_COUNTER,ct)
end
--remove a damage counter(s) from a pokémon
function Duel.RemoveDamage(e,count,c)
	local damc=c:GetCounter(PM_DAMAGE_COUNTER)
	if damc==0 then return end
	local ct=count
	if count>damc then ct=damc end
	c:RemoveCounter(e:GetHandlerPlayer(),PM_DAMAGE_COUNTER,ct,REASON_EFFECT)
end
--heal damage from a pokémon
function Duel.HealDamage(e,count,c)
	count=count/10
	local damc=c:GetCounter(PM_DAMAGE_COUNTER)
	if damc==0 then return end
	local ct=count
	if count>damc then ct=damc end
	c:RemoveCounter(e:GetHandlerPlayer(),PM_DAMAGE_COUNTER,ct,REASON_EFFECT)
end
--switch the damage counters between pokémon
function Duel.SwitchDamage(e,c1,c2)
	local damc1=c1:GetCounter(PM_DAMAGE_COUNTER)
	local damc2=c2:GetCounter(PM_DAMAGE_COUNTER)
	if damc1>0 then c1:RemoveCounter(e:GetHandlerPlayer(),PM_DAMAGE_COUNTER,damc1,REASON_EFFECT) end
	if damc2>0 then c2:RemoveCounter(e:GetHandlerPlayer(),PM_DAMAGE_COUNTER,damc2,REASON_EFFECT) end
	if damc2>0 then c1:AddCounter(PM_DAMAGE_COUNTER,damc2) end
	if damc1>0 then c2:AddCounter(PM_DAMAGE_COUNTER,damc1) end
end
--let a player switch an active pokémon with a benched pokémon
function Duel.SwitchPokemon(e,switch_player,target_player)
	--switch_player: the player who will select the pokémon
	--target_player: the player whose pokémon will switch
	local tp=e:GetHandlerPlayer()
	local g1=Duel.GetMatchingGroup(Auxiliary.ActivePokemonFilter,target_player,PM_LOCATION_ACTIVE,0,nil)
	local g2=Duel.GetMatchingGroup(Auxiliary.BenchPokemonFilter,target_player,PM_LOCATION_IN_PLAY,0,nil)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	local tc1=g1:GetFirst()
	--register active counters
	local damc1=tc1:GetCounter(PM_DAMAGE_COUNTER)
	local colc1=tc1:GetCounter(PM_COLORING_COUNTER)
	local chac1=tc1:GetCounter(PM_CHAR_COUNTER)
	--register active markers
	local burm1=tc1:GetMarker(PM_BURN_MARKER)
	local poim1=tc1:GetMarker(PM_POISON_MARKER)
	local rodm1=tc1:GetMarker(PM_LIGHTNING_ROD_MARKER)
	local ivym1=tc1:GetMarker(PM_DARK_IVYSAUR_MARKER)
	local prim1=tc1:GetMarker(PM_IMPRISON_MARKER)
	local shom1=tc1:GetMarker(PM_SHOCKWAVE_MARKER)
	Duel.Hint(HINT_SELECTMSG,switch_player,PM_HINTMSG_PROMOTE)
	local sg=g2:Select(switch_player,1,1,nil)
	local tc2=sg:GetFirst()
	--register bench counters
	local damc2=tc2:GetCounter(PM_DAMAGE_COUNTER)
	local colc2=tc2:GetCounter(PM_COLORING_COUNTER)
	local chac2=tc2:GetCounter(PM_CHAR_COUNTER)
	--register bench markers
	local burm2=tc2:GetMarker(PM_BURN_MARKER)
	local poim2=tc2:GetMarker(PM_POISON_MARKER)
	local rodm2=tc2:GetMarker(PM_LIGHTNING_ROD_MARKER)
	local ivym2=tc2:GetMarker(PM_DARK_IVYSAUR_MARKER)
	local prim2=tc2:GetMarker(PM_IMPRISON_MARKER)
	local shom2=tc2:GetMarker(PM_SHOCKWAVE_MARKER)
	Duel.HintSelection(sg)
	Duel.SwapSequence(tc1,tc2)
	if not tc1:IsLocation(PM_LOCATION_BENCH_EXTENDED) then return end
	--retain counters
	if damc1>0 then tc1:AddCounter(PM_DAMAGE_COUNTER,damc1) end
	if colc1>0 then tc1:AddCounter(PM_COLORING_COUNTER,colc1) end
	if chac1>0 then tc1:AddCounter(PM_CHAR_COUNTER,chac1) end
	if damc2>0 then tc2:AddCounter(PM_DAMAGE_COUNTER,damc2) end
	if colc2>0 then tc2:AddCounter(PM_COLORING_COUNTER,colc2) end
	if chac2>0 then tc2:AddCounter(PM_CHAR_COUNTER,chac2) end
	--retain counters
	if burm1>0 then tc1:AddMarker(PM_BURN_MARKER,burm1) end
	if poim1>0 then tc1:AddMarker(PM_POISON_MARKER,poim1) end
	if rodm1>0 then tc1:AddMarker(PM_LIGHTNING_ROD_MARKER,rodm1) end
	if ivym1>0 then tc1:AddMarker(PM_DARK_IVYSAUR_MARKER,ivym1) end
	if prim1>0 then tc1:AddMarker(PM_IMPRISON_MARKER,prim1) end
	if shom1>0 then tc1:AddMarker(PM_SHOCKWAVE_MARKER,shom1) end
	if burm2>0 then tc2:AddMarker(PM_BURN_MARKER,burm2) end
	if poim2>0 then tc2:AddMarker(PM_POISON_MARKER,poim2) end
	if rodm2>0 then tc2:AddMarker(PM_LIGHTNING_ROD_MARKER,rodm2) end
	if ivym2>0 then tc2:AddMarker(PM_DARK_IVYSAUR_MARKER,ivym2) end
	if prim2>0 then tc2:AddMarker(PM_IMPRISON_MARKER,prim2) end
	if shom2>0 then tc2:AddMarker(PM_SHOCKWAVE_MARKER,shom2) end
end
--remove a special condition affecting a pokémon
function Duel.RemoveSpecialCondition(c,code)
	--code: PM_EFFECT_ASLEEP, PM_EFFECT_BURNED, PM_EFFECT_CONFUSED, PM_EFFECT_PARALYZED or PM_EFFECT_POISONED
	if code==PM_EFFECT_ASLEEP or not code then
		if c:IsPosition(PM_POS_FACEUP_COUNTERCLOCKWISE) then Duel.ChangePosition(c,PM_POS_FACEUP_UPSIDE) end
		if c:IsHasEffect(PM_EFFECT_ASLEEP) then c:ResetEffect(PM_EFFECT_ASLEEP,RESET_EVENT) end
		if c:GetFlagEffect(PM_EFFECT_ASLEEP)~=0 then c:ResetFlagEffect(PM_EFFECT_ASLEEP) end
	end
	if code==PM_EFFECT_BURNED or not code then
		if c:GetMarker(PM_BURN_MARKER)~=0 then c:RemoveMarker(tp,PM_BURN_MARKER,1,REASON_RULE) end
		if c:IsHasEffect(PM_EFFECT_BURNED) then c:ResetEffect(PM_EFFECT_BURNED,RESET_EVENT) end
		if c:GetFlagEffect(PM_EFFECT_BURNED)~=0 then c:ResetFlagEffect(PM_EFFECT_BURNED) end
	end
	if code==PM_EFFECT_CONFUSED or not code then
		if c:IsHasEffect(PM_EFFECT_CONFUSED) then c:ResetEffect(PM_EFFECT_CONFUSED,RESET_EVENT) end
		if c:GetFlagEffect(PM_EFFECT_CONFUSED)~=0 then c:ResetFlagEffect(PM_EFFECT_CONFUSED) end
	end
	if code==PM_EFFECT_PARALYZED or not code then
		if c:IsPosition(PM_POS_FACEUP_CLOCKWISE) then Duel.ChangePosition(c,PM_POS_FACEUP_UPSIDE) end
		if c:IsHasEffect(PM_EFFECT_PARALYZED) then c:ResetEffect(PM_EFFECT_PARALYZED,RESET_EVENT) end
		if c:GetFlagEffect(PM_EFFECT_PARALYZED)~=0 then c:ResetFlagEffect(PM_EFFECT_PARALYZED) end
	end
	if code==PM_EFFECT_POISONED or not code then
		if c:GetMarker(PM_POISON_MARKER)~=0 then c:RemoveMarker(tp,PM_POISON_MARKER,1,REASON_RULE) end
		if c:IsHasEffect(PM_EFFECT_POISONED) then c:ResetEffect(PM_EFFECT_POISONED,RESET_EVENT) end
		if c:GetFlagEffect(PM_EFFECT_POISONED)~=0 then c:ResetFlagEffect(PM_EFFECT_POISONED) end
	end
end
--discard an energy card(s) attached to a pokémon
function Duel.DiscardEnergy(e,c,min1,max1,ener1,min2,max2,ener2)
	--ener1: CARD_GRASS_ENERGY for [G], CARD_FIRE_ENERGY for [R], CARD_WATER_ENERGY for [W], etc.
	local max1=max1 or min1
	local g=c:GetAttachmentGroup()
	local ener1=ener1 or nil
	local tp=e:GetHandlerPlayer()
	if not g or g:GetCount()==0 then return end
	local dg=Group.CreateGroup()
	if ener1 then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARDENERGY)
		sg=g:FilterSelect(tp,Card.IsEnergy,min1,max1,nil,ener1)
		dg:Merge(sg)
	else
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARDENERGY)
		sg=g:FilterSelect(tp,Card.IsEnergy,min1,max1,nil)
		dg:Merge(sg)
	end
	if ener2 then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARDENERGY)
		sg=g:FilterSelect(tp,Card.IsEnergy,min2,max2,nil,ener2)
		dg:Merge(sg)
	end
	return Duel.SendtoDPile(dg,REASON_EFFECT+REASON_DISCARD)
end

--========== Auxiliary ==========
function Auxiliary.GetValueType(v)
	local t=type(v)
	if t=="userdata" then
		local mt=getmetatable(v)
		if mt==Group then return "Group"
		elseif mt==Effect then return "Effect"
		else return "Card" end
	else return t end
end

--==========[+RuleFunctions]==========
--functions that are included on the rules card
function Auxiliary.RuleProtect(c)
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
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE)
	e2:SetRange(PM_LOCATION_RULES)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e2b=e2:Clone()
	e2b:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	c:RegisterEffect(e2b)
	local e2c=e2:Clone()
	e2c:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2c)
	--cannot release
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UNRELEASABLE_SUM)
	e3:SetRange(PM_LOCATION_RULES)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e3b=e3:Clone()
	e3b:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e3b)
	local e3c=e3:Clone()
	e3c:SetCode(EFFECT_UNRELEASABLE_EFFECT)
	c:RegisterEffect(e3c)
	--cannot be material
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e4b=e4:Clone()
	e4b:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e4b)
	local e4c=e4:Clone()
	e4c:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e4c)
	local e4d=e4:Clone()
	e4d:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	c:RegisterEffect(e4d)
	--cannot change zone
	local e5=Effect.CreateEffect(c)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_TO_HAND)
	e5:SetRange(PM_LOCATION_RULES)
	c:RegisterEffect(e5)
	local e5b=e5:Clone()
	e5b:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e5b)
	local e5c=e5:Clone()
	e5c:SetCode(EFFECT_CANNOT_REMOVE) 
	c:RegisterEffect(e5c)
	local e5d=e5:Clone()
	e5d:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e5d)
	local e6=Effect.CreateEffect(c)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e6)
	local e6b=e6:Clone()
	e6b:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e6b)
	local e6c=e6:Clone()
	e6c:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e6c)
	local e6d=e6:Clone()
	e6d:SetCode(EFFECT_CANNOT_MSET)
	c:RegisterEffect(e6d)
	local e6e=e6:Clone()
	e6e:SetCode(EFFECT_CANNOT_SSET)
	c:RegisterEffect(e6e)
	local e6f=e6:Clone()
	e6f:SetCode(EFFECT_CANNOT_USE_AS_COST)
	c:RegisterEffect(e6f)
end
--remove type
function Auxiliary.RuleRemoveType(c,val,range)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_REMOVE_TYPE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	if range then e1:SetRange(range) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end
--cannot bp
function Auxiliary.RuleCannotBP(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(1,0)
	c:RegisterEffect(e1)
end
--infinite hand
function Auxiliary.RuleInfiniteHand(c)
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
function Auxiliary.RuleCannotChangePosition(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(LOCATION_MZONE,0)
	c:RegisterEffect(e1)
end
--cannot attack
function Auxiliary.RuleCannotAttack(c)
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
function Auxiliary.RuleCannotDirectAttack(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(LOCATION_MZONE,0)
	c:RegisterEffect(e1)
end
--indestructible
function Auxiliary.RuleIndestructible(c,code1,...)
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
function Auxiliary.RuleNoBattleDamage(c)
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
function Auxiliary.RuleNoEffectDamage(c)
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
function Auxiliary.RuleCannotSummonMSet(c)
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
function Auxiliary.RuleCannotSSet(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SSET)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetTargetRange(1,0)
	c:RegisterEffect(e1)
end
--adjust extra deck
function Auxiliary.RuleAdjustExtraDeck(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(PM_LOCATION_RULES)
	e1:SetCondition(Auxiliary.AdjustExtraDeckCondition)
	e1:SetOperation(Auxiliary.AdjustExtraDeckOperation)
	c:RegisterEffect(e1)
end
function Auxiliary.AdjustExtraDeckFilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsPreviousLocation(PM_LOCATION_IN_PLAY)
end
function Auxiliary.AdjustExtraDeckCondition(e)
	return Duel.IsExistingMatchingCard(Auxiliary.AdjustExtraDeckFilter,e:GetHandlerPlayer(),LOCATION_EXTRA,0,1,nil)
end
function Auxiliary.AdjustExtraDeckOperation(e)
	local g=Duel.GetMatchingGroup(Auxiliary.AdjustExtraDeckFilter,e:GetHandlerPlayer(),LOCATION_EXTRA,0,nil)
	Duel.SendtoDPile(g,REASON_RULE)
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
	--[[
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(PM_EFFECT_FLAG_BENCH_PARAM+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(Auxiliary.BenchCondition2)
	e2:SetTarget(Auxiliary.BenchTarget)
	e2:SetOperation(Auxiliary.BenchOperation)
	c:RegisterEffect(e2)
	]]
	--retreat
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(PM_DESC_RETREAT)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetRange(PM_LOCATION_ACTIVE)
	e3:SetCondition(Auxiliary.RetreatCondition)
	e3:SetCost(Auxiliary.RetreatCost)
	e3:SetTarget(Auxiliary.HintTarget)
	e3:SetOperation(Auxiliary.RetreatOperation)
	c:RegisterEffect(e3)
	--remove effects
	--not yet implemented: remove other effects affecting the pokémon
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_ADJUST)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetRange(PM_LOCATION_BENCH)
	e4:SetCondition(Auxiliary.RemoveEffectsCondition)
	e4:SetOperation(Auxiliary.RemoveEffectsOperation)
	c:RegisterEffect(e4)
end
function Auxiliary.BenchCondition(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,PM_LOCATION_BENCH)>0 and c:IsBasicPokemon()
end
--[[
function Auxiliary.BenchCondition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsPlayerAffectedByEffect(tp,PM_EFFECT_EXTEND_BENCH_8)
end
function Auxiliary.BenchTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function Auxiliary.BenchOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end
]]
function Auxiliary.RetreatCondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,PM_EFFECT_RETREAT)==0 and e:GetHandler():IsRetreatable()
end
function Auxiliary.RetreatCost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Auxiliary.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_PROMOTE)
	local g=Duel.SelectMatchingCard(tp,Auxiliary.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
	Duel.HintSelection(g)
	g:KeepAlive()
	e:SetLabelObject(g)
	local c=e:GetHandler()
	local og=c:GetAttachmentGroup()
	local rc=c:GetRetreatCost()
	if c:IsHasEffect(PM_EFFECT_RETREAT_COST_REPLACE) then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARD)
		local sog=og:FilterSelect(tp,Card.IsHasEffect,1,1,nil,PM_EFFECT_RETREAT_COST_REPLACE)
		Duel.SendtoDPile(sog,REASON_COST+REASON_DISCARD+REASON_REPLACE)
	else
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARDENERGY)
		local sog=og:FilterSelect(tp,Card.IsEnergy,rc,rc,nil)
		Duel.SendtoDPile(sog,REASON_COST+REASON_DISCARD)
	end
end
function Auxiliary.RetreatOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if g:GetCount()==0 then return end
	--Not fully implemented: Duel.SwapSequence doesn't work when promoting Pokémon in LOCATION_SZONE
	Duel.SwapSequence(e:GetHandler(),g:GetFirst())
	Duel.RegisterFlagEffect(tp,PM_EFFECT_RETREAT,RESET_PHASE+PHASE_END,0,1)
end
function Auxiliary.RemoveEffectsCondition(e)
	return e:GetHandler():IsBench() and e:GetHandler():IsAffectedBySpecialCondition()
end
function Auxiliary.RemoveEffectsOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.RemoveSpecialCondition(e:GetHandler())
end

--==========[+Evolution]==========
--[[
"If you have a card in your hand that says "Evolves from X," and X is the name of a Pokémon you had in play at the beginning
of your turn, you may play that card in your hand on top of Pokémon X.
This is called "evolving" a Pokémon."
]]
--Not fully implemented: Incompatible with Pokémon in LOCATION_SZONE
function Auxiliary.EnableEvolve(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(PM_DESC_EVOLVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(Auxiliary.EvolvePokemonTarget)
	e1:SetOperation(Auxiliary.EvolvePokemonOperation)
	c:RegisterEffect(e1)
end
function Auxiliary.EvolvePokemonFilter(c,tcode)
	return c:IsFaceup() and c.evolve_list and table.unpack(c.evolve_list)==tcode and not c:IsStatus(PM_STATUS_PLAY_TURN)
end
function Auxiliary.EvolvePokemonTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(Auxiliary.EvolvePokemonFilter,tp,PM_LOCATION_IN_PLAY,0,1,nil,c:GetCode())
		and c:IsCanBePutInPlay(e,PM_SUMMON_TYPE_EVOLVE,tp,false,false) end
end
function Auxiliary.EvolvePokemonOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_EVOLVE)
	local g=Duel.SelectMatchingCard(tp,Auxiliary.EvolvePokemonFilter,tp,PM_LOCATION_IN_PLAY,0,1,1,nil,c:GetCode())
	local tc=g:GetFirst()
	if not tc then return end
	Duel.HintSelection(g)
	--register sequence
	local seq=tc:GetSequence()
	--register counters
	local damc=tc:GetCounter(PM_DAMAGE_COUNTER)
	local colc=tc:GetCounter(PM_COLORING_COUNTER)
	local chac=tc:GetCounter(PM_CHAR_COUNTER)
	--register markers
	local burm=tc:GetMarker(PM_BURN_MARKER)
	local poim=tc:GetMarker(PM_POISON_MARKER)
	local rodm=tc:GetMarker(PM_LIGHTNING_ROD_MARKER)
	local ivym=tc:GetMarker(PM_DARK_IVYSAUR_MARKER)
	local prim=tc:GetMarker(PM_IMPRISON_MARKER)
	local shom=tc:GetMarker(PM_SHOCKWAVE_MARKER)
	local mg=tc:GetAttachmentGroup()
	if tc:IsActive() then Duel.SendtoExtraP(c,PLAYER_OWNER,REASON_RULE) end --workaround
	if mg:GetCount()~=0 then
		Duel.Attach(c,mg)
	end
	c:SetAttachment(g)
	Duel.Evolve(c,g)
	Duel.PutInPlay(c,PM_SUMMON_TYPE_EVOLVE,tp,tp,false,false,PM_POS_FACEUP_UPSIDE)
	--retain sequence
	if c:GetSequence()~=seq then Duel.MoveSequence(c,seq) end
	--retain counters
	if damc>0 then c:AddCounter(PM_DAMAGE_COUNTER,damc) end
	if colc>0 then c:AddCounter(PM_COLORING_COUNTER,colc) end
	if chac>0 then c:AddCounter(PM_CHAR_COUNTER,chac) end
	--retain markers
	if burm>0 then c:AddCounter(PM_BURN_MARKER,burm) end
	if poim>0 then c:AddCounter(PM_POISON_MARKER,poim) end
	if rodm>0 then c:AddCounter(PM_LIGHTNING_ROD_MARKER,rodm) end
	if ivym>0 then c:AddCounter(PM_DARK_IVYSAUR_MARKER,ivym) end
	if prim>0 then c:AddCounter(PM_IMPRISON_MARKER,prim) end
	if shom>0 then c:AddCounter(PM_SHOCKWAVE_MARKER,shom) end
end

--==========[+LVX]==========
--[[
"They are played similarly to an Evolution card but have special rules as well:
- Only the Active Pokémon can be Leveled-Up.
- When a Pokémon LV.X is played, it keeps all attacks, Poké-Powers, and Poké-Bodies from the earlier level.
- A Pokémon LV.X shares the same name as the Pokémon it is put on top of.
- A Pokémon LV.X is not considered an Evolution card."
]]
function Auxiliary.EnableLevelUp(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(PM_DESC_LVX)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(Auxiliary.LVXTarget)
	e1:SetOperation(Auxiliary.LVXOperation)
	c:RegisterEffect(e1)
end
function Auxiliary.LVXFilter(c,tcode,tid)
	return Auxiliary.ActivePokemonFilter(c) and c.levelup_list and table.unpack(c.levelup_list)==tcode and c:GetTurnID()~=tid
end
function Auxiliary.LVXTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tid=Duel.GetTurnCount()
	if chk==0 then return Duel.GetLocationCount(tp,PM_LOCATION_ACTIVE)>-1
		and Duel.IsExistingMatchingCard(Auxiliary.LVXFilter,tp,PM_LOCATION_ACTIVE,0,1,nil,c:GetCode(),tid)
		and c:IsCanBePutInPlay(e,PM_SUMMON_TYPE_LEVELUP,tp,false,false) end
end
function Auxiliary.LVXOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tid=Duel.GetTurnCount()
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_LEVELUP)
	local g=Duel.SelectMatchingCard(tp,Auxiliary.LVXFilter,tp,PM_LOCATION_ACTIVE,0,1,1,nil,c:GetCode(),tid)
	local tc=g:GetFirst()
	if not tc then return end
	Duel.HintSelection(g)
	--register sequence
	local seq=tc:GetSequence()
	--register counters
	local damc=tc:GetCounter(PM_DAMAGE_COUNTER)
	local colc=tc:GetCounter(PM_COLORING_COUNTER)
	local chac=tc:GetCounter(PM_CHAR_COUNTER)
	--register markers
	local burm=tc:GetMarker(PM_BURN_MARKER)
	local poim=tc:GetMarker(PM_POISON_MARKER)
	local rodm=tc:GetMarker(PM_LIGHTNING_ROD_MARKER)
	local ivym=tc:GetMarker(PM_DARK_IVYSAUR_MARKER)
	local prim=tc:GetMarker(PM_IMPRISON_MARKER)
	local shom=tc:GetMarker(PM_SHOCKWAVE_MARKER)
	local mg=tc:GetAttachmentGroup()
	Duel.SendtoExtraP(c,PLAYER_OWNER,REASON_RULE) --workaround
	if mg:GetCount()~=0 then
		Duel.Attach(c,mg)
	end
	c:SetAttachment(g)
	Duel.LevelUp(c,g)
	Duel.PutInPlay(c,PM_SUMMON_TYPE_LEVELUP,tp,tp,false,false,PM_POS_FACEUP_UPSIDE)
	--retain sequence
	if c:GetSequence()~=seq then Duel.MoveSequence(c,seq) end
	--retain counters
	if damc>0 then c:AddCounter(PM_DAMAGE_COUNTER,damc) end
	if colc>0 then c:AddCounter(PM_COLORING_COUNTER,colc) end
	if chac>0 then c:AddCounter(PM_CHAR_COUNTER,chac) end
	--retain markers
	if burm>0 then c:AddCounter(PM_BURN_MARKER,burm) end
	if poim>0 then c:AddCounter(PM_POISON_MARKER,poim) end
	if rodm>0 then c:AddCounter(PM_LIGHTNING_ROD_MARKER,rodm) end
	if ivym>0 then c:AddCounter(PM_DARK_IVYSAUR_MARKER,ivym) end
	if prim>0 then c:AddCounter(PM_IMPRISON_MARKER,prim) end
	if shom>0 then c:AddCounter(PM_SHOCKWAVE_MARKER,shom) end
	--gain attack & effect
	local code=tc:GetOriginalCode()
	c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD_DISABLE,1)
end

--==========[+Energy]==========
--Energy card
function Auxiliary.EnableEnergyAttribute(c,setname,discard)
	--discard: true to discard at the end of the turn
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(PM_DESC_ENERGY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	if setname then
		e1:SetTarget(Auxiliary.EnergyTarget2(setname))
		e1:SetOperation(Auxiliary.EnergyOperation2(setname,discard))
	else
		e1:SetTarget(Auxiliary.EnergyTarget)
		e1:SetOperation(Auxiliary.EnergyOperation)
	end
	c:RegisterEffect(e1)
	--not yet implemented
	--"(If this card is attached to anything other than an X Pokémon, discard this card.)"
end
--basic Energy
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
	Duel.Attach(g:GetFirst(),e:GetHandler())
end
--Special Energy
function Auxiliary.EnergyFilter2(c,setname)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(setname)
end
function Auxiliary.EnergyTarget2(setname)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				if chk==0 then return Duel.IsExistingMatchingCard(Auxiliary.EnergyFilter2,tp,PM_LOCATION_IN_PLAY,0,1,nil,setname) end
			end
end
function Auxiliary.EnergyOperation2(setname,discard)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ATTACHENERGY)
				local g=Duel.SelectMatchingCard(tp,Auxiliary.EnergyFilter2,tp,PM_LOCATION_IN_PLAY,0,1,1,nil,setname)
				if g:GetCount()==0 then return end
				local c=e:GetHandler()
				local tc=g:GetFirst()
				Duel.HintSelection(g)
				Duel.Attach(tc,c)
				if not discard then return end
				c:RegisterFlagEffect(c:GetOriginalCode(),RESET_EVENT+RESETS_STANDARD,0,1)
				--discard
				local e1=Effect.CreateEffect(c)
				e1:SetDescription(PM_DESC_SELF_DETACH)
				e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				e1:SetCode(EVENT_PHASE+PHASE_END)
				e1:SetCountLimit(1)
				e1:SetLabelObject(c)
				e1:SetCondition(Auxiliary.SpecialEnergyDiscardCondition)
				e1:SetOperation(Auxiliary.SpecialEnergyDiscardOperation)
				Duel.RegisterEffect(e1,tp)
			end
end
function Auxiliary.SpecialEnergyDiscardCondition(e)
	local tc=e:GetLabelObject()
	local code=e:GetHandler():GetOriginalCode()
	if tc:GetFlagEffect(code)~=0 then
		return true
	else
		e:Reset()
		return false
	end
end
function Auxiliary.SpecialEnergyDiscardOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDPile(e:GetLabelObject(),REASON_EFFECT+REASON_DISCARD)
end

--==========[+Trainer]==========
--Trainer card
function Auxiliary.EnableTrainerPlay(c,cate,targ_func,op_func,con_func,cost_func,prop)
	--play
	local e1=Effect.CreateEffect(c)
	if cate then e1:SetCategory(cate) end
	e1:SetType(PM_EFFECT_TYPE_PLAY)
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
	Duel.SendtoDPile(e:GetHandler(),REASON_RULE+REASON_DISCARD)
end
--========== Item ==========
--Pokémon Tool
function Auxiliary.EnablePokemonTool(c,desc_id,con_func)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(PM_DESC_TOOL)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(Auxiliary.PokemonToolTarget)
	e1:SetOperation(Auxiliary.PokemonToolOperation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(PM_EFFECT_TYPE_POKEMON_TOOL+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCondition(aux.AND(Auxiliary.AddToolDescCondition,con_func))
	e2:SetOperation(Auxiliary.AddToolDescOperation(desc_id))
	e2:SetLabelObject(c)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCondition(Auxiliary.RemoveToolDescCondition)
	e3:SetOperation(Auxiliary.RemoveToolDescOperation)
	c:RegisterEffect(e3)
end
function Auxiliary.PokemonToolFilter(c)
	return c:IsFaceup() and c:IsPokemon() and not c:GetAttachmentGroup():IsExists(Card.IsPokemonTool,1,nil)
end
Auxiliary.toolfilter=Auxiliary.PokemonToolFilter
function Auxiliary.PokemonToolTarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Auxiliary.PokemonToolFilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
end
function Auxiliary.PokemonToolOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ATTACHTOOL)
	local g=Duel.SelectMatchingCard(tp,Auxiliary.PokemonToolFilter,tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.Attach(g:GetFirst(),e:GetHandler())
end
function Auxiliary.AddToolDescCondition(e)
	local c=e:GetLabelObject()
	local code=c:GetOriginalCode()
	return e:GetHandler():GetFlagEffect(code)==0
end
function Auxiliary.AddToolDescOperation(desc_id)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				if not desc_id then return end
				local c=e:GetLabelObject()
				local code=c:GetOriginalCode()
				e:GetHandler():RegisterFlagEffect(code,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(code,desc_id))
			end
end
function Auxiliary.RemoveToolDescCondition(e)
	local c=e:GetLabelObject()
	local code=c:GetOriginalCode()
	return e:GetHandler():GetFlagEffect(code)~=0 and e:GetHandler():GetLocation()~=PM_LOCATION_ATTACHED
end
function Auxiliary.RemoveToolDescOperation(e)
	local c=e:GetLabelObject()
	local code=c:GetOriginalCode()
	e:GetHandler():ResetFlagEffect(code)
end
--========== Stadium ==========
--Stadium card
function Auxiliary.EnableStadium(c)
	--play
	local e1=Effect.CreateEffect(c)
	e1:SetType(PM_EFFECT_TYPE_PLAY)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--self discard
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(PM_DESC_SELF_DISCARD)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAINING)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(PM_LOCATION_STADIUM)
	e2:SetCondition(Auxiliary.StadiumReplaceCondition)
	e2:SetOperation(Auxiliary.StadiumReplaceOperation)
	c:RegisterEffect(e2)
	--cannot play
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(PM_EFFECT_CANNOT_PLAY)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(PM_LOCATION_STADIUM)
	e3:SetTargetRange(1,1)
	e3:SetValue(Auxiliary.StadiumPlayLimit)
	c:RegisterEffect(e3)
end
function Auxiliary.StadiumReplaceCondition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(PM_TYPE_STADIUM) and re:GetHandler()~=e:GetHandler()
end
function Auxiliary.StadiumReplaceOperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDPile(e:GetHandler(),REASON_RULE+REASON_DISCARD)
end
function Auxiliary.StadiumPlayLimit(e,te,tp)
	local code=e:GetHandler():GetOriginalCode()
	return te:IsHasType(PM_EFFECT_TYPE_PLAY) and te:IsActiveType(PM_TYPE_STADIUM)
		and te:GetHandler():GetOriginalCode()==code
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
--"The Defending Pokémon can't retreat during your opponent's next turn." (e.g. "Axew Black Star Promo BW26")
function Auxiliary.EnableCannotRetreat(c,desc,reset_flag,reset_count,con_func)
	local reset_flag=reset_flag or RESET_EVENT+RESETS_STANDARD
	local reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(desc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_CANNOT_RETREAT)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	if con_func then e1:SetCondition(con_func) end
	e1:SetReset(reset_flag,reset_count)
	c:RegisterEffect(e1)
end
--"This Pokémon can't attack" (e.g. "Haxorus NVI 88")
function Auxiliary.EnableCannotAttack(c,desc,reset_flag,reset_count,con_func)
	local reset_flag=reset_flag or RESET_EVENT+RESETS_STANDARD
	local reset_count=reset_count or 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(desc)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	if con_func then e1:SetCondition(con_func) end
	e1:SetReset(reset_flag,reset_count)
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
--show a player their deck when they search it for a card
function Auxiliary.ConfirmDeck(tp,player)
	local g=Duel.GetFieldGroup(player,LOCATION_DECK,0)
	if g:GetCount()<=0 then return end
	Duel.ConfirmCards(player,g)
end
--notify a player that there are no valid targets and shuffle their deck after they looked at it
function Auxiliary.ConfirmInvalid(tp,player)
	Duel.Hint(HINT_MESSAGE,tp,PM_DESC_NO_TARGETS)
	Duel.ShuffleDeck(tp)
end
--"This card provides Double ... Energy." (e.g. "Double Colorless Energy BS 96")
function Auxiliary.EnableDoubleEnergy(c,val)
	--val: PM_TYPE_DOUBLE_..._ENERGY
	local code=c:GetOriginalCode()
	local m=_G["c"..code]
	if not m.global_check then
		m.global_check=true
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(PM_EFFECT_ADD_SETCODE)
		ge1:SetTargetRange(PM_LOCATION_ATTACHED,PM_LOCATION_ATTACHED)
		ge1:SetTarget(aux.TargetBoolFunction(Card.IsCode,code))
		ge1:SetValue(val)
		Duel.RegisterEffect(ge1,0)
	end
end
--"Draw N cards."
function Auxiliary.DrawTarget(p,ct)
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local player=nil
				if p==PLAYER_PLAYER or p==tp then player=tp
				elseif p==PLAYER_OPPONENT or p==1-tp then player=1-tp end
				if chk==0 then return Duel.IsPlayerCanDraw(player,ct) end
				if e:GetHandler():IsPokemon() then Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription()) end
			end
end
Auxiliary.drtg=Auxiliary.DrawTarget
function Auxiliary.DrawOperation(p,ct)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local player=nil
				if p==PLAYER_PLAYER or p==tp then player=tp
				elseif p==PLAYER_OPPONENT or p==1-tp then player=1-tp end
				Duel.Draw(player,ct,REASON_EFFECT)
			end
end
Auxiliary.drop=Auxiliary.DrawOperation
--"The Retreat Cost for each [P] and [D] Pokémon is 0." (e.g. "Moonlight Stadium GE 100")
function Auxiliary.EnableNoRetreatCost(c,range,s_range,o_range,targ_func,con_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(PM_EFFECT_NO_RETREAT_COST)
	e1:SetRange(range)
	e1:SetTargetRange(s_range,o_range)
	if targ_func then e1:SetTarget(targ_func) end
	if con_func then e1:SetCondition(con_func) end
	c:RegisterEffect(e1)
end
--"The Retreat Cost of each Basic Pokémon in play is [C] less." (e.g. "Skyarrow Bridge NXD 91")
function Auxiliary.EnableRetreatCostChange(c,val,range,s_range,o_range,targ_func,con_func)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(PM_EFFECT_UPDATE_RETREAT_COST)
	e1:SetRange(range)
	e1:SetTargetRange(s_range,o_range)
	if targ_func then e1:SetTarget(targ_func) end
	if con_func then e1:SetCondition(con_func) end
	e1:SetValue(val)
	c:RegisterEffect(e1)
end

--==========[+SpecialCondition]==========
--[[
"Turn the Pokémon counterclockwise to show that it is Asleep.
If a Pokémon is Asleep, it cannot attack or retreat. Between turns, flip a coin. If you flip heads, the Pokémon wakes up
(turn the card right-side up), but if you flip tails, it stays Asleep."
]]
function Auxiliary.EnableAsleep(c,con_func,reset_flag)
	if c:IsAsleep() or not c:IsCanBeAsleep() then return end
	reset_flag=reset_flag or RESET_EVENT+RESETS_STANDARD
	if not c:IsPosition(PM_POS_FACEUP_COUNTERCLOCKWISE) then Duel.ChangePosition(c,PM_POS_FACEUP_COUNTERCLOCKWISE) end
	--asleep
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_ASLEEP)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	if con_func then e1:SetCondition(con_func) end
	e1:SetReset(reset_flag)
	c:RegisterEffect(e1,true)
	c:RegisterFlagEffect(PM_EFFECT_ASLEEP,reset_flag,EFFECT_FLAG_CLIENT_HINT,1,0,PM_DESC_ASLEEP)
	--asleep check
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(PM_DESC_ASLEEP_CHECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCountLimit(1)
	e2:SetLabelObject(c)
	if con_func then
		e2:SetCondition(aux.AND(Auxiliary.CheckAsleepCondition,con_func))
	else
		e2:SetCondition(Auxiliary.CheckAsleepCondition)
	end
	e2:SetOperation(Auxiliary.CheckAsleepOperation)
	Duel.RegisterEffect(e2,c:GetControler())
end
function Auxiliary.CheckAsleepCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsAsleep() then
		return true
	else
		e:Reset()
		return false
	end
end
function Auxiliary.CheckAsleepOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
	local res=Duel.TossCoin(tp,1)
	if res==RESULT_HEADS then Duel.RemoveSpecialCondition(tc,PM_EFFECT_ASLEEP) end
end
--[[
"A Burned Pokémon takes damage between turns, but the condition might heal on its own.
When a Pokémon is Burned, put a Burn marker on it. Between turns, put 2 damage counters on your Burned Pokémon, then flip a
coin. If heads, remove the Special Condition Burned.
A Pokémon cannot have two Burn markers; if an attack gives it another Burn marker, the new Burned Condition simply replaces
the old one."
]]
function Auxiliary.EnableBurned(c,con_func,reset_flag)
	if not c:IsCanBeBurned() then return end
	reset_flag=reset_flag or RESET_EVENT+RESETS_STANDARD
	if c:GetMarker(PM_BURN_MARKER)==1 then
		c:RemoveMarker(c:GetControler(),PM_BURN_MARKER,1,REASON_RULE)
		c:AddMarker(PM_BURN_MARKER,1)
	else
		c:AddMarker(PM_BURN_MARKER,1)
	end
	--burned
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_BURNED)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	if con_func then e1:SetCondition(con_func) end
	e1:SetReset(reset_flag)
	c:RegisterEffect(e1,true)
	c:RegisterFlagEffect(PM_EFFECT_BURNED,reset_flag,EFFECT_FLAG_CLIENT_HINT,1,0,PM_DESC_BURNED)
	--burned check
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(PM_DESC_BURNED_CHECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCountLimit(1)
	e2:SetLabelObject(c)
	if con_func then
		e2:SetCondition(aux.AND(Auxiliary.CheckBurnedCondition,con_func))
	else
		e2:SetCondition(Auxiliary.CheckBurnedCondition)
	end
	e2:SetOperation(Auxiliary.CheckBurnedOperation)
	Duel.RegisterEffect(e2,c:GetControler())
end
function Auxiliary.CheckBurnedCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsBurned() then
		return true
	else
		e:Reset()
		return false
	end
end
function Auxiliary.CheckBurnedOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
	tc:AddCounter(PM_DAMAGE_COUNTER,2)
	Duel.BreakEffect()
	local res=Duel.TossCoin(tp,1)
	if res==RESULT_HEADS then Duel.RemoveSpecialCondition(tc,PM_EFFECT_BURNED) end
end
--[[
"Turn a Confused Pokémon with its head pointed toward you to show that it is Confused.
If your Pokémon is Confused, you must flip a coin before attacking with it. If heads, the attack works normally. If tails,
the attack does nothing, and put 3 damage counters on your Confused Pokémon."
]]
function Auxiliary.EnableConfused(c,con_func,reset_flag)
	if c:IsConfused() or not c:IsCanBeConfused() then return end
	reset_flag=reset_flag or RESET_EVENT+RESETS_STANDARD
	--confused
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_CONFUSED)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	if con_func then e1:SetCondition(con_func) end
	e1:SetReset(reset_flag)
	c:RegisterEffect(e1,true)
	c:RegisterFlagEffect(PM_EFFECT_CONFUSED,reset_flag,EFFECT_FLAG_CLIENT_HINT,1,0,PM_DESC_CONFUSED)
	--confused check
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(PM_DESC_CONFUSED_CHECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(PM_EVENT_PRE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(PM_LOCATION_IN_PLAY)
	if con_func then
		e2:SetCondition(aux.AND(Auxiliary.CheckConfusedCondition,con_func))
	else
		e2:SetCondition(Auxiliary.CheckConfusedCondition)
	end
	e2:SetOperation(Auxiliary.CheckConfusedOperation)
	e2:SetReset(reset_flag)
	c:RegisterEffect(e2)
end
function Auxiliary.CheckConfusedCondition(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return loc==PM_LOCATION_ACTIVE and re:GetHandler():IsConfused() and re:IsHasProperty(PM_EFFECT_FLAG_POKEMON_ATTACK)
end
function Auxiliary.CheckConfusedOperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	local res=Duel.TossCoin(tp,1)
	if res==RESULT_HEADS then return end
	if not Duel.NegatePokemonAttack(ev) then return end
	if not c:AddCounter(PM_DAMAGE_COUNTER,3) then return end
	Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
end
--[[
"Turn the Paralyzed Pokémon clockwise to show that it is Paralyzed.
If a Pokémon is Paralyzed, it cannot attack or retreat. Remove the Special Condition Paralyzed during the between-turns step
if your Pokémon was Paralyzed since the beginning of your last turn."
]]
function Auxiliary.EnableParalyzed(c,con_func,reset_flag)
	if c:IsParalyzed() or not c:IsCanBeParalyzed() then return end
	reset_flag=reset_flag or RESET_EVENT+RESETS_STANDARD
	if not c:IsPosition(PM_POS_FACEUP_CLOCKWISE) then Duel.ChangePosition(c,PM_POS_FACEUP_CLOCKWISE) end
	--paralyzed
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_PARALYZED)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	if con_func then e1:SetCondition(con_func) end
	e1:SetReset(reset_flag)
	c:RegisterEffect(e1)
	c:RegisterFlagEffect(PM_EFFECT_PARALYZED,reset_flag,EFFECT_FLAG_CLIENT_HINT,1,0,PM_DESC_PARALYZED)
	--paralyzed check
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(PM_DESC_PARALYZED_CHECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCountLimit(1)
	e2:SetLabelObject(c)
	e2:SetLabel(0)
	if con_func then
		e2:SetCondition(aux.AND(Auxiliary.CheckParalyzedCondition,con_func))
	else
		e2:SetCondition(Auxiliary.CheckParalyzedCondition)
	end
	e2:SetOperation(Auxiliary.CheckParalyzedOperation)
	e2:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN)
	Duel.RegisterEffect(e2,c:GetControler())
end
function Auxiliary.CheckParalyzedCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc:IsParalyzed() and Duel.GetTurnPlayer()==tp and Duel.GetTurnCount()~=e:GetLabel()
end
function Auxiliary.CheckParalyzedOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
	Duel.RemoveSpecialCondition(tc,PM_EFFECT_PARALYZED)
end
--[[
"A Poisoned Pokémon takes damage between turns. When a Pokémon is Poisoned, put a Poison marker on it. Between turns, put a
damage counter on your Poisoned Pokémon.
Pokémon cannot have two Poison markers; if an attack gives it another Poison marker, the new Poisoned Condition simply
replaces the old one."
]]
function Auxiliary.EnablePoisoned(c,con_func,reset_flag)
	if not c:IsCanBePoisoned() then return end
	reset_flag=reset_flag or RESET_EVENT+RESETS_STANDARD
	if c:GetMarker(PM_POISON_MARKER)==1 then
		c:RemoveMarker(c:GetControler(),PM_POISON_MARKER,1,REASON_RULE)
		c:AddMarker(PM_POISON_MARKER,1)
	else
		c:AddMarker(PM_POISON_MARKER,1)
	end
	--poisoned
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_POISONED)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	if con_func then e1:SetCondition(con_func) end
	e1:SetReset(reset_flag)
	c:RegisterEffect(e1)
	c:RegisterFlagEffect(PM_EFFECT_POISONED,reset_flag,EFFECT_FLAG_CLIENT_HINT,1,0,PM_DESC_POISONED)
	--poisoned check
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(PM_DESC_POISONED_CHECK)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCountLimit(1)
	e2:SetLabelObject(c)
	if con_func then
		e2:SetCondition(aux.AND(Auxiliary.CheckPoisonedCondition,con_func))
	else
		e2:SetCondition(Auxiliary.CheckPoisonedCondition)
	end
	e2:SetOperation(Auxiliary.CheckPoisonedOperation)
	Duel.RegisterEffect(e2,c:GetControler())
end
function Auxiliary.CheckPoisonedCondition(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsPoisoned() then
		return true
	else
		e:Reset()
		return false
	end
end
function Auxiliary.CheckPoisonedOperation(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
	tc:AddCounter(PM_DAMAGE_COUNTER,1)
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
--condition for attacks with no Energy Cost
function Auxiliary.AttackCostCondition0(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Auxiliary.ActivePokemonFilter(c) and c:IsCanAttack()
end
Auxiliary.econ0=Auxiliary.AttackCostCondition0
--condition for attacks with an Energy Cost of 1 Energy
function Auxiliary.AttackCostCondition1(ener1,count1)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local ct1=c:GetAttachmentGroup():FilterCount(Card.IsEnergy,nil,ener1)
				local cct=c:GetAttachmentGroup():FilterCount(Card.IsDoubleColorlessEnergy,nil)*2
				local wct=c:GetAttachmentGroup():FilterCount(Card.IsDoubleWaterEnergy,nil)*2
				local fct=c:GetAttachmentGroup():FilterCount(Card.IsDoubleFightingEnergy,nil)*2
				if wct>0 then
					if ener1==CARD_WATER_ENERGY then ct1=ct1+wct end
				end
				if fct>0 then
					if ener1==CARD_FIGHTING_ENERGY then ct1=ct1+fct end
				end
				local res=count1
				local sum=ct1+cct
				if not (Auxiliary.ActivePokemonFilter(c) and c:IsCanAttack()) then return false end
				if cct>0 then
					return sum>=res
				else
					return ct1>=count1
				end
			end
end
Auxiliary.econ1=Auxiliary.AttackCostCondition1
--condition for attacks with an Energy Cost of 2 different Energy
function Auxiliary.AttackCostCondition2(ener1,count1,ener2,count2)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local g1=c:GetAttachmentGroup():Filter(Card.IsEnergy,nil,ener1)
				local g2=c:GetAttachmentGroup():Filter(Card.IsEnergy,g1,ener2)
				local dcg=c:GetAttachmentGroup():Filter(Card.IsDoubleColorlessEnergy,nil)
				local dwg=c:GetAttachmentGroup():Filter(Card.IsDoubleWaterEnergy,nil)
				local dfg=c:GetAttachmentGroup():Filter(Card.IsDoubleFightingEnergy,nil)
				local ct1=g1:GetCount()
				local ct2=g2:GetCount()
				local cct=dcg:GetCount()*2
				local wct=dwg:GetCount()*2
				local fct=dfg:GetCount()*2
				if ener1==CARD_COLORLESS_ENERGY then ct1=count1
				elseif ener2==CARD_COLORLESS_ENERGY then ct2=count2 end
				if wct>0 then
					if ener1==CARD_WATER_ENERGY then ct1=ct1+wct
					elseif ener2==CARD_WATER_ENERGY then ct2=ct2+wct end
				end
				if fct>0 then
					if ener1==CARD_FIGHTING_ENERGY then ct1=ct1+fct
					elseif ener2==CARD_FIGHTING_ENERGY then ct2=ct2+fct end
				end
				local res=count1+count2
				local sum=ct1+ct2+cct
				if not (Auxiliary.ActivePokemonFilter(c) and c:IsCanAttack()) then return false end
				if cct>0 then
					return sum>=res
				else
					return ct1>=count1 and ct2>=count2
				end
			end
end
Auxiliary.econ2=Auxiliary.AttackCostCondition2
--condition for attacks with an Energy Cost of 3 different Energy
function Auxiliary.AttackCostCondition3(ener1,count1,ener2,count2,ener3,count3)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local g1=c:GetAttachmentGroup():Filter(Card.IsEnergy,nil,ener1)
				local g2=c:GetAttachmentGroup():Filter(Card.IsEnergy,g1,ener2)
				local g3=c:GetAttachmentGroup():Filter(Card.IsEnergy,g2,ener3)
				local dcg=c:GetAttachmentGroup():Filter(Card.IsDoubleColorlessEnergy,nil)
				local dwg=c:GetAttachmentGroup():Filter(Card.IsDoubleWaterEnergy,nil)
				local dfg=c:GetAttachmentGroup():Filter(Card.IsDoubleFightingEnergy,nil)
				local ct1=g1:GetCount()
				local ct2=g2:GetCount()
				local ct3=g3:GetCount()
				local cct=dcg:GetCount()*2
				local wct=dwg:GetCount()*2
				local fct=dfg:GetCount()*2
				if ener1==CARD_COLORLESS_ENERGY then ct1=count1
				elseif ener2==CARD_COLORLESS_ENERGY then ct2=count2
				elseif ener3==CARD_COLORLESS_ENERGY then ct3=count3 end
				if wct>0 then
					if ener1==CARD_WATER_ENERGY then ct1=ct1+wct
					elseif ener2==CARD_WATER_ENERGY then ct2=ct2+wct
					elseif ener3==CARD_WATER_ENERGY then ct3=ct3+wct end
				end
				if fct>0 then
					if ener1==CARD_FIGHTING_ENERGY then ct1=ct1+fct
					elseif ener2==CARD_FIGHTING_ENERGY then ct2=ct2+fct
					elseif ener3==CARD_FIGHTING_ENERGY then ct3=ct3+fct end
				end
				local res=count1+count2+count3
				local sum=ct1+ct2+ct3+cct
				if not (Auxiliary.ActivePokemonFilter(c) and c:IsCanAttack()) then return false end
				if cct>0 then
					return sum>=res
				else
					return ct1>=count1 and ct2>=count2 and ct3>=count3
				end
			end
end
Auxiliary.econ3=Auxiliary.AttackCostCondition3
--condition for attacks with an Energy Cost of 4 different Energy
function Auxiliary.AttackCostCondition4(ener1,count1,ener2,count2,ener3,count3,ener4,count4)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local g1=c:GetAttachmentGroup():Filter(Card.IsEnergy,nil,ener1)
				local g2=c:GetAttachmentGroup():Filter(Card.IsEnergy,g1,ener2)
				local g3=c:GetAttachmentGroup():Filter(Card.IsEnergy,g2,ener3)
				local g4=c:GetAttachmentGroup():Filter(Card.IsEnergy,g3,ener4)
				local dcg=c:GetAttachmentGroup():Filter(Card.IsDoubleColorlessEnergy,nil)
				local dwg=c:GetAttachmentGroup():Filter(Card.IsDoubleWaterEnergy,nil)
				local dfg=c:GetAttachmentGroup():Filter(Card.IsDoubleFightingEnergy,nil)
				local ct1=g1:GetCount()
				local ct2=g2:GetCount()
				local ct3=g3:GetCount()
				local ct4=g4:GetCount()
				local cct=dcg:GetCount()*2
				local wct=dwg:GetCount()*2
				local fct=dfg:GetCount()*2
				if ener1==CARD_COLORLESS_ENERGY then ct1=count1
				elseif ener2==CARD_COLORLESS_ENERGY then ct2=count2
				elseif ener3==CARD_COLORLESS_ENERGY then ct3=count3
				elseif ener4==CARD_COLORLESS_ENERGY then ct4=count4 end
				if wct>0 then
					if ener1==CARD_WATER_ENERGY then ct1=ct1+wct
					elseif ener2==CARD_WATER_ENERGY then ct2=ct2+wct
					elseif ener3==CARD_WATER_ENERGY then ct3=ct3+wct
					elseif ener4==CARD_WATER_ENERGY then ct4=ct4+wct end
				end
				if fct>0 then
					if ener1==CARD_FIGHTING_ENERGY then ct1=ct1+fct
					elseif ener2==CARD_FIGHTING_ENERGY then ct2=ct2+fct
					elseif ener3==CARD_FIGHTING_ENERGY then ct3=ct3+fct
					elseif ener4==CARD_FIGHTING_ENERGY then ct4=ct4+fct end
				end
				local res=count1+count2+count3+count4
				local sum=ct1+ct2+ct3+ct4+cct
				if not (Auxiliary.ActivePokemonFilter(c) and c:IsCanAttack()) then return false end
				if cct>0 then
					return sum>=res
				else
					return ct1>=count1 and ct2>=count2 and ct3>=count3 and ct4>=count4
				end
			end
end
Auxiliary.econ4=Auxiliary.AttackCostCondition4
--condition for attacks with an Energy Cost of 5 different energy
function Auxiliary.AttackCostCondition5(ener1,count1,ener2,count2,ener3,count3,ener4,count4,ener5,count5)
	return	function(e,tp,eg,ep,ev,re,r,rp)
				local c=e:GetHandler()
				local g1=c:GetAttachmentGroup():Filter(Card.IsEnergy,nil,ener1)
				local g2=c:GetAttachmentGroup():Filter(Card.IsEnergy,g1,ener2)
				local g3=c:GetAttachmentGroup():Filter(Card.IsEnergy,g2,ener3)
				local g4=c:GetAttachmentGroup():Filter(Card.IsEnergy,g3,ener4)
				local g5=c:GetAttachmentGroup():Filter(Card.IsEnergy,g4,ener5)
				local dcg=c:GetAttachmentGroup():Filter(Card.IsDoubleColorlessEnergy,nil)
				local dwg=c:GetAttachmentGroup():Filter(Card.IsDoubleWaterEnergy,nil)
				local dfg=c:GetAttachmentGroup():Filter(Card.IsDoubleFightingEnergy,nil)
				local ct1=g1:GetCount()
				local ct2=g2:GetCount()
				local ct3=g3:GetCount()
				local ct4=g4:GetCount()
				local ct5=g5:GetCount()
				local cct=dcg:GetCount()*2
				local wct=dwg:GetCount()*2
				local fct=dfg:GetCount()*2
				if ener1==CARD_COLORLESS_ENERGY then ct1=count1
				elseif ener2==CARD_COLORLESS_ENERGY then ct2=count2
				elseif ener3==CARD_COLORLESS_ENERGY then ct3=count3
				elseif ener4==CARD_COLORLESS_ENERGY then ct4=count4
				elseif ener5==CARD_COLORLESS_ENERGY then ct5=count5 end
				if wct>0 then
					if ener1==CARD_WATER_ENERGY then ct1=ct1+wct
					elseif ener2==CARD_WATER_ENERGY then ct2=ct2+wct
					elseif ener3==CARD_WATER_ENERGY then ct3=ct3+wct
					elseif ener4==CARD_WATER_ENERGY then ct4=ct4+wct
					elseif ener5==CARD_WATER_ENERGY then ct5=ct5+wct end
				end
				if fct>0 then
					if ener1==CARD_FIGHTING_ENERGY then ct1=ct1+fct
					elseif ener2==CARD_FIGHTING_ENERGY then ct2=ct2+fct
					elseif ener3==CARD_FIGHTING_ENERGY then ct3=ct3+fct
					elseif ener4==CARD_FIGHTING_ENERGY then ct4=ct4+fct
					elseif ener5==CARD_FIGHTING_ENERGY then ct5=ct5+fct end
				end
				local res=count1+count2+count3+count4+count5
				local sum=ct1+ct2+ct3+ct4+ct5+cct
				if not (Auxiliary.ActivePokemonFilter(c) and c:IsCanAttack()) then return false end
				if cct>0 then
					return sum>=res
				else
					return ct1>=count1 and ct2>=count2 and ct3>=count3 and ct4>=count4 and ct5>=count5
				end
			end
end
Auxiliary.econ5=Auxiliary.AttackCostCondition5

--==========[+Costs]==========
--cost for discarding Energy to a pokémon
function Auxiliary.DiscardEnergyCost(c,min,max,energy)
	--energy: CARD_GRASS_ENERGY for [G], CARD_FIRE_ENERGY for [R], CARD_WATER_ENERGY for [W], etc.
	return	function(e,tp,eg,ep,ev,re,r,rp,chk)
				local max=max or min
				local g=c:GetAttachmentGroup()
				local energy=energy or nil
				if chk==0 then
					if energy then
						return g:IsExists(Card.IsEnergy,min,energy)
					else
						return g:IsExists(Card.IsEnergy,min,nil)
					end
				end
				local sg=nil
				if energy then
					Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARDENERGY)
					sg=g:FilterSelect(tp,Card.IsEnergy,min,max,energy)
				else
					Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARDENERGY)
					sg=g:FilterSelect(tp,Card.IsEnergy,min,max,nil)
				end
				Duel.SendtoDPile(sg,REASON_COST+REASON_DISCARD)
			end
end
Auxiliary.decost=Auxiliary.DiscardEnergyCost

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

--==========[+Lists]==========
--length list for "Blaine's Quiz #1" (Gym Heroes 97/132)
Auxiliary.length_list={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,
31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,}
--height list for "Cedric Juniper" (Legendary Treasures 110/113)
Auxiliary.height_list={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,
31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,}
return Auxiliary
