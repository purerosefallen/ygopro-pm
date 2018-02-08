--Zekrom-EX (Next Destinies 51/99)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--discard energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost1=pm.econ2(CARD_LIGHTNING_ENERGY,1,CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ2(CARD_LIGHTNING_ENERGY,2,CARD_COLORLESS_ENERGY,2)
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=50
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+30 end
	if dam>50 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
end
--discard energy
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(150)
	Duel.DiscardEnergy(e,e:GetHandler(),2)
end
