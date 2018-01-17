--Granbull (Kalos Starter Set 23/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,pm.econ2(CARD_FAIRY_ENERGY,1,CARD_COLORLESS_ENERGY,1),pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,PM_CATEGORY_COIN,pm.econ2(CARD_FAIRY_ENERGY,1,CARD_COLORLESS_ENERGY,2),pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=4.07
scard.devolve_list={CARD_SNUBBULL}
scard.weakness_x2=PM_ENERGY_METAL
scard.resistance_20=PM_ENERGY_DARKNESS
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2=Duel.TossCoin(tp,2)
	local res=c1+c2
	local ct=res*20
	Duel.AttackDamage(50+ct)
end