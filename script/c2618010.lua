--Axew (Black Star Promo BW10)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,PM_CATEGORY_COIN,pm.econ1(CARD_COLORLESS_ENERGY,2),pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=2.00
scard.evolve_list={CARD_FRAXURE}
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=50
	local c1,c2=Duel.TossCoin(tp,2)
	if c1+c2~=RESULT_HEADS+RESULT_HEADS then ct=0 end
	pm.AttackDamage(e,ct)
end