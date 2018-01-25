--Professor Oak (Base Set 88/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--discard hand & draw
	pm.EnableTrainerPlay(c,nil,pm.drtg(PLAYER_PLAYER,7),scard.drop)
end
scard.pokemon_card=true
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDPile(g,REASON_EFFECT+REASON_DISCARD)
	Duel.BreakEffect()
	Duel.Draw(tp,7,REASON_EFFECT)
end
