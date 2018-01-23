--Brigette (BREAKthrough 134/162)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to bench
	pm.EnableTrainerPlay(c,nil,scard.tbtg,scard.tbop)
end
scard.pokemon_card=true
function scard.tbfilter1(c,e,tp)
	return c:IsPokemonEX() and c:IsBasicPokemon() and c:IsCanBePutInPlay(e,0,tp,false,false)
end
function scard.tbfilter2(c,e,tp)
	return c:IsBasicPokemon() and c:IsCanBePutInPlay(e,0,tp,false,false)
end
function scard.tbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,PM_LOCATION_BENCH)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function scard.tbop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,PM_LOCATION_BENCH)
	if ft<=0 then return end
	if ft>3 then ft=3 end
	local g1=Duel.GetMatchingGroup(scard.tbfilter1,tp,LOCATION_DECK,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(scard.tbfilter2,tp,LOCATION_DECK,0,nil,e,tp)
	local opt=0
	pm.ConfirmDeck(tp,tp)
	if g1:GetCount()>0 and g2:GetCount()>0 then
		opt=Duel.SelectOption(tp,aux.Stringid(sid,0),aux.Stringid(sid,1))
	elseif g1:GetCount()>0 then
		opt=Duel.SelectOption(tp,aux.Stringid(sid,0))
	elseif g2:GetCount()>0 then
		opt=Duel.SelectOption(tp,aux.Stringid(sid,1))+1
	else return pm.ConfirmInvalid(tp,tp) end
	local sg=nil
	if opt==0 then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOBENCH)
		sg=g1:Select(tp,1,1,nil)
	else
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOBENCH)
		sg=g2:Select(tp,ft,ft,nil)
	end
	Duel.PutInPlay(sg,0,tp,tp,false,false,PM_POS_FACEUP_UPSIDE)
end
