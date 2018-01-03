--Axew (Black Star Promo BW26)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage & cannot retreat
	pm.EnablePokemonAttack(c,0,nil,pm.econ1(CARD_COLORLESS_ENERGY,2),pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=2.00
scard.evolve_list={CARD_FRAXURE}
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(e,20)
	local tc=Duel.GetDefendingPokemon(e)
	pm.EnableCannotRetreat(tc,aux.Stringid(sid,1),RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
end
