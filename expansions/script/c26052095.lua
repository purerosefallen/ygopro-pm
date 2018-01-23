--Hooligans Jim & Cas (Dark Explorers 95/108)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck
	pm.EnableTrainerPlay(c,nil,scard.tdtg,scard.tdop)
end
scard.pokemon_card=true
function scard.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
function scard.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		local sg=g:RandomSelect(tp,3)
		Duel.ConfirmCards(tp,sg)
		Duel.SendtoDeck(sg,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
end
