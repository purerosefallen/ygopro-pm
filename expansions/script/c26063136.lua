--Repeat Ball (Primal Clash 136/160)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--search
	pm.EnableTrainerPlay(c,nil,scard.thtg,scard.thop)
end
scard.pokemon_card=true
function scard.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.cfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.thfilter(c,...)
	return c:IsPokemon() and c:IsCode(...) and c:IsAbleToHand()
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(scard.cfilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	local tc=g1:GetFirst()
	local t={}
	for tc in aux.Next(g1) do
		table.insert(t,tc:GetCode())
	end
	pm.ConfirmDeck(tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local g2=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,1,1,nil,table.unpack(t))
	if g2:GetCount()==0 then return pm.ConfirmInvalid(tp,tp) end
	Duel.SendtoHand(g2,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g2)
end
