--Mightyena (Kalos Starter Set 17/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,PM_CATEGORY_COIN,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=3.03
scard.devolve_list={CARD_MIGHTYENA}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_20=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ2(CARD_DARKNESS_ENERGY,1,CARD_COLORLESS_ENERGY,1)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=40
	if Duel.TossCoin(tp,1)==RESULT_HEADS then ct=ct+20 end
	if ct>40 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
