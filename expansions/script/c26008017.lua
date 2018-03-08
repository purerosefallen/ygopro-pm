--Typhlosion (Neo Genesis 17/111)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--poké-power (attach)
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
scard.length=5.70
scard.devolve_list={[1]=CARD_QUILAVA,[2]=CARD_CYNDAQUIL}
scard.weakness_x2=PM_ENERGY_WATER
scard.attack_cost=pm.econ1(CARD_FIRE_ENERGY,4)
--poké-power (attach)
function scard.atfilter(c)
	return c:IsFaceup() and c:IsPokemon() and c:IsPokemonType(PM_ENERGY_FIRE)
end
function scard.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsEnergy,tp,PM_LOCATION_DPILE,0,1,nil,CARD_FIRE_ENERGY)
		and Duel.IsExistingMatchingCard(scard.atfilter,tp,PM_LOCATION_IN_PLAY,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.atop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	local g1=Duel.GetMatchingGroup(Card.IsEnergy,tp,PM_LOCATION_DPILE,0,nil,CARD_FIRE_ENERGY)
	local g2=Duel.GetMatchingGroup(scard.atfilter,tp,PM_LOCATION_IN_PLAY,0,nil)
	if g1:GetCount()==0 or g2:GetCount()==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_RENERGY)
	local sg1=g1:Select(tp,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_ATTACHENERGY)
	local sg2=g2:Select(tp,1,1,nil)
	Duel.HintSelection(sg2)
	Duel.Attach(sg2:GetFirst(),sg1)
end
--damage
function scard.damop(e,tp,eg,ep,ev,re,r,rp)
	local dam=60
	local self_damage=false
	if Duel.TossCoin(tp,1)==RESULT_HEADS then dam=dam+20 self_damage=true end
	if dam>60 then Duel.Hint(HINT_OPSELECTED,1-tp,PM_DESC_DAMAGE_INCREASE) end
	Duel.AttackDamage(dam)
	if self_damage then Duel.EffectDamage(20,e:GetHandler(),e:GetHandler(),false,false) end
end
