--Fletchling (Kalos Starter Set 31/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,PM_CATEGORY_COIN,pm.econ1(CARD_COLORLESS_ENERGY,1),pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=1.00
scard.weakness_x2=PM_ENERGY_LIGHTNING
scard.resistance_20=PM_ENERGY_FIGHTING
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=20
	if Duel.TossCoin(tp,1)==RESULT_TAILS then ct=0 end
	Duel.AttackDamage(ct)
end
