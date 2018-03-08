--Larvitar (Neo Discovery 57/75)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.length=2.00
scard.evolve_list={[1]=CARD_PUPITAR,[2]=CARD_TYRANITAR}
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost=pm.econ1(CARD_COLORLESS_ENERGY,1)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
end
