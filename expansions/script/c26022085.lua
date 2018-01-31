--Pow! Hand Extension (EX Team Rocket Returns 85/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--move energy or switch
	pm.EnableTrainerPlay(c,nil,scard.opttg,scard.optop,scard.optcon)
end
scard.pokemon_card=true
function scard.optcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetPrizeGroupCount(tp,tp)>Duel.GetPrizeGroupCount(tp,1-tp)
end
function scard.mefilter(c)
	return pm.ActivePokemonFilter(c) and c:GetAttachmentGroup():IsExists(Card.IsEnergy,1,nil)
end
function scard.opttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.IsExistingMatchingCard(scard.mefilter,tp,0,PM_LOCATION_ACTIVE,1,nil)
	local b2=Duel.IsExistingMatchingCard(pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,1,nil)
	local b3=Duel.GetDefendingPokemon()
	if chk==0 then return (b1 and b2) or b3 end
	local opt=0
	if b1 and b2 and b3 then
		opt=Duel.SelectOption(tp,aux.Stringid(sid,0),aux.Stringid(sid,1))
	elseif b1 and b2 then
		opt=Duel.SelectOption(tp,aux.Stringid(sid,0))
	elseif b2 and b3 then
		opt=Duel.SelectOption(tp,aux.Stringid(sid,1))+1
	end
	e:SetLabel(opt)
end
function scard.optop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		local g1=Duel.GetMatchingGroup(scard.mefilter,tp,0,PM_LOCATION_ACTIVE,nil)
		local g2=Duel.GetMatchingGroup(pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,nil)
		Duel.MoveEnergy(e,g1,g2,1)
	else
		Duel.SwitchPokemon(e,1-tp,1-tp)
	end
end
