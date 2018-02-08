--Regigigas-EX (Next Destinies 82/99)
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
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,3)
scard.attack_cost2=pm.econ1(CARD_COLORLESS_ENERGY,4)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	local dam=60
	local self_damage=false
	if Duel.SelectYesNo(tp,aux.Stringid(sid,2)) then dam=dam+20 self_damage=true end
	if dam>60 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
	if self_damage then Duel.EffectDamage(20,e:GetHandler(),e:GetHandler(),false,false) end
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	local dam=50
	local ct=e:GetHandler():GetCounter(PM_DAMAGE_COUNTER)
	if ct>0 then dam=dam+(ct*10) end
	if dam>50 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
end
