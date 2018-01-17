--Metal Energy (XY 139/140)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableEnergyAttribute(c)
end
scard.pokemon_card=true
