--Team Aqua's Walrein (Double Crisis 5/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=4.07
scard.devolve_list={[1]=CARD_TEAM_AQUAS_SEALEO,[2]=CARD_TEAM_AQUAS_SPHEAL}
scard.weakness_x2=PM_ENERGY_METAL
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_WATER_ENERGY,3,CARD_COLORLESS_ENERGY,1)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetAttachmentGroup():FilterCount(Card.IsEnergy,nil)
	Duel.AttackDamage(30*ct)
end
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardEnergy(e,e:GetHandler(),2,2,CARD_WATER_ENERGY)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_POKEMON)
	local g=Duel.SelectMatchingCard(tp,scard.damfilter,tp,0,PM_LOCATION_IN_PLAY,2,2,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.AttackDamage(80,g)
end
