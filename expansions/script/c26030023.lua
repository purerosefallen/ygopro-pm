--Tropius (EX Dragon Frontiers 23/101)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--poké-power (remove special condition and marker)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(PM_EVENT_PLAY_SUCCESS)
	e1:SetProperty(PM_EFFECT_FLAG_POKEPOWER+EFFECT_FLAG_DELAY)
	e1:SetCondition(scard.spcon)
	e1:SetTarget(scard.sptg)
	e1:SetOperation(scard.spop)
	c:RegisterEffect(e1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost=pm.econ1(CARD_METAL_ENERGY,1)
--poké-power (remove special condition and marker)
function scard.spcon(e,tp,eg,ep,ev,re,r,rp)
	return pm.ppowcon(e,tp,eg,ep,ev,re,r,rp) and e:GetHandler():IsPreviousLocation(LOCATION_HAND)
end
function scard.spfilter(c)
	return c:IsFaceup() and c:IsPokemon()
		and (c:IsAffectedBySpecialCondition() or c:GetMarker(PM_IMPRISON_MARKER)>0 or c:GetMarker(PM_SHOCKWAVE_MARKER)>0)
end
function scard.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.spfilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.spfilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	local ct1=tc:GetMarker(PM_IMPRISON_MARKER)
	local ct2=tc:GetMarker(PM_SHOCKWAVE_MARKER)
	for tc in aux.Next(g) do
		Duel.RemoveSpecialCondition(tc)
		if ct1>0 then tc:RemoveMarker(tp,PM_IMPRISON_MARKER,ct1,REASON_EFFECT) end
		if ct2>0 then tc:RemoveMarker(tp,PM_SHOCKWAVE_MARKER,ct2,REASON_EFFECT) end
	end
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=e:GetHandler():GetAttachmentGroup():FilterCount(Card.IsEnergy,nil)
	Duel.AttackDamage(10*dam)
end
