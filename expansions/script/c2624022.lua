--Snubbull (Kalos Starter Set 22/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=2.00
scard.evolve_list={CARD_GRANBULL}
scard.weakness_x2=PM_ENERGY_METAL
scard.resistance_20=PM_ENERGY_DARKNESS
scard.attack_cost=pm.econ2(CARD_FAIRY_ENERGY,1,CARD_COLORLESS_ENERGY,1)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
end
