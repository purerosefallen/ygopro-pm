--Team Aqua's Seviper (Double Crisis 9/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--poisoned
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.poiop)
	--discard energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.height=8.10
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ1(CARD_PSYCHIC_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_COLORLESS_ENERGY,2)
function scard.poiop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnablePoisoned(Duel.GetDefendingPokemon()) end
end
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
	local tc=Duel.GetDefendingPokemon()
	if not tc:IsAffectedBySpecialCondition() then return end
	Duel.DiscardEnergy(e,tc,1)
end
