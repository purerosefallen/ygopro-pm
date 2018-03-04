--Sneasel ex (EX Ruby & Sapphire 103/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_30=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ1(CARD_DARKNESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_DARKNESS_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local dam=c1+c2
	Duel.AttackDamage(10*dam)
end
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(scard.damfilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	local dam=0
	repeat
		local res=Duel.TossCoin(tp,1)
		if res==RESULT_HEADS then dam=dam+1 end
		ct=ct-1
	until ct==0
	Duel.AttackDamage(20*dam)
end
