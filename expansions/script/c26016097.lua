--Electabuzz ex (EX Ruby & Sapphire 97/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--paralyzed
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.parop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_30=PM_ENERGY_METAL
scard.attack_cost1=pm.econ1(CARD_LIGHTNING_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_LIGHTNING_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.parop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnableParalyzed(Duel.GetDefendingPokemon()) end
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=40
	if Duel.TossCoin(tp,1)==RESULT_HEADS then ct=ct+20 end
	if ct>40 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
