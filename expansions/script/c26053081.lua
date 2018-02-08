--Registeel-EX (Dragons Exalted 81/124)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--damage reduce
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.effop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_FIRE
scard.resistance_20=PM_ENERGY_PSYCHIC
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,3)
scard.attack_cost2=pm.econ2(CARD_METAL_ENERGY,2,CARD_COLORLESS_ENERGY,2)
--damage
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_DAMAGE)
	local g=Duel.SelectMatchingCard(tp,scard.damfilter,tp,0,PM_LOCATION_IN_PLAY,3,3,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	Duel.HintSelection(g)
	for tc in aux.Next(g) do
		if tc:IsBench() then
			Duel.EffectDamage(30,c,tc,false,false)
		else Duel.EffectDamage(30,c,tc) end
	end
end
--damage reduce
function scard.effop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(80)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,2))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_DAMAGE_ATTACK_REDUCE_20)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	e:GetHandler():RegisterEffect(e1)
end
