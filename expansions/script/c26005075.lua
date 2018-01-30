--Digger (Team Rocket 75/82)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	--damage
	pm.EnableTrainerPlay(c,nil,scard.damtg,scard.damop)
end
scard.pokemon_card=true
function scard.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttackingPokemon() or Duel.GetDefendingPokemon() end
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=1-tp
	repeat
		p=1-p
	until (Duel.TossCoin(p,1)==RESULT_TAILS)
	local c=(p==tp) and Duel.GetAttackingPokemon() or Duel.GetDefendingPokemon()
	c:AddCounter(PM_DAMAGE_COUNTER,1)
end
