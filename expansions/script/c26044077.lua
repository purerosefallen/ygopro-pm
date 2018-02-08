--Interviewer's Questions (Unleashed 77/95)
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
function scard.thfilter(c)
	return c:IsEnergy() and c:IsAbleToHand()
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	local g=Duel.GetDecktopGroup(tp,8)
	Duel.ConfirmCards(tp,g)
	if g:IsExists(scard.thfilter,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
		local sg=g:FilterSelect(tp,scard.thfilter,1,g:GetCount(),nil)
		if sg:GetCount()>0 then
			Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	else pm.SearchFailed(tp,tp) end
end
