--Ghetsis (Plasma Freeze 101/116)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck
	pm.EnableTrainerPlay(c,nil,scard.tdtg,scard.tdop)
end
scard.pokemon_card=true
function scard.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 and Duel.IsPlayerCanDraw(tp) end
end
function scard.tdfilter(c)
	return c:IsItem() and c:IsAbleToDeck()
end
function scard.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()<=0 then return end
	Duel.ConfirmCards(tp,g)
	local sg=g:Filter(scard.tdfilter,nil)
	Duel.SendtoDeck(sg,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleHand(1-tp)
	local ct=Duel.GetOperatedGroup():FilterCount(Card.IsLocation,nil,LOCATION_DECK)
	if ct==0 then return end
	Duel.BreakEffect()
	Duel.Draw(tp,ct,REASON_EFFECT)
end
