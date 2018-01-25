--Gold Potion (Boundaries Crossed 140/149)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--ace spec
	pm.EnableDeckRestriction(c,PM_EFFECT_RESTRICT_ACE_SPEC)
	--heal
	pm.EnableTrainerPlay(c,nil,scard.healtg,scard.healop)
end
scard.pokemon_card=true
function scard.healfilter(c)
	return pm.ActivePokemonFilter(c) and c:GetCounter(PM_DAMAGE_COUNTER)>0
end
function scard.healtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.healfilter,tp,PM_LOCATION_ACTIVE,0,1,nil) end
end
function scard.healop(e,tp,eg,ep,ev,re,r,rp)
	Duel.HealDamage(e,90,Duel.GetAttackingPokemon())
end
