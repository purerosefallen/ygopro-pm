--Blaziken FB (Supreme Victors 2/147)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--switch & burned
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.burop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_WATER
scard.attack_cost1=pm.econ1(CARD_FIRE_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIRE_ENERGY,1,CARD_COLORLESS_ENERGY,1)
function scard.burop(e,tp,eg,ep,ev,re,r,rp)
	local tc1=Duel.GetDefendingPokemon()
	Duel.PokemonAttack(e:GetHandler(),tc1)
	Duel.SwitchPokemon(e,tp,1-tp)
	local tc2=Duel.GetDefendingPokemon()
	pm.EnableBurned(tc2)
end
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsPokemonType(PM_ENERGY_WATER)
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=30
	if Duel.IsExistingMatchingCard(scard.damfilter,tp,0,PM_LOCATION_IN_PLAY,1,nil) then ct=ct+30 end
	if ct>30 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
