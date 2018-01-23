--Tyrunt (Furious Fists 61/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--restored
	pm.EnableRestoredAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--discard energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost1=pm.econ2(CARD_FIGHTING_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIGHTING_ENERGY,1,CARD_COLORLESS_ENERGY,2)
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(30)
end
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(50)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then Duel.DiscardEnergy(e,Duel.GetDefendingPokemon(),1) end
end
