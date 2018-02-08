--Thought Wave Machine (Neo Destiny 96/105)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--return & end turn
	pm.EnableTrainerPlay(c,nil,scard.rettg,scard.retop)
end
scard.pokemon_card=true
function scard.retfilter(c)
	return pm.ActivePokemonFilter(c) and c:GetAttachmentGroup():IsExists(Card.IsEnergy,1,nil) and c:IsAbleToHand()
end
function scard.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.retfilter,tp,0,PM_LOCATION_IN_PLAY,1,nil) end
end
function scard.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.retfilter,tp,0,PM_LOCATION_ACTIVE,nil)
	if g:GetCount()>0 then
		local ag=g:GetFirst():GetAttachmentGroup()
		if ag:GetCount()==0 then return end
		local ct=0
		repeat
			local res=Duel.TossCoin(tp,1)
			if res==RESULT_HEADS then ct=ct+1 end
		until res==RESULT_TAILS
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,0))
		local sg=ag:FilterSelect(tp,Card.IsEnergy,ct,ct,nil)
		local tc=sg:GetFirst()
		if tc and not tc:IsAbleToRemoveEnergy() then return Duel.Hint(HINT_CARD,0,CARD_BROCKS_PROTECTION) end
		Duel.SendtoHand(sg,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(tp,sg)
	end
	pm.EndTurn(e)
end
