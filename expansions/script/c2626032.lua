--Team Magma's Secret Base (Double Crisis 32/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadiumAttribute(c)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(PM_EVENT_PLAY_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(PM_LOCATION_STADIUM)
	e1:SetCondition(scard.ctcon)
	e1:SetOperation(scard.ctop)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.cfilter(c)
	return c:IsBasicPokemon() and not c:IsSetCard(PM_SETNAME_TEAM_MAGMA)
		and c:IsPreviousLocation(LOCATION_HAND) and c:IsBench()
end
function scard.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return eg and eg:GetCount()==1 and eg:IsExists(scard.cfilter,1,nil)
end
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	eg:GetFirst():AddCounter(PM_DAMAGE_COUNTER,2)
end
