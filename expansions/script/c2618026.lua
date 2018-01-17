--Axew (Black Star Promo BW26)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--cannot retreat
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.abop)
end
scard.pokemon_card=true
scard.height=2.00
scard.evolve_list={CARD_FRAXURE}
scard.attack_cost=pm.econ1(CARD_COLORLESS_ENERGY,2)
function scard.abop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
	local tc=Duel.GetDefendingPokemon()
	pm.EnableCannotRetreat(tc,aux.Stringid(sid,1),RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
end
