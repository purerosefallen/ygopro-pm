--Chespin (Kalos Starter Set 3/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,pm.econ1(CARD_GRASS_ENERGY,1),pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,pm.econ2(CARD_GRASS_ENERGY,1,CARD_COLORLESS_ENERGY,1),pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=1.04
scard.evolve_list={CARD_QUILLADIN,CARD_CHESNAUGHT,CARD_CHESNAUGHT_BREAK}
scard.weakness_x2=PM_ENERGY_FIRE
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
end