--Honedge (Kalos Starter Set 21/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=2.07
scard.weakness_x2=PM_ENERGY_FIRE
scard.resistance_20=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ2(CARD_METAL_ENERGY,1,CARD_COLORLESS_ENERGY,1)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=0
	repeat
		local res=Duel.TossCoin(tp,1)
		if res==RESULT_HEADS then dam=dam+1 end
	until res==RESULT_TAILS
	Duel.AttackDamage(30*dam)
end
