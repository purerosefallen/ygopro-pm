--Team Magma's Aron (Double Crisis 12/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=1.04
scard.evolve_list={[1]=CARD_TEAM_MAGMAS_LAIRON,[2]=CARD_TEAM_MAGMAS_AGGRON}
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost=pm.econ1(CARD_FIGHTING_ENERGY,1)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
end
