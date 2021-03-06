--Oracle (Skyridge 138/144)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck
	pm.EnableTrainerPlay(c,nil,scard.tdtg,scard.tdop)
end
scard.pokemon_card=true
function scard.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.tdop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==1 then return pm.ConfirmDeck(tp,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TODECKTOP)
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,2,2,nil)
	if g:GetCount()==0 then return pm.SearchFailed(tp,player) end
	Duel.ShuffleDeck(tp)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		Duel.MoveSequence(tc,DECK_ORDER_TOP)
	end
	Duel.SortDecktop(tp,tp,2)
end
