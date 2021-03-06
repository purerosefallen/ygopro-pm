--Team Aqua's Mightyena (Double Crisis 18/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--discard energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.height=3.03
scard.devolve_list={[1]=CARD_TEAM_AQUAS_POOCHYENA}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_20=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ2(CARD_WATER_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_WATER_ENERGY,2,CARD_COLORLESS_ENERGY,1)
--damage
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(PM_SETNAME_TEAM_AQUA)
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local count=Duel.GetMatchingGroupCount(scard.damfilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	local dam=0
	repeat
		if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+1 end
		count=count-1
	until count==0
	Duel.AttackDamage(30*dam)
end
--discard energy
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(80)
	local tc=Duel.GetDefendingPokemon()
	if not tc:IsAbleToRemoveEnergy() then return Duel.Hint(HINT_CARD,0,CARD_BROCKS_PROTECTION) end
	if Duel.TossCoin(tp,1)==RESULT_HEADS then Duel.DiscardEnergy(e,tc,1) end
end
