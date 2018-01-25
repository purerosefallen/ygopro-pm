--Scoop Up Cyclone (Plasma Blast 95/101)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--ace spec
	pm.EnableDeckRestriction(c,PM_EFFECT_RESTRICT_ACE_SPEC)
	--return
	pm.EnableTrainerPlay(c,nil,scard.rettg,scard.retop)
end
scard.pokemon_card=true
function scard.retfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsAbleToHand()
end
function scard.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.retfilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
end
function scard.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOHAND)
	local g=Duel.SelectMatchingCard(tp,scard.retfilter,tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
	if g:GetCount()==0 then return end
	local ag=g:GetFirst():GetAttachmentGroup()
	g:Merge(ag)
	Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
end
