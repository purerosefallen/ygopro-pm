--Shaymin-EX (Next Destinies 5/99)
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
scard.weakness_x2=PM_ENERGY_FIRE
scard.resistance_20=PM_ENERGY_FIGHTING
scard.attack_cost1=pm.econ1(CARD_GRASS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_GRASS_ENERGY,1,CARD_COLORLESS_ENERGY,1)
function scard.atfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	pm.ConfirmDeck(tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_GENERGY)
	local g1=Duel.SelectMatchingCard(tp,Card.IsEnergy,tp,LOCATION_DECK,0,1,1,nil,CARD_GRASS_ENERGY)
	if g1:GetCount()==0 then return pm.SearchFailed(tp,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ATTACHENERGY)
	local g2=Duel.SelectMatchingCard(tp,scard.atfilter,tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
	Duel.Attach(g2:GetFirst(),g1)
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFlagEffect(1-tp,PM_EFFECT_PRIZE_CARD_CHECK)
	if ct>0 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(30+ct)
end
