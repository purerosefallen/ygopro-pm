--Braixen (Kalos Starter Set 9/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,PM_CATEGORY_COIN,pm.econ2(CARD_FIRE_ENERGY,1,CARD_COLORLESS_ENERGY,1),pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,pm.econ2(CARD_FIRE_ENERGY,1,CARD_COLORLESS_ENERGY,2),pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=3.03
scard.evolve_list={CARD_DELPHOX,CARD_DELPHOX_BREAK}
scard.devolve_list={CARD_FENNEKIN}
scard.weakness_x2=PM_ENERGY_WATER
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	local ct=20
	if Duel.TossCoin(tp,1)==RESULT_HEADS then ct=ct+20 end
	if ct>20 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(60)
end