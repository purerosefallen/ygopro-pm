--Moonlight Stadium (Great Encounters 100/106)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadiumAttribute(c)
	--no retreat cost
	pm.EnableNoRetreatCost(c,PM_LOCATION_STADIUM,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,scard.rctg)
end
scard.pokemon_card=true
function scard.rctg(e,c)
	return c:IsFaceup() and c:IsPokemon() and c:IsPokemonType(PM_ENERGY_PSYCHIC+PM_ENERGY_DARKNESS)
end
