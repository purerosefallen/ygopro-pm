--Gyarados (Black Star Promo XY60)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--double pokémon tool
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_DOUBLE_POKEMON_TOOL)
	c:RegisterEffect(e1)
	--damage
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost1,pm.hinttg,scard.damop1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost2,pm.hinttg,scard.damop2)
end
scard.pokemon_card=true
scard.devolve_list={[1]=CARD_MAGIKARP}
scard.weakness_x2=PM_ENERGY_LIGHTNING
scard.attack_cost1=pm.econ1(CARD_COLORLESS_ENERGY,2)
scard.attack_cost2=pm.econ2(CARD_WATER_ENERGY,2,CARD_COLORLESS_ENERGY,2)
function scard.cfilter(c)
	return c:IsFaceup() and c:IsCode(CARD_MAGIKARP) and c:IsBench()
end
function scard.damop1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(scard.cfilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	local tc=g:GetFirst()
	local dam=30
	for tc in aux.Next(g) do
		local ct=tc:GetCounter(PM_DAMAGE_COUNTER)
		if ct>0 then
			dam=dam*ct
			dam=dam+30
		end
	end
	if dam>30 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
end
function scard.damop2(e,tp,eg,ep,ev,re,r,rp)
	local dam=100
	local self_damage=false
	if Duel.TossCoin(tp,1)==RESULT_HEADS then
		dam=dam+30
	else self_damage=true end
	if dam>100 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
	if self_damage then Duel.EffectDamage(30,e:GetHandler(),e:GetHandler(),false,false) end
end
