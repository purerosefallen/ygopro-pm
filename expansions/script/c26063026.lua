--Torchic (Primal Clash 26/126)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--extra attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--draw
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.drop)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_WATER
scard.attack_cost=pm.econ1(CARD_FIRE_ENERGY,1)
--draw
function scard.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PokemonAttack(e:GetHandler(),Duel.GetDefendingPokemon())
	if Duel.DiscardHand(tp,Card.IsEnergy,1,1,REASON_COST+REASON_DISCARD,nil,CARD_FIRE_ENERGY)==0 then return end
	Duel.BreakEffect()
	Duel.Draw(tp,2,REASON_EFFECT)
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=20
	if Duel.TossCoin(tp,1)==RESULT_TAILS then dam=0 end
	Duel.AttackDamage(dam)
end
