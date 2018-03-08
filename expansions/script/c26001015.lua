--Venusaur (Base Set 15/102)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--poké-power (move energy)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(PM_EFFECT_FLAG_POKEPOWER)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCondition(aux.AND(pm.ppowcon,pm.nspcon))
	e1:SetTarget(scard.metg)
	e1:SetOperation(scard.meop)
	c:RegisterEffect(e1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.length=6.70
scard.devolve_list={[1]=CARD_IVYSAUR,[2]=CARD_VENUSAUR}
scard.weakness_x2=PM_ENERGY_FIRE
scard.attack_cost=pm.econ1(CARD_GRASS_ENERGY,4)
--poké-power (move energy)
function scard.cfilter1(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachmentGroup():IsExists(Card.IsEnergy,1,nil,CARD_GRASS_ENERGY)
end
function scard.cfilter2(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.metg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g1=Duel.GetMatchingGroup(scard.cfilter1,tp,PM_LOCATION_IN_PLAY,0,nil)
	local g2=Duel.GetMatchingGroup(scard.cfilter2,tp,PM_LOCATION_IN_PLAY,0,g1)
	if chk==0 then return g1:GetCount()>0 and g2:GetCount()>0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.meop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(scard.cfilter1,tp,PM_LOCATION_IN_PLAY,0,nil)
	local g2=Duel.GetMatchingGroup(scard.cfilter2,tp,PM_LOCATION_IN_PLAY,0,g1)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	local ag=Duel.GetAttachmentGroup(tp,1,0):Filter(Card.IsEnergy,nil,CARD_GRASS_ENERGY)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_GENERGY)
	local sg1=ag:Select(tp,1,1,nil)
	local ac=sg1:GetFirst():GetAttachmentTarget()
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_MOVEENERGY)
	local sg2=g2:Select(tp,1,1,ac)
	Duel.HintSelection(sg2)
	Duel.Attach(sg2:GetFirst(),sg1)
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(60)
end
