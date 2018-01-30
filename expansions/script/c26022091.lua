--Surprise! Time Machine (EX Team Rocket Returns 91/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--devolve & evolve
	pm.EnableTrainerPlay(c,nil,scard.devtg,scard.devop)
end
scard.pokemon_card=true
function scard.devfilter(c)
	return c:IsFaceup() and c:IsEvolved() and c:IsAbleToDeck()
end
function scard.devtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.devfilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
end
function scard.cfilter(c,e,tp)
	if not c:IsDevolved() then return false end
	local code=c:GetOriginalCode()
	local class=_G["c"..code]
	if class==nil or class.evolve_list==nil then return false end
	return Duel.IsExistingMatchingCard(scard.evofilter,tp,LOCATION_DECK,0,1,nil,e,tp,class)
end
function scard.evofilter(c,e,tp,class)
	return c:IsEvolution() and c:IsCode(class.evolve_list[1])
		and c:IsCanBePutInPlay(e,PM_SUMMON_TYPE_EVOLVE,tp,false,false)
end
function scard.devop(e,tp,eg,ep,ev,re,r,rp)
	pm.devop(scard.devfilter,PM_LOCATION_IN_PLAY,0,LOCATION_DECK,DECK_ORDER_SHUFFLE,true)(e,tp,eg,ep,ev,re,r,rp)
	pm.evoop(scard.cfilter,PM_LOCATION_IN_PLAY,0,scard.evofilter,LOCATION_DECK,0)(e,tp,eg,ep,ev,re,r,rp)
end
