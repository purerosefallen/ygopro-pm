--Magikarp (Base Set 35/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.length=2.11
scard.evolve_list={[1]=CARD_GYARADOS}
scard.weakness_x2=PM_ENERGY_LIGHTNING
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_WATER_ENERGY,1)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	local dam=e:GetHandler():GetCounter(PM_DAMAGE_COUNTER)
	Duel.AttackDamage(10*dam)
end
