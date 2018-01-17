--Inkay (Kalos Starter Set 18/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,pm.econ1(CARD_DARKNESS_ENERGY,1),pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=1.04
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_20=PM_ENERGY_PSYCHIC
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
end
