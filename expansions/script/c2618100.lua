--N (Black & White Promo BW100)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck & draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct1=Duel.GetPrizeGroupCount(tp,tp)
	local ct2=Duel.GetPrizeGroupCount(tp,1-tp)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,ct1) or Duel.IsPlayerCanDraw(1-tp,ct2)
		or Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,LOCATION_HAND,1,e:GetHandler()) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.ShuffleDeck(1-tp)
	Duel.BreakEffect()
	local ct1=Duel.GetPrizeGroupCount(tp,tp)
	local ct2=Duel.GetPrizeGroupCount(tp,1-tp)
	Duel.Draw(tp,ct1,REASON_EFFECT)
	Duel.Draw(1-tp,ct2,REASON_EFFECT)
end
