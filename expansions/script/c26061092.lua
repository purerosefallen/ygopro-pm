--Fossil Researcher (Furious Fists 92/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to bench
	pm.EnableTrainerPlay(c,nil,scard.tbtg,scard.tbop)
end
scard.pokemon_card=true
function scard.tbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,PM_LOCATION_BENCH)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.tbfilter(c,e,tp)
	return c:IsCode(CARD_AMAURA,CARD_TYRUNT) and c:IsCanBePutInPlay(e,0,tp,true,false)
end
function scard.tbop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,PM_LOCATION_BENCH)
	if ft<=0 then return end
	if ft>2 then ft=2 end
	pm.ConfirmDeck(tp,tp)
	local g=Duel.GetMatchingGroup(scard.tbfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()==0 then return pm.SearchFailed(tp,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOBENCH)
	local sg=g:Select(tp,1,ft,nil)
	Duel.PutInPlay(sg,0,tp,tp,true,false,PM_POS_FACEUP_UPSIDE)
end
