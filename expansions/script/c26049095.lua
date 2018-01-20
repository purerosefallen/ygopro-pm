--Pokémon Catcher (Emerging Powers 95/98)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--switch
	pm.EnableTrainerPlay(c,nil,scard.swtg,scard.swop)
end
scard.pokemon_card=true
function scard.swtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(pm.ActivePokemonFilter,tp,0,PM_LOCATION_ACTIVE,1,nil)
		and Duel.IsExistingMatchingCard(pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,1,nil) end
end
function scard.swop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then Duel.SwitchPokemon(e,tp,1-tp) end
end
