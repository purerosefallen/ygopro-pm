--Unown ? (Legends Awakened 82/146)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--poké-power (draw)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(PM_EFFECT_FLAG_POKEPOWER)
	e1:SetRange(PM_LOCATION_BENCH)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.AND(pm.ppowcon,pm.benchcon))
	e1:SetTarget(scard.drtg)
	e1:SetOperation(scard.drop1)
	c:RegisterEffect(e1)
	--discard hand & draw
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.drop2)
end
scard.pokemon_card=true
scard.weakness_x2=PM_ENERGY_PSYCHIC
scard.attack_cost=pm.econ0()
--poké-power (draw)
function scard.drfilter(c)
	return c:IsPokemon() and not c:IsPublic()
end
function scard.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.drfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.drop1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_POKEMON)
	local g=Duel.SelectMatchingCard(tp,scard.drfilter,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEDOWN,true)
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(sid,2))
	local opt=pm.energy_list[Duel.SelectOption(1-tp,table.unpack(pm.select_list))+1]
	Duel.ChangePosition(tc,POS_FACEUP)
	Duel.HintSelection(g)
	if opt~=tc:GetPokemonType() then Duel.Draw(tp,1,REASON_EFFECT) end
	Duel.BreakEffect()
	Duel.SendtoHand(tc,PLAYER_OWNER,REASON_RULE)
end
--discard hand & draw
function scard.drop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.PokemonAttack(c,Duel.GetDefendingPokemon())
	local ct=Duel.DiscardHand(tp,nil,1,2,REASON_EFFECT+REASON_DISCARD)
	Duel.BreakEffect()
	Duel.Draw(tp,ct,REASON_EFFECT)
end
