--Rare Candy (EX Sandstorm 88/100)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--evolve
	pm.EnableTrainerPlay(c,nil,pm.evotg(scard.cfilter,PM_LOCATION_IN_PLAY,0),
	pm.evoop(scard.cfilter,PM_LOCATION_IN_PLAY,0,scard.evofilter,LOCATION_HAND,0),pm.nfturncon)
end
scard.pokemon_card=true
function scard.cfilter(c,e,tp)
	if not c:IsFaceup() or not c:IsBasicPokemon() or c:IsStatus(PM_STATUS_PLAY_TURN) then return false end
	local code=c:GetOriginalCode()
	local class=_G["c"..code]
	if class==nil or class.evolve_list==nil then return false end
	return Duel.IsExistingMatchingCard(scard.evofilter,tp,LOCATION_HAND,0,1,nil,e,tp,class)
end
function scard.evofilter(c,e,tp,class)
	return c:IsStage2() and c:IsCode(class.evolve_list[2])
		and c:IsCanBePutInPlay(e,PM_SUMMON_TYPE_EVOLVE,tp,false,false)
end
