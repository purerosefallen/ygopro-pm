--Magnezone (Plasma Storm 46/135)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--double supporter
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(PM_EFFECT_DOUBLE_SUPPORTER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetTargetRange(1,0)
	e1:SetCondition(pm.turnpcon(PLAYER_PLAYER))
	c:RegisterEffect(e1)
	--switch
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.swop)
end
scard.pokemon_card=true
scard.height=3.11
scard.devolve_list={[1]=CARD_MAGNETON,[2]=CARD_MAGNEMITE}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost=pm.econ2(CARD_LIGHTNING_ENERGY,2,CARD_COLORLESS_ENERGY,1)
function scard.swop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(80)
	Duel.SwitchPokemon(e,tp,tp)
	Duel.BreakEffect()
	Duel.SwitchPokemon(e,1-tp,1-tp)
end
