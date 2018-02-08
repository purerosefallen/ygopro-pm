--Nihilego-GX (Crimson Invasion 49/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--confused & poisoned
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(PM_EVENT_PLAY_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(scard.spcon)
	e1:SetTarget(pm.hinttg)
	e1:SetOperation(scard.spop)
	c:RegisterEffect(e1)
	--cannot retreat
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.effop)
	--gx attack (to prize)
	pm.EnablePokemonAttack(c,2,nil,scard.attack_cost,pm.hinttg,scard.tpop,nil,PM_EFFECT_FLAG_GX_ATTACK)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ1(CARD_PSYCHIC_ENERGY,3)
--confused & poisoned
function scard.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND)
end
function scard.spop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttackingPokemon()
	local d=Duel.GetDefendingPokemon()
	pm.EnableConfused(a)
	pm.EnablePoisoned(a)
	pm.EnableConfused(d)
	pm.EnablePoisoned(d)
end
--cannot retreat
function scard.effop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(120)
	local tc=Duel.GetDefendingPokemon()
	pm.EnableCannotRetreat(tc,aux.Stringid(sid,3),RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
end
--gx attack (to prize)
function scard.tpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	local g=Duel.GetDecktopGroup(1-tp,2)
	if g:GetCount()==0 then return end
	Duel.SendtoPrize(e,g,1-tp,REASON_EFFECT)
end
