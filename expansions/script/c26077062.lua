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
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	local g1=Duel.GetMatchingGroup(Card.IsEnergy,tp,PM_LOCATION_DPILE,0,nil,CARD_PSYCHIC_ENERGY)
	local g2=Duel.GetMatchingGroup(scard.cfilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	local ct=Duel.GetMatchingGroupCount(scard.cfilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_PENERGY)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,2))
		local sg2=g2:Select(tp,1,1,nil)
		Duel.HintSelection(sg2)
		Duel.Attach(sg2:GetFirst(),sg1)
		ct=ct-1
	until sg1:GetCount()==0 or sg2:GetCount()==0 or ct==0
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetAttachmentGroup(tp,1,1):FilterCount(Card.IsEnergy,nil)
	Duel.AttackDamage(20*ct)
end
