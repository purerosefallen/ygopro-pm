--Darkrai-EX (Dark Explorers 63/108)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--no retreat cost
	pm.EnableNoRetreatCost(c,PM_LOCATION_IN_PLAY,PM_LOCATION_IN_PLAY,0,scard.rctg)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.resistance_20=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ2(CARD_DARKNESS_ENERGY,2,CARD_COLORLESS_ENERGY,1)
--no retreat cost
function scard.rctg(e,c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachmentGroup():IsExists(Card.IsEnergy,1,nil,CARD_DARKNESS_ENERGY)
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(90)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DAMAGE)
	local g=Duel.SelectMatchingCard(tp,pm.BenchPokemonFilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	Duel.EffectDamage(30,e:GetHandler(),g:GetFirst())
end
