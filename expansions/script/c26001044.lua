--Bulbasaur (Base Set 44/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--remove counter
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.ctop)
end
scard.pokemon_card=true
scard.length=2.40
scard.evolve_list={[1]=CARD_IVYSAUR,[2]=CARD_VENUSAUR}
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost=pm.econ1(CARD_GRASS_ENERGY,2)
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
	if not Duel.GetDefendingPokemon():IsImmuneToDamage() and Duel.SelectYesNo(tp,aux.Stringid(sid,1)) then
		Duel.RemoveDamage(e,1,e:GetHandler())
	end
end
