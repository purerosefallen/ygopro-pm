--Sage's Training (Undaunted 77/90)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to hand
	pm.EnableTrainerPlay(c,nil,scard.thtg,scard.thop)
end
scard.pokemon_card=true
function scard.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	local g=Duel.GetDecktopGroup(tp,5)
	Duel.ConfirmCards(tp,g)
	if g:IsExists(Card.IsAbleToHand,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
		local sg=g:FilterSelect(tp,Card.IsAbleToHand,2,2,nil)
		g:Sub(sg)
		if sg:GetCount()>0 then
			Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
			Duel.ShuffleHand(tp)
		end
		if g:GetCount()>0 then
			Duel.DisableShuffleCheck()
			Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
		end
	else Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD) end
end
