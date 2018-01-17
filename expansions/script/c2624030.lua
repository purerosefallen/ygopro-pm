--Bunnelby (Kalos Starter Set 30/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=1.04
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost=pm.econ1(CARD_COLORLESS_ENERGY,2)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
end
