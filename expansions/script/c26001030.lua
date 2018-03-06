--Ivysaur (Base Set 30/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--poisoned
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.poiop)
end
scard.pokemon_card=true
scard.length=3.30
scard.evolve_list={[1]=CARD_VENUSAUR}
scard.devolve_list={[1]=CARD_BULBASAUR}
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost1=pm.econ2(CARD_GRASS_ENERGY,1,CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ1(CARD_GRASS_ENERGY,3)
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
end
--poisoned
function scard.poiop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
	pm.EnablePoisoned(Duel.GetDefendingPokemon())
end
