--Gardevoir ex (EX Dragon Frontiers 93/101)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--poké-power (add marker)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(PM_LOCATION_ACTIVE)
	e1:SetCountLimit(1)
	e1:SetCondition(scard.ctcon)
	e1:SetTarget(scard.cttg)
	e1:SetOperation(scard.ctop)
	c:RegisterEffect(e1)
	--move energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.meop)
end
scard.pokemon_card=true
scard.devolve_list={[1]=CARD_KIRLIA,[2]=CARD_RALTS}
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ2(CARD_FIRE_ENERGY,1,CARD_COLORLESS_ENERGY,2)
--poké-power (add marker)
function scard.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return pm.ppowcon(e,tp,eg,ep,ev,re,r,rp) and pm.nspcon(e,tp,eg,ep,ev,re,r,rp) and e:GetHandler():IsActive()
end
function scard.ctfilter(c)
	return c:IsFaceup() and c:IsPokemon()
end
function scard.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.ctfilter,tp,0,PM_LOCATION_IN_PLAY,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.ctop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,2))
	local g=Duel.SelectMatchingCard(tp,scard.ctfilter,tp,0,PM_LOCATION_IN_PLAY,1,1,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	Duel.HintSelection(g)
	tc:AddMarker(PM_IMPRISON_MARKER,1)
	--cannot use poké-power/poké-body
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,4))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_CANNOT_USE_POKEPOWER)
	e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
	e1:SetCondition(scard.effcon)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetDescription(aux.Stringid(sid,5))
	e2:SetCode(PM_EFFECT_CANNOT_USE_POKEBODY)
	tc:RegisterEffect(e2)
end
function scard.effcon(e)
	return e:GetHandler():GetMarker(PM_IMPRISON_MARKER)>0
end
--move energy
function scard.meop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(80)
	local g1=e:GetHandler():GetAttachmentGroup():Filter(Card.IsEnergy,nil,CARD_FIRE_ENERGY)
	local g2=Duel.GetMatchingGroup(pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	if g1:GetCount()==0 or g2:GetCount()==0 or not Duel.SelectYesNo(tp,aux.Stringid(sid,3)) then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_RENERGY)
	local sg1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_MOVEENERGY)
	local sg2=g2:Select(tp,1,1,nil)
	Duel.HintSelection(sg2)
	Duel.Attach(sg2:GetFirst(),sg1)
end
