--Sitrus Berry (Unseen Forces 91/115)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonTool(c,1)
	--heal
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(PM_EFFECT_TYPE_POKEMON_TOOL+EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCondition(scard.healcon)
	e1:SetTarget(pm.hinttg)
	e1:SetOperation(scard.healop)
	e1:SetLabelObject(c)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
function scard.healcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(PM_DAMAGE_COUNTER)>=3
end
function scard.healop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(tp,PM_DAMAGE_COUNTER,3,REASON_EFFECT)
	Duel.SendtoDPile(e:GetLabelObject(),REASON_EFFECT)
end
