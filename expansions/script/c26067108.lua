--Psychic's Third Eye (BREAKpoint 108/122)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--discard hand & draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 or Duel.IsPlayerCanDraw(tp) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		Duel.ShuffleHand(1-tp)
	end
	local max=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if max<=0 then return end
	local ct=Duel.DiscardHand(tp,nil,1,max,REASON_EFFECT+REASON_DISCARD)
	Duel.BreakEffect()
	Duel.Draw(tp,ct,REASON_EFFECT)
end
