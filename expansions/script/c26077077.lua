--Darkrai Prism Star (Ultra Prism 77/156)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--prism star
	pm.EnablePrismStarAttribute(c)
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(PM_EVENT_PLAY_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(scard.atcon)
	e1:SetTarget(scard.attg)
	e1:SetOperation(scard.atop)
	c:RegisterEffect(e1)
	--asleep
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.aslop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_20=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ1(CARD_DARKNESS_ENERGY,4)
function scard.atcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) and Duel.GetTurnPlayer()==tp
end
function scard.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsEnergy,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DENERGY)
	local g=Duel.SelectMatchingCard(tp,Card.IsEnergy,tp,LOCATION_HAND,0,2,2,nil,CARD_DARKNESS_ENERGY)
	if g:GetCount()==0 then return end
	Duel.Attach(e:GetHandler(),g)
end
function scard.aslop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(120)
	local c=e:GetHandler()
	local tc=Duel.GetDefendingPokemon()
	c:SetCardTarget(tc)
	pm.EnableAsleep(tc)
	--increase flip for asleep
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,2))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(PM_EFFECT_ASLEEP_TOSS_2_COIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(0,1)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_ADJUST)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCondition(scard.rscon)
	e2:SetOperation(scard.rsop)
	e2:SetLabelObject(e1)
	Duel.RegisterEffect(e2,tp)
	tc:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,0,1)
end
function scard.rscon(e)
	local tc=e:GetHandler():GetFirstCardTarget()
	return not tc:IsAsleep() and tc:GetFlagEffect(sid)~=0
end
function scard.rsop(e)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	tc:ResetFlagEffect(sid)
	c:CancelCardTarget(tc)
	local e1=e:GetLabelObject()
	e1:Reset()
	e:Reset()
end
