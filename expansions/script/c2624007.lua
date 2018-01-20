--Pansear (Kalos Starter Set 7/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--draw
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.drtg(PLAYER_PLAYER,1),pm.drop(PLAYER_PLAYER,1))
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=2.00
scard.weakness_x2=PM_ENERGY_WATER
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_COLORLESS_ENERGY,2)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2,c3=Duel.TossCoin(tp,3)
	local ct=c1+c2+c3
	Duel.AttackDamage(10*ct)
end
