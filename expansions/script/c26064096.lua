--Winona (Roaring Skies 96/108)
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
function scard.thfilter(c)
	return c:IsPokemon() and c:IsPokemonType(PM_TYPE_COLORLESS) and c:IsAbleToHand()
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	pm.ConfirmDeck(tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,1,3,nil)
	if g:GetCount()==0 then return pm.ConfirmInvalid(tp,tp) end
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g)
end