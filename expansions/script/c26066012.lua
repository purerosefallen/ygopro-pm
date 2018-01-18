--Chesnaught BREAK (BREAKthrough 12/162)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.devolve_list={CARD_CHESNAUGHT}
scard.attack_cost=pm.econ2(CARD_GRASS_ENERGY,2,CARD_COLORLESS_ENERGY,2)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.AttackDamage(160)
	Duel.EffectDamage(30,c,c)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_BENCHEDPOKEMON)
	local g=Duel.SelectMatchingCard(tp,pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.EffectDamage(30,c,g:GetFirst())
end
