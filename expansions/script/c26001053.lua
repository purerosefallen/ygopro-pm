--Magnemite (Base Set 53/102)
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
scard.length=1.00
scard.evolve_list={[1]=CARD_MAGNETON,[2]=CARD_MAGNEZONE}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost1=pm.econ1(CARD_LIGHTNING_ENERGY,1)
scard.attack_cost1=pm.econ2(CARD_LIGHTNING_ENERGY,1,CARD_COLORLESS_ENERGY,1)
--paralyzed
function scard.parop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnableParalyzed(Duel.GetDefendingPokemon()) end
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(40)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,nil)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		Duel.EffectDamage(10,c,tc)
	end
	Duel.EffectDamage(40,c,c,false,false)
end
