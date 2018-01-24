--Brock's Protection (Gym Challenge 101/132)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--attach
	pm.EnableTrainerAttach(c,1,scard.atfilter,PM_LOCATION_IN_PLAY,0,aux.Stringid(sid,0))
	--cannot remove energy
	local e1=Effect.CreateEffect(c)
	e1:SetType(PM_EFFECT_TYPE_ATTACHED_TRAINER)
	e1:SetCode(PM_EFFECT_CANNOT_REMOVE_ENERGY_ATTACK_TRAINER)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.atfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(PM_SETNAME_BROCK)
end
