--Sabrina's ESP (Gym Heroes 117/132)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableTrainerAttach(c,0,scard.cfilter,PM_LOCATION_IN_PLAY,0,aux.Stringid(sid,1),true)
	--re-flip coin
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,3))
	e1:SetType(PM_EFFECT_TYPE_ATTACHED_TRAINER+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(PM_EVENT_TOSS_COIN_NEGATE)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCondition(scard.coincon)
	e1:SetOperation(scard.coinop)
	c:RegisterEffect(e1)
end
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(PM_SETNAME_SABRINA)
end
function scard.coincon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetFlagEffect(tp,CARD_SABRINAS_ESP)==0 and re:IsHasProperty(PM_EFFECT_FLAG_POKEMON_ATTACK)
end
function scard.coinop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,CARD_SABRINAS_ESP)~=0 then return end
	if not Duel.SelectYesNo(tp,aux.Stringid(CARD_SABRINAS_ESP,2)) then return end
	Duel.Hint(HINT_CARD,0,CARD_SABRINAS_ESP)
	Duel.RegisterFlagEffect(tp,CARD_SABRINAS_ESP,RESET_PHASE+PHASE_END,0,1)
	Duel.TossCoin(tp,ev)
end
