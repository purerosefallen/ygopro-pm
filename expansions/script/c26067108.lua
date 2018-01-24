--Psychic's Third Eye (BREAKpoint 108/122)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--discard hand & draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return or Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0
		or Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler()) or Duel.IsPlayerCanDraw(tp) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		Duel.ShuffleHand(1-tp)
	end
	local ft=Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ft<=0 then return end
	local ct=Duel.DiscardHand(tp,nil,1,ft,REASON_EFFECT+REASON_DISCARD)
	Duel.BreakEffect()
	Duel.Draw(tp,ct,REASON_EFFECT)
end
