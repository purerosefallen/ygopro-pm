--Energy Stadium (Neo Destiny 99/105)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadium(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetCategory(PM_CATEGORY_COIN+PM_CATEGORY_RECYCLE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(PM_LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetTarget(scard.thtg)
	e1:SetOperation(scard.thop)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.thfilter(c)
	return c:IsBasicEnergy() and c:IsAbleToHand()
end
function scard.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.thfilter,tp,PM_LOCATION_DPILE,0,1,nil) end
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.TossCoin(tp,1)
	if res==RESULT_HEADS then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
		local g=Duel.SelectMatchingCard(tp,Card.IsBasicEnergy,tp,PM_LOCATION_DPILE,0,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
