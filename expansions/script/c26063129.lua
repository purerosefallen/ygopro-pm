--Fresh Water Set (Primal Clash 129/160)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--heal
	pm.EnableTrainerPlay(c,nil,scard.healtg,scard.healop)
end
scard.pokemon_card=true
function scard.healfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetCounter(PM_DAMAGE_COUNTER)>0
end
function scard.healtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.healfilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
end
function scard.healop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.healfilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		Duel.HealDamage(e,20,tc)
	end
end
