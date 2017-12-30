--Fraxure (Noble Victories 87/101)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,pm.econ1(CARD_COLORLESS_ENERGY,1),pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,PM_CATEGORY_COIN,pm.econ1(CARD_COLORLESS_ENERGY,2),pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=3.03
scard.devolve_list={CARD_AXEW}
scard.evolve_list={CARD_HAXORUS}
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	pm.AttackDamage(e,20)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local ct=c1+c2
	pm.AttackDamage(e,ct*30)
end
