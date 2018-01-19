--Team Magma's Baltoy (Double Crisis 10/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=1.08
scard.evolve_list={[1]=CARD_TEAM_MAGMAS_CLAYDOL}
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ2(CARD_PSYCHIC_ENERGY,1,CARD_COLORLESS_ENERGY,1)
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_POKEMON)
	local g=Duel.SelectMatchingCard(tp,scard.damfilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.AttackDamage(20,g,false,false)
end
