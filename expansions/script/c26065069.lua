--Ace Trainer (Ancient Origins 69/98)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck & draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop,scard.drcon)
end
scard.pokemon_card=true
function scard.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetPrizeGroupCount(tp,tp)>Duel.GetPrizeGroupCount(tp,1-tp)
end
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,6) or Duel.IsPlayerCanDraw(1-tp,3) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.ShuffleDeck(1-tp)
	Duel.BreakEffect()
	Duel.Draw(tp,6,REASON_EFFECT)
	Duel.Draw(1-tp,3,REASON_EFFECT)
end
