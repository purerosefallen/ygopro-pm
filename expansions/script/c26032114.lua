--Speed Stadium (Diamond & Pearl 114/130)
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
	e1:SetTarget(pm.drtg(PLAYER_PLAYER,1))
	e1:SetOperation(scard.drop)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local ct=0
	repeat
		local res=Duel.TossCoin(tp,1)
		if res==RESULT_HEADS then ct=ct+1 end
	until res==RESULT_TAILS
	Duel.Draw(tp,ct,REASON_EFFECT)
end
