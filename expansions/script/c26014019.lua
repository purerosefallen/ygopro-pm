--Kingdra (Aquapolis 19/147)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--move energy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCondition(scard.mecon)
	e1:SetTarget(scard.metg)
	e1:SetOperation(scard.meop)
	c:RegisterEffect(e1)
	--discard energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.deop)
end
scard.pokemon_card=true
scard.devolve_list={[1]=CARD_HORSEA,[2]=CARD_SEADRA}
scard.weakness_x2=PM_ENERGY_LIGHTNING
scard.attack_cost=pm.econ2(CARD_WATER_ENERGY,2,CARD_COLORLESS_ENERGY,2)
--move energy
function scard.mecon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsAffectedBySpecialCondition()
end
function scard.mefilter(c)
	return pm.ActivePokemonFilter(c) and c:GetAttachmentGroup():IsExists(Card.IsEnergy,1,nil,CARD_WATER_ENERGY)
end
function scard.metg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.mefilter,tp,PM_LOCATION_ACTIVE,0,1,nil)
		and Duel.IsExistingMatchingCard(pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.meop(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(scard.mefilter,tp,PM_LOCATION_ACTIVE,0,nil)
	local g2=Duel.GetMatchingGroup(pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	local ag=g1:GetFirst():GetAttachmentGroup()
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_WENERGY)
	local sg1=ag:FilterSelect(tp,Card.IsEnergy,1,1,nil,CARD_WATER_ENERGY)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_MOVEENERGY)
	local sg2=g2:Select(tp,1,1,nil)
	Duel.HintSelection(sg2)
	Duel.Attach(sg2:GetFirst(),sg1)
end
--discard energy
function scard.deop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(50)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then Duel.DiscardEnergy(e,Duel.GetDefendingPokemon(),1) end
end
