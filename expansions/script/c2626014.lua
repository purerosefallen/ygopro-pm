--Team Magma's Aggron (Double Crisis 14/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=6.11
scard.devolve_list={[1]=CARD_TEAM_MAGMAS_LAIRON,[2]=CARD_TEAM_MAGMAS_ARON}
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost1=pm.econ2(CARD_FIGHTING_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIGHTING_ENERGY,3,CARD_COLORLESS_ENERGY,1)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	local ag=Duel.GetAttachmentGroup(tp,1,0)
	local max=ag:FilterCount(Card.IsEnergy,nil,CARD_FIGHTING_ENERGY)
	if max==0 then return Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon()) end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARDENERGY)
	local sg=ag:FilterSelect(tp,Card.IsEnergy,1,max,nil,CARD_FIGHTING_ENERGY)
	local dam=Duel.SendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
	Duel.AttackDamage(40*dam)
end
function scard.damfilter(c)
	return pm.BenchPokemonFilter(c) and c:GetCounter(PM_DAMAGE_COUNTER)>0
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(120)
	local g=Duel.GetMatchingGroup(scard.damfilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		Duel.EffectDamage(20,e:GetHandler(),tc)
	end
end
