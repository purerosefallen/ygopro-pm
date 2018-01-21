--Team Magma's Claydol (Double Crisis 11/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--move energy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCountLimit(1)
	e1:SetTarget(scard.metg)
	e1:SetOperation(scard.meop)
	c:RegisterEffect(e1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.height=4.11
scard.devolve_list={[1]=CARD_TEAM_MAGMAS_BALTOY}
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ2(CARD_PSYCHIC_ENERGY,1,CARD_COLORLESS_ENERGY,2)
function scard.cfilter1(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachmentGroup():IsExists(Card.IsBasicEnergy,1,nil)
end
function scard.cfilter2(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsSetCard(PM_SETNAME_TEAM_MAGMA)
end
function scard.metg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g1=Duel.GetMatchingGroup(scard.cfilter1,tp,PM_LOCATION_IN_PLAY,0,nil)
	local g2=Duel.GetMatchingGroup(scard.cfilter2,tp,PM_LOCATION_IN_PLAY,0,nil)
	g1:Merge(g2)
	if chk==0 then return g1:GetCount()>1 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.meop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(scard.cfilter1,tp,PM_LOCATION_IN_PLAY,0,nil)
	local g2=Duel.GetMatchingGroup(scard.cfilter2,tp,PM_LOCATION_IN_PLAY,0,nil)
	g1:Merge(g2)
	if g1:GetCount()<2 then return end
	local ag=Duel.GetAttachmentGroup(tp,1,0)
	if g2:GetCount()==1 then
		ag:Sub(g1:GetFirst():GetAttachmentGroup())
	end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_BASICENERGY)
	local sg1=ag:FilterSelect(tp,Card.IsBasicEnergy,1,1,nil)
	local ac=sg1:GetFirst():GetAttachmentTarget()
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_MOVEENERGY)
	local sg2=g2:Select(tp,1,1,ac)
	Duel.HintSelection(sg2)
	Duel.Attach(sg2:GetFirst(),sg1)
end
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(70)
end
