--Wally (Roaring Skies 94/108)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--evolve
	pm.EnableTrainerPlay(c,nil,pm.evotg(scard.cfilter,PM_LOCATION_IN_PLAY,0),
	pm.evoop(scard.cfilter,PM_LOCATION_IN_PLAY,0,scard.evofilter,LOCATION_DECK,0))
end
scard.pokemon_card=true
function scard.cfilter(c,e,tp)
	if not c:IsPokemon() or c:IsPokemonEX() then return false end
	local code=c:GetOriginalCode()
	local class=_G["c"..code]
	if class==nil or class.evolve_list==nil then return false end
	local b=Duel.IsExistingMatchingCard(scard.evofilter,tp,LOCATION_DECK,0,1,nil,e,tp,class)
	if not b then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
	else return b end
end
function scard.evofilter(c,e,tp,class)
	return c:IsCode(class.evolve_list[1]) and c:IsCanBePutInPlay(e,PM_SUMMON_TYPE_EVOLVE,tp,false,false)
end
