--Maintenance (Base Set 83/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--draw
	pm.EnableTrainerPlay(c,nil,pm.drtg(PLAYER_PLAYER,1),pm.drop(PLAYER_PLAYER,1),nil,pm.tdcost(LOCATION_HAND,2))
end
scard.pokemon_card=true
