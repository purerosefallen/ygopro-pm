--Scorched Earth (Primal Clash 138/160)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadiumAttribute(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(PM_LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:Setcost(scard.drcost)
	e1:SetTarget(pm.drtg(PLAYER_PLAYER,2))
	e1:SetOperation(pm.drop(PLAYER_PLAYER,2))
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.costfilter(c)
	return c:IsEnergy(CARD_FIRE_ENERGY) or c:IsEnergy(CARD_FIGHTING_ENERGY)
end
function scard.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,scard.costfilter,1,1,REASON_COST+REASON_DISCARD,nil)
end
