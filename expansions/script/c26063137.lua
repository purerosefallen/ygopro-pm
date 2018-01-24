--Rough Seas (Primal Clash 137/160)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadiumAttribute(c)
	--heal
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(PM_LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetTarget(scard.healtg)
	e1:SetOperation(scard.healop)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.healfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsPokemonType(PM_ENERGY_WATER+PM_ENERGY_LIGHTNING)
		and c:GetCounter(PM_DAMAGE_COUNTER)>0
end
function scard.healtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.healfilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
end
function scard.healop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.healfilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		Duel.HealDamage(e,30,tc)
	end
end
