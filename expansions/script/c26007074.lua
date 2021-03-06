--Giovanni's Meowth (Gym Challenge 74/132)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--confused
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.conop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.length=1.40
scard.evolve_list={[1]=CARD_GIOVANNIS_PERSIAN}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_30=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_COLORLESS_ENERGY,3)
--confused
function scard.conop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetDefendingPokemon()
	Duel.PokemonAttack(e:GetHandler(),tc)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnableConfused(tc) end
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
end
