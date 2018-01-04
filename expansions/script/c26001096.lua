--Double Colorless Energy (Base Set 96/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableEnergyAttribute(c)
	--provide energy
	pm.EnableDoubleEnergy(c,PM_TYPE_DOUBLE_COLORLESS_ENERGY)
end
scard.pokemon_card=true
