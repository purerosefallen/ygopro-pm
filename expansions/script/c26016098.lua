--Hitmonchan ex (EX Ruby & Sapphire 98/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ1(CARD_FIGHTING_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIGHTING_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	local ct=10
	if Duel.TossCoin(tp,1)==RESULT_HEADS then ct=ct+10 end
	if ct>10 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(50,Duel.GetDefendingPokemon(),true,false)
end
