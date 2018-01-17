--Swirlix (Kalos Starter Set 24/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--heal
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.healop)
end
scard.pokemon_card=true
scard.height=1.04
scard.weakness_x2=PM_ENERGY_METAL
scard.resistance_20=PM_ENERGY_DARKNESS
scard.attack_cost=pm.econ1(CARD_FAIRY_ENERGY,1)
function scard.healop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
	Duel.HealDamage(e,10,e:GetHandler())
end
