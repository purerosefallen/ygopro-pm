--Team Aqua's Secret Base (Double Crisis 28/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableStadium(c)
	--retreat cost up
	pm.EnableRetreatCostChange(c,1,PM_LOCATION_STADIUM,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,scard.rctg)
end
scard.pokemon_card=true
function scard.rctg(e,c)
	return c:IsFaceup() and c:IsPokemon() and not c:IsSetCard(PM_SETNAME_TEAM_AQUA)
end
