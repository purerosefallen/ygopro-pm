--Pupitar (Neo Discovery 45/75)
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
scard.length=3.11
scard.evolve_list={[1]=CARD_TYRANITAR}
scard.devolve_list={[1]=CARD_LARVITAR}
scard.weakness_x2=PM_ENERGY_GRASS
scard.resistance_30=PM_ENERGY_LIGHTNING
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ1(CARD_FIGHTING_ENERGY,2)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
end
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon() and not c:IsPokemonType(PM_ENERGY_FIGHTING)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	local g=Duel.GetMatchingGroup(scard.damfilter,tp,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,nil)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		Duel.EffectDamage(10,e:GetHandler(),tc,false,false)
	end
end
