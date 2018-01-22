--Professor Oak's Visit (Secret Wonders 122/132)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--draw & to deck
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,3,REASON_EFFECT)>0 then Duel.ShuffleHand(tp) end
	Duel.BreakEffect()
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TODECKBOT)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_BOTTOM,REASON_EFFECT)
end
