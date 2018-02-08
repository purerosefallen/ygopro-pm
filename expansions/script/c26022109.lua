--Treecko Star (EX Team Rocket Returns 109/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--star
	pm.EnableDeckRestriction(c,PM_EFFECT_RESTRICT_POKEMON_STAR)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--poisoned
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.poiop)
end
scard.pokemon_card=true
scard.evolve_list={[1]=CARD_GROVYLE,[2]=CARD_SCEPTILE}
scard.weakness_x2=PM_ENERGY_FIRE
scard.resistance_30=PM_ENERGY_WATER
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_GRASS_ENERGY,2)
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
end
--poisoned
function scard.poiop(e,tp,eg,ep,ev,re,r,rp)
	local dam=20
	if Duel.GetPrizeGroupCount(tp,1-tp)==1 then dam=dam+50 end
	if dam>20 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
	if Duel.GetPrizeGroupCount(tp,1-tp)==1 then pm.EnablePoisoned(Duel.GetDefendingPokemon()) end
end
