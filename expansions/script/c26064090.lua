--Steven (Roaring Skies 90/108)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--search
	pm.EnableTrainerPlay(c,nil,scard.thtg,scard.thop)
end
scard.pokemon_card=true
function scard.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.thfilter1(c)
	return c:IsSupporter() and c:IsAbleToHand()
end
function scard.thfilter2(c)
	return c:IsBasicEnergy() and c:IsAbleToHand()
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	pm.ConfirmDeck(tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local sg1=Duel.SelectMatchingCard(tp,scard.thfilter1,tp,LOCATION_DECK,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local sg2=Duel.SelectMatchingCard(tp,scard.thfilter2,tp,LOCATION_DECK,0,1,1,nil)
	if sg1:GetCount()==0 and sg2:GetCount()==0 then return pm.ConfirmInvalid(tp,tp) end
	sg1:Merge(sg2)
	Duel.SendtoHand(sg1,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg1)
end