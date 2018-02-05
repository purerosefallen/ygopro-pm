--Dialga G (Platinum 7/127)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--cannot play
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.actop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_FIRE
scard.resistance_20=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ2(CARD_METAL_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_METAL_ENERGY,1,CARD_COLORLESS_ENERGY,2)
function scard.actop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,2))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(PM_EFFECT_CANNOT_PLAY)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
	e1:SetTargetRange(0,1)
	e1:SetLabel(Duel.GetTurnCount())
	e1:SetCondition(scard.accon)
	e1:SetValue(scard.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
end
function scard.accon(e)
	return e:GetLabel()~=Duel.GetTurnCount()
end
function scard.aclimit(e,re,tp)
	return re:IsHasType(PM_EFFECT_TYPE_PLAY) and re:IsActiveType(PM_TYPE_TRAINER)
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=50
	if Duel.GetDefendingPokemon():GetCounter(PM_DAMAGE_COUNTER)>=2 then ct=ct+20 end
	if ct>50 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(ct)
end
