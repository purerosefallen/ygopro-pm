--Potion (BREAKpoint 106/122)
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
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_HEAL)
	local g=Duel.SelectMatchingCard(tp,scard.healfilter,tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.HealDamage(e,30,g:GetFirst())
end
