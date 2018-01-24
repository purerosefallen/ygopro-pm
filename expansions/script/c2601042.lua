--Pokémon Tower (Black Star Promo Wizards of the Coast 42)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadiumAttribute(c)
	--cannot to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_QUICK_F)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetRange(PM_LOCATION_STADIUM)
	e1:SetCondition(scard.effcon)
	e1:SetOperation(scard.effop)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.effcon(e,tp,eg,ep,ev,re,r,rp)
	local ex1,g1,gc1,dp1,dv1=Duel.GetOperationInfo(ev,PM_CATEGORY_TOHAND)
	return ex1 and bit.band(dv1,PM_LOCATION_DPILE)==PM_LOCATION_DPILE and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function scard.effop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
