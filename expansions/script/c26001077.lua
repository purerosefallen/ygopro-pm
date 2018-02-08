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
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		and Duel.IsExistingMatchingCard(scard.tdfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
end
function scard.thfilter(c)
	return (c:IsBasicPokemon() or c:IsEvolution()) and c:IsAbleToHand()
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.tdfilter,tp,LOCATION_HAND,0,nil)
	if g:GetCount()==0 then return end
	pm.ConfirmDeck(tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local sg1=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if sg1:GetCount()==0 then return pm.SearchFailed(tp,tp) end
	Duel.SendtoHand(sg1,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg1)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TODECK)
	local sg2=g:Select(tp,1,1,nil)
	Duel.ConfirmCards(1-tp,sg2)
	Duel.SendtoDeck(sg2,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
end
