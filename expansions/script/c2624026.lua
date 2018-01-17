--Snorlax (Kalos Starter Set 26/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,PM_CATEGORY_COIN,pm.econ1(CARD_COLORLESS_ENERGY,3),pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,pm.econ1(CARD_COLORLESS_ENERGY,4),pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=6.11
scard.weakness_x2=PM_ENERGY_FIGHTING
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	local ct=10
	if Duel.TossCoin(tp,1)==RESULT_HEADS then ct=ct+30 end
	if ct>10 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(70)
end