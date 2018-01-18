--Team Aqua's Poochyena (Double Crisis 16/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--switch
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.swop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=1.08
scard.evolve_list={CARD_TEAM_AQUAS_MIGHTYENA}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_20=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_WATER_ENERGY,1,CARD_COLORLESS_ENERGY,1)
function scard.swop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SwitchPokemon(e,1-tp,1-tp)
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
end
