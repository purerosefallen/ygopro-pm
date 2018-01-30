--Sleep! (Team Rocket 79/82)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--asleep
	pm.EnableTrainerPlay(c,nil,scard.asltg,scard.aslop)
end
scard.pokemon_card=true
function scard.asltg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetDefendingPokemon() end
end
function scard.aslop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnableAsleep(Duel.GetDefendingPokemon()) end
end
