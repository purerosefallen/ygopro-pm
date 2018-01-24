--Acro Bike (Primal Clash 122/160)
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
	local g=Duel.GetDecktopGroup(tp,2)
	Duel.ConfirmCards(tp,g)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local sg=g:FilterSelect(tp,Card.IsAbleToHand,1,1,nil)
	g:Sub(sg)
	if sg:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
	end
	if g:GetCount()>0 then
		Duel.DisableShuffleCheck()
		Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
	end
end
