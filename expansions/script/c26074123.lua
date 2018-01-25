--Sophocles (Burning Shadows 123/147)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--discard hand & draw
	pm.EnableTrainerPlay(c,nil,pm.drtg(PLAYER_PLAYER,4),pm.drop(PLAYER_PLAYER,4),nil,pm.dhcost(2))
end
scard.pokemon_card=true
