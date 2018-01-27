--Mystery Plate Delta (Skyridge 136/144)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableTechnicalMachineAttribute(c,1,true)
	--gain attack (search)
	pm.AddTrainerAttack(c,0,nil,scard.attack_cost,scard.thtg,scard.thop)
end
scard.pokemon_card=true
scard.attack_cost=pm.econ1(CARD_COLORLESS_ENERGY,1)
function scard.rmcfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetCounter(PM_DAMAGE_COUNTER)>0
end
function scard.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetPrizeGroupCount(tp,1-tp)>=5 then
			return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		elseif Duel.GetPrizeGroupCount(tp,1-tp)==2 then
			return Duel.IsExistingMatchingCard(scard.rmcfilter,tp,PM_LOCATION_IN_PLAY,0,1,nil)
		else return false end
	end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.thfilter(c)
	return c:IsBasicEnergy() and c:IsAbleToHand()
end
function scard.thop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetPrizeGroupCount(tp,1-tp)>=5 then
		pm.ConfirmDeck(tp,tp)
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
		local g=Duel.SelectMatchingCard(tp,scard.thfilter,tp,LOCATION_DECK,0,1,3,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		else pm.SearchFailed(tp,tp) end
	end
	if Duel.GetPrizeGroupCount(tp,1-tp)==2 then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_REMOVEDAMAGE)
		local g=Duel.SelectMatchingCard(tp,scard.rmcfilter,tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.HintSelection(g)
		local tc=g:GetFirst()
		local ct=tc:GetCounter(PM_DAMAGE_COUNTER)
		Duel.RemoveDamage(e,ct,tc)
	end
end
