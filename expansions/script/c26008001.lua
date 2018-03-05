--Ampharos (Neo Genesis 1/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--paralyzed
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.parop)
end
scard.pokemon_card=true
scard.length=4.70
scard.devolve_list={[1]=CARD_FLAAFFY,[2]=CARD_MAREEP}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost=pm.econ1(CARD_LIGHTNING_ENERGY,3)
function scard.parop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(40)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	pm.EnableParalyzed(Duel.GetDefendingPokemon())
	local g=Duel.GetMatchingGroup(pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		Duel.EffectDamage(10,e:GetHandler(),tc)
	end
end
