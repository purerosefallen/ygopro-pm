--Magmar ex (EX Ruby & Sapphire 100/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage reduce
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.effop)
	--burned
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.burop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_WATER
scard.attack_cost1=pm.econ1(CARD_FIRE_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_FIRE_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.effop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
	local tc=Duel.GetDefendingPokemon()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,2))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(PM_EVENT_PRE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCondition(scard.coincon)
	e1:SetOperation(scard.coinop)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,2)
	tc:RegisterEffect(e1)
end
function scard.coincon(e,tp,eg,ep,ev,re,r,rp)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return Duel.GetAttackingPokemon()==e:GetHandler() and re:IsHasProperty(PM_EFFECT_FLAG_POKEMON_ATTACK)
		and loc==PM_LOCATION_ACTIVE
end
function scard.coinop(e,tp,eg,ep,ev,re,r,rp)
	local turnp=Duel.GetTurnPlayer()
	local code=e:GetHandler():GetOriginalCode()
	Duel.Hint(HINT_CARD,0,code)
	if Duel.TossCoin(turnp,1)==RESULT_HEADS then return end
	if not Duel.NegatePokemonAttack(ev) then return end
	pm.EndTurn(e)
end
function scard.burop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(40)
	pm.EnableBurned(Duel.GetDefendingPokemon())
end
