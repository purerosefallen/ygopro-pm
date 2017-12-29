--Pokémon Fan Club (POP Series 4 9/17)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to bench
	pm.EnableTrainerPlay(c,nil,scard.tbtg,scard.tbop)
end
scard.pokemon_card=true
scard.old_supporter=true
function scard.tbfilter(c,e,tp)
	return c:IsBasicPokemon() and c:IsCanBePutOnBench(e,0,tp,false,false)
end
function scard.tbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,PM_LOCATION_BENCH)>0
		and Duel.IsExistingMatchingCard(scard.tbfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
end
function scard.tbop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,PM_LOCATION_BENCH)
	if ft<=0 then return end
	if ft>2 then ft=2 end
	local g=Duel.GetMatchingGroup(scard.tbfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOBENCH)
	local sg=g:Select(tp,1,ft,nil)
	Duel.PutOnBench(sg,0,tp,tp,false,false,PM_POS_FACEUP_UPSIDE)
end
