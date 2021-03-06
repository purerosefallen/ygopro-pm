--Haxorus (Noble Victories 89/101)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--paralyzed
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.parop)
end
scard.pokemon_card=true
scard.height=5.11
scard.devolve_list={[1]=CARD_FRAXURE,[2]=CARD_AXEW}
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,3)
scard.attack_cost2=pm.econ1(CARD_COLORLESS_ENERGY,4)
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(60)
end
--paralyzed
function scard.parop(e,tp,eg,ep,ev,re,r,rp)
	local dam=80
	local c1,c2=Duel.TossCoin(tp,2)
	if c1+c2==RESULT_HEADS+RESULT_HEADS then
		Duel.AttackDamage(dam)
		local tc=Duel.GetDefendingPokemon()
		pm.EnableParalyzed(tc)
	elseif c1+c2==RESULT_TAILS+RESULT_TAILS then
		dam=0
		Duel.AttackDamage(dam)
	end
end
