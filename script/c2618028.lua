--Tropical Beach (Black & White Promo BW28)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadium(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(PM_LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetTarget(scard.drtg)
	e1:SetOperation(scard.drop)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=7-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,ct) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local ct=7-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ct==0 then return end
	if Duel.Draw(tp,ct,REASON_EFFECT)==0 then return end
	Duel.BreakEffect()
	Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
end
