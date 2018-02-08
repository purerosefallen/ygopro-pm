--Groudon-EX (Dark Explorers 54/108)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.evolve_list={[1]=CARD_PRIMAL_GROUDON_EX}
scard.weakness_x2=PM_ENERGY_WATER
scard.resistance_20=PM_ENERGY_LIGHTNING
scard.attack_cost1=pm.econ2(CARD_FIGHTING_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIGHTING_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
	local g=Duel.GetMatchingGroup(pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		Duel.EffectDamage(10,e:GetHandler(),tc,false,false)
	end
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	local dam=80
	local tc=Duel.GetDefendingPokemon()
	if tc:GetCounter(PM_DAMAGE_COUNTER)>=2 then dam=dam+40 end
	if dam>80 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
end
