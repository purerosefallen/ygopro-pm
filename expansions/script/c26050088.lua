--Haxorus (Noble Victories 88/101)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--cannot attack
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.effop)
end
scard.pokemon_card=true
scard.height=5.11
scard.devolve_list={[1]=CARD_FRAXURE,[2]=CARD_AXEW}
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ1(CARD_COLORLESS_ENERGY,3)
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local dam=c1+c2
	Duel.AttackDamage(50*dam)
end
--cannot attack
function scard.effop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(120)
	local c=e:GetHandler()
	pm.EnableCannotAttack(c,aux.Stringid(sid,2),RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
end
