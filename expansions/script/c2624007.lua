--Pansear (Kalos Starter Set 7/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--draw
	pm.EnablePokemonAttack(c,0,nil,pm.econ1(CARD_COLORLESS_ENERGY,1),pm.drtg(PLAYER_PLAYER,1),pm.drop(PLAYER_PLAYER,1))
	--damage
	pm.EnablePokemonAttack(c,1,PM_CATEGORY_COIN,pm.econ1(CARD_COLORLESS_ENERGY,2),pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=2.00
scard.weakness_x2=PM_ENERGY_WATER
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local c1,c2,c3=Duel.TossCoin(tp,3)
	local ct=c1+c2+c3
	Duel.AttackDamage(10*ct)
end
