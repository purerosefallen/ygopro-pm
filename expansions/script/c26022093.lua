--Venture Bomb (EX Team Rocket Returns 93/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--add counter
	pm.EnableTrainerPlay(c,nil,scard.cttg,scard.ctop)
end
scard.pokemon_card=true
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.ctfilter,tp,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,1,nil) end
end
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	local s,o=PM_LOCATION_IN_PLAY,0
	if Duel.TossCoin(tp,1)==RESULT_HEADS then s,o=0,PM_LOCATION_IN_PLAY end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ADDDAMAGE)
	local g=Duel.SelectMatchingCard(tp,scard.ctfilter,tp,s,o,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	g:GetFirst():AddCounter(PM_DAMAGE_COUNTER,1)
end
