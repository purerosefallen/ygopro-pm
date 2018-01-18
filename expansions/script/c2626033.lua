--Double Aqua Energy (Double Crisis 33/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableEnergyAttribute(c,PM_SETNAME_TEAM_AQUA,true)
	--provide energy
	pm.EnableDoubleEnergy(c,PM_TYPE_DOUBLE_WATER_ENERGY)
end
scard.pokemon_card=true
