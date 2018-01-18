--Team Aqua Admin (Double Crisis 25/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--attach
	pm.EnableTrainerPlay(c,nil,scard.attg,scard.atop)
end
scard.pokemon_card=true
function scard.atfilter(c)
	return c:IsActive() and c:IsSetCard(PM_SETNAME_TEAM_AQUA)
end
function scard.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsBasicEnergy,tp,PM_LOCATION_DPILE,0,1,nil)
		and Duel.IsExistingMatchingCard(scard.atfilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
end
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(Card.IsBasicEnergy,tp,PM_LOCATION_DPILE,0,nil)
	local g2=Duel.GetMatchingGroup(scard.atfilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_BASICENERGY)
	local sg1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,0))
	local sg2=g2:Select(tp,1,1,nil)
	Duel.HintSelection(sg2)
	Duel.Attach(sg2:GetFirst(),sg1)
end
