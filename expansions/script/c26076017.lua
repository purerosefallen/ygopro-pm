--Magikarp (Crimson Invasion 17/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_IMMUNE_DAMAGE)
	c:RegisterEffect(e1)
	--evolve
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.evoop)
end
scard.pokemon_card=true
scard.height=2.11
scard.evolve_list={[1]=CARD_GYARADOS}
scard.weakness_x2=PM_ENERGY_LIGHTNING
scard.attack_cost=pm.econ2(CARD_WATER_ENERGY,1,CARD_COLORLESS_ENERGY,2)
function scard.evofilter(c,e,tp,class)
	return c:IsCode(class.evolve_list[1]) and c:IsCanBePutInPlay(e,PM_SUMMON_TYPE_EVOLVE,tp,false,false)
end
function scard.evoop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	pm.evoop(nil,nil,nil,scard.evofilter,LOCATION_DECK,0)(e,tp,eg,ep,ev,re,r,rp)
end
