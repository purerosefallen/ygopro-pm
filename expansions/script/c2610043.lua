--Probopass G (Black Star Promo DP43)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop)
	--no retreat cost
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.rcop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_WATER
scard.attack_cost1=pm.econ2(CARD_METAL_ENERGY,1,CARD_COLORLESS_ENERGY,1)
scard.attack_cost2=pm.econ2(CARD_METAL_ENERGY,1,CARD_COLORLESS_ENERGY,3)
--damage
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsHasPokeBody()
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	local g=Duel.GetMatchingGroup(scard.damfilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	for tc in aux.Next(g) do
		Duel.EffectDamage(10,c,tc)
	end
end
--no retreat cost
function scard.rcop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(70)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,2))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_NO_RETREAT_COST)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	c:RegisterEffect(e1)
end
