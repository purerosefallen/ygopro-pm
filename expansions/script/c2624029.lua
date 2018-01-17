--Bidoof (Kalos Starter Set 29/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,pm.econ1(CARD_COLORLESS_ENERGY,3),pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=1.08
scard.weakness_x2=PM_ENERGY_FIGHTING
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(60)
end
