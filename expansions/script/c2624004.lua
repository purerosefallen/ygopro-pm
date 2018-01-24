--Quilladin (Kalos Starter Set 4/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--heal
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.healop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=2.04
scard.evolve_list={[1]=CARD_CHESNAUGHT,[2]=CARD_CHESNAUGHT_BREAK}
scard.devolve_list={[1]=CARD_CHESPIN}
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost1=pm.econ2(CARD_GRASS_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_GRASS_ENERGY,1,CARD_COLORLESS_ENERGY,2)
function scard.healop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
	Duel.HealDamage(e,10,e:GetHandler())
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(50)
end
