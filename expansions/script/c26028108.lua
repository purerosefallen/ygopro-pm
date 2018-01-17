--Lightning Energy (EX Holon Phantoms 108/110)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableEnergyAttribute(c)
end
scard.pokemon_card=true
