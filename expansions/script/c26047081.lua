--Lost World (Call of Legends 81/95)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadiumAttribute(c)
	--win
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e1:SetRange(PM_LOCATION_STADIUM)
	e1:SetCountLimit(1)
	e1:SetCondition(scard.wincon)
	e1:SetOperation(scard.winop)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.wincon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(pm.LostZoneFilter(Card.IsPokemon),tp,0,PM_LOCATION_LOST,6,nil)
end
function scard.winop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Win(tp,PM_WIN_REASON_LOST_WORLD)
end
