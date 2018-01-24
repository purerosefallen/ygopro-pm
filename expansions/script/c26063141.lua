--Teammates (Primal Clash 141/160)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--search
	pm.EnableTrainerPlay(c,nil,scard.thtg,scard.thop,scard.thcon)
	if not scard.global_check then
		scard.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(PM_EVENT_KNOCKED_OUT)
		ge1:SetOperation(scard.regop)
		Duel.RegisterEffect(ge1,0)
	end
end
scard.pokemon_card=true
function scard.regop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local p1=false
	local p2=false
	for tc in aux.Next(eg) do
		if tc:IsPokemon() and tc:IsPreviousLocation(PM_LOCATION_IN_PLAY) and Duel.GetTurnPlayer()==1 then
			if tc:GetPreviousControler()==0 then p1=true else p2=true end
		end
	end
	if p1 then Duel.RegisterFlagEffect(0,sid,RESET_PHASE+EVENT_PHASE_START+PHASE_DRAW,0,2) end
	if p2 then Duel.RegisterFlagEffect(1,sid,RESET_PHASE+EVENT_PHASE_START+PHASE_DRAW,0,2) end
end
function scard.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,sid)~=0
end
function scard.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	pm.ConfirmDeck(tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToHand,tp,LOCATION_DECK,0,1,2,nil)
	if g:GetCount()==0 then return pm.ConfirmInvalid(tp,tp) end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
end
