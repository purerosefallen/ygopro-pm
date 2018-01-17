--Quilladin (Kalos Starter Set 4/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--heal
	pm.EnablePokemonAttack(c,0,nil,pm.econ2(CARD_GRASS_ENERGY,1,CARD_COLORLESS_ENERGY,1),pm.hinttg,scard.healop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,pm.econ2(CARD_GRASS_ENERGY,1,CARD_COLORLESS_ENERGY,2),pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=2.04
scard.evolve_list={CARD_CHESNAUGHT,CARD_CHESNAUGHT_BREAK}
scard.devolve_list={CARD_CHESPIN}
scard.weakness_x2=PM_ENERGY_FIRE
function scard.healop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
	Duel.HealDamage(e,10,e:GetHandler())
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(50)
end
