--Omanyte (Neo Discovery 60/75)
local pm=require "expansions.utility_ptcg"
local scard,sid=pm.GetID()
function scard.initial_effect(c)
	pm.EnablePokemonAttribute(c)
	--evolve
	pm.EnableEvolutionAttribute(c)
	--pokémon power (to bench)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(sid,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(PM_LOCATION_IN_PLAY)
	e1:SetCountLimit(1)
	e1:SetCondition(pm.nspcon)
	e1:SetTarget(scard.tbtg)
	e1:SetOperation(scard.tbop)
	c:RegisterEffect(e1)
	--paralyzed
	pm.EnablePokemonAttack(c,1,nil,scard.attack_cost,pm.hinttg,scard.parop)
end
scard.pokemon_card=true
scard.length=1.40
scard.devolve_list={[1]=CARD_MYSTERIOUS_FOSSIL}
scard.weakness_x2=PM_ENERGY_GRASS
scard.attack_cost=pm.econ1(PM_ENERGY_WATER,1)
--pokémon power (to bench)
function scard.tbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,PM_LOCATION_BENCH)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function scard.tbfilter(c,e,tp)
	return c.devolve_list and table.unpack(c.devolve_list)==CARD_MYSTERIOUS_FOSSIL and c:IsCanBePutInPlay(e,0,tp,false,false)
end
function scard.tbop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,PM_LOCATION_BENCH)<=0 then return end
	if Duel.TossCoin(tp,1)==RESULT_TAILS then return end
	pm.ConfirmDeck(tp,tp)
	Duel.Hint(HINT_SELECTMSG,tp,PM_HINTMSG_TOBENCH)
	local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if not tc then return pm.SearchFailed(tp,tp) end
	if not Duel.PutInPlayStep(tc,0,tp,tp,false,false,PM_POS_FACEUP_UPSIDE) then return end
	--treat as basic pokémon
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(sid,2))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(PM_EFFECT_ADD_SETCODE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetValue(PM_TYPE_BASIC_POKEMON)
	e1:SetReset(RESET_EVENT+0x47c0000)
	tc:RegisterEffect(e1,true)
	local e2=e1:Clone()
	e2:SetCode(PM_EFFECT_REMOVE_TYPE)
	e2:SetValue(PM_TYPE_TRAINER)
	tc:RegisterEffect(e2,true)
	Duel.PutInPlayComplete()
end
--paralyzed
function scard.parop(e,tp,eg,ep,ev,re,r,rp)
	Duel.AttackDamage(10)
	if Duel.TossCoin(tp,1)==RESULT_HEADS then pm.EnableParalyzed(Duel.GetDefendingPokemon()) end
end
