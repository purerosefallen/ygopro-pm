--Chansey ex (EX Ruby & Sapphire 96/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--remove counter
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.ctop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ1(CARD_COLORLESS_ENERGY,3)
--remove counter
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetCounter(PM_DAMAGE_COUNTER)>0
end
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	local g=Duel.GetMatchingGroup(scard.ctfilter,tp,PM_LOCATION_IN_PLAY,0,c)
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		Duel.RemoveDamage(e,2,tc)
	end
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(80)
	Duel.EffectDamage(60,e:GetHandler(),e:GetHandler(),false,false)
end
