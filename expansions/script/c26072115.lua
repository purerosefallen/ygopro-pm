--Crushing Hammer (Sun & Moon 115/149)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--discard energy
	pm.EnableTrainerPlay(c,nil,scard.detg,scard.deop)
end
scard.pokemon_card=true
function scard.defilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachmentGroup():IsExists(Card.IsEnergy,1,nil)
		and c:IsAbleToRemoveEnergy()
end
function scard.detg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.defilter,tp,0,PM_LOCATION_IN_PLAY,1,nil) end
end
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		local g=Duel.GetAttachmentGroup(tp,0,1)
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARDENERGY)
		local sg=g:FilterSelect(tp,Card.IsEnergy,1,1,nil)
		Duel.SendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
	end
end
