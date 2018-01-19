--Hyper Devolution Spray (Neo Discovery 73/75)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--devolve
	pm.EnableTrainerPlay(c,nil,scard.devtg,pm.devop(scard.devfilter,PM_LOCATION_IN_PLAY,0))
end
scard.pokemon_card=true
function scard.devfilter(c)
	return c:IsFaceup() and c:IsEvolution() and c:IsAbleToHand()
end
function scard.devtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.devfilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
end
