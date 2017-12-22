--Balloon Berry (Neo Revelation 60/64)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--pokémon tool
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(PM_DESC_TOOL)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(pm.PokemonToolTarget)
	e1:SetOperation(scard.ptop)
	c:RegisterEffect(e1)
	--retreat cost replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(PM_EFFECT_TYPE_POKEMON_TOOL)
	e2:SetCode(PM_EFFECT_NO_RETREAT_COST)
	e2:SetRange(PM_LOCATION_ACTIVE)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(PM_EFFECT_RETREAT_COST_REPLACE)
	c:RegisterEffect(e3)
	if not scard.global_check then
		scard.global_check=true
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD)
		ge1:SetCode(PM_EFFECT_RETREAT_COST_REPLACE)
		ge1:SetTargetRange(PM_LOCATION_ATTACHED,PM_LOCATION_ATTACHED)
		ge1:SetTarget(aux.TargetBoolFunction(Card.IsCode,sid))
		Duel.RegisterEffect(ge1,0)
	end
end
scard.pokemon_card=true
function scard.ptop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ATTACHTOOL)
	local g=Duel.SelectMatchingCard(tp,pm.PokemonToolFilter,tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	Duel.HintSelection(g)
	Duel.Attach(tc,Group.FromCards(e:GetHandler()))
	--register description
	tc:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(sid,0))
	tc:RegisterFlagEffect(sid+1,RESET_EVENT+RESETS_STANDARD,EFFECT_FLAG_CLIENT_HINT,1,0,aux.Stringid(sid,1))
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCondition(scard.resetcon)
	e1:SetOperation(scard.resetop)
	tc:RegisterEffect(e1)
end
function scard.resetcon(e)
	return e:GetHandler():IsBench() and e:GetHandler():GetFlagEffect(sid)~=0 and e:GetHandler():GetFlagEffect(sid+1)~=0
end
function scard.resetop(e)
	e:GetHandler():ResetFlagEffect(sid)
	e:GetHandler():ResetFlagEffect(sid+1)
end
