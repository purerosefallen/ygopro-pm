--Quilava (Neo Genesis 47/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--damage reduce
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.effop)
	--add counter
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.ctop)
end
scard.pokemon_card=true
scard.length=2.11
scard.evolve_list={[1]=CARD_TYPHLOSION}
scard.devolve_list={[1]=CARD_CYNDAQUIL}
scard.weakness_x2=PM_ENERGY_WATER
scard.attack_cost1=pm.econ1(CARD_FIRE_ENERGY,2)
scard.attack_cost2=pm.econ1(CARD_FIRE_ENERGY,3)
--damage reduce
function scard.effop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
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
	if Duel.TossCoin(turnp,1)==RESULT_TAILS then
		if not Duel.NegatePokemonAttack(ev) then return end
		pm.EndTurn(e)
	end
end
--add counter
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetDefendingPokemon()
	Duel.AttackDamage(30)
	if tc:GetCounter(PM_CHAR_COUNTER)>0 then return end
	if Duel.TossCoin(tp,1)==RESULT_HEADS then tc:AddCounter(PM_CHAR_COUNTER,1) end
	--char check
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,3))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCountLimit(1)
	e1:SetLabelObject(tc)
	e1:SetCondition(scard.charcon)
	e1:SetOperation(scard.charop)
	Duel.RegisterEffect(e1,tp)
end
function scard.charcon(e)
	local tc=e:GetLabelObject()
	if tc:GetCounter(PM_CHAR_COUNTER)>0 then
		return true
	else
		e:Reset()
		return false
	end
end
function scard.charop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Hint(HINT_CARD,0,tc:GetOriginalCode())
	Duel.BreakEffect()
	if Duel.TossCoin(tp,1)==RESULT_TAILS then tc:AddCounter(PM_DAMAGE_COUNTER,2) end
end
