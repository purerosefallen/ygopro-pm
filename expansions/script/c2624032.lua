--Furfrou (Kalos Starter Set 32/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--paralyzed
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.parop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=3.11
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ1(CARD_COLORLESS_ENERGY,3)
function scard.parop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnableParalyzed(Duel.GetDefendingPokemon()) end
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(50)
end
