--Amulet Coin (Great Encounters 97/106)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonToolAttribute(c,1)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(PM_EFFECT_TYPE_POKEMON_TOOL+EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(PM_LOCATION_ACTIVE)
	e1:SetCountLimit(1)
	e1:SetCondition(scard.drcon)
	e1:SetTarget(pm.hinttg)
	e1:SetOperation(pm.drop(PLAYER_PLAYER,1))
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsActive() and Duel.GetTurnPlayer()==tp
end
