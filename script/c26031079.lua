--Phoebe's Stadium (Power Keepers 79/108)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadium(c)
	--retreat cost down
	pm.EnableRetreatCostChange(c,-2,PM_LOCATION_STADIUM,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,scard.rctg1)
	pm.EnableNoRetreatCost(c,PM_LOCATION_STADIUM,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,scard.rctg2)
end
scard.pokemon_card=true
function scard.rctg1(e,c)
	return c:IsFaceup() and c:IsPokemon() and c:IsPokemonType(PM_ENERGY_PSYCHIC) and c:IsRetreatCostAbove(3)
end
function scard.rctg2(e,c)
	return c:IsFaceup() and c:IsPokemon() and c:IsPokemonType(PM_ENERGY_PSYCHIC) and c:GetOriginalRetreatCost()<=2
end
