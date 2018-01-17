--Poochyena (Kalos Starter Set 16/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=1.08
scard.evolve_list={CARD_MIGHTYENA}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_20=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ2(CARD_DARKNESS_ENERGY,1,CARD_COLORLESS_ENERGY,1)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
end
