--Skyarrow Bridge (Next Destinies 91/99)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadium(c)
	--retreat cost down
	pm.EnableRetreatCostChange(c,-1,PM_LOCATION_STADIUM,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,scard.rctg1)
	pm.EnableNoRetreatCost(c,PM_LOCATION_STADIUM,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,scard.rctg2)
end
scard.pokemon_card=true
function scard.rctg1(e,c)
	return c:IsFaceup() and c:IsBasicPokemon() and c:IsRetreatCostAbove(2)
end
function scard.rctg2(e,c)
	return c:IsFaceup() and c:IsBasicPokemon() and c:GetOriginalRetreatCost()<=1
end
