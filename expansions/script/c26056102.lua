--Shadow Triad (Plasma Freeze 102/116)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to hand
	pm.EnableTrainerPlay(c,PM_CATEGORY_TOHAND,scard.thtg,scard.thop)
end
scard.pokemon_card=true
function scard.thfilter(c)
	return c:IsSetCard(PM_SETNAME_TEAM_PLASMA) and c:IsAbleToHand()
end
function scard.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.thfilter,tp,PM_LOCATION_DPILE,0,1,nil) end
	Duel.SetOperationInfo(0,PM_CATEGORY_TOHAND,nil,1,tp,PM_LOCATION_DPILE)
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,PM_LOCATION_DPILE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end
