--Delinquent (BREAKpoint 98/122)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--discard hand
	pm.EnableTrainerPlay(c,nil,scard.dhtg,scard.dhop,nil,scard.dhcost)
end
scard.pokemon_card=true
function scard.dhcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,PM_LOCATION_STADIUM,PM_LOCATION_STADIUM,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,nil,tp,PM_LOCATION_STADIUM,PM_LOCATION_STADIUM,1,1,nil)
	Duel.HintSelection(g)
	Duel.SendtoDPile(g,REASON_COST+REASON_DISCARD)
end
function scard.dhtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
function scard.dhop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardHand(1-tp,nil,3,3,REASON_EFFECT+REASON_DISCARD)
end
