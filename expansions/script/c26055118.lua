--Colress (Plasma Storm 118/135)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck & draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,nil)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,ct) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,nil)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.Draw(tp,ct,REASON_EFFECT)
end
