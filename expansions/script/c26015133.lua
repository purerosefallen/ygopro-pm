--Mystery Plate Alpha (Skyridge 133/144)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableTechnicalMachineAttribute(c,1,true)
	--gain attack (search)
	pm.AddTrainerAttack(c,0,nil,scard.attack_cost,scard.thtg,scard.thop)
end
scard.pokemon_card=true
scard.attack_cost=pm.econ1(CARD_COLORLESS_ENERGY,1)
function scard.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetPrizeGroupCount(tp,1-tp)>=5 then
			return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		elseif Duel.GetPrizeGroupCount(tp,1-tp)==1 then
			return Duel.GetDefendingPokemon()
		else return false end
	end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.thfilter(c)
	return c:IsTrainer() and c:IsAbleToHand()
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetPrizeGroupCount(tp,1-tp)>=5 then
		pm.ConfirmDeck(tp,tp)
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
		local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		else pm.SearchFailed(tp,tp) end
	end
	if Duel.GetPrizeGroupCount(tp,1-tp)==1 then
		local tc=Duel.GetDefendingPokemon()
		pm.EnableBurned(tc)
		pm.EnableParalyzed(tc)
		pm.EnablePoisoned(tc)
	end
end
