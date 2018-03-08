--Electivire (Diamond & Pearl 3/130)
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
scard.height=5.11
scard.devolve_list={[1]=CARD_ELECTABUZZ,[2]=CARD_ELEKID}
scard.weakness_x2=PM_ENERGY_FIGHTING
scard.attack_cost=pm.econ2(CARD_LIGHTNING_ENERGY,3,CARD_COLORLESS_ENERGY,1)
--poké-power (move energy)
function scard.mefilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:GetAttachmentGroup():IsExists(Card.IsEnergy,1,nil,CARD_LIGHTNING_ENERGY)
end
function scard.metg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=c:GetAttachmentGroup()
	if chk==0 then return g:IsExists(Card.IsCode,1,nil,CARD_ELEKID)
		and Duel.IsExistingMatchingCard(scard.mefilter,tp,PM_LOCATION_IN_PLAY,0,1,c) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.meop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g1=c:GetAttachmentGroup()
	if g1:FilterCount(Card.IsCode,nil,CARD_ELEKID)==0
		or Duel.GetMatchingGroupCount(scard.mefilter,tp,PM_LOCATION_IN_PLAY,0,c)==0 then return end
	local g2=Duel.GetAttachmentGroup(tp,1,0):Filter(Card.IsEnergy,nil,CARD_LIGHTNING_ENERGY)
	g2:Sub(g1)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_LENERGY)
	local sg=g2:Select(tp,1,1,nil)
	Duel.Attach(c,sg)
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=60
	local g=e:GetHandler():GetAttachmentGroup():Filter(Card.IsEnergy,nil)
	if Duel.SelectYesNo(tp,aux.Stringid(sid,2)) then
		Duel.SendtoDPile(g,REASON_COST+REASON_DISCARD)
		dam=120
	end
	Duel.AttackDamage(dam)
end
