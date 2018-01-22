--TV Reporter (EX Dragon 88/97)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--draw & discard hand
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Draw(tp,3,REASON_EFFECT)>0 then Duel.ShuffleHand(tp) end
	Duel.BreakEffect()
	Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
end
