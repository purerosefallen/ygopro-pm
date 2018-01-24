--Sky Field (Roaring Skies 89/108)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadiumAttribute(c)
	--extend bench
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(PM_EFFECT_EXTEND_BENCH_8)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(PM_LOCATION_STADIUM)
	e1:SetTargetRange(1,1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE_FIELD)
	e2:SetCondition(scard.zcon)
	e2:SetOperation(scard.zop)
	e2:SetLabel(8)
	Duel.RegisterEffect(e2,0)
	local e3=e2:Clone()
	e3:SetLabel(12)
	Duel.RegisterEffect(e3,0)
	--leave play 
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(sid,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(PM_EVENT_LEAVE_PLAY)
	e4:SetOperation(scard.leaveop)
	c:RegisterEffect(e4)
end
scard.pokemon_card=true
function scard.zcon(e)
	return e:GetHandler():IsOnField() and e:GetHandler():IsFaceup()
end
function scard.zop(e)
	return bit.lshift(0x1,e:GetLabel())
end
function scard.leaveop(e)
	local tp=e:GetHandlerPlayer()
	local ct1=Duel.GetMatchingGroupCount(pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	local ct2=Duel.GetMatchingGroupCount(pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	if ct1>5 then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARD)
		local g=Duel.SelectMatchingCard(tp,pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,0,ct1-5,ct1-5,nil)
		if g:GetCount()==0 then return end
		Duel.SendtoDPile(g,REASON_RULE+REASON_DISCARD)
	end
	if ct2>5 then
		Duel.Hint(HINT_SELECTMSG,1-tp,PM_HINTMSG_DISCARD)
		local g=Duel.SelectMatchingCard(1-tp,pm.BenchPokemonFilter,1-tp,PM_LOCATION_IN_PLAY,0,ct2-5,ct2-5,nil)
		if g:GetCount()==0 then return end
		Duel.SendtoDPile(g,REASON_RULE+REASON_DISCARD)
	end
end
