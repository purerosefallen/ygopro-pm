--Team Aqua's Mightyena (Double Crisis 18/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,PM_CATEGORY_COIN,scard.attack_cost1,pm.hinttg,scard.damop)
	--discard energy
	pm.EnablePokemonAttack(c,1,PM_CATEGORY_COIN,scard.attack_cost2,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.height=3.03
scard.devolve_list={CARD_TEAM_AQUAS_POOCHYENA}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_20=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ2(CARD_WATER_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_WATER_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(PM_SETNAME_TEAM_AQUA)
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local count=Duel.GetMatchingGroupCount(scard.damfilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	local ct=0
	repeat
		if Duel.TossCoin(tp,1)==RESULT_HEADS then ct=ct+1 end
		count=count-1
	until count==0
	Duel.AttackDamage(30*ct)
end
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(80)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then Duel.DiscardEnergy(e,Duel.GetDefendingPokemon(),1) end
end
