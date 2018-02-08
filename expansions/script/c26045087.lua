--Kyogre & Groudon LEGEND (Undaunted 87/90)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--legend
	pm.EnableLEGENDAttribute(c)
	--discard deck
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.ddop1)
	--discard deck
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.ddop2)
end
scard.pokemon_card=true
scard.legend_top_half=CARD_KYOGRE_AND_GROUDON_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_GRASS,[2]=PM_ENERGY_LIGHTNING}
scard.attack_cost1=pm.econ2(CARD_WATER_ENERGY,2,CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ2(CARD_FIGHTING_ENERGY,2,CARD_COLORLESS_ENERGY,2)
function scard.ddop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	Duel.DiscardDeck(1-tp,5,REASON_EFFECT)
	local dam=Duel.GetOperatedGroup():FilterCount(Card.IsEnergy,nil)
	if dam==0 then return end
	local dg=Duel.GetMatchingGroup(pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	if dg:GetCount()==0 then return end
	local tc=dg:GetFirst()
	for tc in aux.Next(dg) do
		Duel.EffectDamage(30*dam,c,tc,false,false)
	end
end
function scard.ddop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,5,REASON_EFFECT)
	local dam=Duel.GetOperatedGroup():FilterCount(Card.IsEnergy,nil)
	if dam==0 then return Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon()) end
	Duel.AttackDamage(100*dam)
end
