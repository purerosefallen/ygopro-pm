--Brock's Sandslash (Gym Challenge 36/132)
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
scard.devolve_list={[1]=CARD_BROCKS_SANDSHREW}
scard.weakness_x2=PM_ENERGY_GRASS
scard.resistance_30=PM_ENERGY_LIGHTNING
scard.attack_cost1=pm.econ2(CARD_FIGHTING_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_FIGHTING_ENERGY,2)
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20,Duel.GetDefendingPokemon(),false,false,false)
end
--poisoned
function scard.poiop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnablePoisoned(Duel.GetDefendingPokemon()) end
end
