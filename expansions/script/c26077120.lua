--Cyrus Prism Star (Ultra Prism 120/156)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--to deck
	pm.EnableTrainerPlay(c,nil,scard.tdtg,scard.tdop,scard.tdcon)
end
scard.pokemon_card=true
function scard.cfilter(c)
	return pm.ActivePokemonFilter(c) and c:IsPokemonType(PM_ENERGY_WATER+PM_ENERGY_METAL)
end
function scard.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(scard.cfilter,tp,PM_LOCATION_IN_PLAY,0,1,nil)
end
function scard.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,nil)>2 end
end
function scard.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_BENCHEDPOKEMON)
	local sg=g:Select(1-tp,2,2,nil)
	g:Sub(sg)
	local tc=sg:GetFirst()
	for tc in aux.Next(sg) do
		local ag=g:GetFirst():GetAttachmentGroup()
		g:Merge(ag)
	end
	Duel.SendtoDeck(g,PLAYER_OWNER,DECK_ORDER_SHUFFLE,REASON_EFFECT)
end
