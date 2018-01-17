--Chesnaught (Kalos Starter Set 5/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,pm.econ2(CARD_GRASS_ENERGY,1,CARD_COLORLESS_ENERGY,2),pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,PM_CATEGORY_COIN,pm.econ2(CARD_GRASS_ENERGY,2,CARD_COLORLESS_ENERGY,2),pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=5.03
scard.evolve_list={CARD_CHESNAUGHT_BREAK}
scard.devolve_list={CARD_QUILLADIN,CARD_CHESPIN}
scard.weakness_x2=PM_ENERGY_FIRE
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(50)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	local ct=80
	if Duel.TossCoin(tp,1)==RESULT_HEADS then ct=ct+40 end
	if ct>80 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
