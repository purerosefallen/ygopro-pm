--Lass (Base Set 75/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck
	pm.EnableTrainerPlay(c,nil,scard.tdtg,scard.tdop)
end
scard.pokemon_card=true
function scard.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,LOCATION_HAND)>0 end
end
function scard.tdfilter(c)
	return c:IsTrainer() and c:IsAbleToDeck()
end
function scard.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if g1:GetCount()>0 then
		Duel.ConfirmCards(1-tp,g1)
		local sg1=g1:Filter(scard.tdfilter,nil)
		Duel.SendtoDeck(sg1,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
		Duel.ShuffleHand(tp)
	end
	local g2=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g2:GetCount()>0 then
		Duel.ConfirmCards(tp,g2)
		local sg2=g2:Filter(scard.tdfilter,nil)
		Duel.SendtoDeck(sg2,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
end
