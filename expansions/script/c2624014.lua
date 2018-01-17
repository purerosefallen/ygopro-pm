--Greninja (Kalos Starter Set 14/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--discard energy
	pm.EnablePokemonAttack(c,0,PM_CATEGORY_COIN,scard.attack_cost1,pm.hinttg,scard.deop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=4.11
scard.evolve_list={CARD_GRENINJA_BREAK}
scard.devolve_list={CARD_FROGADIER,CARD_FROAKIE}
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost1=pm.econ1(CARD_WATER_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_WATER_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(40)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then Duel.DiscardEnergy(e,Duel.GetDefendingPokemon(),1) end
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(80)
end
