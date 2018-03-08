--Ampharos (EX Dragon Frontiers 1/101)
--Not fully implemented: c stack overflow error caused by e1
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--poké-body (add setcode)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(PM_EFFECT_ADD_SETCODE)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetTargetRange(LOCATION_DECK+PM_LOCATION_DPILE+LOCATION_HAND+PM_LOCATION_IN_PLAY,0)
	e1:SetCondition(pm.pbodcon)
	e1:SetTarget(scard.settg)
	e1:SetValue(PM_SETNAME_DELTA)
	c:RegisterEffect(e1)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.devolve_list={[1]=CARD_FLAAFFY,[2]=CARD_MAREEP}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost=pm.econ1(CARD_COLORLESS_ENERGY,3)
--poké-body (add setcode)
function scard.settg(e,c)
	return c:IsBasicPokemon() or c:IsEvolution()
end
--damage
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(PM_SETNAME_DELTA)
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=Duel.GetMatchingGroupCount(scard.damfilter,tp,PM_LOCATION_IN_PLAY,0,nil)*10
	Duel.AttackDamage(20+dam)
end
