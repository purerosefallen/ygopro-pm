--Delphox (Kalos Starter Set 10/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--discard energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.height=4.11
scard.evolve_list={[1]=CARD_DELPHOX_BREAK}
scard.devolve_list={[1]=CARD_BRAIXEN,[2]=CARD_FENNEKIN}
scard.weakness_x2=PM_ENERGY_WATER
scard.attack_cost1=pm.econ2(CARD_FIRE_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIRE_ENERGY,1,CARD_COLORLESS_ENERGY,3)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
end
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(120)
	Duel.DiscardEnergy(e,e:GetHandler(),1)
end
