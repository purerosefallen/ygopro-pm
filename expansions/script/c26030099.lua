--Tyranitar ex (EX Dragon Frontiers 99/101)
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
	--knock out
	pm.EnablePokemonAttack(c,2,nil,scard.attack_cost3,pm.hinttg,scard.koop)
end
scard.pokemon_card=true
scard.devolve_list={[1]=CARD_PUPITAR,[2]=CARD_LARVITAR}
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost1=pm.econ2(CARD_LIGHTNING_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_LIGHTNING_ENERGY,1,CARD_COLORLESS_ENERGY,2)
scard.attack_cost3=pm.econ2(CARD_LIGHTNING_ENERGY,2,CARD_COLORLESS_ENERGY,1)
--add marker
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,3))
	local g=Duel.SelectMatchingCard(tp,scard.ctfilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	Duel.HintSelection(g)
	tc:AddMarker(PM_SHOCKWAVE_MARKER,1)
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=70
	local tc=Duel.GetDefendingPokemon()
	if tc:IsStage2() and tc:IsEvolved() then dam=dam+20 end
	if dam>70 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
end
--knock out
function scard.kofilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetMarker(PM_SHOCKWAVE_MARKER)>0
end
function scard.koop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_KNOCKOUT)
	local g=Duel.SelectMatchingCard(tp,scard.kofilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.KnockOut(g,REASON_EFFECT)
end
