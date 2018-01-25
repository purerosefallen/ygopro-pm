--Professor Juniper (Black & White 101/114)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--discard hand & draw
	pm.EnableTrainerPlay(c,nil,pm.drtg(PLAYER_PLAYER,7),pm.drop(PLAYER_PLAYER,7),nil,scard.drcost)
end
scard.pokemon_card=true
scard.clone=true
function scard.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDPile(g,REASON_COST+REASON_DISCARD)
end
