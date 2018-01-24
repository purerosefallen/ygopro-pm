--Quilladin (BREAKthrough 10/162)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=2.04
scard.evolve_list={[1]=CARD_CHESNAUGHT,[2]=CARD_CHESNAUGHT_BREAK}
scard.devolve_list={[1]=CARD_CHESPIN}
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost1=pm.econ2(CARD_GRASS_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_GRASS_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2,c3,c4=Duel.TossCoin(tp,4)
	local ct=c1+c2+c3+c4
	Duel.AttackDamage(40*ct)
end
