--Electabuzz (Black Star Promo Wizards of the Coast 46)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--add marker
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.ctop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.length=3.70
scard.evolve_list={[1]=CARD_ELECTIVIRE}
scard.devolve_list={[1]=CARD_ELEKID}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost1=pm.econ1(CARD_LIGHTNING_ENERGY,1)
scard.attack_cost2=pm.econ1(CARD_LIGHTNING_ENERGY,2)
--add marker
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetMarker(PM_LIGHTNING_ROD_MARKER)==0
end
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,2))
	local g=Duel.SelectMatchingCard(tp,scard.ctfilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	g:GetFirst():AddCounter(PM_LIGHTNING_ROD_MARKER,1)
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=10
	if Duel.GetDefendingPokemon():GetMarker(PM_LIGHTNING_ROD_MARKER)>0 then dam=dam+20 end
	Duel.AttackDamage(dam)
end
