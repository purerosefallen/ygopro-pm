--Mewtwo (Base Set 10/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,pm.econ2(CARD_PSYCHIC_ENERGY,1,CARD_COLORLESS_ENERGY,1),pm.hinttg,scard.damop)
	--immune
	pm.EnablePokemonAttack(c,1,nil,pm.econ2(CARD_PSYCHIC_ENERGY,1,CARD_PSYCHIC_ENERGY,1),pm.hinttg,scard.imop,
	pm.decost(c,1,1,CARD_PSYCHIC_ENERGY))
end
scard.pokemon_card=true
scard.length=6.07
scard.weakness_x2=PM_ENERGY_PSYCHIC
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local tc=pm.GetDefendingPokemon(e)
	local ct=tc:GetAttachmentGroup():FilterCount(Card.IsEnergy,nil)*10
	pm.AttackDamage(e,10+ct)
end
--immune
function scard.imop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,2))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_IMMUNE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	e:GetHandler():RegisterEffect(e1)
end
