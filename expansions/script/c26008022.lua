--Elekid (Neo Genesis 22/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	c:SetStatus(PM_STATUS_NO_RETREAT_COST,true)
	pm.EnablePokemonAttribute(c)
	--baby
	pm.EnableBabyAttribute(c)
	--pokémon power (damage)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCountLimit(1)
	e1:SetCondition(pm.nspcon)
	e1:SetTarget(pm.hinttg)
	e1:SetOperation(scard.damop)
	c:RegisterEffect(e1)
end
scard.pokemon_card=true
scard.length=2.00
scard.evolve_list={[1]=CARD_ELECTABUZZ,[2]=CARD_ELECTIVIRE}
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then Duel.EffectDamage(20,e:GetHandler(),Duel.GetDefendingPokemon()) end
	pm.EndTurn(e)
end
