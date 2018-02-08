--Tickling Machine (Gym Heroes 119/132)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--destroy hand or end turn
	pm.EnableTrainerPlay(c,nil,scard.dhtg,scard.dhop)
end
scard.pokemon_card=true
function scard.dhtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
function scard.dhop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_HAND,nil)
		if g:GetCount()==0 then return end
		Duel.SetAside(g,POS_FACEDOWN,REASON_EFFECT)
		local og=Duel.GetOperatedGroup()
		local tc=og:GetFirst()
		for tc in aux.Next(og) do
			tc:RegisterFlagEffect(sid,RESET_EVENT+RESETS_STANDARD,0,1)
		end
		og:KeepAlive()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCountLimit(1)
		e1:SetLabel(0)
		e1:SetLabelObject(og)
		e1:SetCondition(scard.thcon)
		e1:SetOperation(scard.thop)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		Duel.RegisterEffect(e1,tp)
	else pm.EndTurn(e) end
end
function scard.thfilter(c)
	return c:GetFlagEffect(sid)~=0
end
function scard.thcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	return g:IsExists(scard.thfilter,1,nil) and Duel.GetTurnPlayer()==1-tp and Duel.GetTurnCount()~=e:GetLabel()
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	local code=e:GetHandler():GetOriginalCode()
	Duel.Hint(HINT_CARD,0,code)
	local g=e:GetLabelObject()
	local sg=g:Filter(scard.thfilter,nil)
	g:DeleteGroup()
	local tc=sg:GetFirst()
	for tc in aux.Next(sg) do
		Duel.SendtoHand(tc,1-tp,REASON_EFFECT)
	end
end
