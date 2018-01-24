--Greninja (Kalos Starter Set 14/39)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--discard energy
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.deop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=4.11
scard.evolve_list={[1]=CARD_GRENINJA_BREAK}
scard.devolve_list={[1]=CARD_FROGADIER,[2]=CARD_FROAKIE}
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost1=pm.econ1(CARD_WATER_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_WATER_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(40)
	local tc=Duel.GetDefendingPokemon()
	if not tc:IsAbleToRemoveEnergy() then return Duel.Hint(HINT_CARD,0,CARD_BROCKS_PROTECTION) end
	if Duel.TossCoin(tp,1)==RESULT_HEADS then Duel.DiscardEnergy(e,tc,1) end
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(80)
end
