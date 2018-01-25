--Professor Oak's New Theory (HeartGold & SoulSilver 101/123)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck & draw
	pm.EnableTrainerPlay(c,nil,pm.drtg(PLAYER_PLAYER,6),scard.drop)
end
scard.pokemon_card=true
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.Draw(tp,6,REASON_EFFECT)
end
