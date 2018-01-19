--Team Magma's Lairon (Double Crisis 13/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=2.11
scard.evolve_list={[1]=CARD_TEAM_MAGMAS_AGGRON}
scard.devolve_list={[1]=CARD_TEAM_MAGMAS_ARON}
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost1=pm.econ2(CARD_FIGHTING_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIGHTING_ENERGY,1,CARD_COLORLESS_ENERGY,2)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(60)
	Duel.EffectDamage(10,e:GetHandler(),e:GetHandler(),false,false)
end
