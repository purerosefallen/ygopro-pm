--Swoop! Teleporter (EX Team Rocket Returns 92/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--switch
	pm.EnableTrainerPlay(c,nil,scard.swtg,scard.swop)
end
scard.pokemon_card=true
function scard.swfilter1(c)
	return c:IsBasicPokemon() and not (c:IsPokemonex() or c:IsPokemonEX())
end
function scard.swfilter2(c)
	return c:IsBasicPokemon() and not (c:IsPokemonex() or c:IsPokemonEX()) and c:IsAbleToDPile()
end
function scard.swtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		and Duel.IsExistingMatchingCard(scard.swfilter2,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
end
function scard.swop(e,tp,eg,ep,ev,re,r,rp)
	pm.ConfirmDeck(tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_PROMOTE)
	local g1=Duel.SelectMatchingCard(tp,scard.swfilter1,tp,LOCATION_DECK,0,1,1,nil)
	if g1:GetCount()==0 then return pm.SearchFailed(tp,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TODISCARD)
	local g2=Duel.SelectMatchingCard(tp,scard.swfilter2,tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
	if g2:GetCount()==0 then return end
	Duel.HintSelection(g2)
	Duel.SwitchPokemonOffField(e,g2:GetFirst(),g1:GetFirst(),PM_LOCATION_DPILE)
end
