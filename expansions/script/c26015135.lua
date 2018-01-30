--Mystery Plate Gamma (Skyridge 135/144)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnableTechnicalMachineAttribute(c,1,true)
	--gain attack (to deck & draw)
	pm.AddTrainerAttack(c,0,nil,scard.attack_cost,scard.drtg,scard.drop)
end
scard.pokemon_card=true
scard.attack_cost=pm.econ1(CARD_COLORLESS_ENERGY,1)
function scard.devfilter(c)
	return c:IsFaceup() and c:IsEvolved() and c:IsAbleToDeck()
end
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetPrizeGroupCount(tp,1-tp)>=5 then
			return Duel.IsPlayerCanDraw(tp,6)
		elseif Duel.GetPrizeGroupCount(tp,1-tp)==2 then
			return Duel.IsExistingMatchingCard(scard.devfilter,tp,PM_LOCATION_IN_PLAY,0,1,nil)
		else return false end
	end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetPrizeGroupCount(tp,1-tp)>=5 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
		Duel.ShuffleDeck(tp)
		Duel.BreakEffect()
		Duel.Draw(tp,6,REASON_EFFECT)
	end
	if Duel.GetPrizeGroupCount(tp,1-tp)==2 then
		pm.devop(scard.devfilter,0,PM_LOCATION_IN_PLAY,LOCATION_DECK,DECK_ORDER_BOTTOM)(e,tp,eg,ep,ev,re,r,rp)
	end
end
