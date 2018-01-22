--Caitlin (Plasma Blast 78/101)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck & draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp)
		or Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,LOCATION_HAND,1,e:GetHandler()) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local max=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TODECKBOT)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,max,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_TOP,REASON_EFFECT)
	local ct=Duel.GetOperatedGroup():Filter(Card.IsLocation,nil,LOCATION_DECK):GetCount()
	if ct==0 then return end
	if ct>1 then Duel.SortDecktop(tp,tp,ct) end
	for i=1,ct do
		local mg=Duel.GetDecktopGroup(tp,1)
		Duel.MoveSequence(mg:GetFirst(),1)
	end
	Duel.BreakEffect()
	Duel.Draw(tp,ct,REASON_EFFECT)
end
