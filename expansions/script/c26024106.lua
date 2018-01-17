--Fighting Energy (EX Emerald 106/106)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableEnergyAttribute(c)
end
scard.pokemon_card=true
