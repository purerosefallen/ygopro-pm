--Weedle (Kalos Starter Set 1/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--paralyzed
	pm.EnablePokemonAttack(c,0,PM_CATEGORY_COIN,scard.attack_cost,pm.hinttg,scard.parop)
end
scard.pokemon_card=true
scard.height=1.00
scard.evolve_list={[1]=CARD_KAKUNA,[2]=CARD_BEEDRIL}
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost=pm.econ1(CARD_GRASS_ENERGY,1)
function scard.parop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnableParalyzed(Duel.GetDefendingPokemon()) end
end
