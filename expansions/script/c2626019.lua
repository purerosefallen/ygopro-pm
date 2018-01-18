--Team Magma's Mightyena (Double Crisis 19/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.height=3.03
scard.devolve_list={CARD_TEAM_MAGMAS_POOCHYENA}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_20=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ2(CARD_FIGHTING_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIGHTING_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	local ct=80
	local tc=Duel.GetDefendingPokemon()
	if tc:IsSetCard(PM_SETNAME_TEAM_AQUA) then ct=ct+40 end
	if ct>80 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
