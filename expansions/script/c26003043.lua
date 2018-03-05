--Slowbro (Fossil 43/62)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--move counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCondition(pm.nspcon)
	e1:SetTarget(scard.cttg)
	e1:SetOperation(scard.ctop)
	c:RegisterEffect(e1)
	--paralyzed
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.parop)
end
scard.pokemon_card=true
scard.length=5.30
scard.devolve_list={[1]=CARD_SLOWPOKE}
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ1(CARD_PSYCHIC_ENERGY,2)
--move counter
function scard.ctfilter(c)
	return c:GetCounter(PM_DAMAGE_COUNTER)>0
end
function scard.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(scard.ctfilter,tp,PM_LOCATION_IN_PLAY,0,1,c) and c:GetHP()>10 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(scard.ctfilter,tp,PM_LOCATION_IN_PLAY,0,c)
	if g:GetCount()==0 or c:GetHP()<=10 then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_REMOVEDAMAGE)
	local sg=g:Select(tp,1,1,nil)
	local tc=sg:GetFirst()
	Duel.HintSelection(sg)
	tc:RemoveCounter(tp,PM_DAMAGE_COUNTER,1,REASON_EFFECT)
	c:AddCounter(PM_DAMAGE_COUNTER,1,REASON_EFFECT)
end
--paralyzed
function scard.parop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(20)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnableParalyzed(Duel.GetDefendingPokemon()) end
end
