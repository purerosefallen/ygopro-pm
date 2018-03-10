--Primal Kyogre-EX (Primal Clash 55/160)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CUSTOM+PM_EVENT_ATTACH_ENERGY_FROM_HAND)
	e1:SetOperation(scard.atop)
	c:RegisterEffect(e1)
	--move energy
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.meop)
end
scard.pokemon_card=true
scard.devolve_list={[1]=CARD_KYOGRE_EX}
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost=pm.econ2(CARD_WATER_ENERGY,3,CARD_COLORLESS_ENERGY,1)
--attach
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsEnergy,tp,LOCATION_HAND,0,nil)
	if g:GetCount()==0 then return end
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	if not Duel.SelectYesNo(player,aux.Stringid(sid,2)) then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ENERGY)
	local sg=g:Select(tp,1,1,nil)
	Duel.Attach(c,sg:GetFirst())
end
--move energy
function scard.damfilter(c)
	return c:IsFaceup() and c:IsPokemonEX() and c:IsBench()
end
function scard.meop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(150)
	local c=e:GetHandler()
	local g1=c:GetAttachmentGroup()
	local g2=Duel.GetMatchingGroup(pm.BenchPokemonFilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	if g1:FilterCount(Card.IsEnergy,nil)>0 and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ENERGY)
		local sg1=g1:FilterSelect(tp,Card.IsEnergy,2,2,nil)
		Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_MOVEENERGY)
		local sg2=g2:Select(tp,1,1,nil)
		Duel.HintSelection(sg2)
		Duel.Attach(sg2:GetFirst(),sg1)
	end
	local g3=Duel.GetMatchingGroup(scard.damfilter,tp,0,PM_LOCATION_IN_PLAY,nil)
	if g3:GetCount()==0 then return end
	local tc=g3:GetFirst()
	for tc in aux.Next(g3) do
		Duel.EffectDamage(30,c,tc)
	end
end
