--Bastiodon GL (Rising Rivals 2/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--switch
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.swop)
	--remove counter
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.ctop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_FIRE
scard.resistance_20=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ2(CARD_METAL_ENERGY,1,CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ2(CARD_METAL_ENERGY,1,CARD_COLORLESS_ENERGY,3)
function scard.swop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
	Duel.SwitchPokemon(e,1-tp,1-tp)
end
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(60)
	Duel.RemoveDamage(e,1,e:GetHandler())
end
