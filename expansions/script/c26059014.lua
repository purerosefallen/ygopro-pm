--Chesnaught (XY 14/146)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(PM_EVENT_ADD_COUNTER+PM_DAMAGE_COUNTER)
	e1:SetCondition(scard.ctcon)
	e1:SetTarget(pm.hinttg)
	e1:SetOperation(scard.ctop)
	c:RegisterEffect(e1)
	--heal
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.healop)
end
scard.pokemon_card=true
scard.height=5.03
scard.evolve_list={[1]=CARD_CHESNAUGHT_BREAK}
scard.devolve_list={[1]=CARD_QUILLADIN,[2]=CARD_CHESPIN}
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost=pm.econ2(CARD_GRASS_ENERGY,2,CARD_COLORLESS_ENERGY,2)
--add counter
function scard.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsActive() and bit.band(r,PM_REASON_ATTACK)~=0 and rp~=tp
end
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	Duel.GetAttackingPokemon():AddCounter(PM_DAMAGE_COUNTER,3)
end
--heal
function scard.healop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(90)
	Duel.HealDamage(e,20,e:GetHandler())
end
