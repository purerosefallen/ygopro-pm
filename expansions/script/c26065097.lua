--Primal Groudon-EX (Primal Clash 86/160)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetValue(scard.efilter)
	c:RegisterEffect(e1)
	--discard stadium
	pm.EnablePokemonAttack(c,0,nil,scard.attack_cost,pm.hinttg,scard.dsop)
end
scard.pokemon_card=true
scard.devolve_list={[1]=CARD_GROUDON_EX}
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost=pm.econ2(CARD_FIGHTING_ENERGY,3,CARD_COLORLESS_ENERGY,1)
--immune
function scard.efilter(e,te)
	local tc=te:GetHandler()
	if tc:IsPokemonTool() or tc:IsStadium() then return false end
	return te:IsActiveType(PM_TYPE_TRAINER) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
--discard stadium
function scard.dsop(e,tp,eg,ep,ev,re,r,rp)
	local dam=100
	local tc=Duel.GetFirstMatchingCard(nil,tp,PM_LOCATION_STADIUM,PM_LOCATION_STADIUM,nil)
	if tc then dam=dam+100 end
	if dam>100 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
	if tc then Duel.SendtoDPile(tc,REASON_EFFECT+REASON_DISCARD) end
end
