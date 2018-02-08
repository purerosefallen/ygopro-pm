--Chespin (XY 12/146)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=1.04
scard.evolve_list={[1]=CARD_QUILLADIN,[2]=CARD_CHESNAUGHT,[3]=CARD_CHESNAUGHT_BREAK}
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost=pm.econ1(CARD_GRASS_ENERGY,1)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2,c3,c4=Duel.TossCoin(tp,4)
	local dam=c1+c2+c3+c4
	Duel.AttackDamage(10*dam)
end
