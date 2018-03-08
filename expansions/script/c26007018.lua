--Giovanni (Gym Challenge 18/132)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--evolve turn
	pm.EnableTrainerPlay(c,nil,scard.efftg,scard.effop)
end
scard.pokemon_card=true
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(PM_SETNAME_GIOVANNI)
end
function scard.efftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.cfilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
end
function scard.effop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,0))
	local g=Duel.SelectMatchingCard(tp,scard.cfilter,tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	pm.EnableEvolveTurnPlay(g:GetFirst())
end
