--Ilima (Sun & Moon 121/149)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck & draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,LOCATION_HAND,1,e:GetHandler())
		or Duel.IsPlayerCanDraw(tp) or Duel.IsPlayerCanDraw(1-tp) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.ShuffleDeck(1-tp)
	Duel.BreakEffect()
	local ct1=3
	local ct2=3
	if Duel.TossCoin(tp,1)==RESULT_HEADS then ct1=6 end
	Duel.Draw(tp,ct1,REASON_EFFECT)
	if Duel.TossCoin(1-tp,1)==RESULT_HEADS then ct2=6 end
	Duel.Draw(1-tp,ct2,REASON_EFFECT)
end
