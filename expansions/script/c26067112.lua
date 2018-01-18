--Tierno (BREAKpoint 112/122)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--draw
	pm.EnableTrainerPlay(c,nil,pm.drtg(PLAYER_PLAYER,3),pm.drop(PLAYER_PLAYER,3))
end
scard.pokemon_card=true
