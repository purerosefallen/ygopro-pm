--Double Magma Energy (Double Crisis 34/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableEnergyAttribute(c,PM_SETNAME_TEAM_MAGMA,true)
	--provide energy
	pm.EnableDoubleEnergy(c,PM_TYPE_DOUBLE_FIGHTING_ENERGY)
end
scard.pokemon_card=true
