--Mystery Plate Beta (Skyridge 134/144)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableTechnicalMachineAttribute(c,1,true)
	--gain attack (draw)
	pm.AddTrainerAttack(c,0,nil,scard.attack_cost,scard.drtg,scard.drop)
end
scard.pokemon_card=true
scard.attack_cost=pm.econ1(CARD_COLORLESS_ENERGY,1)
function scard.drfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachmentGroup():IsExists(Card.IsEnergy,1,nil)
end
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetPrizeGroupCount(tp,1-tp)>=5 then
			return Duel.IsPlayerCanDraw(tp,3)
		elseif Duel.GetPrizeGroupCount(tp,1-tp)==1 then
			return Duel.IsExistingMatchingCard(scard.drfilter,tp,0,PM_LOCATION_IN_PLAY,1,nil)
		else return false end
	end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetPrizeGroupCount(tp,1-tp)>=5 then
		Duel.Draw(tp,3,REASON_EFFECT)
	end
	if Duel.GetPrizeGroupCount(tp,1-tp)==1 then
		local g=Duel.GetDefendingPokemon():GetAttachmentGroup()
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TODECK)
		local sg=g:FilterSelect(tp,Card.IsEnergy,2,2,nil)
		Duel.SendtoDeck(sg,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
	end
end
