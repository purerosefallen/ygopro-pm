--Gardevoir (EX Ruby & Sapphire 7/109)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--poké-power (attach & add counter)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.AND(pm.ppowcon,pm.nspcon))
	e1:SetTarget(scard.attg)
	e1:SetOperation(scard.atop)
	c:RegisterEffect(e1)
	--damage
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.damop)
end
scard.pokemon_card=true
scard.devolve_list={[1]=CARD_KIRLIA,[2]=CARD_RALTS}
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ1(CARD_PSYCHIC_ENERGY,1)
--poké-power (attach & add counter)
function scard.atfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		and Duel.IsExistingMatchingCard(scard.atfilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	pm.ConfirmDeck(tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_PENERGY)
	local g1=Duel.SelectMatchingCard(tp,Card.IsEnergy,tp,LOCATION_DECK,0,1,1,nil,CARD_PSYCHIC_ENERGY)
	if g1:GetCount()==0 then return pm.SearchFailed(tp,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ATTACHENERGY)
	local g2=Duel.SelectMatchingCard(tp,scard.atfilter,tp,PM_LOCATION_IN_PLAY,0,1,1,nil)
	if g2:GetCount()==0 then return end
	local tc=g2:GetFirst()
	Duel.Attach(tc,g1)
	tc:AddCounter(PM_DAMAGE_COUNTER,2)
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local a=e:GetHandler()
	local d=Duel.GetDefendingPokemon()
	local dam=a:GetAttachmentGroup():FilterCount(Card.IsEnergy,nil)+d:GetAttachmentGroup():FilterCount(Card.IsEnergy,nil)
	if dam>0 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(10*dam)
end
