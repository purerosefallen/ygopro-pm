--Escape Rope (Plasma Storm 120/135)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--switch
	pm.EnableTrainerPlay(c,nil,scard.swtg,scard.swop)
end
scard.pokemon_card=true
function scard.swtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(pm.ActivePokemonFilter,tp,PM_LOCATION_ACTIVE,PM_LOCATION_ACTIVE,1,nil)
		and Duel.IsExistingMatchingCard(pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,1,nil) end
end
function scard.swop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SwitchPokemon(e,1-tp,1-tp)
	Duel.SwitchPokemon(e,tp,tp)
end
