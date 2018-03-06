--Natu (Neo Genesis 67/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	c:SetStatus(PM_STATUS_NO_RETREAT_COST,true)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=0.80
scard.evolve_list={[1]=CARD_XATU}
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_PSYCHIC_ENERGY,2)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
end
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DAMAGE)
	local g=Duel.SelectMatchingCard(tp,scard.damfilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.EffectDamage(20,c,g:GetFirst(),false,false)
end
