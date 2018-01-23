--Pokémon Flute (Base Set 86/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to bench
	pm.EnableTrainerPlay(c,nil,scard.tbtg,scard.tbop)
end
scard.pokemon_card=true
function scard.tbfilter(c,e,tp)
	return c:IsBasicPokemon() and c:IsCanBePutInPlay(e,0,tp,false,false)
end
function scard.tbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,PM_LOCATION_BENCH)>0
		and Duel.IsExistingMatchingCard(scard.tbfilter,tp,0,PM_LOCATION_DPILE,1,nil,e,tp) end
end
function scard.tbop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,PM_LOCATION_BENCH)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOBENCH)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,0,PM_LOCATION_DPILE,1,1,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.PutInPlay(g,0,tp,1-tp,false,false,PM_POS_FACEUP_UPSIDE)
end
