--Silent Lab (Primal Clash 140/160)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadiumAttribute(c)
	--no ability
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(PM_EFFECT_NO_ABILITY)
	e1:SetRange(PM_LOCATION_STADIUM)
	e1:SetTargetRange(PM_LOCATIONS_PHDP,PM_LOCATIONS_PHDP)
	e1:SetTarget(scard.nabtg)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.nabtg(e,c)
	return c:IsBasicPokemon() and (c:IsHasAbility() or bit.band(c:GetOriginalType(),PM_TYPE_ABILITY)==PM_TYPE_ABILITY)
end
