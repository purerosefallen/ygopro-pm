--Team Magma's Great Ball (Double Crisis 31/34)
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
function scard.thfilter1(c)
	return c:IsBasicPokemon() and c:IsSetCard(PM_SETNAME_TEAM_MAGMA) and c:IsAbleToHand()
end
function scard.thfilter2(c)
	return c:IsBasicEnergy() and c:IsEnergy(CARD_FIGHTING_ENERGY) and c:IsAbleToHand()
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	pm.ConfirmDeck(tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local g1=Duel.SelectMatchingCard(tp,scard.thfilter1,tp,LOCATION_DECK,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local g2=Duel.SelectMatchingCard(tp,scard.thfilter2,tp,LOCATION_DECK,0,1,1,nil)
	if g1:GetCount()==0 and g2:GetCount()==0 then return pm.ConfirmInvalid(tp,tp) end
	g1:Merge(g2)
	Duel.SendtoHand(g1,PLAYER_OWNER,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,g1)
end
