--Team Aqua's Carvanha (Double Crisis 20/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=2.07
scard.evolve_list={[1]=CARD_TEAM_AQUAS_SHARPEDO}
scard.weakness_x2=PM_ENERGY_LIGHTNING
scard.attack_cost=pm.econ1(CARD_DARKNESS_ENERGY,1)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local ct=c1+c2
	Duel.AttackDamage(ct*10)
end
