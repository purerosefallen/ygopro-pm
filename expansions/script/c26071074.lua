--Brock's Grit (Evolutions 74/108)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck
	pm.EnableTrainerPlay(c,nil,scard.tdtg,scard.tdop)
end
scard.pokemon_card=true
function scard.tdfilter(c)
	return (c:IsPokemon() or c:IsBasicEnergy()) and c:IsAbleToDeck()
end
function scard.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.tdfilter,tp,PM_LOCATION_DPILE,0,1,nil) end
end
function scard.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,scard.tdfilter,tp,PM_LOCATION_DPILE,0,6,6,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
end
