--Snorlax-GX (Black Star Promo SM05)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--asleep
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.aslop1)
	--damage
	pm.EnablePokemonAttack(c,1,PM_CATEGORY_ASLEEP_ATTACK,scard.attack_cost2,pm.hinttg,scard.damop)
	--gx attack (asleep)
	pm.EnablePokemonAttack(c,2,nil,scard.attack_cost2,pm.hinttg,scard.aslop2,nil,PM_EFFECT_FLAG_GX_ATTACK)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,3)
scard.attack_cost2=pm.econ1(CARD_COLORLESS_ENERGY,5)
--asleep
function scard.aslop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(80)
	pm.EnableAsleep(e:GetHandler())
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=180
	if not e:GetHandler():IsAsleep() then dam=0 end
	Duel.AttackDamage(dam)
end
--gx attack (asleep)
function scard.aslop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(210)
	pm.EnableAsleep(e:GetHandler())
end
