--Team Magma's Numel (Double Crisis 1/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--discard energy
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.height=2.04
scard.evolve_list={[1]=CARD_TEAM_MAGMAS_CAMERUPT}
scard.weakness_x2=PM_ENERGY_WATER
scard.attack_cost=pm.econ2(CARD_ENERGY_FIRE,1,CARD_ENERGY_COLORLESS,1)
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
	Duel.DiscardEnergy(e,e:GetHandler(),1)
end
