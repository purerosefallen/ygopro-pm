--Power Spray (Platinum 117/127)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--prevent effects
	local e1=Effect.CreateEffect(c)
	e1:SetType(PM_EFFECT_TYPE_PLAY)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(scard.effcon)
	e1:SetOperation(scard.effop)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemonSP()
end
function scard.effcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(scard.cfilter,tp,PM_LOCATION_IN_PLAY,0,3,nil) and Duel.GetTurnPlayer()~=tp
		and re:IsActiveType(PM_TYPE_POKEMON) and re:IsHasProperty(PM_EFFECT_FLAG_POKEPOWER)
end
function scard.effop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
