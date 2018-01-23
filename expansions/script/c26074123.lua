--Sophocles (Burning Shadows 123/147)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--discard hand & draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())>0
		and Duel.IsPlayerCanDraw(tp,4) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.DiscardHand(tp,nil,2,2,REASON_EFFECT+REASON_DISCARD)~=2 then return end
	Duel.BreakEffect()
	Duel.Draw(tp,4,REASON_EFFECT)
end
