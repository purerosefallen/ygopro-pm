--Misty's Determination (BREAKpoint 104/122)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to hand
	pm.EnableTrainerPlay(c,nil,scard.thtg,scard.thop)
end
scard.pokemon_card=true
function scard.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())<=0 then return false end
	if chk==0 then return true end
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARD)
	local g1=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,1,nil)
	if g1:GetCount()==0 then return end
	if Duel.SendtoDPile(g1,REASON_EFFECT+REASON_DISCARD)==0 then return end
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	local g2=Duel.GetDecktopGroup(tp,8)
	if g2:IsExists(Card.IsAbleToHand,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
		local sg=g2:FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ShuffleHand(tp)
		Duel.ShuffleDeck(tp)
	else
		Duel.Hint(HINT_MESSAGE,tp,PM_DESC_NO_TARGETS)
		Duel.ShuffleDeck(tp)
	end
end
