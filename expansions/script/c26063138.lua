--Scorched Earth (Primal Clash 138/160)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadium(c)
	--discard hand & draw
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
function scard.drfilter(c)
	return c:IsEnergy(CARD_FIRE_ENERGY) or c:IsEnergy(CARD_FIGHTING_ENERGY)
end
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.drfilter,tp,LOCATION_HAND,0,1,nil)
		and Duel.IsPlayerCanDraw(tp,2) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,scard.drfilter,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 then return end
	if Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)==0 then return end
	Duel.BreakEffect()
	Duel.Draw(tp,2,REASON_EFFECT)
end
