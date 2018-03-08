--Ralts (EX Ruby & Sapphire 66/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--confused
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.conop)
end
scard.pokemon_card=true
scard.evolve_list={[1]=CARD_KIRLIA,[2]=CARD_GARDEVOIR}
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ1(CARD_PSYCHIC_ENERGY,1)
function scard.conop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnableConfused(Duel.GetDefendingPokemon()) end
end
