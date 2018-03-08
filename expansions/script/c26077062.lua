--Lunala Prism Star (Ultra Prism 62/156)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--prism star
	pm.EnablePrismStarAttribute(c)
	--attach
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.atop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_DARKNESS
scard.resistance_20=PM_ENERGY_FIGHTING
scard.attack_cost1=pm.econ1(CARD_PSYCHIC_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_PSYCHIC_ENERGY,4)
--attach
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	if Duel.GetMatchingGroupCount(Card.IsEnergy,tp,PM_LOCATION_DPILE,0,nil,CARD_PSYCHIC_ENERGY)==0
		or Duel.GetMatchingGroupCount(scard.cfilter,tp,PM_LOCATION_IN_PLAY,0,nil)==0 then return end
	local count=Duel.GetMatchingGroupCount(scard.cfilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_PENERGY)
		local g1=Duel.SelectMatchingCard(tp,Card.IsEnergy,tp,PM_LOCATION_DPILE,0,1,1,nil,CARD_PSYCHIC_ENERGY)
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ATTACHENERGY)
		local g2=Duel.SelectMatchingCard(tp,scard.cfilter,tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
		Duel.HintSelection(g2)
		Duel.Attach(g2:GetFirst(),g1)
		count=count-1
	until g1:GetCount()==0 or g2:GetCount()==0 or count==0
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetAttachmentGroup(tp,1,1):FilterCount(Card.IsEnergy,nil)
	Duel.AttackDamage(20*ct)
end
