--Archie's Ace in the Hole (Primal Clash 124/160)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to bench
	pm.EnableTrainerPlay(c,nil,scard.tbtg,scard.tbop,scard.tbcon)
end
scard.pokemon_card=true
function scard.tbcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==1
end
function scard.tbfilter(c,e,tp)
	return c:IsPokemon() and c:IsPokemonType(PM_ENERGY_WATER) and c:IsCanBePutInPlay(e,0,tp,false,false)
end
function scard.tbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,PM_LOCATION_BENCH)>0
		and Duel.IsExistingMatchingCard(scard.tbfilter,tp,PM_LOCATION_DPILE,0,1,nil,e,tp)
		and Duel.IsPlayerCanDraw(tp,5) end
end
function scard.tbop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,PM_LOCATION_BENCH)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOBENCH)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,PM_LOCATION_DPILE,0,1,1,nil)
	if g:GetCount()==0 then return end
	if Duel.PutInPlay(g,0,tp,tp,false,false,PM_POS_FACEUP_UPSIDE)==0 then return end
	Duel.BreakEffect()
	Duel.Draw(tp,5,PLAYER_EFFECT)
end
