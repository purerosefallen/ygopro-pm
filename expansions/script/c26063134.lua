--Professor Birch's Observations (Primal Clash 134/160)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck & draw
	pm.EnableTrainerPlay(c,nil,pm.drtg(PLAYER_PLAYER),scard.drop)
end
scard.pokemon_card=true
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local ct=4
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	if Duel.TossCoin(tp,1)==RESULT_HEADS then ct=7 end
	Duel.Draw(tp,ct,REASON_EFFECT)
end
