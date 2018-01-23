--Pokémon Trader (Base Set 77/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--search
	pm.EnableTrainerPlay(c,nil,scard.thtg,scard.thop)
end
scard.pokemon_card=true
function scard.tdfilter(c)
	return (c:IsBasicPokemon() or c:IsEvolution()) and c:IsAbleToDeck()
end
function scard.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>-1
		and Duel.IsExistingMatchingCard(scard.tdfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
end
function scard.thfilter(c)
	return (c:IsBasicPokemon() or c:IsEvolution()) and c:IsAbleToHand()
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TODECKTOP)
	local g1=Duel.SelectMatchingCard(tp,scard.tdfilter,tp,LOCATION_HAND,0,1,1,nil)
	if g1:GetCount()==0 then return end
	Duel.SendtoDeck(g1,PLAYER_OWNER,DECK_ORDER_TOP,REASON_EFFECT)
	if Duel.GetOperatedGroup():FilterCount(Card.IsLocation,nil,LOCATION_DECK)==0 then return end
	pm.ConfirmDeck(tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local g2=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g2:GetCount()==0 then return pm.ConfirmInvalid(tp,tp) end
	Duel.SendtoHand(g2,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g2)
end
