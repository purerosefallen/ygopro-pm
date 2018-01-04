--Haxorus (Noble Victories 89/101)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,pm.econ1(CARD_COLORLESS_ENERGY,3),pm.hinttg,scard.damop)
	--paralyzed
	pm.EnablePokemonAttack(c,1,PM_CATEGORY_COIN,pm.econ1(CARD_COLORLESS_ENERGY,4),pm.hinttg,scard.parop)
end
scard.pokemon_card=true
scard.height=5.11
scard.devolve_list={CARD_FRAXURE,CARD_AXEW}
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(60)
end
function scard.parop(e,tp,eg,ep,ev,re,r,rp)
	local ct=80
	local c1,c2=Duel.TossCoin(tp,2)
	if c1+c2==RESULT_HEADS+RESULT_HEADS then
		Duel.AttackDamage(ct)
		local tc=Duel.GetDefendingPokemon()
		pm.EnableParalyzed(tc)
	elseif c1+c2==RESULT_TAILS+RESULT_TAILS then
		ct=0
		Duel.AttackDamage(ct)
	end
end
