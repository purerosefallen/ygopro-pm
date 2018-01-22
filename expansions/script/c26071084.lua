--Professor Oak's Hint (Evolutions 84/108)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--draw & end turn
	pm.EnableTrainerPlay(c,nil,scard.drtg,scard.drop)
end
scard.pokemon_card=true
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=7-Duel.GetMatchingGroupCount(nil,tp,LOCATION_HAND,0,e:GetHandler())
	if chk==0 then return ct>0 and Duel.IsPlayerCanDraw(tp,ct) end
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	local ct=7-Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)
	if ct<=0 then return end
	Duel.Draw(tp,ct,REASON_EFFECT)
	Duel.BreakEffect()
	Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
