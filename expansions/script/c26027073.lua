--Fieldworker (EX Legend Maker 73/92)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--draw
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) or Duel.IsPlayerCanDraw(1-tp,1) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,3,REASON_EFFECT)
	if Duel.SelectOption(1-tp,PM_QHINTMSG_DRAW) then Duel.Draw(1-tp,1,REASON_EFFECT) end
end
