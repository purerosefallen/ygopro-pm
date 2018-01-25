--Copycat (Expedition Base Set 138/165)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck & draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,ct) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.Draw(tp,ct,REASON_EFFECT)
end
