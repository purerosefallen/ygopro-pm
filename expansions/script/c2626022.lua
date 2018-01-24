--Team Magma's Zangoose (Double Crisis 22/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--to bench
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,scard.tbtg,scard.tbop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=4.03
scard.devolve_list={[1]=CARD_TEAM_AQUAS_CARVANHA}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_COLORLESS_ENERGY,3)
function scard.tbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,PM_LOCATION_BENCH)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.tbfilter(c,e,tp)
	return c:IsBasicPokemon() and c:IsSetCard(PM_SETNAME_TEAM_MAGMA) and c:IsCanBePutInPlay(e,0,tp,false,false)
end
function scard.tbop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,PM_LOCATION_BENCH)
	if ft<=0 then return end
	if ft>2 then ft=2 end
	pm.ConfirmDeck(tp,tp)
	local g=Duel.GetMatchingGroup(scard.tbfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()==0 then return pm.SearchFailed(tp,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOBENCH)
	local sg=g:Select(tp,1,ft,nil)
	Duel.PutInPlay(sg,0,tp,tp,false,false,PM_POS_FACEUP_UPSIDE)
end
function scard.damfilter(c)
	return pm.BenchPokemonFilter(c) and c:IsSetCard(PM_SETNAME_TEAM_MAGMA)
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(scard.damfilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	Duel.AttackDamage(20*ct)
end
