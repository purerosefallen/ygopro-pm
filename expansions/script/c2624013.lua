--Frogadier (Kalos Starter Set 13/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,PM_CATEGORY_COIN,scard.attack_cost2,pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=2.00
scard.evolve_list={[1]=CARD_GRENINJA,[2]=CARD_GRENINJA_BREAK}
scard.devolve_list={[1]=CARD_FROAKIE}
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost1=pm.econ1(CARD_WATER_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_WATER_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local res=c1+c2
	local ct=res*20
	Duel.AttackDamage(40+ct)
end
