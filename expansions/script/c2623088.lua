--Chespin (Black Star Promo XY88)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=1.04
scard.evolve_list={CARD_QUILLADIN,CARD_CHESNAUGHT,CARD_CHESNAUGHT_BREAK}
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost=pm.econ2(CARD_GRASS_ENERGY,1,CARD_COLORLESS_ENERGY,1)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
end
