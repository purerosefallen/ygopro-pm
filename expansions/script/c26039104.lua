--Broken Time-Space (Platinum 104/127)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadiumAttribute(c)
	--evolve turn play
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(PM_EFFECT_EVOLVE_TURN_PLAY)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(PM_LOCATION_STADIUM)
	e1:SetTargetRange(1,1)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
