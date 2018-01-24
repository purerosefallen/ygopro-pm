--Team Aqua's Sealeo (Double Crisis 4/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=3.07
scard.evolve_list={[1]=CARD_TEAM_AQUAS_WALREIN}
scard.devolve_list={[1]=CARD_TEAM_AQUAS_SPHEAL}
scard.weakness_x2=PM_ENERGY_METAL
scard.attack_cost1=pm.econ2(CARD_WATER_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_WATER_ENERGY,1,CARD_COLORLESS_ENERGY,2)
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_POKEMON)
	local g=Duel.SelectMatchingCard(tp,scard.damfilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.AttackDamage(20,g)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	local ct=60
	if Duel.GetDefendingPokemon():IsSetCard(PM_SETNAME_TEAM_MAGMA) then ct=ct+60 end
	if ct>60 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
