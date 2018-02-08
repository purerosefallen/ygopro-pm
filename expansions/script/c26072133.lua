--Team Skull Grunt (Sun & Moon 133/149)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--discard hand
	pm.EnableTrainerPlay(c,nil,scard.dhtg,scard.dhop)
end
scard.pokemon_card=true
function scard.dhtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
function scard.dhop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()<=0 then return end
	Duel.ConfirmCards(tp,g)
	local tg=g:Filter(Card.IsEnergy,nil)
	if tg:GetCount()==0 then
		Duel.Hint(HINT_MESSAGE,tp,PM_DESC_NO_TARGETS)
		Duel.ShuffleHand(1-tp)
		return
	end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DISCARD)
	local sg=tg:Select(tp,2,2,nil)
	Duel.SendtoDPile(sg,REASON_EFFECT+REASON_DISCARD)
	Duel.ShuffleHand(1-tp)
end
