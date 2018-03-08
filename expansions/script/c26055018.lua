--Victini-EX (Plasma Storm 18/135)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--attach
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.atop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_WATER
scard.attack_cost1=pm.econ1(CARD_FIRE_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIRE_ENERGY,1,CARD_COLORLESS_ENERGY,2)
--attach
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	if Duel.GetMatchingGroupCount(pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,0,nil)==0 then return end
	pm.ConfirmDeck(tp,tp)
	if Duel.GetMatchingGroupCount(Card.IsBasicEnergy,tp,LOCATION_DECK,0,nil)==0 then return pm.SearchFailed(tp,tp) end
	local count=2
	repeat
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_BASICENERGY)
		local g1=Duel.SelectMatchingCard(tp,Card.IsBasicEnergy,tp,LOCATION_DECK,0,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ATTACHENERGY)
		local g2=Duel.SelectMatchingCard(tp,pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
		Duel.HintSelection(g2)
		Duel.Attach(g2:GetFirst(),g1)
		count=count-1
	until g1:GetCount()==0 or g2:GetCount()==0 or count==0
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=50
	if Duel.GetDefendingPokemon():IsPokemonEX() then dam=dam+50 end
	if dam>50 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
end
