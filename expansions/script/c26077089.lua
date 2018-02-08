--Solgaleo Prism Star (Ultra Prism 89/156)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--prism star
	pm.EnablePrismStarAttribute(c)
	--attach
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.atop)
	--cannot attack
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.effop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_FIRE
scard.resistance_20=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ1(CARD_METAL_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_METAL_ENERGY,4)
--attach
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	local g1=Duel.GetMatchingGroup(Card.IsEnergy,tp,PM_LOCATION_DPILE,0,nil,CARD_METAL_ENERGY)
	local g2=Duel.GetMatchingGroup(scard.cfilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	local ct=Duel.GetMatchingGroupCount(scard.cfilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_MENERGY)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,2))
		local sg2=g2:Select(tp,1,1,nil)
		Duel.HintSelection(sg2)
		Duel.Attach(sg2:GetFirst(),sg1)
		ct=ct-1
	until sg1:GetCount()==0 or sg2:GetCount()==0 or ct==0
end
--cannot attack
function scard.effop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(160)
	local c=e:GetHandler()
	pm.EnableCannotAttack(c,aux.Stringid(sid,3),RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
end
