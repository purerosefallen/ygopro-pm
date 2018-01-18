--Team Magma's Camerupt (Double Crisis 2/34)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolve(c)
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCountLimit(1)
	e1:SetTarget(scard.attg)
	e1:SetOperation(scard.atop)
	c:RegisterEffect(e1)
	--move energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.meop)
end
scard.pokemon_card=true
scard.height=6.03
scard.devolve_list={CARD_TEAM_MAGMAS_NUMEL}
scard.weakness_x2=PM_ENERGY_WATER
scard.attack_cost=pm.econ2(CARD_ENERGY_FIRE,1,CARD_ENERGY_COLORLESS,2)
function scard.atfilter(c)
	return c:IsEnergy(CARD_FIGHTING_ENERGY) or c:IsEnergy(CARD_FIRE_ENERGY)
end
function scard.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.atfilter,tp,PM_LOCATION_DPILE,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(sid,2))
	local g=Duel.SelectMatchingCard(tp,scard.atfilter,tp,PM_LOCATION_DPILE,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.Attach(e:GetHandler(),g)
end
function scard.meop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(60)
	local ag=e:GetHandler():GetAttachmentGroup()
	local mg=Duel.GetMatchingGroup(pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	if ag:FilterCount(Card.IsEnergy,nil)==0 or mg:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_BASICENERGY)
	local sg1=ag:FilterSelect(tp,Card.IsBasicEnergy,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_MOVEENERGY)
	local sg2=mg:Select(tp,1,1,nil)
	Duel.HintSelection(sg2)
	Duel.Attach(sg2:GetFirst(),sg1)
end
