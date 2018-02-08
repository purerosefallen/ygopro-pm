--Giratina Prism Star (Ultra Prism 58/156)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--prism star
	pm.EnablePrismStarAttribute(c)
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(PM_EVENT_PLAY_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(scard.atcon)
	e1:SetTarget(scard.attg)
	e1:SetOperation(scard.atop)
	c:RegisterEffect(e1)
	--discard energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_DARKNESS
scard.resistance_20=PM_ENERGY_FIGHTING
scard.attack_cost=pm.econ1(CARD_PSYCHIC_ENERGY,4)
--attach
function scard.atcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) and Duel.GetTurnPlayer()==tp
end
function scard.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsEnergy,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_PENERGY)
	local g=Duel.SelectMatchingCard(tp,Card.IsEnergy,tp,LOCATION_HAND,0,2,2,nil,CARD_PSYCHIC_ENERGY)
	if g:GetCount()==0 then return end
	Duel.Attach(e:GetHandler(),g)
end
--discard energy
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(160)
	Duel.DiscardEnergy(e,e:GetHandler(),2)
end
