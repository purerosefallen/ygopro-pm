--Mysterious Fossil (Fossil 62/62)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--play
	pm.EnableTrainerPlay(c,nil,scard.pltg,scard.plop)
end
scard.pokemon_card=true
scard.evolve_list={[1]=CARD_OMANYTE}
function scard.pltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,PM_LOCATION_BENCH)>0 
		and Duel.IsPlayerCanPutPokemonInPlay(tp,sid,PM_TYPE_BASIC_POKEMON,PM_TYPE_POKEMON,10,10,0,RACE_DINOSAUR,0) end
end
function scard.plop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,PM_LOCATION_BENCH)<=0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e)
		or not Duel.IsPlayerCanPutPokemonInPlay(tp,sid,PM_TYPE_BASIC_POKEMON,PM_TYPE_POKEMON,10,10,0,RACE_DINOSAUR,0) then return end
	c:AddPokemonAttribute(PM_TYPE_POKEMON,0,RACE_DINOSAUR,0,10,10)
	Duel.PutInPlayStep(c,0,tp,tp,true,false,PM_POS_FACEUP_UPSIDE)
	c:AddPokemonAttributeComplete()
	c:SetStatus(PM_STATUS_NO_RETREAT_COST,true)
	--self discard
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetTarget(pm.hinttg)
	e1:SetOperation(scard.tgop)
	e1:SetReset(RESET_EVENT+0x47c0000)
	c:RegisterEffect(e1,true)
	--treat as basic pokémon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(sid,1))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(PM_EFFECT_ADD_SETCODE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
	e2:SetValue(PM_TYPE_BASIC_POKEMON)
	e2:SetReset(RESET_EVENT+0x47c0000)
	c:RegisterEffect(e2,true)
	local e3=e2:Clone()
	e3:SetCode(PM_EFFECT_REMOVE_TYPE)
	e3:SetValue(PM_TYPE_TRAINER)
	c:RegisterEffect(e3,true)
	--no attack
	local e4=e2:Clone()
	e4:SetDescription(aux.Stringid(sid,2))
	e4:SetCode(PM_EFFECT_NO_ATTACK)
	c:RegisterEffect(e4,true)
	--cannot retreat
	local e5=e2:Clone()
	e5:SetDescription(aux.Stringid(sid,3))
	e5:SetCode(PM_EFFECT_CANNOT_RETREAT)
	c:RegisterEffect(e5,true)
	--cannot be asleep
	local e6=e2:Clone()
	e6:SetDescription(aux.Stringid(sid,4))
	e6:SetCode(PM_EFFECT_CANNOT_BE_ASLEEP)
	c:RegisterEffect(e6,true)
	--cannot be confused
	local e7=e6:Clone()
	e7:SetCode(PM_EFFECT_CANNOT_BE_CONFUSED)
	c:RegisterEffect(e7,true)
	--cannot be paralyzed
	local e8=e6:Clone()
	e8:SetCode(PM_EFFECT_CANNOT_BE_PARALYZED)
	c:RegisterEffect(e8,true)
	--cannot be poisoned
	local e9=e6:Clone()
	e9:SetCode(PM_EFFECT_CANNOT_BE_POISONED)
	c:RegisterEffect(e9,true)
	--cannot be knocked out
	local e10=Effect.CreateEffect(c)
	e10:SetDescription(aux.Stringid(sid,4))
	e10:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(PM_EFFECT_KNOCK_OUT_REPLACE)
	e10:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e10:SetRange(PM_LOCATION_IN_PLAY)
	e10:SetTarget(scard.reptg)
	e10:SetOperation(scard.repop)
	e10:SetReset(RESET_EVENT+0x47c0000)
	c:RegisterEffect(e10,true)
	Duel.PutInPlayComplete()
end
function scard.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not (c:IsRelateToEffect(e) and c:IsLocation(PM_LOCATION_IN_PLAY)) then return end
	Duel.SendtoDPile(c,REASON_EFFECT+REASON_DISCARD)
end
function scard.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsFaceup() and c:IsOnField() and c:IsAbleToDPile() end
	if not c:IsReason(REASON_REPLACE) and c:IsAbleToDPile() then return true
	else return false end
end
function scard.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoDPile(e:GetHandler(),REASON_RULE+REASON_REPLACE)
end
