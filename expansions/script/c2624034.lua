--Crushing Hammer (Kalos Starter Set 34/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--discard energy
	pm.EnableTrainerPlay(c,nil,scard.detg,scard.deop)
end
scard.pokemon_card=true
function scard.defilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachmentGroup():IsExists(Card.IsEnergy,1,nil)
end
function scard.detg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.defilter,tp,0,PM_LOCATION_IN_PLAY,1,nil) end
end
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARDENERGYFROM)
		local g=Duel.SelectMatchingCard(tp,scard.defilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
		local tc=g:GetFirst()
		if not tc then return end
		Duel.HintSelection(g)
		if not tc:IsAbleToRemoveEnergy() then return Duel.Hint(HINT_CARD,0,CARD_BROCKS_PROTECTION) end
		Duel.DiscardEnergy(e,tc,1)
	end
end
