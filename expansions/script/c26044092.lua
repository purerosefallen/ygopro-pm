--Raikou & Suicune LEGEND (Unleashed 92/95)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--legend
	pm.EnableLEGENDAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--remove counter
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.ctop)
end
scard.pokemon_card=true
scard.legend_top_half=CARD_RAIKOU_AND_SUICUNE_LEGEND
scard.dual_weakness_x2={[1]=PM_ENERGY_FIGHTING,[2]=PM_ENERGY_LIGHTNING}
scard.attack_cost1=pm.econ2(CARD_LIGHTNING_ENERGY,2,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_WATER_ENERGY,1,CARD_COLORLESS_ENERGY,2)
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(150)
	Duel.EffectDamage(50,e:GetHandler(),e:GetHandler(),false,false)
end
--remove counter
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(50)
	Duel.RemoveDamage(e,5,e:GetHandler())
end
