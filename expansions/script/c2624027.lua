--Miltank (Kalos Starter Set 27/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,PM_CATEGORY_COIN,pm.econ1(CARD_COLORLESS_ENERGY,3),pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=3.11
scard.weakness_x2=PM_ENERGY_FIGHTING
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=50
	if Duel.TossCoin(tp,1)==RESULT_HEADS then ct=ct+20 end
	if ct>50 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
