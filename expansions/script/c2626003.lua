--Team Aqua's Spheal (Double Crisis 3/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=2.07
scard.evolve_list={[1]=CARD_TEAM_AQUAS_SEALEO,[2]=CARD_TEAM_AQUAS_WALREIN}
scard.weakness_x2=PM_ENERGY_METAL
scard.attack_cost=pm.econ1(CARD_WATER_ENERGY,1)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
end
