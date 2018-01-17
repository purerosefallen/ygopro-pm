--Furfrou (Kalos Starter Set 33/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--paralyzed
	pm.EnablePokemonAttack(c,0,PM_CATEGORY_COIN,pm.econ1(CARD_COLORLESS_ENERGY,2),pm.hinttg,scard.parop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,pm.econ1(CARD_COLORLESS_ENERGY,3),pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=3.11
scard.weakness_x2=PM_ENERGY_FIGHTING
function scard.parop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnableParalyzed(Duel.GetDefendingPokemon()) end
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(50)
end
